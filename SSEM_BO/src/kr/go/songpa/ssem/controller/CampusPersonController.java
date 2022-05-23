package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.BbsService;
import kr.go.songpa.ssem.service.CampusService;
import kr.go.songpa.ssem.service.FileMngService;
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
 * Date : 2020-09-28
 * Description :
 * History :
 * Version :
 */
@Controller
public class CampusPersonController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    @Autowired
    private BbsService bbsService;

    @Autowired
    private CampusService campusService;

    public CampusPersonController() {
    }

    @RequestMapping("/cont/campus/person_banner_list.do")
    public String person_banner_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/person_banner_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("PERSON");

            List<BannerVo> bannerList = bbsService.selectBannerList(searchVo);
            int totalCount = bbsService.selectBannerListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bannerList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/person_banner_inscr.do", method = RequestMethod.GET)
    public String person_banner_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/person_banner_inscr";
        String menu_url = "cont/campus/person_banner_list";
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

    @RequestMapping(value = "/cont/campus/person_banner_inscr.do", method = RequestMethod.POST)
    public String person_banner_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                // 이미지파일 처리
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bannerVo.setAtch_file_id(atchFileId);
                    bannerVo.setReg_id(adminLoginVo.getAdmin_id());
                    bannerVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bannerVo.setGubun("PERSON"); // 송파진로체험지원센터(꿈마루)

                    bbsService.insertBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/person_banner_list.do");
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

    @RequestMapping(value = "/cont/campus/person_banner_view.do", method = RequestMethod.GET)
    public String person_banner_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/person_banner_view";
        String menu_url = "cont/campus/person_banner_list";
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
            int banner_idx = ServletRequestUtils.getIntParameter(request, "banner_idx", 0);

            BannerVo bannerVo = new BannerVo();
            bannerVo.setBanner_idx(banner_idx);

            bannerVo = bbsService.selectBannerInfo(bannerVo);

            // 첨부파일 처리
            String atchFileId = bannerVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            bannerVo.setFileList(fileVoList);

            model.addAttribute("bannerVo", bannerVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/person_banner_view.do", method = RequestMethod.POST)
    public String person_banner_view_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bannerVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_",cnt, bannerVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bannerVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bannerVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bannerVo.setAtch_file_id("");
                        }
                    }

                    bannerVo.setUp_id(adminLoginVo.getAdmin_id());
                    bannerVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bannerVo.setGubun("PERSON");

                    bbsService.updateBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/person_banner_list.do");
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

    @RequestMapping(value = "/cont/campus/person_banner_delete.do", method = RequestMethod.POST)
    public String person_banner_delete(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                bbsService.deleteBannerInfo(bannerVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/person_banner_list.do");
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

    @RequestMapping(value = "/cont/campus/person_banner_ord.do", method = RequestMethod.POST)
    public String person_banner_ord_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                if(bannerVo.getOrdList().size() > 0) {
                    for (OrdVo ord : bannerVo.getOrdList()) {
                        bbsService.updateBannerOrd(ord);
                    }
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/person_banner_list.do");
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

    @RequestMapping("/cont/campus/person_book_list.do")
    public String person_book_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/person_book_list";
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

            searchVo.setSearchVal2("N"); // gubun 값

            List<PersonBookVo> itemList = campusService.selectPersonBookList(searchVo);
            int totalCount = campusService.selectPersonBookListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/person_book_inscr.do", method = RequestMethod.GET)
    public String person_book_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/person_book_inscr";
        String menu_url = "cont/campus/person_book_list";
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

    @RequestMapping(value = "/cont/campus/person_book_inscr.do", method = RequestMethod.POST)
    public String person_book_inproc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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
                // 썸네일 등록 정보
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        thumbFileid = fileMngService.insertFileInfs(result);
                    }

                    personBookVo.setThumb_atch_file_id(thumbFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    personBookVo.setAtch_file_id(atchFileId);
                    personBookVo.setReg_id(adminLoginVo.getAdmin_id());
                    personBookVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    personBookVo.setGubun("N"); // 일반

                    campusService.insertPersonBookInfo(personBookVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/person_book_list.do");
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

    @RequestMapping(value = "/cont/campus/person_book_view.do", method = RequestMethod.GET)
    public String person_book_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/person_book_view";
        String menu_url = "cont/campus/person_book_list";
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
            int person_book_idx = ServletRequestUtils.getIntParameter(request, "person_book_idx", 0);

            PersonBookVo personBookVo = new PersonBookVo();
            personBookVo.setPerson_book_idx(person_book_idx);

            campusService.updatePersonBookViewCnt(personBookVo);
            personBookVo = campusService.selectPersonBookInfo(personBookVo);

            //썸네일 처리
            String thumbFileId = personBookVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setThumbFileList(thumbFileList);

            // 첨부파일 처리
            String atchFileId = personBookVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setFileList(fileVoList);

            model.addAttribute("personBookVo", personBookVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/person_book_view.do", method = RequestMethod.POST)
    public String person_book_view_proc(final MultipartHttpServletRequest multiRequest,
                                            @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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

                // 썸네일 처리
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getThumb_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_",cnt, personBookVo.getThumb_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            thumbFileid = fileMngService.insertFileInfs(result);
                            personBookVo.setThumb_atch_file_id(thumbFileid);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getThumb_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            personBookVo.setThumb_atch_file_id("");
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_",cnt, personBookVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            personBookVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            personBookVo.setAtch_file_id("");
                        }
                    }

                    personBookVo.setUp_id(adminLoginVo.getAdmin_id());
                    personBookVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    campusService.updatePersonBookInfo(personBookVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/person_book_list.do");
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

    @RequestMapping(value = "/cont/campus/person_book_delete.do", method = RequestMethod.POST)
    public String person_book_delete(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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
                campusService.deletePersonBookInfo(personBookVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/person_book_list.do");
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

    @RequestMapping("/cont/campus/school_book_list.do")
    public String school_book_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/school_book_list";
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

            searchVo.setSearchVal2("S"); // gubun 값

            List<PersonBookVo> itemList = campusService.selectPersonBookList(searchVo);
            int totalCount = campusService.selectPersonBookListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/school_book_inscr.do", method = RequestMethod.GET)
    public String school_book_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/school_book_inscr";
        String menu_url = "cont/campus/school_book_list";
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

    @RequestMapping(value = "/cont/campus/school_book_inscr.do", method = RequestMethod.POST)
    public String school_book_inproc(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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
                // 썸네일 등록 정보
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        thumbFileid = fileMngService.insertFileInfs(result);
                    }

                    personBookVo.setThumb_atch_file_id(thumbFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    personBookVo.setAtch_file_id(atchFileId);
                    personBookVo.setReg_id(adminLoginVo.getAdmin_id());
                    personBookVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    personBookVo.setGubun("S"); // 일반

                    campusService.insertPersonBookInfo(personBookVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/school_book_list.do");
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

    @RequestMapping(value = "/cont/campus/school_book_view.do", method = RequestMethod.GET)
    public String school_book_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/school_book_view";
        String menu_url = "cont/campus/school_book_list";
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
            int person_book_idx = ServletRequestUtils.getIntParameter(request, "person_book_idx", 0);

            PersonBookVo personBookVo = new PersonBookVo();
            personBookVo.setPerson_book_idx(person_book_idx);

            campusService.updatePersonBookViewCnt(personBookVo);
            personBookVo = campusService.selectPersonBookInfo(personBookVo);

            //썸네일 처리
            String thumbFileId = personBookVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setThumbFileList(thumbFileList);

            // 첨부파일 처리
            String atchFileId = personBookVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setFileList(fileVoList);

            model.addAttribute("personBookVo", personBookVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/school_book_view.do", method = RequestMethod.POST)
    public String school_book_view_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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

                // 썸네일 처리
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getThumb_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_",cnt, personBookVo.getThumb_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            thumbFileid = fileMngService.insertFileInfs(result);
                            personBookVo.setThumb_atch_file_id(thumbFileid);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getThumb_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            personBookVo.setThumb_atch_file_id("");
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_",cnt, personBookVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            personBookVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            personBookVo.setAtch_file_id("");
                        }
                    }

                    personBookVo.setUp_id(adminLoginVo.getAdmin_id());
                    personBookVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    campusService.updatePersonBookInfo(personBookVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/school_book_list.do");
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

    @RequestMapping(value = "/cont/campus/school_book_delete.do", method = RequestMethod.POST)
    public String school_book_delete(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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
                campusService.deletePersonBookInfo(personBookVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/school_book_list.do");
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

    @RequestMapping("/cont/campus/month_book_list.do")
    public String month_book_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/month_book_list";
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

            searchVo.setSearchVal2("M"); // gubun 값

            List<PersonBookVo> itemList = campusService.selectPersonBookList(searchVo);
            int totalCount = campusService.selectPersonBookListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/month_book_inscr.do", method = RequestMethod.GET)
    public String month_book_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/month_book_inscr";
        String menu_url = "cont/campus/month_book_list";
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

    @RequestMapping(value = "/cont/campus/month_book_inscr.do", method = RequestMethod.POST)
    public String month_book_inproc(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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
                // 썸네일 등록 정보
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        thumbFileid = fileMngService.insertFileInfs(result);
                    }

                    personBookVo.setThumb_atch_file_id(thumbFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    personBookVo.setAtch_file_id(atchFileId);
                    personBookVo.setReg_id(adminLoginVo.getAdmin_id());
                    personBookVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    personBookVo.setGubun("M"); // 일반

                    String year_month = personBookVo.getYear_month();
                    String[] tokens = year_month.split("-");
                    String year = tokens[0];
                    String month = tokens[1];

                    personBookVo.setYear(Integer.parseInt(year));
                    personBookVo.setMonth(Integer.parseInt(month));

                    campusService.insertPersonBookInfo(personBookVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/month_book_list.do");
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

    @RequestMapping(value = "/cont/campus/month_book_view.do", method = RequestMethod.GET)
    public String month_book_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/month_book_view";
        String menu_url = "cont/campus/month_book_list";
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
            int person_book_idx = ServletRequestUtils.getIntParameter(request, "person_book_idx", 0);

            PersonBookVo personBookVo = new PersonBookVo();
            personBookVo.setPerson_book_idx(person_book_idx);

            campusService.updatePersonBookViewCnt(personBookVo);
            personBookVo = campusService.selectPersonBookInfo(personBookVo);

            //썸네일 처리
            String thumbFileId = personBookVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setThumbFileList(thumbFileList);

            // 첨부파일 처리
            String atchFileId = personBookVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setFileList(fileVoList);

            model.addAttribute("personBookVo", personBookVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/month_book_view.do", method = RequestMethod.POST)
    public String month_book_view_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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

                // 썸네일 처리
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getThumb_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_",cnt, personBookVo.getThumb_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            thumbFileid = fileMngService.insertFileInfs(result);
                            personBookVo.setThumb_atch_file_id(thumbFileid);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getThumb_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            personBookVo.setThumb_atch_file_id("");
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_",cnt, personBookVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            personBookVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            personBookVo.setAtch_file_id("");
                        }
                    }

                    personBookVo.setUp_id(adminLoginVo.getAdmin_id());
                    personBookVo.setGroup_idx(adminLoginVo.getGroup_idx());

                    String year_month = personBookVo.getYear_month();
                    String[] tokens = year_month.split("-");
                    String year = tokens[0];
                    String month = tokens[1];

                    personBookVo.setYear(Integer.parseInt(year));
                    personBookVo.setMonth(Integer.parseInt(month));

                    campusService.updatePersonBookInfo(personBookVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/month_book_list.do");
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

    @RequestMapping(value = "/cont/campus/month_book_delete.do", method = RequestMethod.POST)
    public String month_book_delete(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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
                campusService.deletePersonBookInfo(personBookVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/month_book_list.do");
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

    @RequestMapping("/cont/campus/live_book_list.do")
    public String live_book_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/live_book_list";
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

            searchVo.setSearchVal2("L"); // gubun 값

            List<PersonBookVo> itemList = campusService.selectPersonBookList(searchVo);
            int totalCount = campusService.selectPersonBookListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/live_book_inscr.do", method = RequestMethod.GET)
    public String live_book_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/live_book_inscr";
        String menu_url = "cont/campus/live_book_list";
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

    @RequestMapping(value = "/cont/campus/live_book_inscr.do", method = RequestMethod.POST)
    public String live_book_inproc(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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
                // 썸네일 등록 정보
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        thumbFileid = fileMngService.insertFileInfs(result);
                    }

                    personBookVo.setThumb_atch_file_id(thumbFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    personBookVo.setAtch_file_id(atchFileId);
                    personBookVo.setReg_id(adminLoginVo.getAdmin_id());
                    personBookVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    personBookVo.setGubun("L"); // 일반

                    campusService.insertPersonBookInfo(personBookVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/live_book_list.do");
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

    @RequestMapping(value = "/cont/campus/live_book_view.do", method = RequestMethod.GET)
    public String live_book_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/live_book_view";
        String menu_url = "cont/campus/live_book_list";
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
            int person_book_idx = ServletRequestUtils.getIntParameter(request, "person_book_idx", 0);

            PersonBookVo personBookVo = new PersonBookVo();
            personBookVo.setPerson_book_idx(person_book_idx);

            campusService.updatePersonBookViewCnt(personBookVo);
            personBookVo = campusService.selectPersonBookInfo(personBookVo);

            //썸네일 처리
            String thumbFileId = personBookVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setThumbFileList(thumbFileList);

            // 첨부파일 처리
            String atchFileId = personBookVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setFileList(fileVoList);

            model.addAttribute("personBookVo", personBookVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/live_book_view.do", method = RequestMethod.POST)
    public String live_book_view_proc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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

                // 썸네일 처리
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getThumb_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_",cnt, personBookVo.getThumb_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            thumbFileid = fileMngService.insertFileInfs(result);
                            personBookVo.setThumb_atch_file_id(thumbFileid);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getThumb_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            personBookVo.setThumb_atch_file_id("");
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_",cnt, personBookVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            personBookVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            personBookVo.setAtch_file_id("");
                        }
                    }

                    personBookVo.setUp_id(adminLoginVo.getAdmin_id());
                    personBookVo.setGroup_idx(adminLoginVo.getGroup_idx());

                    campusService.updatePersonBookInfo(personBookVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/live_book_list.do");
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

    @RequestMapping(value = "/cont/campus/live_book_delete.do", method = RequestMethod.POST)
    public String live_book_delete(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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
                campusService.deletePersonBookInfo(personBookVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/live_book_list.do");
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

    @RequestMapping("/cont/campus/review_book_list.do")
    public String review_book_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/review_book_list";
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

            searchVo.setSearchVal2("R"); // gubun 값

            List<PersonBookVo> itemList = campusService.selectPersonBookList(searchVo);
            int totalCount = campusService.selectPersonBookListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/review_book_inscr.do", method = RequestMethod.GET)
    public String review_book_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/review_book_inscr";
        String menu_url = "cont/campus/review_book_list";
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

    @RequestMapping(value = "/cont/campus/review_book_inscr.do", method = RequestMethod.POST)
    public String review_book_inproc(final MultipartHttpServletRequest multiRequest,
                                   @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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
                // 썸네일 등록 정보
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        thumbFileid = fileMngService.insertFileInfs(result);
                    }

                    personBookVo.setThumb_atch_file_id(thumbFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    personBookVo.setAtch_file_id(atchFileId);
                    personBookVo.setReg_id(adminLoginVo.getAdmin_id());
                    personBookVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    personBookVo.setGubun("R"); // 일반

                    campusService.insertPersonBookInfo(personBookVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/review_book_list.do");
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

    @RequestMapping(value = "/cont/campus/review_book_view.do", method = RequestMethod.GET)
    public String review_book_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/review_book_view";
        String menu_url = "cont/campus/review_book_list";
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
            int person_book_idx = ServletRequestUtils.getIntParameter(request, "person_book_idx", 0);

            PersonBookVo personBookVo = new PersonBookVo();
            personBookVo.setPerson_book_idx(person_book_idx);

            campusService.updatePersonBookViewCnt(personBookVo);
            personBookVo = campusService.selectPersonBookInfo(personBookVo);

            //썸네일 처리
            String thumbFileId = personBookVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setThumbFileList(thumbFileList);

            // 첨부파일 처리
            String atchFileId = personBookVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setFileList(fileVoList);

            model.addAttribute("personBookVo", personBookVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/review_book_view.do", method = RequestMethod.POST)
    public String review_book_view_proc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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

                // 썸네일 처리
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getThumb_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_",cnt, personBookVo.getThumb_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            thumbFileid = fileMngService.insertFileInfs(result);
                            personBookVo.setThumb_atch_file_id(thumbFileid);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getThumb_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            personBookVo.setThumb_atch_file_id("");
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_",cnt, personBookVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            personBookVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            personBookVo.setAtch_file_id("");
                        }
                    }

                    personBookVo.setUp_id(adminLoginVo.getAdmin_id());
                    personBookVo.setGroup_idx(adminLoginVo.getGroup_idx());

                    campusService.updatePersonBookInfo(personBookVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/review_book_list.do");
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

    @RequestMapping(value = "/cont/campus/review_book_delete.do", method = RequestMethod.POST)
    public String review_book_delete(final MultipartHttpServletRequest multiRequest,
                                   @ModelAttribute("personBookVo") PersonBookVo personBookVo,
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
                campusService.deletePersonBookInfo(personBookVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/review_book_list.do");
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

    @RequestMapping("/cont/campus/person_apply_list.do")
    public String person_apply_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/person_apply_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchEx(request, -3, 0);
        this.getModelEx(request, model, -3, -0);

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

            List<PersonBookApyVo> itemList = campusService.selectPersonBookApplyList(searchVo);
            int totalCount = campusService.selectPersonBookApplyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/person_apply_view.do", method = RequestMethod.GET)
    public String person_apply_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/person_apply_view";
        String menu_url = "cont/campus/person_apply_list";
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
            int person_book_apy_idx = ServletRequestUtils.getIntParameter(request, "person_book_apy_idx", 0);

            PersonBookApyVo personBookApyVo = new PersonBookApyVo();
            personBookApyVo.setPerson_book_apy_idx(person_book_apy_idx);

            campusService.updatePersonBookApplyViewCnt(personBookApyVo);
            personBookApyVo = campusService.selectPersonBookApplyInfo(personBookApyVo);

            // 엔터처리
            String reason = personBookApyVo.getReason();
            if(!"".equals(Util.nvl(reason))) {
                reason = reason.replaceAll(System.getProperty("line.separator"), "<br/>");
            }
            personBookApyVo.setReason(reason);

            model.addAttribute("personBookApyVo", personBookApyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/person_apply_view.do", method = RequestMethod.POST)
    public String person_apply_view_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("personBookApyVo") PersonBookApyVo personBookApyVo,
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
                personBookApyVo.setUp_id(adminLoginVo.getAdmin_id());

                campusService.updatePersonBookApplyInfo(personBookApyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/person_apply_list.do");
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/campus/person_reg_list.do")
    public String person_reg_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/person_reg_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchEx(request, -6, 0);
        this.getModelEx(request, model, -6, -0);

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

            List<PersonBookRegVo> itemList = campusService.selectPersonBookRegList(searchVo);
            int totalCount = campusService.selectPersonBookRegListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/person_reg_view.do", method = RequestMethod.GET)
    public String person_reg_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/person_reg_view";
        String menu_url = "cont/campus/person_reg_list";
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
            int person_book_reg_idx = ServletRequestUtils.getIntParameter(request, "person_book_reg_idx", 0);

            PersonBookRegVo personBookRegVo = new PersonBookRegVo();
            personBookRegVo.setPerson_book_reg_idx(person_book_reg_idx);

            personBookRegVo = campusService.selectPersonBookRegInfo(personBookRegVo);

            // 첨부파일 처리
            String atchFileId = personBookRegVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            personBookRegVo.setFileList(fileVoList);

            model.addAttribute("personBookRegVo", personBookRegVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/person_reg_view.do", method = RequestMethod.POST)
    public String person_reg_view_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("personBookRegVo") PersonBookRegVo personBookRegVo,
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
                personBookRegVo.setUp_id(adminLoginVo.getAdmin_id());

                campusService.updatePersonBookRegInfo(personBookRegVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/person_reg_list.do");
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }
}
