package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.*;
import kr.go.songpa.ssem.util.DateUtil;
import kr.go.songpa.ssem.util.FileMngUtil;
import kr.go.songpa.ssem.util.Util;
import lgdacom.XPayClient.XPayClient;
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
import java.util.ArrayList;
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
public class CampusInstrumentController extends CommonController {

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

    @Autowired
    private MsgService msgService;

    public CampusInstrumentController() {
    }

    @RequestMapping("/cont/campus/instrum_banner_list.do")
    public String instrum_banner_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_banner_list";
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
            searchVo.setSearchKind("INSTRUM");

            List<BannerVo> bannerList = bbsService.selectBannerList(searchVo);
            int totalCount = bbsService.selectBannerListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bannerList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_banner_inscr.do", method = RequestMethod.GET)
    public String instrum_banner_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_banner_inscr";
        String menu_url = "cont/campus/instrum_banner_list";
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

    @RequestMapping(value = "/cont/campus/instrum_banner_inscr.do", method = RequestMethod.POST)
    public String instrum_banner_inproc(final MultipartHttpServletRequest multiRequest,
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
                    bannerVo.setGubun("INSTRUM"); // 송파진로체험지원센터(꿈마루)

                    bbsService.insertBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_banner_list.do");
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

    @RequestMapping(value = "/cont/campus/instrum_banner_view.do", method = RequestMethod.GET)
    public String instrum_banner_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_banner_view";
        String menu_url = "cont/campus/instrum_banner_list";
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

    @RequestMapping(value = "/cont/campus/instrum_banner_view.do", method = RequestMethod.POST)
    public String instrum_banner_view_proc(final MultipartHttpServletRequest multiRequest,
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
                    bannerVo.setGubun("INSTRUM");

                    bbsService.updateBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_banner_list.do");
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

    @RequestMapping(value = "/cont/campus/instrum_banner_delete.do", method = RequestMethod.POST)
    public String instrum_banner_delete(final MultipartHttpServletRequest multiRequest,
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
                model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_banner_list.do");
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

    @RequestMapping(value = "/cont/campus/instrum_banner_ord.do", method = RequestMethod.POST)
    public String instrum_banner_ord_proc(final MultipartHttpServletRequest multiRequest,
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
                model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_banner_list.do");
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

    @RequestMapping("/cont/campus/instrum_reg_list.do")
    public String instrum_reg_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_reg_list";
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

            List<InstrumVo> itemList = campusService.selectInstrumRegList(searchVo);
            int totalCount = campusService.selectInstrumRegListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_reg_inscr.do", method = RequestMethod.GET)
    public String instrum_reg_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_reg_inscr";
        String menu_url = "cont/campus/instrum_reg_list";
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

    @RequestMapping(value = "/cont/campus/instrum_reg_inscr.do", method = RequestMethod.POST)
    public String instrum_reg_inproc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("instrumVo") InstrumVo instrumVo,
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
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "IT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    instrumVo.setAtch_file_id(atchFileId);
                    instrumVo.setReg_id(adminLoginVo.getAdmin_id());
                    instrumVo.setGroup_idx(adminLoginVo.getGroup_idx());

                    campusService.insertInstrumInfo(instrumVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_reg_list.do");
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

    @RequestMapping(value = "/cont/campus/instrum_reg_view.do", method = RequestMethod.GET)
    public String instrum_reg_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_reg_view";
        String menu_url = "cont/campus/instrum_reg_list";
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
            int instrum_idx = ServletRequestUtils.getIntParameter(request, "instrum_idx", 0);

            InstrumVo instrumVo = new InstrumVo();
            instrumVo.setInstrum_idx(instrum_idx);

            instrumVo = campusService.selectInstrumInfo(instrumVo);

            // 첨부파일 처리
            String atchFileId = instrumVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            instrumVo.setFileList(fileVoList);

            model.addAttribute("instrumVo", instrumVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_reg_view.do", method = RequestMethod.POST)
    public String instrum_reg_view_proc(final MultipartHttpServletRequest multiRequest,
                                           @ModelAttribute("instrumVo") InstrumVo instrumVo,
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
                        fvo.setAtch_file_id(instrumVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "IT_",cnt, instrumVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "IT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            instrumVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(instrumVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            instrumVo.setAtch_file_id("");
                        }
                    }

                    instrumVo.setUp_id(adminLoginVo.getAdmin_id());
                    instrumVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    campusService.updateInstrumInfo(instrumVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_reg_list.do");
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

    @RequestMapping("/cont/campus/instrum_apply_list.do")
    public String instrum_apply_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_apply_list";
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

            List<InstrumApyVo> itemList = campusService.selectInstrumApyList(searchVo);
            // 연체여부 판단
            for(InstrumApyVo apply : itemList) {
                String today = Util.getDate(3);
                if("N".equals(apply.getReturn_yn()) && "O".equals(apply.getStatus())) {
                    long late_day = DateUtil.calDates(today, apply.getRental_end_dt());
                    if( late_day > 0) {
                        apply.setLate_yn("Y");
                        apply.setLate_day(late_day);
                    } else {
                        apply.setLate_yn("N");
                    }
                }
            }
            int totalCount = campusService.selectInstrumApyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_apply_view.do", method = RequestMethod.GET)
    public String instrum_apply_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_apply_view";
        String menu_url = "cont/campus/instrum_apply_list";
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
            int instrum_apy_idx = ServletRequestUtils.getIntParameter(request, "instrum_apy_idx", 0);

            InstrumApyVo instrumApyVo = new InstrumApyVo();
            instrumApyVo.setInstrum_apy_idx(instrum_apy_idx);

            instrumApyVo = campusService.selectInstrumApyInfo(instrumApyVo);

            // 연체여부 판단
            String today = Util.getDate(3);
            if("N".equals(instrumApyVo.getReturn_yn()) && "O".equals(instrumApyVo.getStatus())) {
                long late_day = DateUtil.calDates(today, instrumApyVo.getRental_end_dt());
                if( late_day > 0) {
                    instrumApyVo.setLate_yn("Y");
                    instrumApyVo.setLate_day(late_day);
                } else {
                    instrumApyVo.setLate_yn("N");
                }
            } else {
                instrumApyVo.setLate_yn("N");
            }

            // 첨부파일 처리
            String atchFileId = instrumApyVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            instrumApyVo.setFileList(fileVoList);

            model.addAttribute("instrumApyVo", instrumApyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_apply_view.do", method = RequestMethod.POST)
    public String instrum_apply_view_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("instrumApyVo") InstrumApyVo instrumApyVo,
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
                        fvo.setAtch_file_id(instrumApyVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "IT_",cnt, instrumApyVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "IT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            instrumApyVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(instrumApyVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            instrumApyVo.setAtch_file_id("");
                        }
                    }

                    String pay_dt = instrumApyVo.getPay_dt();
                    if ("1900-01-01".equals(pay_dt)) {
                        instrumApyVo.setPay_dt(null);
                    }

                    String refund_dt = instrumApyVo.getRefund_dt();
                    if ("1900-01-01".equals(refund_dt)) {
                        instrumApyVo.setRefund_dt(null);
                    }

                    String return_dt = instrumApyVo.getReturn_dt();
                    if ("1900-01-01".equals(return_dt)) {
                        instrumApyVo.setReturn_dt(null);
                    }

                    if("R".equals(instrumApyVo.getStatus()) || "C".equals(instrumApyVo.getStatus()) ) {
                        // 신청수량 삭제
                        campusService.updateInstrumRentalQty(instrumApyVo);
                        instrumApyVo.setLate_day(0);
                    }

                    if("O".equals(instrumApyVo.getStatus()) && instrumApyVo.getPay_status() == null) {
                        // 승인 처리 시 결제상태 결제대기로 셋팅
                        instrumApyVo.setPay_status("A");
                    }

                    /*if("C".equals(instrumApyVo.getStatus()) && instrumApyVo.getPay_status() == null) {
                        // 승인취소 시 대여 수량 복귀한다
                        campusService.updateInstrumRentalQty(instrumApyVo);
                    }*/

                    if(!"Y".equals(instrumApyVo.getReturn_flag()) && "Y".equals(instrumApyVo.getReturn_yn())) {
                        // 반납이 되면 대여 수량 복귀 한다.
                        campusService.updateInstrumRentalQty(instrumApyVo);
                        instrumApyVo.setReturn_flag("Y");
                    }

                    long rental_qty = instrumApyVo.getRental_qty();
                    if("N".equals(instrumApyVo.getReturn_yn())) {
                        if("Y".equals(instrumApyVo.getReturn_flag())) {
                            // 다시 대여 수량 처리한다.
                            instrumApyVo.setRental_qty(-rental_qty);
                            campusService.updateInstrumRentalQty(instrumApyVo);
                        }
                        instrumApyVo.setRental_qty(rental_qty);
                        instrumApyVo.setReturn_dt(null);
                        instrumApyVo.setReturn_flag("N");
                    }

                    instrumApyVo.setUp_id(adminLoginVo.getAdmin_id());
                    campusService.updateInstrumApyInfo(instrumApyVo);

                    // 승인시 메세지 발송
                    if("O".equals(instrumApyVo.getStatus())) {
                        // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        if ("yes".equals(EgovProperties.getProperty("msg.send"))) {
                            InstrumApyVo apply = campusService.selectInstrumApyInfoByIdx(instrumApyVo.getInstrum_apy_idx());
                            InstrumVo instrumVo = campusService.selectInstrumInfoByIdx(apply.getInstrum_idx());

                            StringBuffer sb = new StringBuffer();
                            sb.append("[송파구청 송파쌤(SSEM)]");
                            sb.append("\r\n");
                            sb.append(String.format("%s님의 악기대여 신청이 승인되었습니다.", apply.getApy_nm()));
                            sb.append("\r\n");
                            sb.append("<악기대여 신청내역>");
                            sb.append("\r\n");
                            sb.append(String.format("- 악기명: %s", instrumVo.getName()));
                            sb.append("\r\n");
                            sb.append(String.format("- 대여수량: %d", apply.getRental_qty()));
                            sb.append("\r\n");
                            sb.append(String.format("- 대여기간: %s~%s", apply.getRental_start_dt(), apply.getRental_end_dt()));
                            sb.append("\r\n");
                            sb.append("악기대여는 현장결제로 진행되며, 악기대여 신청 확인은 마이페이지에서 확인이 가능합니다.");
                            sb.append("\r\n");
                            sb.append("감사합니다.");
                            sb.append("\r\n");
                            sb.append("☎ 문의: 송파쌤(SSEM) 악기도서관 02-2147-2544");

                            msgService.sendMsgKakao("악기대여 신청완료 관리자승인", sb.toString(), apply.getApy_nm(), apply.getApy_mob_no().replaceAll("-", ""), "UMS_2021061514563743639");
                        }
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    }

                    // 신청취소시 메세지 발송
                    if("R".equals(instrumApyVo.getStatus())) {
                        // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        if ("yes".equals(EgovProperties.getProperty("msg.send"))) {
                            InstrumApyVo apply = campusService.selectInstrumApyInfoByIdx(instrumApyVo.getInstrum_apy_idx());
                            InstrumVo instrumVo = campusService.selectInstrumInfoByIdx(apply.getInstrum_idx());

                            StringBuffer sb = new StringBuffer();
                            sb.append("[송파구청 송파쌤(SSEM)]");
                            sb.append("\r\n");
                            sb.append(String.format("%s님의 악기대여 신청이 취소되었습니다.", apply.getApy_nm()));
                            sb.append("\r\n");
                            sb.append("<취소내역>");
                            sb.append("\r\n");
                            sb.append(String.format("- 악기명: %s", instrumVo.getName()));
                            sb.append("\r\n");
                            sb.append(String.format("- 대여수량: %d", apply.getRental_qty()));
                            sb.append("\r\n");
                            sb.append(String.format("- 대여기간: %s~%s", apply.getRental_start_dt(), apply.getRental_end_dt()));
                            sb.append("\r\n");
                            sb.append("신청취소 확인은 마이페이지에서 확인이 가능합니다.");
                            sb.append("\r\n");
                            sb.append("감사합니다.");
                            sb.append("\r\n");
                            sb.append("☎ 문의: 송파쌤(SSEM) 악기도서관 02-2147-2544");

                            msgService.sendMsgKakao("악기대여 신청취소", sb.toString(), apply.getApy_nm(), apply.getApy_mob_no().replaceAll("-", ""), "UMS_2021061514563772590");
                        }
                        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    }

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_apply_list.do");
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

    @RequestMapping("/cont/campus/instrum_donation_list.do")
    public String instrum_donation_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_donation_list";
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

            List<InstrumDntVo> itemList = campusService.selectInstrumDntList(searchVo);
            int totalCount = campusService.selectInstrumDntListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_donation_view.do", method = RequestMethod.GET)
    public String instrum_donation_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_donation_view";
        String menu_url = "cont/campus/instrum_donation_list";
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
            int instrum_dnt_idx = ServletRequestUtils.getIntParameter(request, "instrum_dnt_idx", 0);

            InstrumDntVo instrumDntVo = new InstrumDntVo();
            instrumDntVo.setInstrum_dnt_idx(instrum_dnt_idx);

            instrumDntVo = campusService.selectInstrumDntInfo(instrumDntVo);

            // 첨부파일 처리
            String atchFileId = instrumDntVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            instrumDntVo.setFileList(fileVoList);

            // 악기설명 line 처리
            String cont = instrumDntVo.getCont();
            cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
            instrumDntVo.setCont(cont);

            model.addAttribute("instrumDntVo", instrumDntVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_donation_view.do", method = RequestMethod.POST)
    public String instrum_donation_view_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("instrumDntVo") InstrumDntVo instrumDntVo,
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
                instrumDntVo.setUp_id(adminLoginVo.getAdmin_id());
                campusService.updateInstrumDntInfo(instrumDntVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_donation_list.do");
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

    @RequestMapping(value = "/cont/campus/instrum_donation_delete.do", method = RequestMethod.POST)
    public String instrum_donation_delete(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("instrumDntVo") InstrumDntVo instrumDntVo,
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
                campusService.deleteInstrumDntInfo(instrumDntVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_donation_list.do");
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

    @RequestMapping("/cont/campus/instrum_review_list.do")
    public String instrum_review_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_review_list";
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

            List<InstrumReviewVo> itemList = campusService.selectInstrumReviewList(searchVo);
            int totalCount = campusService.selectInstrumReviewListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_review_inscr.do", method = RequestMethod.GET)
    public String instrum_review_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_review_inscr";
        String menu_url = "cont/campus/instrum_review_list";
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

    @RequestMapping(value = "/cont/campus/instrum_review_inscr.do", method = RequestMethod.POST)
    public String instrum_review_inproc(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("instrumReviewVo") InstrumReviewVo instrumReviewVo,
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
                        List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "IT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        thumbFileid = fileMngService.insertFileInfs(result);
                    }

                    instrumReviewVo.setThumb_atch_file_id(thumbFileid);
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
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "IT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    instrumReviewVo.setAtch_file_id(atchFileId);
                    instrumReviewVo.setReg_id(adminLoginVo.getAdmin_id());
                    instrumReviewVo.setGroup_idx(adminLoginVo.getGroup_idx());

                    campusService.insertInstrumReviewInfo(instrumReviewVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_review_list.do");
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

    @RequestMapping(value = "/cont/campus/instrum_review_view.do", method = RequestMethod.GET)
    public String instrum_review_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_review_view";
        String menu_url = "cont/campus/instrum_review_list";
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
            int instrum_review_idx = ServletRequestUtils.getIntParameter(request, "instrum_review_idx", 0);

            InstrumReviewVo instrumReviewVo = new InstrumReviewVo();
            instrumReviewVo.setInstrum_review_idx(instrum_review_idx);

            campusService.updateInstrumReviewViewCnt(instrumReviewVo);
            instrumReviewVo = campusService.selectInstrumReviewInfo(instrumReviewVo);

            //썸네일 처리
            String thumbFileId = instrumReviewVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            instrumReviewVo.setThumbFileList(thumbFileList);

            // 첨부파일 처리
            String atchFileId = instrumReviewVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            instrumReviewVo.setFileList(fileVoList);

            model.addAttribute("instrumReviewVo", instrumReviewVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_review_view.do", method = RequestMethod.POST)
    public String instrum_review_view_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("instrumReviewVo") InstrumReviewVo instrumReviewVo,
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
                        fvo.setAtch_file_id(instrumReviewVo.getThumb_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "IT_",cnt, instrumReviewVo.getThumb_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "IT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            thumbFileid = fileMngService.insertFileInfs(result);
                            instrumReviewVo.setThumb_atch_file_id(thumbFileid);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(instrumReviewVo.getThumb_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            instrumReviewVo.setThumb_atch_file_id("");
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
                        fvo.setAtch_file_id(instrumReviewVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "IT_",cnt, instrumReviewVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "IT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            instrumReviewVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(instrumReviewVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            instrumReviewVo.setAtch_file_id("");
                        }
                    }

                    instrumReviewVo.setUp_id(adminLoginVo.getAdmin_id());
                    instrumReviewVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    campusService.updateInstrumReviewInfo(instrumReviewVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_review_list.do");
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

    @RequestMapping(value = "/cont/campus/instrum_review_delete.do", method = RequestMethod.POST)
    public String instrum_review_delete(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("instrumReviewVo") InstrumReviewVo instrumReviewVo,
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
                campusService.deleteInstrumReviewInfo(instrumReviewVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_review_list.do");
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

    @RequestMapping("/cont/campus/instrum_rental_list.do")
    public String instrum_rental_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_rental_list";
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

            List<RentalFtyVo> itemList = campusService.selectRentalFtyList(searchVo);
            int totalCount = campusService.selectRentalFtyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_rental_inscr.do", method = RequestMethod.GET)
    public String instrum_rental_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_rental_inscr";
        String menu_url = "cont/campus/instrum_rental_list";
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

    @RequestMapping(value = "/cont/campus/instrum_rental_inscr.do", method = RequestMethod.POST)
    public String instrum_review_inproc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("rentalFtyVo") RentalFtyVo rentalFtyVo,
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
                        List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "RF_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        thumbFileid = fileMngService.insertFileInfs(result);
                    }

                    rentalFtyVo.setThumb_atch_file_id(thumbFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                rentalFtyVo.setReg_id(adminLoginVo.getAdmin_id());
                rentalFtyVo.setGroup_idx(adminLoginVo.getGroup_idx());

                campusService.insertRentalFtyInfo(rentalFtyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_rental_list.do");
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

    @RequestMapping(value = "/cont/campus/instrum_rental_view.do", method = RequestMethod.GET)
    public String instrum_rental_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_rental_view";
        String menu_url = "cont/campus/instrum_rental_list";
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

            int rental_fty_idx = ServletRequestUtils.getIntParameter(request, "rental_fty_idx", 0);

            RentalFtyVo rentalFtyVo = new RentalFtyVo();
            rentalFtyVo.setRental_fty_idx(rental_fty_idx);

            rentalFtyVo = campusService.selectRentalFtyInfo(rentalFtyVo);

            //썸네일 처리
            String thumbFileId = rentalFtyVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            rentalFtyVo.setThumbFileList(thumbFileList);

            model.addAttribute("rentalFtyVo", rentalFtyVo);

            GroupVo groupVo = appService.selectGruopByIdx(rentalFtyVo.getGroup_idx());

            String CST_PLATFORM = EgovProperties.getProperty("xpay.platform");
            String LGD_MID = groupVo.getPay_shop_id();

            model.addAttribute("CST_PLATFORM", CST_PLATFORM);
            model.addAttribute("LGD_MID", LGD_MID);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_rental_view.do", method = RequestMethod.POST)
    public String instrum_rental_view_proc(final MultipartHttpServletRequest multiRequest,
                                           @ModelAttribute("rentalFtyVo") RentalFtyVo rentalFtyVo,
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
                        fvo.setAtch_file_id(rentalFtyVo.getThumb_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "RF_",cnt, rentalFtyVo.getThumb_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "RF_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            thumbFileid = fileMngService.insertFileInfs(result);
                            rentalFtyVo.setThumb_atch_file_id(thumbFileid);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(rentalFtyVo.getThumb_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            rentalFtyVo.setThumb_atch_file_id("");
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                rentalFtyVo.setUp_id(adminLoginVo.getAdmin_id());
                campusService.updateRentalFtyInfo(rentalFtyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_rental_list.do");
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

    @RequestMapping("/cont/campus/instrum_rental_schedule.do")
    public String instrum_rental_schedule(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_rental_schedule";
        String menu_url = "cont/campus/instrum_rental_list";
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

            int rental_fty_idx = ServletRequestUtils.getIntParameter(request, "rental_fty_idx", 0);
            RentalFtyVo rentalFtyVo = campusService.selectRentalFtyInfoByIdx(rental_fty_idx);

            model.addAttribute("rentalFtyVo", rentalFtyVo);

            // 현재 월을 보여준다.
            if("".equals(searchVo.getSearchKind())) {
                searchVo.setSearchKind(DateUtil.getYear());
                model.addAttribute("searchKind", DateUtil.getYear());
            }

            // 현재 월을 보여준다.
            if("".equals(searchVo.getSearchVal())) {
                searchVo.setSearchVal(DateUtil.getMonth());
                model.addAttribute("searchVal", DateUtil.getMonth());
            }

            List<String> dayList = DateUtil.getDayList( Integer.parseInt(searchVo.getSearchKind()), Integer.parseInt(searchVo.getSearchVal()));
            List<DateVo> dateList = new ArrayList<DateVo>();
            for(String day : dayList) {
                DateVo date = new DateVo();
                date.setDate(day);
                date.setWeek_str(DateUtil.getDateDay(day, "yyyy-MM-dd"));

                dateList.add(date);
            }
            model.addAttribute("dateList", dateList);

            RentalFtySdVo rentalFtySdVo = new RentalFtySdVo();
            rentalFtySdVo.setRental_fty_idx(Long.valueOf(rental_fty_idx));
            rentalFtySdVo.setGroup_idx(rentalFtyVo.getGroup_idx());
            rentalFtySdVo.setYear(Long.parseLong(searchVo.getSearchKind()));
            rentalFtySdVo.setMonth(Long.parseLong(searchVo.getSearchVal()));

            List<RentalFtySdVo> saveList = campusService.selectRentalFtyscheduleList(rentalFtySdVo);
            model.addAttribute("saveList", saveList);

            // 연도 리스트는 당해 년도 포함 5년을 보여준다.
            List<String> yearList = DateUtil.getYearList();
            model.addAttribute("yearList", yearList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_rental_schedule_insert.do", method = RequestMethod.POST)
    public String instrum_rental_schedule_inproc(final MultipartHttpServletRequest multiRequest,
                                           @ModelAttribute("rentalFtyVo") RentalFtyVo rentalFtyVo,
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

                String cur_date = rentalFtyVo.getDate(); // YYYY-MM 형식
                RentalFtySdVo deleteVo = new RentalFtySdVo();
                String[] tokens_del = cur_date.split("-");
                String year_del = tokens_del[0];
                String month_del = tokens_del[1];

                deleteVo.setYear(Long.parseLong(year_del));
                deleteVo.setMonth(Long.parseLong(month_del));
                deleteVo.setRental_fty_idx(rentalFtyVo.getRental_fty_idx());
                deleteVo.setGroup_idx(rentalFtyVo.getGroup_idx());

                campusService.deleteRentalFtySchedule(deleteVo);

                for(RentalFtySdVo rentalFtySdVo : rentalFtyVo.getDateList()) {
                    String date = rentalFtySdVo.getDate();
                    if(!"".equals(Util.nvl(date))) {
                        rentalFtySdVo.setRental_fty_idx(rentalFtyVo.getRental_fty_idx());
                        rentalFtySdVo.setGroup_idx(rentalFtyVo.getGroup_idx());

                        String[] tokens = date.split("-");
                        String year = tokens[0];
                        String month = tokens[1];
                        String day = tokens[2];

                        rentalFtySdVo.setYear(Long.parseLong(year));
                        rentalFtySdVo.setMonth(Long.parseLong(month));
                        rentalFtySdVo.setDay(Long.parseLong(day));

                        if(!"".equals(Util.nvl(rentalFtySdVo.getH9()))) { rentalFtySdVo.setH9("Y"); }
                        if(!"".equals(Util.nvl(rentalFtySdVo.getH10()))) { rentalFtySdVo.setH10("Y"); }
                        if(!"".equals(Util.nvl(rentalFtySdVo.getH11()))) { rentalFtySdVo.setH11("Y"); }
                        if(!"".equals(Util.nvl(rentalFtySdVo.getH12()))) { rentalFtySdVo.setH12("Y"); }
                        if(!"".equals(Util.nvl(rentalFtySdVo.getH13()))) { rentalFtySdVo.setH13("Y"); }
                        if(!"".equals(Util.nvl(rentalFtySdVo.getH14()))) { rentalFtySdVo.setH14("Y"); }
                        if(!"".equals(Util.nvl(rentalFtySdVo.getH15()))) { rentalFtySdVo.setH15("Y"); }
                        if(!"".equals(Util.nvl(rentalFtySdVo.getH16()))) { rentalFtySdVo.setH16("Y"); }
                        if(!"".equals(Util.nvl(rentalFtySdVo.getH17()))) { rentalFtySdVo.setH17("Y"); }
                        if(!"".equals(Util.nvl(rentalFtySdVo.getH18()))) { rentalFtySdVo.setH18("Y"); }
                        if(!"".equals(Util.nvl(rentalFtySdVo.getH19()))) { rentalFtySdVo.setH19("Y"); }
                        if(!"".equals(Util.nvl(rentalFtySdVo.getH20()))) { rentalFtySdVo.setH20("Y"); }

                        campusService.insertRentalFtySchedule(rentalFtySdVo);
                    }
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/campus/instrum_rental_schedule.do?rental_fty_idx=" + rentalFtyVo.getRental_fty_idx());
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

    @RequestMapping("/cont/campus/instrum_rental_calendar.do")
    public String instrum_rental_calendar(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_rental_calendar";
        String menu_url = "cont/campus/instrum_rental_list";
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

            int rental_fty_idx = ServletRequestUtils.getIntParameter(request, "rental_fty_idx", 0);

            if("".equals(searchVo.getSearchKind())) {
                searchVo.setSearchKind(String.valueOf(rental_fty_idx));
                model.addAttribute("searchKind", String.valueOf(rental_fty_idx));
            }

            List<CalendarVo> calList = new ArrayList<CalendarVo>();
            List<RentalFtyApyVo> applyList = campusService.selectRentalFtyApyList(searchVo);
            for(RentalFtyApyVo rentalFtyApyVo : applyList) {
                String date = rentalFtyApyVo.getResv_dt().substring(0, 10);
                String title = rentalFtyApyVo.getApy_name() + " (" + rentalFtyApyVo.getApy_mob_no() + ")";
                String color = "#142459";
                if("O".equals(rentalFtyApyVo.getPay_status())) {
                    title += " 결제완료";
                } else if ("C".equals(rentalFtyApyVo.getPay_status())) {
                    title += " 예약취소";
                    color = "#cf4a45";
                }
                String group_id = String.valueOf(rentalFtyApyVo.getRental_fty_apy_idx());
                if("Y".equals(rentalFtyApyVo.getH9())) {
                    calList.add(setCalendarInfo(date, "09:00", "10:00", title, group_id, rentalFtyApyVo.getRental_fty_apy_idx(), color));
                }
                if("Y".equals(rentalFtyApyVo.getH10())) {
                    calList.add(setCalendarInfo(date, "10:00", "11:00", title, group_id, rentalFtyApyVo.getRental_fty_apy_idx(), color));
                }
                if("Y".equals(rentalFtyApyVo.getH11())) {
                    calList.add(setCalendarInfo(date, "11:00", "12:00", title, group_id, rentalFtyApyVo.getRental_fty_apy_idx(), color));
                }
                if("Y".equals(rentalFtyApyVo.getH12())) {
                    calList.add(setCalendarInfo(date, "12:00", "13:00", title, group_id, rentalFtyApyVo.getRental_fty_apy_idx(), color));
                }
                if("Y".equals(rentalFtyApyVo.getH13())) {
                    calList.add(setCalendarInfo(date, "13:00", "14:00", title, group_id, rentalFtyApyVo.getRental_fty_apy_idx(), color));
                }
                if("Y".equals(rentalFtyApyVo.getH14())) {
                    calList.add(setCalendarInfo(date, "14:00", "15:00", title, group_id, rentalFtyApyVo.getRental_fty_apy_idx(), color));
                }
                if("Y".equals(rentalFtyApyVo.getH15())) {
                    calList.add(setCalendarInfo(date, "15:00", "16:00", title, group_id, rentalFtyApyVo.getRental_fty_apy_idx(), color));
                }
                if("Y".equals(rentalFtyApyVo.getH16())) {
                    calList.add(setCalendarInfo(date, "16:00", "17:00", title, group_id, rentalFtyApyVo.getRental_fty_apy_idx(), color));
                }
                if("Y".equals(rentalFtyApyVo.getH17())) {
                    calList.add(setCalendarInfo(date, "17:00", "18:00", title, group_id, rentalFtyApyVo.getRental_fty_apy_idx(), color));
                }
                if("Y".equals(rentalFtyApyVo.getH18())) {
                    calList.add(setCalendarInfo(date, "18:00", "19:00", title, group_id, rentalFtyApyVo.getRental_fty_apy_idx(), color));
                }
                if("Y".equals(rentalFtyApyVo.getH19())) {
                    calList.add(setCalendarInfo(date, "19:00", "20:00", title, group_id, rentalFtyApyVo.getRental_fty_apy_idx(), color));
                }
                if("Y".equals(rentalFtyApyVo.getH20())) {
                    calList.add(setCalendarInfo(date, "20:00", "21:00", title, group_id, rentalFtyApyVo.getRental_fty_apy_idx(), color));
                }
            }

            model.addAttribute("calList", calList);

            // 시설 리스트
            List<RentalFtyVo> ftyList = campusService.selectRentalFtyListAll();
            model.addAttribute("ftyList", ftyList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/campus/instrum_rental_pay_cancel.do", method = RequestMethod.POST)
    public String instrum_rental_pay_cancel(final MultipartHttpServletRequest multiRequest,
                                            @ModelAttribute("payVo") PayVo payVo,
                                            BindingResult bindingResult,
                                            Model model,
                                            SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            String configPath = EgovProperties.getProperty("xpay.config");
            String LGD_MID = payVo.getCST_MID();

            XPayClient xpay = new XPayClient();
            boolean isInitOK = xpay.Init(configPath, payVo.getCST_PLATFORM());

            if( !isInitOK ) {
                return ret_url;
            }else{
                try{
                    // (3) Init_TX: 메모리에 mall.conf, lgdacom.conf 할당 및 트랜잭션의 고유한 키 TXID 생성
                    xpay.Init_TX(LGD_MID);
                    xpay.Set("LGD_TXNAME", "Cancel");
                    xpay.Set("LGD_MID", payVo.getCST_MID());
                    xpay.Set("LGD_TID", payVo.getLGD_TID());

                    //금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
                    //String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
                    //xpay.Set("LGD_AMOUNTCHECKYN", "Y");
                    //xpay.Set("LGD_AMOUNT", DB_AMOUNT);

                } catch(Exception e) {
                        /*out.println("토스페이먼츠 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
                        out.println(""+e.getMessage());*/
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "결제 취소에 실패하였습니다.");
                    return ret_url;
                }
            }

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                if ( xpay.TX() ) {
                    RentalFtyApyVo rentalFtyApyVo = new RentalFtyApyVo();
                    rentalFtyApyVo.setRental_fty_apy_idx(payVo.getRental_fty_apy_idx());
                    rentalFtyApyVo.setUp_id(adminLoginVo.getAdmin_id());
                    rentalFtyApyVo.setPay_status("C");

                    campusService.updateRentalFtyApyInfo(rentalFtyApyVo);

                    // 대관신청 예약완료 메세지 발송
                    // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    if ("yes".equals(EgovProperties.getProperty("msg.send"))) {
                        RentalFtyApyVo rental = campusService.selectRentalFtyApyByIdx((int)payVo.getRental_fty_apy_idx());
                        RentalFtyVo rentalFtyVo = campusService.selectRentalFtyInfoByIdx((int)rental.getRental_fty_idx());

                        StringBuffer sb = new StringBuffer();
                        sb.append("[송파구청 송파쌤(SSEM)]");
                        sb.append("\r\n");
                        sb.append(String.format("%s님의 대관신청 예약이 취소되었습니다.", rental.getApy_name()));
                        sb.append("\r\n");
                        sb.append("<예약취소 내역>");
                        sb.append("\r\n");
                        sb.append(String.format("- 시설명: %s", rentalFtyVo.getName()));
                        sb.append("\r\n");
                        sb.append(String.format("- 예약날짜: %s", rental.getResv_dt().substring(0, 10)));
                        sb.append("\r\n");
                        String start_time = "";
                        String end_time = "";
                        if ("Y".equals(rental.getH9())) {
                            start_time = "09:00";
                            end_time = "10:00";
                        }
                        if ("Y".equals(rental.getH10())) {
                            if("".equals(start_time)) {
                                start_time = "10:00";
                            }
                            end_time = "11:00";
                        }
                        if ("Y".equals(rental.getH11())) {
                            if("".equals(start_time)) {
                                start_time = "11:00";
                            }
                            end_time = "12:00";
                        }
                        if ("Y".equals(rental.getH12())) {
                            if("".equals(start_time)) {
                                start_time = "12:00";
                            }
                            end_time = "13:00";
                        }
                        if ("Y".equals(rental.getH13())) {
                            if("".equals(start_time)) {
                                start_time = "13:00";
                            }
                            end_time = "14:00";
                        }
                        if ("Y".equals(rental.getH14())) {
                            if("".equals(start_time)) {
                                start_time = "14:00";
                            }
                            end_time = "15:00";
                        }
                        if ("Y".equals(rental.getH15())) {
                            if("".equals(start_time)) {
                                start_time = "15:00";
                            }
                            end_time = "16:00";
                        }
                        if ("Y".equals(rental.getH16())) {
                            if("".equals(start_time)) {
                                start_time = "16:00";
                            }
                            end_time = "17:00";
                        }
                        if ("Y".equals(rental.getH17())) {
                            if("".equals(start_time)) {
                                start_time = "17:00";
                            }
                            end_time = "18:00";
                        }
                        if ("Y".equals(rental.getH18())) {
                            if("".equals(start_time)) {
                                start_time = "18:00";
                            }
                            end_time = "19:00";
                        }
                        if ("Y".equals(rental.getH19())) {
                            if("".equals(start_time)) {
                                start_time = "19:00";
                            }
                            end_time = "20:00";
                        }
                        if ("Y".equals(rental.getH20())) {
                            if("".equals(start_time)) {
                                start_time = "20:00";
                            }
                            end_time = "21:00";
                        }
                        sb.append(String.format("- 예약시간: %s~%s", start_time, end_time));
                        sb.append("\r\n");
                        sb.append("감사합니다.");
                        sb.append("\r\n");
                        sb.append("☎ 문의: 송파쌤(SSEM) 악기도서관 02-2147-2544");

                        msgService.sendMsgKakao("대관신청 예약취소", sb.toString(), rental.getApy_name(), rental.getApy_mob_no().replaceAll("-", ""), "UMS_2021061514563704177");
                    }
                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/popup/campus/instrum_rental_view.do?rental_fty_apy_idx=" + payVo.getRental_fty_apy_idx());
                    model.addAttribute("altmsg", "예약취소 되었습니다.");
                    return "common/message";
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "예약취소에 실패하였습니다.(결제모듈 초기화실패)");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "예약취소에 실패하였습니다.(예외발생)");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/campus/instrum_rental_itemlist.do")
    public String instrum_rental_itemlist(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/campus/instrum_rental_itemlist";
        String menu_url = "cont/campus/instrum_rental_list";
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

            int rental_fty_idx = ServletRequestUtils.getIntParameter(request, "rental_fty_idx", 0);

            if("".equals(searchVo.getSearchKind())) {
                searchVo.setSearchKind(String.valueOf(rental_fty_idx));
                model.addAttribute("searchKind", String.valueOf(rental_fty_idx));
            }

            List<RentalFtyApyVo> itemList = campusService.selectRentalFtyApyListEx(searchVo);
            int totalCount = campusService.selectRentalFtyApyListTotalEx(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 시설 리스트
            List<RentalFtyVo> ftyList = campusService.selectRentalFtyListAll();
            model.addAttribute("ftyList", ftyList);
        }

        return ret_url;
    }

    private CalendarVo setCalendarInfo(String date, String start_time, String end_time, String title, String group_id, long rental_fty_apy_idx, String color) {
        CalendarVo cal = new CalendarVo();
        cal.setGroupId(group_id);
        cal.setTitle(title);
        cal.setStart(date + " " + start_time);
        cal.setEnd(date + " " + end_time);
        cal.setColor(color);
        cal.setTextColor("#fff");
        cal.setUrl("/ssemadmin/popup/campus/instrum_rental_view.do?rental_fty_apy_idx=" + rental_fty_apy_idx);
        cal.setPopup_yn("Y");

        return cal;
    }
}
