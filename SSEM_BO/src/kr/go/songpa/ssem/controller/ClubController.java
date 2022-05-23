package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.ClubService;
import kr.go.songpa.ssem.service.FileMngService;
import kr.go.songpa.ssem.util.FileMngUtil;
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
 * Date : 2020-09-20
 * Description :
 * History :
 * Version :
 */
@Controller
public class ClubController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private ClubService clubService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    public ClubController() {
    }

    @RequestMapping("/cont/club/club_apply_list.do")
    public String club_apply_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/club/club_apply_list";
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

            List<ClubVo> clubList = clubService.selectClubList(searchVo);
            int totalCount = clubService.selectClubListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", clubList);

            List<CodeVo> codeList = appService.selectCodeList("CLUB_CATE");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/club/club_apply_view.do", method = RequestMethod.GET)
    public String club_apply_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/club/club_apply_view";
        String menu_url = "cont/club/club_apply_list";
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
            int club_idx = ServletRequestUtils.getIntParameter(request, "club_idx", 0);

            ClubVo clubVo = new ClubVo();
            clubVo.setClub_idx(club_idx);

            clubVo = clubService.selectClubInfo(clubVo);

            // 첨부파일 처리
            String atchFileId = clubVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            clubVo.setFileList(fileVoList);

            model.addAttribute("clubVo", clubVo);

            List<CodeVo> codeList = appService.selectCodeList("CLUB_CATE");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/club/club_apply_view.do", method = RequestMethod.POST)
    public String club_apply_view_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("clubVo") ClubVo clubVo,
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
                clubVo.setUp_id(adminLoginVo.getAdmin_id());

                clubService.updateClubInfo(clubVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/club/club_apply_list.do");
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

    @RequestMapping("/cont/club/club_status_list.do")
    public String club_status_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/club/club_status_list";
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

            List<CodeVo> codeList = appService.selectCodeList("CLUB_CATE");

            List<ClubStatusVo> clubStatusList = clubService.selectClubStatusList(searchVo);
            int totalCount = clubService.selectClubStatusListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("codeList", codeList);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", clubStatusList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/club/club_status_inscr.do", method = RequestMethod.GET)
    public String club_status_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/club/club_status_inscr";
        String menu_url = "cont/club/club_status_list";
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

            List<CodeVo> codeList = appService.selectCodeList("CLUB_CATE");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/club/club_status_inscr.do", method = RequestMethod.POST)
    public String club_status_inproc(final MultipartHttpServletRequest multiRequest,
                                   @ModelAttribute("clubStatusVo") ClubStatusVo clubStatusVo,
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
                clubStatusVo.setReg_id(adminLoginVo.getAdmin_id());
                clubStatusVo.setGroup_idx(adminLoginVo.getGroup_idx());

                clubService.insertClubStatusInfo(clubStatusVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/club/club_status_list.do");
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

    @RequestMapping(value = "/cont/club/club_status_view.do", method = RequestMethod.GET)
    public String club_status_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/club/club_status_view";
        String menu_url = "cont/club/club_status_list";
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
            int club_status_idx = ServletRequestUtils.getIntParameter(request, "club_status_idx", 0);

            ClubStatusVo clubStatusVo = new ClubStatusVo();
            clubStatusVo.setClub_status_idx(club_status_idx);

            clubStatusVo = clubService.selectClubStatusInfo(clubStatusVo);

            model.addAttribute("clubStatusVo", clubStatusVo);

            List<CodeVo> codeList = appService.selectCodeList("CLUB_CATE");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/club/club_status_view.do", method = RequestMethod.POST)
    public String club_status_view_proc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("clubStatusVo") ClubStatusVo clubStatusVo,
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
                clubStatusVo.setUp_id(adminLoginVo.getAdmin_id());
                clubStatusVo.setGroup_idx(adminLoginVo.getGroup_idx());

                clubService.updateClubStatusInfo(clubStatusVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/club/club_status_list.do");
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

    @RequestMapping(value = "/cont/club/club_status_delete.do", method = RequestMethod.POST)
    public String club_status_delete(final MultipartHttpServletRequest multiRequest,
                                   @ModelAttribute("clubStatusVo") ClubStatusVo clubStatusVo,
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
                clubService.deleteClubStatusInfo(clubStatusVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/club/club_status_list.do");
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

    @RequestMapping("/cont/club/club_news_list.do")
    public String club_news_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/club/club_news_list";
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

            List<ClubNewsVo> clubList = clubService.selectClubNewsList(searchVo);
            int totalCount = clubService.selectClubNewsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", clubList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/club/club_news_inscr.do", method = RequestMethod.GET)
    public String club_news_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/club/club_news_inscr";
        String menu_url = "cont/club/club_news_list";
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

    @RequestMapping(value = "/cont/club/club_news_inscr.do", method = RequestMethod.POST)
    public String club_news_inproc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("clubNewsVo") ClubNewsVo clubNewsVo,
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
                        List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "CN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        thumbFileid = fileMngService.insertFileInfs(result);
                    }

                    clubNewsVo.setThumb_atch_file_id(thumbFileid);
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
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "CN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    clubNewsVo.setAtch_file_id(atchFileId);
                    clubNewsVo.setReg_id(adminLoginVo.getAdmin_id());
                    clubNewsVo.setGroup_idx(adminLoginVo.getGroup_idx());

                    clubService.insertClubNewsInfo(clubNewsVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/club/club_news_list.do");
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

    @RequestMapping(value = "/cont/club/club_news_view.do", method = RequestMethod.GET)
    public String club_news_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/club/club_news_view";
        String menu_url = "cont/club/club_news_list";
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
            int club_news_idx = ServletRequestUtils.getIntParameter(request, "club_news_idx", 0);

            ClubNewsVo clubNewsVo = new ClubNewsVo();
            clubNewsVo.setClub_news_idx(club_news_idx);

            clubService.updateClubNewsViewCnt(clubNewsVo);
            clubNewsVo = clubService.selectClubNewsInfo(clubNewsVo);

            //썸네일 처리
            String thumbFileId = clubNewsVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            clubNewsVo.setThumbFileList(thumbFileList);

            // 첨부파일 처리
            String atchFileId = clubNewsVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            clubNewsVo.setFileList(fileVoList);

            model.addAttribute("clubNewsVo", clubNewsVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/club/club_news_view.do", method = RequestMethod.POST)
    public String club_news_view_proc(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("clubNewsVo") ClubNewsVo clubNewsVo,
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
                        fvo.setAtch_file_id(clubNewsVo.getThumb_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "CN_",cnt, clubNewsVo.getThumb_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "CN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            thumbFileid = fileMngService.insertFileInfs(result);
                            clubNewsVo.setThumb_atch_file_id(thumbFileid);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(clubNewsVo.getThumb_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            clubNewsVo.setThumb_atch_file_id("");
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
                        fvo.setAtch_file_id(clubNewsVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "CN_",cnt, clubNewsVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "CN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            clubNewsVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(clubNewsVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            clubNewsVo.setAtch_file_id("");
                        }
                    }

                    clubNewsVo.setUp_id(adminLoginVo.getAdmin_id());
                    clubNewsVo.setGroup_idx(adminLoginVo.getGroup_idx());

                    clubService.updateClubNewsInfo(clubNewsVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/club/club_news_list.do");
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

    @RequestMapping(value = "/cont/club/club_news_delete.do", method = RequestMethod.POST)
    public String club_news_delete(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("clubNewsVo") ClubNewsVo clubNewsVo,
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
                clubService.deleteClubNewsInfo(clubNewsVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/club/club_news_list.do");
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
}
