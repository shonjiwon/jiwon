package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.*;
import kr.go.songpa.ssem.util.DateUtil;
import kr.go.songpa.ssem.util.FileMngUtil;
import kr.go.songpa.ssem.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-09-15
 * Description :
 * History :
 * Version :
 */
@Controller
public class SiteController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    @Autowired
    private BbsService bbsService;

    @Autowired
    private CoachService coachService;

    @Autowired
    private LawTaxService lawTaxService;

    public SiteController() {
    }

    @RequestMapping("/cont/site/notice_list.do")
    public String notice_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/notice_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<BbsDetailVo> bbsList = bbsService.selectSiteBbsList(searchVo);
            int totalCount = bbsService.selectSiteBbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);

            // 메인 노출 게시물 가져오기
            List<BbsDetailVo> mainList = bbsService.selectMainBbsList();
            if(mainList.size() < 4) {
                List<BbsDetailVo> tempList = bbsService.selectMainTempBbsList(4 - mainList.size());
                mainList.addAll(tempList);
            }
            model.addAttribute("mainList", mainList);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/notice_inscr.do", method = RequestMethod.GET)
    public String notice_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/notice_inscr";
        String menu_url = "cont/site/notice_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/notice_inscr.do", method = RequestMethod.POST)
    public String notice_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
                                      BindingResult bindingResult,
                                      Model model,
                                      SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    //bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());

                    if(bbsDetailVo.getGroup_idx() == 0) {
                        bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    }

                    if(bbsDetailVo.getGroup_idx() == 75) {
                        bbsDetailVo.setGubun("SONGPA");
                        //bbsDetailVo.setP_top_yn(null);
                    } else if(bbsDetailVo.getGroup_idx() == 76) {
                        bbsDetailVo.setGubun("MACHUN");
                        //bbsDetailVo.setP_top_yn(null);
                    } else if(bbsDetailVo.getGroup_idx() == 77) {
                        bbsDetailVo.setGubun("JAMSIL");
                        //bbsDetailVo.setP_top_yn(null);
                    } else if(bbsDetailVo.getGroup_idx() == 78) {
                        bbsDetailVo.setGubun("FUTURE");
                        //bbsDetailVo.setP_top_yn(null);
                    } else if(bbsDetailVo.getGroup_idx() == 86) {
                        bbsDetailVo.setGubun("DREAM");
                        //bbsDetailVo.setP_top_yn(null);
                    } else {
                        bbsDetailVo.setGubun("PORTAL");
                        //bbsDetailVo.setTop_yn(null);
                    }

                    bbsDetailVo.setType_cd("B");

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/site/notice_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/notice_view.do", method = RequestMethod.GET)
    public String notice_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/notice_view";
        String menu_url = "cont/site/notice_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int bbs_detail_idx = ServletRequestUtils.getIntParameter(request, "bbs_detail_idx", 0);

            BbsDetailVo bbsDetailVo = new BbsDetailVo();
            bbsDetailVo.setBbs_detail_idx(bbs_detail_idx);

            bbsService.updateBbsViewCnt(bbsDetailVo);
            bbsDetailVo = bbsService.selectBbsInfo(bbsDetailVo);

            // 첨부파일 처리
            String atchFileId = bbsDetailVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            bbsDetailVo.setFileList(fileVoList);

            model.addAttribute("bbsDetailVo", bbsDetailVo);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/notice_view.do", method = RequestMethod.POST)
    public String notice_view_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
                                         BindingResult bindingResult,
                                         Model model,
                                         SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    /*bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("DREAM"); // 송파진로체험지원센터(꿈마루)*/

                    if(bbsDetailVo.getGroup_idx() == 0) {
                        bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    }

                    if(bbsDetailVo.getGroup_idx() == 75) {
                        bbsDetailVo.setGubun("SONGPA");
                    } else if(bbsDetailVo.getGroup_idx() == 76) {
                        bbsDetailVo.setGubun("MACHUN");
                    } else if(bbsDetailVo.getGroup_idx() == 77) {
                        bbsDetailVo.setGubun("JAMSIL");
                    } else if(bbsDetailVo.getGroup_idx() == 78) {
                        bbsDetailVo.setGubun("FUTURE");
                    } else if(bbsDetailVo.getGroup_idx() == 86) {
                        bbsDetailVo.setGubun("DREAM");
                    } else {
                        bbsDetailVo.setGubun("PORTAL");
                    }

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/site/notice_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/notice_delete.do", method = RequestMethod.POST)
    public String notice_delete(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
                                       BindingResult bindingResult,
                                       Model model,
                                       SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/site/notice_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/notice_ord.do", method = RequestMethod.POST)
    public String notice_ord_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
                                         BindingResult bindingResult,
                                         Model model,
                                         SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {

                // 슨서 처리
                if(bbsDetailVo.getOrdList().size() > 0) {
                    for (OrdVo ord : bbsDetailVo.getOrdList()) {
                        bbsService.updateBbsOrd(ord);
                    }
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/site/notice_list.do");
                model.addAttribute("altmsg", "수정 되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "수정에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/site/faq_list.do")
    public String faq_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/faq_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            //searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchVal2("");
            searchVo.setSearchKind("PORTAL");
            searchVo.setSearchVal3("F");

            List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
            int totalCount = bbsService.selectbbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/faq_inscr.do", method = RequestMethod.GET)
    public String faq_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/faq_inscr";
        String menu_url = "cont/site/faq_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/faq_inscr.do", method = RequestMethod.POST)
    public String faq_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
                                      BindingResult bindingResult,
                                      Model model,
                                      SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("PORTAL"); // 송파진로체험지원센터(꿈마루)
                    bbsDetailVo.setType_cd("F");

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/site/faq_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/faq_view.do", method = RequestMethod.GET)
    public String faq_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/faq_view";
        String menu_url = "cont/site/faq_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int bbs_detail_idx = ServletRequestUtils.getIntParameter(request, "bbs_detail_idx", 0);

            BbsDetailVo bbsDetailVo = new BbsDetailVo();
            bbsDetailVo.setBbs_detail_idx(bbs_detail_idx);

            bbsService.updateBbsViewCnt(bbsDetailVo);
            bbsDetailVo = bbsService.selectBbsInfo(bbsDetailVo);

            // 첨부파일 처리
            String atchFileId = bbsDetailVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            bbsDetailVo.setFileList(fileVoList);

            model.addAttribute("bbsDetailVo", bbsDetailVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/faq_view.do", method = RequestMethod.POST)
    public String faq_view_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
                                         BindingResult bindingResult,
                                         Model model,
                                         SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("PORTAL"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/site/faq_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/faq_delete.do", method = RequestMethod.POST)
    public String faq_delete(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
                                      BindingResult bindingResult,
                                      Model model,
                                      SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/site/faq_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/site/survey_list.do")
    public String survey_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/survey_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 10, DateUtil.getYear() + "-01-01", DateUtil.getYear() + "-12-31");
        this.getModel(request, model, 10, DateUtil.getYear() + "-01-01", DateUtil.getYear() + "-12-31");

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<SvyMstVo> itemList = bbsService.selectSurveyList(searchVo);
            for(SvyMstVo survey : itemList) {
                // 접수유무 확인
                String today = Util.getDate(1);
                if (Integer.valueOf(today) < Integer.valueOf(survey.getStart_dt().substring(0, 10).replaceAll("-", ""))) {
                    survey.setSrv_yn("예정");
                } else if (Integer.valueOf(today) > Integer.valueOf(survey.getEnd_dt().substring(0, 10).replaceAll("-", ""))) {
                    survey.setSrv_yn("종료");
                } else {
                    survey.setSrv_yn("진행 중");
                }
            }
            int totalCount = bbsService.selectSurveyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/survey_inscr.do", method = RequestMethod.GET)
    public String survey_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/survey_inscr";
        String menu_url = "cont/site/survey_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/survey_inscr.do", method = RequestMethod.POST)
    public String survey_inproc(final MultipartHttpServletRequest multiRequest,
                                @ModelAttribute("svyMstVo") SvyMstVo svyMstVo,
                                BindingResult bindingResult,
                                Model model,
                                SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                svyMstVo.setReg_id(adminLoginVo.getAdmin_id());

                // 1. 설문마스터 입력
                bbsService.insertSurveyMstInfo(svyMstVo);

                for(SvyQstVo quest : svyMstVo.getQuestList()) {
                    quest.setSvy_idx(svyMstVo.getSvy_idx());
                    quest.setReg_id(adminLoginVo.getAdmin_id());
                    // 2. 설문문항 입력
                    bbsService.insertSurveyQstInfo(quest);

                    if (!"L".equals(quest.getType())) {

                        for(SvyItemVo item : quest.getItemList()) {
                            item.setSvy_idx(svyMstVo.getSvy_idx());
                            item.setSvy_qst_idx(quest.getSvy_qst_idx());
                            item.setReg_id(adminLoginVo.getAdmin_id());
                            item.setSa_yn("N");
                            // 3. 설문아이템 입력
                            bbsService.insertSurveyItemInfo(item);
                        }
                    } else {
                        SvyItemVo item = new SvyItemVo();
                        item.setSvy_idx(svyMstVo.getSvy_idx());
                        item.setSvy_qst_idx(quest.getSvy_qst_idx());
                        item.setReg_id(adminLoginVo.getAdmin_id());
                        item.setSa_yn("Y");

                        bbsService.insertSurveyItemInfo(item);
                    }
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/site/survey_list.do");
                model.addAttribute("altmsg", "저장 하였습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/survey_view.do", method = RequestMethod.GET)
    public String survey_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/survey_view";
        String menu_url = "cont/site/survey_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int svy_idx = ServletRequestUtils.getIntParameter(request, "svy_idx", 0);

            SvyMstVo svyMstVo = new SvyMstVo();
            svyMstVo.setSvy_idx(svy_idx);

            svyMstVo = bbsService.selectSurvey(svyMstVo);

            String today = Util.getDate(1);

            if (Integer.valueOf(today) < Integer.valueOf(svyMstVo.getStart_dt().substring(0, 10).replaceAll("-", ""))) {
                svyMstVo.setSrv_yn("예정");
            } else if (Integer.valueOf(today) > Integer.valueOf(svyMstVo.getEnd_dt().substring(0, 10).replaceAll("-", ""))) {
                svyMstVo.setSrv_yn("종료");
            } else {
                svyMstVo.setSrv_yn("진행 중");
            }

            List<SvyQstVo> questList = bbsService.selectQuestList(svyMstVo);
            for(SvyQstVo quest : questList) {
                List<SvyItemVo> itemList = bbsService.selectItemList(quest);

                for(SvyItemVo item : itemList) {
                    List<SvyRpyVo> replyList = bbsService.selectReplyList(item);
                    int item_cnt = replyList.size();
                    int tot_cnt = bbsService.selectQuestTotalReply(item);

                    if(tot_cnt == 0) break;

                    double percent = (double) item_cnt / (double) tot_cnt * 100.0;

                    item.setTot_reply_cnt(item_cnt);
                    item.setReply_percent(String.format("%.2f", percent) + "%");

                    item.setReplyList(replyList);
                }

                quest.setItemList(itemList);
            }

            svyMstVo.setQuestList(questList);

            model.addAttribute("svyMstVo", svyMstVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/survey_view.do", method = RequestMethod.POST)
    public String survey_view_proc(final MultipartHttpServletRequest multiRequest,
                                   @ModelAttribute("svyMstVo") SvyMstVo svyMstVo,
                                   BindingResult bindingResult,
                                   Model model,
                                   SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                svyMstVo.setUp_id(adminLoginVo.getAdmin_id());

                // 1. 설문마스터 수정
                bbsService.updateSurveyMstInfo(svyMstVo);

                // 2. 설문 quest / item 삭제 후 다시 입력
                bbsService.deleteSurveyItem(svyMstVo);
                bbsService.deleteSurveyQuest(svyMstVo);

                for(SvyQstVo quest : svyMstVo.getQuestList()) {
                    quest.setSvy_idx(svyMstVo.getSvy_idx());
                    quest.setReg_id(adminLoginVo.getAdmin_id());
                    // 3. 설문문항 입력
                    bbsService.insertSurveyQstInfo(quest);

                    if (!"L".equals(quest.getType())) {

                        for(SvyItemVo item : quest.getItemList()) {
                            item.setSvy_idx(svyMstVo.getSvy_idx());
                            item.setSvy_qst_idx(quest.getSvy_qst_idx());
                            item.setReg_id(adminLoginVo.getAdmin_id());
                            item.setSa_yn("N");
                            // 4. 설문아이템 입력
                            bbsService.insertSurveyItemInfo(item);
                        }
                    } else {
                        SvyItemVo item = new SvyItemVo();
                        item.setSvy_idx(svyMstVo.getSvy_idx());
                        item.setSvy_qst_idx(quest.getSvy_qst_idx());
                        item.setReg_id(adminLoginVo.getAdmin_id());
                        item.setSa_yn("Y");

                        bbsService.insertSurveyItemInfo(item);
                    }
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/site/survey_list.do");
                model.addAttribute("altmsg", "저장하였습니다.");

            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/survey_delete.do", method = RequestMethod.POST)
    public String survey_delete(final MultipartHttpServletRequest multiRequest,
                                @ModelAttribute("svyMstVo") SvyMstVo svyMstVo,
                                BindingResult bindingResult,
                                Model model,
                                SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                //0. reply 삭제
                //bbsService.deleteSurveyReply(svyMstVo);
                //1. item 삭제
                bbsService.deleteSurveyItem(svyMstVo);
                //2. quest 삭제
                bbsService.deleteSurveyQuest(svyMstVo);
                //3. master 삭제
                bbsService.deleteSurveyMst(svyMstVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/site/survey_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/site/coaching_list.do")
    public String coaching_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/coaching_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<CoachVo> itemList = coachService.selectCoachList(searchVo);
            int totalCount = coachService.selectCoachListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/coaching_inscr.do", method = RequestMethod.GET)
    public String coaching_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/coaching_inscr";
        String menu_url = "cont/site/coaching_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            // 시간
            List<String> hourList = DateUtil.getHourList();
            model.addAttribute("hourList", hourList);

            // 분
            List<String> minList = DateUtil.getMinList();
            model.addAttribute("minList", minList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/coaching_inscr.do", method = RequestMethod.POST)
    public String coaching_inproc(final MultipartHttpServletRequest multiRequest,
                             @ModelAttribute("coachVo") CoachVo coachVo,
                             BindingResult bindingResult,
                             Model model,
                             SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                coachVo.setReg_id(adminLoginVo.getAdmin_id());

                String start_time = coachVo.getStart_hour() + ":" + coachVo.getStart_min();
                String end_time = coachVo.getEnd_hour() + ":" + coachVo.getEnd_min();

                coachVo.setStart_time(start_time);
                coachVo.setEnd_time(end_time);

                coachService.insertCoachInfo(coachVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/site/coaching_list.do");
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/coaching_view.do", method = RequestMethod.GET)
    public String coaching_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/coaching_view";
        String menu_url = "cont/site/coaching_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int coach_idx = ServletRequestUtils.getIntParameter(request, "coach_idx", 0);

            CoachVo coachVo = coachService.selectCoachInfo(coach_idx);

            String start_hour = coachVo.getStart_time().substring(0, 2);
            String start_min = coachVo.getStart_time().substring(3, 5);
            String end_hour = coachVo.getEnd_time().substring(0, 2);
            String end_min = coachVo.getEnd_time().substring(3, 5);

            coachVo.setStart_hour(start_hour);
            coachVo.setStart_min(start_min);
            coachVo.setEnd_hour(end_hour);
            coachVo.setEnd_min(end_min);

            model.addAttribute("coachVo", coachVo);

            // 시간
            List<String> hourList = DateUtil.getHourList();
            model.addAttribute("hourList", hourList);

            // 분
            List<String> minList = DateUtil.getMinList();
            model.addAttribute("minList", minList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/coaching_view.do", method = RequestMethod.POST)
    public String coaching_view_proc(final MultipartHttpServletRequest multiRequest,
                                @ModelAttribute("coachVo") CoachVo coachVo,
                                BindingResult bindingResult,
                                Model model,
                                SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                coachVo.setUp_id(adminLoginVo.getAdmin_id());

                String start_time = coachVo.getStart_hour() + ":" + coachVo.getStart_min();
                String end_time = coachVo.getEnd_hour() + ":" + coachVo.getEnd_min();

                coachVo.setStart_time(start_time);
                coachVo.setEnd_time(end_time);

                coachService.updateCoachInfo(coachVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/site/coaching_list.do");
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/coaching_delete.do", method = RequestMethod.POST)
    public String coaching_delete(final MultipartHttpServletRequest multiRequest,
                             @ModelAttribute("coachVo") CoachVo coachVo,
                             BindingResult bindingResult,
                             Model model,
                             SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                coachService.deleteCoachInfo(coachVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/site/coaching_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/coaching_room.do", method = RequestMethod.GET)
    public String coaching_room(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/coaching_room";
        String menu_url = "cont/site/coaching_room";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int coach_idx = ServletRequestUtils.getIntParameter(request, "coach_idx", 1);

            CoachRoomVo coachRoomVo = coachService.selectCoachRoomInfo(coach_idx);

            String start_hour = coachRoomVo.getStart_time().substring(0, 2);
            String start_min = coachRoomVo.getStart_time().substring(3, 5);
            String end_hour = coachRoomVo.getEnd_time().substring(0, 2);
            String end_min = coachRoomVo.getEnd_time().substring(3, 5);

            coachRoomVo.setStart_hour(start_hour);
            coachRoomVo.setStart_min(start_min);
            coachRoomVo.setEnd_hour(end_hour);
            coachRoomVo.setEnd_min(end_min);

            model.addAttribute("coachRoomVo", coachRoomVo);

            // 시간
            List<String> hourList = DateUtil.getHourList();
            model.addAttribute("hourList", hourList);

            // 분
            List<String> minList = DateUtil.getMinList();
            model.addAttribute("minList", minList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/coaching_room.do", method = RequestMethod.POST)
    public String coaching_room_proc(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("coachRoomVo") CoachRoomVo coachRoomVo,
                                     BindingResult bindingResult,
                                     Model model,
                                     SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                coachRoomVo.setUp_id(adminLoginVo.getAdmin_id());

                String start_time = coachRoomVo.getStart_hour() + ":" + coachRoomVo.getStart_min();
                String end_time = coachRoomVo.getEnd_hour() + ":" + coachRoomVo.getEnd_min();

                coachRoomVo.setStart_time(start_time);
                coachRoomVo.setEnd_time(end_time);

                coachService.updateCoachRoomInfo(coachRoomVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/site/coaching_room.do");
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/site/lawtax_list.do")
    public String lawtax_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/lawtax_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<LawtaxCounselVo> itemList = lawTaxService.selectLawTaxList(searchVo);
            int totalCount = lawTaxService.selectLawTaxListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/lawtax_view.do", method = RequestMethod.GET)
    public String lawtax_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/site/lawtax_view";
        String menu_url = "cont/site/lawtax_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            int lawtax_idx = ServletRequestUtils.getIntParameter(request, "lawtax_idx", 0);

            LawtaxCounselVo lawtaxCounselVo = new LawtaxCounselVo();
            lawtaxCounselVo.setLawtax_idx(lawtax_idx);

            lawtaxCounselVo = lawTaxService.selectLawTax(lawtaxCounselVo);
            String cont = lawtaxCounselVo.getCont();
            if(!"".equals(Util.nvl(cont))) {
                cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
                lawtaxCounselVo.setCont(cont);
            }

            model.addAttribute("lawtaxCounselVo", lawtaxCounselVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/lawtax_view.do", method = RequestMethod.POST)
    public String lawtax_view_proc(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("lawtaxCounselVo") LawtaxCounselVo lawtaxCounselVo,
                                     BindingResult bindingResult,
                                     Model model,
                                     SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                lawtaxCounselVo.setUp_id(adminLoginVo.getAdmin_id());

                lawTaxService.updateLawTax(lawtaxCounselVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/site/lawtax_list.do");
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/site/lawtax_delete.do", method = RequestMethod.POST)
    public String lawtax_delete(final MultipartHttpServletRequest multiRequest,
                                @ModelAttribute("lawtaxCounselVo") LawtaxCounselVo lawtaxCounselVo,
                                BindingResult bindingResult,
                                Model model,
                                SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                lawTaxService.deleteLawTax(lawtaxCounselVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/site/lawtax_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }
}
