package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.FileMngService;
import kr.go.songpa.ssem.service.LectureService;
import kr.go.songpa.ssem.service.MagnetService;
import kr.go.songpa.ssem.util.DateUtil;
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
 * Date : 2020-10-10
 * Description :
 * History :
 * Version :
 */
@Controller
public class MagnetController  extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    @Autowired
    private MagnetService magnetService;

    @Autowired
    private LectureService lectureService;

    public MagnetController() {
    }

    @RequestMapping("/cont/magnet/hope_study_list.do")
    public String hope_study_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/magnet/hope_study_list";
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

            List<HopeStudyVo> itemList = magnetService.selectHopeStudyList(searchVo);
            for(HopeStudyVo hopeStudyVo : itemList) {
                /*String apy_name = hopeStudyVo.getApy_name();
                apy_name = StringUtil.maskName(apy_name);
                hopeStudyVo.setApy_name(apy_name);*/

                if(DateUtil.calDates(hopeStudyVo.getClose_dt(), DateUtil.getDate(3)) < 0) {
                    hopeStudyVo.setClose_yn("Y");
                }

                // 함께해요 리스트 개수
                int join_cnt = magnetService.selectJoinStudyCountByIdx(hopeStudyVo.getHope_study_idx());
                hopeStudyVo.setJoin_cnt(join_cnt);

                // 가르칠수 있어요 리스트 개수
                int teach_cnt = magnetService.selectTeachStudyCountByIdx(hopeStudyVo.getHope_study_idx());
                hopeStudyVo.setTeach_cnt(teach_cnt);
            }
            int totalCount = magnetService.selectHopeStudyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/magnet/hope_study_view.do", method = RequestMethod.GET)
    public String hope_study_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/magnet/hope_study_view";
        String menu_url = "cont/magnet/hope_study_list";
        String in_url = "/" + menu_url + Constants.global_ext;

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        int hope_study_idx = ServletRequestUtils.getIntParameter(request, "hope_study_idx", 0);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForMagnet(request, 10, String.valueOf(hope_study_idx));
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

            HopeStudyVo hopeStudyVo = new HopeStudyVo();
            hopeStudyVo.setHope_study_idx(hope_study_idx);

            hopeStudyVo = magnetService.selectHopeStudyInfo(hopeStudyVo);
            if("Y".equals(hopeStudyVo.getSelect_yn())) {
                hopeStudyVo.setProgram_name(lectureService.selectLectureNameByIdx(hopeStudyVo.getLecture_idx()));
            }

            hopeStudyVo.setList_type("A"); // 함께해요

            model.addAttribute("hopeStudyVo", hopeStudyVo);

            // 함께해요 리스트
            searchVo.setSearchVal2(String.valueOf(hope_study_idx));

            List<JoinStudyVo> itemList = magnetService.selectJoinStudyList(searchVo);
            int totalCount = magnetService.selectJoinStudyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

        }

        return ret_url;
    }

    @RequestMapping("/cont/magnet/hope_study_join_list.do")
    public String hope_study_join_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/magnet/hope_study_join_list";
        String menu_url = "cont/magnet/hope_study_list";
        String in_url = "/" + menu_url + Constants.global_ext;

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        int hope_study_idx = ServletRequestUtils.getIntParameter(request, "hope_study_idx", 0);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForMagnet(request, 10, String.valueOf(hope_study_idx));
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

            if(hope_study_idx == 0) hope_study_idx = Integer.parseInt(searchVo.getSearchVal2());

            HopeStudyVo hopeStudyVo = new HopeStudyVo();
            hopeStudyVo.setHope_study_idx(hope_study_idx);

            hopeStudyVo = magnetService.selectHopeStudyInfo(hopeStudyVo);
            if("Y".equals(hopeStudyVo.getSelect_yn())) {
                hopeStudyVo.setProgram_name(lectureService.selectLectureNameByIdx(hopeStudyVo.getLecture_idx()));
            }

            hopeStudyVo.setList_type("A"); // 함께해요

            model.addAttribute("hopeStudyVo", hopeStudyVo);

            // 함께해요 리스트
            searchVo.setSearchVal2(String.valueOf(hope_study_idx));

            List<JoinStudyVo> itemList = magnetService.selectJoinStudyList(searchVo);
            int totalCount = magnetService.selectJoinStudyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

        }

        return ret_url;
    }

    @RequestMapping("/cont/magnet/hope_study_teach_list.do")
    public String hope_study_teach_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/magnet/hope_study_teach_list";
        String menu_url = "cont/magnet/hope_study_list";
        String in_url = "/" + menu_url + Constants.global_ext;

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        int hope_study_idx = ServletRequestUtils.getIntParameter(request, "hope_study_idx", 0);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForMagnet(request, 10, String.valueOf(hope_study_idx));
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

            if(hope_study_idx == 0) hope_study_idx = Integer.parseInt(searchVo.getSearchVal2());

            HopeStudyVo hopeStudyVo = new HopeStudyVo();
            hopeStudyVo.setHope_study_idx(hope_study_idx);

            hopeStudyVo = magnetService.selectHopeStudyInfo(hopeStudyVo);
            if("Y".equals(hopeStudyVo.getSelect_yn())) {
                hopeStudyVo.setProgram_name(lectureService.selectLectureNameByIdx(hopeStudyVo.getLecture_idx()));
            }

            hopeStudyVo.setList_type("A"); // 함께해요

            model.addAttribute("hopeStudyVo", hopeStudyVo);

            // 함께해요 리스트
            searchVo.setSearchVal2(String.valueOf(hope_study_idx));

            List<TeachStudyVo> itemList = magnetService.selectTeachStudyList(searchVo);
            for(TeachStudyVo teachStudyVo : itemList) {
                String code_name = appService.selectCodeByIdx(teachStudyVo.getCode_idx());
                teachStudyVo.setCode_name(code_name);
            }
            int totalCount = magnetService.selectTeachStudyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/magnet/hope_study_view.do", method = RequestMethod.POST)
    public String hope_study_view_proc(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("hopeStudyVo") HopeStudyVo hopeStudyVo,
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
                hopeStudyVo.setUp_id(adminLoginVo.getAdmin_id());
                magnetService.updateHopeStudyInfo(hopeStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/magnet/hope_study_list.do");
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

    @RequestMapping(value = "/cont/magnet/hope_study_delete.do", method = RequestMethod.POST)
    public String hope_study_delete(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("hopeStudyVo") HopeStudyVo hopeStudyVo,
                                     BindingResult bindingResult,
                                     Model model,
                                     SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                hopeStudyVo.setUp_id(adminLoginVo.getAdmin_id());
                magnetService.deleteHopeStudyInfo(hopeStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/magnet/hope_study_list.do");
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

    @RequestMapping("/cont/magnet/channel_study_list.do")
    public String channel_study_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/magnet/channel_study_list";
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

            List<ChannelStudyVo> itemList = magnetService.selectChannelStudyList(searchVo);
            int totalCount = magnetService.selectChannelStudyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/magnet/channel_study_inscr.do", method = RequestMethod.GET)
    public String channel_study_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/magnet/channel_study_inscr";
        String menu_url = "cont/magnet/channel_study_list";
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

    @RequestMapping(value = "/cont/magnet/channel_study_inscr.do", method = RequestMethod.POST)
    public String channel_study_inproc(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("channelStudyVo") ChannelStudyVo channelStudyVo,
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
                        List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "MS_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        thumbFileid = fileMngService.insertFileInfs(result);
                    }

                    channelStudyVo.setThumb_atch_file_id(thumbFileid);
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
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "MS_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    channelStudyVo.setAtch_file_id(atchFileId);
                    channelStudyVo.setReg_id(adminLoginVo.getAdmin_id());
                    channelStudyVo.setGroup_idx(adminLoginVo.getGroup_idx());

                    magnetService.insertChannelStudyInfo(channelStudyVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/magnet/channel_study_list.do");
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

    @RequestMapping(value = "/cont/magnet/channel_study_view.do", method = RequestMethod.GET)
    public String channel_study_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/magnet/channel_study_view";
        String menu_url = "cont/magnet/channel_study_list";
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
            int channel_study_idx = ServletRequestUtils.getIntParameter(request, "channel_study_idx", 0);

            ChannelStudyVo channelStudyVo = new ChannelStudyVo();
            channelStudyVo.setChannel_study_idx(channel_study_idx);

            magnetService.updateChannelStudyViewCnt(channelStudyVo);
            channelStudyVo = magnetService.selectChannelStudyInfo(channelStudyVo);

            //썸네일 처리
            String thumbFileId = channelStudyVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            channelStudyVo.setThumbFileList(thumbFileList);

            // 첨부파일 처리
            String atchFileId = channelStudyVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            channelStudyVo.setFileList(fileVoList);

            model.addAttribute("channelStudyVo", channelStudyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/magnet/channel_study_view.do", method = RequestMethod.POST)
    public String channel_study_view_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("channelStudyVo") ChannelStudyVo channelStudyVo,
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
                        fvo.setAtch_file_id(channelStudyVo.getThumb_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "MS_",cnt, channelStudyVo.getThumb_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "MS_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            thumbFileid = fileMngService.insertFileInfs(result);
                            channelStudyVo.setThumb_atch_file_id(thumbFileid);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(channelStudyVo.getThumb_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            channelStudyVo.setThumb_atch_file_id("");
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
                        fvo.setAtch_file_id(channelStudyVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "MS_",cnt, channelStudyVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "MS_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            channelStudyVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(channelStudyVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            channelStudyVo.setAtch_file_id("");
                        }
                    }

                    channelStudyVo.setUp_id(adminLoginVo.getAdmin_id());
                    channelStudyVo.setGroup_idx(adminLoginVo.getGroup_idx());

                    magnetService.updateChannelStudyInfo(channelStudyVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/magnet/channel_study_list.do");
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

    @RequestMapping(value = "/cont/magnet/channel_study_delete.do", method = RequestMethod.POST)
    public String channel_study_delete(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("channelStudyVo") ChannelStudyVo channelStudyVo,
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
                magnetService.deleteChannelStudyInfo(channelStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/magnet/channel_study_list.do");
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

    @RequestMapping("/cont/magnet/teach_apply_list.do")
    public String teach_apply_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/magnet/teach_apply_list";
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

            // code List
            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            List<TeacherApyVo> itemList = magnetService.selectTeachApplyList(searchVo);
            for(TeacherApyVo teacher : itemList) {
                // 강사이력파일 처리
                String careerFileId = teacher.getCareer_atch_file_id();
                String career_path = EgovProperties.getProperty("bd.file.url.path");
                FileVo fvo = new FileVo();
                fvo.setAtch_file_id(careerFileId);
                List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                for(FileVo fileVo : fileVoList){
                    fileVo.setFile_src(career_path + "/" + fileVo.getFile_nm());
                }
                teacher.setCareerFileList(fileVoList);
            }
            int totalCount = magnetService.selectTeachApplyistTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/magnet/teach_apply_view.do", method = RequestMethod.GET)
    public String teach_apply_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/magnet/teach_apply_view";
        String menu_url = "cont/magnet/teach_apply_list";
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
            int teacher_apy_idx = ServletRequestUtils.getIntParameter(request, "teacher_apy_idx", 0);

            TeacherApyVo teacherApyVo = new TeacherApyVo();
            teacherApyVo.setTeacher_apy_idx(teacher_apy_idx);

            teacherApyVo = magnetService.selectTeachApplyInfo(teacherApyVo);

            //사진파일 처리
            String picFileId = teacherApyVo.getPic_atch_file_id();
            String pic_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo picfvo = new FileVo();
            picfvo.setAtch_file_id(picFileId);
            List<FileVo> picFileList = fileMngService.selectFileInfs(picfvo);
            for(FileVo fileVo : picFileList){
                fileVo.setFile_src(pic_path + "/" + fileVo.getFile_nm());
            }
            teacherApyVo.setPicFileList(picFileList);

            // 강사이력파일 처리
            String careerFileId = teacherApyVo.getCareer_atch_file_id();
            String career_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(careerFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(career_path + "/" + fileVo.getFile_nm());
            }
            teacherApyVo.setCareerFileList(fileVoList);

            model.addAttribute("teacherApyVo", teacherApyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/magnet/teach_apply_view.do", method = RequestMethod.POST)
    public String teach_apply_view_proc(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("teacherApyVo") TeacherApyVo teacherApyVo,
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
                teacherApyVo.setUp_id(adminLoginVo.getAdmin_id());

                magnetService.updateTeachApplyInfo(teacherApyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/magnet/teach_apply_list.do");
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

    @RequestMapping(value = "/cont/magnet/teach_apply_delete.do", method = RequestMethod.POST)
    public String teach_apply_delete(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("teacherApyVo") TeacherApyVo teacherApyVo,
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
                magnetService.deleteTeachApplyInfo(teacherApyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/magnet/teach_apply_list.do");
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
