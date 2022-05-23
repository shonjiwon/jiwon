package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.common.SafeHtmlUtil;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.FileMngService;
import kr.go.songpa.ssem.service.LectureService;
import kr.go.songpa.ssem.service.MagnetService;
import kr.go.songpa.ssem.util.DateUtil;
import kr.go.songpa.ssem.util.FileMngUtil;
import kr.go.songpa.ssem.util.StringUtil;
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
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-11-12
 * Description :
 * History :
 * Version :
 */
@Controller
public class MagnetController extends CommonController {

    @Autowired
    private MagnetService magnetService;

    @Autowired
    private AppService appService;

    @Autowired
    private FileMngUtil fileUtil;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private LectureService lectureService;

    public MagnetController() {
    }

    @RequestMapping(value = "/youth/magnet/intro.do", method = RequestMethod.GET)
    public String youth_magnet_intro(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/magnet/intro";

        return ret_url;
    }

    @RequestMapping("/youth/magnet/study_hope_list.do")
    public String youth_magnet_study_hope_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/magnet/study_hope_list";

        // 청원성공강좌 신청 프로그램 리스트 12개
        List<LectureVo> lectureList = magnetService.selectLectureList("J");
        for(LectureVo lectureVo : lectureList) {
            //교육대상 가져오기
            List<String> array_tgt = new ArrayList<String>();
            String tgt_code = lectureVo.getTgt_code();
            String[] tokens = tgt_code.split(",");
            for(String code : tokens) {
                String code_txt = appService.selectCodeByIdx(Integer.parseInt(code));
                array_tgt.add(code_txt);
            }
            lectureVo.setArray_tgt(array_tgt);

            // 교육시간
            String dt_str = "";
            String dt_type = lectureVo.getDt_type();
            if("W".equals(dt_type)) {
                dt_str += "매주 ";
            } else if("T".equals(dt_type)) {
                dt_str += "격주 ";
            } else if("Z".equals(dt_type)) {
                dt_str += "기타 ";
            }

            String[] weeks = lectureVo.getDt_week().split(",");
            for(String week : weeks) {
                if("1".equals(week)) {
                    dt_str += "월, ";
                } else if("2".equals(week)) {
                    dt_str += "화, ";
                } else if("3".equals(week)) {
                    dt_str += "수, ";
                } else if("4".equals(week)) {
                    dt_str += "목, ";
                } else if("5".equals(week)) {
                    dt_str += "금, ";
                } else if("6".equals(week)) {
                    dt_str += "토, ";
                } else if("7".equals(week)) {
                    dt_str += "일, ";
                }
            }
            lectureVo.setDt_str(StringUtil.deleteLastStr(dt_str.trim(), ','));

            // 접수방법
            String reg_method_str = "";
            String[] methods = lectureVo.getReg_method().split(",");
            for(String method : methods) {
                if("1".equals(method)) {
                    reg_method_str += "온라인, ";
                } else if("2".equals(method)) {
                    reg_method_str += "방문, ";
                } else if("3".equals(method)) {
                    reg_method_str += "전화, ";
                } else if("4".equals(method)) {
                    reg_method_str += "외부홈페이지, ";
                }
            }
            lectureVo.setReg_method_str(StringUtil.deleteLastStr(reg_method_str.trim(), ','));
            // 프로그램 상태 체크
            // 1. 접수대기 : 접수날짜 도래 하지 않음
            // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
            // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
            // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
            // 5. 교육전 :
            // 6. 교육중 : 교육날짜 내
            // 7. 교육종료 : 교육날짜 지남
            // 8. 외부홈페이지 : 외부 홈페이지일 경우
            int code = Util.getProgramStatus(lectureVo);
            lectureVo.setStatus_code(code);
        }
        model.addAttribute("lectureList", lectureList);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        for (Field field : searchVo.getClass().getDeclaredFields()){
            field.setAccessible(true);
            Object value=field.get(searchVo);
            if(value instanceof String){
                field.set(searchVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
            }
        }

        List<HopeStudyVo> itemList = magnetService.selectHopeStudyList(searchVo);
        for(HopeStudyVo hopeStudyVo : itemList) {
            String apy_name = hopeStudyVo.getApy_name();
            apy_name = StringUtil.maskName(apy_name);
            hopeStudyVo.setApy_name(apy_name);

            if(DateUtil.calDates(hopeStudyVo.getClose_dt(), DateUtil.getDate(3)) < 0) {
                hopeStudyVo.setClose_yn("Y");
            }

            // 함께해요 리스트 개수
            int join_cnt = magnetService.selectJoinStudyCountByIdx(hopeStudyVo.getHope_study_idx());
            hopeStudyVo.setJoin_cnt(join_cnt);
        }
        int totalCount = magnetService.selectHopeStudyListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/magnet/study_hope_view.do", method = RequestMethod.GET)
    public String youth_magnet_study_hope_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/magnet/study_hope_view";

        int hope_study_idx = ServletRequestUtils.getIntParameter(request, "hope_study_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/magnet/study_hope_view.do?hope_study_idx=" + hope_study_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            HopeStudyVo hopeStudyVo = new HopeStudyVo();
            hopeStudyVo.setHope_study_idx(hope_study_idx);

            magnetService.updateHopeStudyViewCnt(hopeStudyVo);
            hopeStudyVo = magnetService.selectHopeStudyInfo(hopeStudyVo);

            String apy_name = hopeStudyVo.getApy_name();
            apy_name = StringUtil.maskName(apy_name);
            hopeStudyVo.setApy_name(apy_name);

            if (DateUtil.calDates(hopeStudyVo.getClose_dt(), DateUtil.getDate(3)) < 0) {
                hopeStudyVo.setClose_yn("Y");
            }

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    hopeStudyVo.setMob_1(tokens[0]);
                    hopeStudyVo.setMob_2(tokens[1]);
                    hopeStudyVo.setMob_3(tokens[2]);
                }
            }

            // 내용 엔터처리
            String cont = hopeStudyVo.getCont();
            if(!"".equals(Util.nvl(cont))) {
                cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
                hopeStudyVo.setCont(cont);
            }

            // 배우고 싶어요 신청 회원 목록
            List<JoinStudyVo> joinList = magnetService.selectJoinListByIdx(hope_study_idx);
            for(JoinStudyVo joinStudyVo : joinList) {
                String apy_id = StringUtil.maskUserId(joinStudyVo.getApy_id());
                joinStudyVo.setApy_id(apy_id);
            }

            model.addAttribute("hopeStudyVo", hopeStudyVo);
            model.addAttribute("joinList", joinList);

            // 청원성공 프로그램 정보
            if("Y".equals(hopeStudyVo.getSelect_yn())) {
                LectureVo lectureVo = new LectureVo();
                lectureVo.setLecture_idx(hopeStudyVo.getLecture_idx());

                lectureVo = lectureService.selectLectureInfo(lectureVo);

                //교육대상 가져오기
                List<String> array_tgt = new ArrayList<String>();
                String tgt_code = lectureVo.getTgt_code();
                String[] tokens = tgt_code.split(",");
                for(String code : tokens) {
                    String code_txt = appService.selectCodeByIdx(Integer.parseInt(code));
                    array_tgt.add(code_txt);
                }
                lectureVo.setArray_tgt(array_tgt);

                // 교육시간
                String dt_str = "";
                String dt_type = lectureVo.getDt_type();
                if("W".equals(dt_type)) {
                    dt_str += "매주 ";
                } else if("T".equals(dt_type)) {
                    dt_str += "격주 ";
                } else if("Z".equals(dt_type)) {
                    dt_str += "기타 ";
                }

                String[] weeks = lectureVo.getDt_week().split(",");
                for(String week : weeks) {
                    if("1".equals(week)) {
                        dt_str += "월, ";
                    } else if("2".equals(week)) {
                        dt_str += "화, ";
                    } else if("3".equals(week)) {
                        dt_str += "수, ";
                    } else if("4".equals(week)) {
                        dt_str += "목, ";
                    } else if("5".equals(week)) {
                        dt_str += "금, ";
                    } else if("6".equals(week)) {
                        dt_str += "토, ";
                    } else if("7".equals(week)) {
                        dt_str += "일, ";
                    }
                }
                lectureVo.setDt_str(StringUtil.deleteLastStr(dt_str.trim(), ','));
                model.addAttribute("lectureVo", lectureVo);
            }
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/magnet/study_hope_insert.do", method = RequestMethod.GET)
    public String youth_magnet_study_hope_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/magnet/study_hope_insert";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int self_counsel_idx = ServletRequestUtils.getIntParameter(request, "self_counsel_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/magnet/study_hope_insert.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            HopeStudyVo hopeStudyVo = new HopeStudyVo();

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    hopeStudyVo.setMob_1(tokens[0]);
                    hopeStudyVo.setMob_2(tokens[1]);
                    hopeStudyVo.setMob_3(tokens[2]);
                }
            }

            String start_dt = DateUtil.getDate(3);
            String end_dt = DateUtil.getMonthMinusFullDate("-", 1);

            hopeStudyVo.setStart_dt(start_dt);
            hopeStudyVo.setEnd_dt(end_dt);

            model.addAttribute("hopeStudyVo", hopeStudyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/magnet/study_hope_insert.do", method = RequestMethod.POST)
    public String youth_magnet_study_hope_inproc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("hopeStudyVo") HopeStudyVo hopeStudyVo,
                                        BindingResult bindingResult,
                                        Model model,
                                        SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : hopeStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(hopeStudyVo);
                if(value instanceof String){
                    field.set(hopeStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                hopeStudyVo.setReg_id(loginVo.getUser_id());

                magnetService.insertHopeStudyInfo(hopeStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/magnet/study_hope_list.do");
                model.addAttribute("altmsg", "등록되었습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "등록에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/magnet/study_hope_join_insert.do", method = RequestMethod.POST)
    public String youth_magnet_study_hope_join_inproc(final MultipartHttpServletRequest multiRequest,
                                           @ModelAttribute("joinStudyVo") JoinStudyVo joinStudyVo,
                                           BindingResult bindingResult,
                                           Model model,
                                           SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : joinStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(joinStudyVo);
                if(value instanceof String){
                    field.set(joinStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                joinStudyVo.setReg_id(loginVo.getUser_id());

                // 예외 처리
                // 1. 등록자는 신청할 수 없다.
                // 2. 중복해서 신청할 수 없다.
                HopeStudyVo hopeStudyVo = magnetService.selectHopeStudyByIdx(joinStudyVo.getHope_study_idx());
                if(hopeStudyVo != null) {
                    if(loginVo.getUser_id().equals(hopeStudyVo.getReg_id())) {
                        model.addAttribute("msg", "alterloc");
                        model.addAttribute("locurl", "/ssem/youth/magnet/study_hope_view.do?hope_study_idx=" + joinStudyVo.getHope_study_idx());
                        model.addAttribute("altmsg", "등록자는 참여하기에 신청할 수 없습니다.");
                        return "common/message";
                    }
                }

                int count = magnetService.selectJoinStudyCount(joinStudyVo);
                if(count != 0) {
                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssem/youth/magnet/study_hope_view.do?hope_study_idx=" + joinStudyVo.getHope_study_idx());
                    model.addAttribute("altmsg", "참여하기는 한번만 가능합니다.");
                    return "common/message";
                }

                magnetService.insertJoinStudyInfo(joinStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/magnet/study_hope_view.do?hope_study_idx=" + joinStudyVo.getHope_study_idx());
                model.addAttribute("altmsg", "등록되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "등록에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/magnet/teach_can_insert.do", method = RequestMethod.GET)
    public String youth_magnet_teach_can_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/magnet/teach_can_insert";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int hope_study_idx = ServletRequestUtils.getIntParameter(request, "hope_study_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/magnet/teach_can_insert.do?hope_study_idx=" + hope_study_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            TeachStudyVo teachStudyVo = new TeachStudyVo();

            teachStudyVo.setHope_study_idx(hope_study_idx);

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    teachStudyVo.setMob_1(tokens[0]);
                    teachStudyVo.setMob_2(tokens[1]);
                    teachStudyVo.setMob_3(tokens[2]);
                }
            }

            // 교육분야
            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            model.addAttribute("teachStudyVo", teachStudyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/magnet/teach_can_insert.do", method = RequestMethod.POST)
    public String youth_magnet_teach_can_inproc(final MultipartHttpServletRequest multiRequest,
                                           @ModelAttribute("teachStudyVo") TeachStudyVo teachStudyVo,
                                           BindingResult bindingResult,
                                           Model model,
                                           SessionStatus status) throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : teachStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(teachStudyVo);
                if(value instanceof String){
                    field.set(teachStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {

                // 강의계획서 등록 정보
                CommonVo plan_file = this.getAttachFileInfoEx(multiRequest, "teach_atch_file_id");
                if (plan_file.isFtype_flag()) {
                    String planFileid = "";
                    if (plan_file.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(plan_file.getTmpfiles(), "TC_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        planFileid = fileMngService.insertFileInfs(result);
                    }

                    teachStudyVo.setTeach_atch_file_id(planFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 강사이력 등록 정보
                CommonVo career_file = this.getAttachFileInfoEx(multiRequest, "career_atch_file_id");
                if (career_file.isFtype_flag()) {
                    String careerFileid = "";
                    if (career_file.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(career_file.getTmpfiles(), "TC_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        careerFileid = fileMngService.insertFileInfs(result);
                    }

                    teachStudyVo.setCareer_atch_file_id(careerFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                teachStudyVo.setReg_id(loginVo.getUser_id());
                magnetService.insertTeachStudyInfo(teachStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/magnet/study_hope_list.do");
                model.addAttribute("altmsg", "등록되었습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "등록에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/youth/magnet/study_share_list.do")
    public String youth_magnet_study_share_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/magnet/study_share_list";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<ChannelStudyVo> itemList = magnetService.selectChannelStudyList(searchVo);
        for(ChannelStudyVo channelStudyVo : itemList) {
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
        }
        int totalCount = magnetService.selectChannelStudyListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/magnet/study_share_view.do", method = RequestMethod.GET)
    public String youth_magnet_study_share_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/magnet/study_share_view";

        int channel_study_idx = ServletRequestUtils.getIntParameter(request, "channel_study_idx", 0);

        ChannelStudyVo channelStudyVo = new ChannelStudyVo();
        channelStudyVo.setChannel_study_idx(channel_study_idx);

        magnetService.updateChannelStudyViewCnt(channelStudyVo);
        channelStudyVo = magnetService.selectChannelStudyInfo(channelStudyVo);

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

        // 내용 엔터처리
        /*String cont = hopeStudyVo.getCont();
        cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
        hopeStudyVo.setCont(cont);*/

        // 이전/다음 목록 가져오기
        ChannelStudyVo next = magnetService.selectNextChannelStudy(channelStudyVo);
        ChannelStudyVo prev = magnetService.selectPrevChannelStudy(channelStudyVo);

        if (next != null) {
            channelStudyVo.setNext(next);
            channelStudyVo.setNext_idx((int)next.getChannel_study_idx());
        }

        if (prev != null) {
            channelStudyVo.setPrev(prev);
            channelStudyVo.setPrev_idx((int)prev.getChannel_study_idx());
        }

        model.addAttribute("channelStudyVo", channelStudyVo);

        return ret_url;
    }

    @RequestMapping(value = "/senior/magnet/intro.do", method = RequestMethod.GET)
    public String senior_magnet_intro(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/magnet/intro";

        return ret_url;
    }

    @RequestMapping("/senior/magnet/study_hope_list.do")
    public String senior_magnet_study_hope_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/magnet/study_hope_list";

        // 청원성공강좌 신청 프로그램 리스트 12개
        List<LectureVo> lectureList = magnetService.selectLectureList("S");
        for(LectureVo lectureVo : lectureList) {
            //교육대상 가져오기
            List<String> array_tgt = new ArrayList<String>();
            String tgt_code = lectureVo.getTgt_code();
            String[] tokens = tgt_code.split(",");
            for(String code : tokens) {
                String code_txt = appService.selectCodeByIdx(Integer.parseInt(code));
                array_tgt.add(code_txt);
            }
            lectureVo.setArray_tgt(array_tgt);

            // 교육시간
            String dt_str = "";
            String dt_type = lectureVo.getDt_type();
            if("W".equals(dt_type)) {
                dt_str += "매주 ";
            } else if("T".equals(dt_type)) {
                dt_str += "격주 ";
            } else if("Z".equals(dt_type)) {
                dt_str += "기타 ";
            }

            String[] weeks = lectureVo.getDt_week().split(",");
            for(String week : weeks) {
                if("1".equals(week)) {
                    dt_str += "월, ";
                } else if("2".equals(week)) {
                    dt_str += "화, ";
                } else if("3".equals(week)) {
                    dt_str += "수, ";
                } else if("4".equals(week)) {
                    dt_str += "목, ";
                } else if("5".equals(week)) {
                    dt_str += "금, ";
                } else if("6".equals(week)) {
                    dt_str += "토, ";
                } else if("7".equals(week)) {
                    dt_str += "일, ";
                }
            }
            lectureVo.setDt_str(StringUtil.deleteLastStr(dt_str.trim(), ','));

            // 접수방법
            String reg_method_str = "";
            String[] methods = lectureVo.getReg_method().split(",");
            for(String method : methods) {
                if("1".equals(method)) {
                    reg_method_str += "온라인, ";
                } else if("2".equals(method)) {
                    reg_method_str += "방문, ";
                } else if("3".equals(method)) {
                    reg_method_str += "전화, ";
                } else if("4".equals(method)) {
                    reg_method_str += "외부홈페이지, ";
                }
            }
            lectureVo.setReg_method_str(StringUtil.deleteLastStr(reg_method_str.trim(), ','));
            // 프로그램 상태 체크
            // 1. 접수대기 : 접수날짜 도래 하지 않음
            // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
            // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
            // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
            // 5. 교육전 :
            // 6. 교육중 : 교육날짜 내
            // 7. 교육종료 : 교육날짜 지남
            // 8. 외부홈페이지 : 외부 홈페이지일 경우
            int code = Util.getProgramStatus(lectureVo);
            lectureVo.setStatus_code(code);
        }
        model.addAttribute("lectureList", lectureList);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<HopeStudyVo> itemList = magnetService.selectHopeStudyList(searchVo);
        for(HopeStudyVo hopeStudyVo : itemList) {
            String apy_name = hopeStudyVo.getApy_name();
            apy_name = StringUtil.maskName(apy_name);
            hopeStudyVo.setApy_name(apy_name);

            if(DateUtil.calDates(hopeStudyVo.getClose_dt(), DateUtil.getDate(3)) < 0) {
                hopeStudyVo.setClose_yn("Y");
            }

            // 함께해요 리스트 개수
            int join_cnt = magnetService.selectJoinStudyCountByIdx(hopeStudyVo.getHope_study_idx());
            hopeStudyVo.setJoin_cnt(join_cnt);
        }
        int totalCount = magnetService.selectHopeStudyListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/senior/magnet/study_hope_view.do", method = RequestMethod.GET)
    public String senior_magnet_study_hope_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/magnet/study_hope_view";

        int hope_study_idx = ServletRequestUtils.getIntParameter(request, "hope_study_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/magnet/study_hope_view.do?hope_study_idx=" + hope_study_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            HopeStudyVo hopeStudyVo = new HopeStudyVo();
            hopeStudyVo.setHope_study_idx(hope_study_idx);

            magnetService.updateHopeStudyViewCnt(hopeStudyVo);
            hopeStudyVo = magnetService.selectHopeStudyInfo(hopeStudyVo);

            String apy_name = hopeStudyVo.getApy_name();
            apy_name = StringUtil.maskName(apy_name);
            hopeStudyVo.setApy_name(apy_name);

            if (DateUtil.calDates(hopeStudyVo.getClose_dt(), DateUtil.getDate(3)) < 0) {
                hopeStudyVo.setClose_yn("Y");
            }

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    hopeStudyVo.setMob_1(tokens[0]);
                    hopeStudyVo.setMob_2(tokens[1]);
                    hopeStudyVo.setMob_3(tokens[2]);
                }
            }

            // 내용 엔터처리
            String cont = hopeStudyVo.getCont();
            if(!"".equals(Util.nvl(cont))) {
                cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
                hopeStudyVo.setCont(cont);
            }

            // 배우고 싶어요 신청 회원 목록
            List<JoinStudyVo> joinList = magnetService.selectJoinListByIdx(hope_study_idx);
            for(JoinStudyVo joinStudyVo : joinList) {
                String apy_id = StringUtil.maskUserId(joinStudyVo.getApy_id());
                joinStudyVo.setApy_id(apy_id);
            }

            model.addAttribute("hopeStudyVo", hopeStudyVo);
            model.addAttribute("joinList", joinList);

            // 청원성공 프로그램 정보
            if("Y".equals(hopeStudyVo.getSelect_yn())) {
                LectureVo lectureVo = new LectureVo();
                lectureVo.setLecture_idx(hopeStudyVo.getLecture_idx());

                lectureVo = lectureService.selectLectureInfo(lectureVo);

                //교육대상 가져오기
                List<String> array_tgt = new ArrayList<String>();
                String tgt_code = lectureVo.getTgt_code();
                String[] tokens = tgt_code.split(",");
                for(String code : tokens) {
                    String code_txt = appService.selectCodeByIdx(Integer.parseInt(code));
                    array_tgt.add(code_txt);
                }
                lectureVo.setArray_tgt(array_tgt);

                // 교육시간
                String dt_str = "";
                String dt_type = lectureVo.getDt_type();
                if("W".equals(dt_type)) {
                    dt_str += "매주 ";
                } else if("T".equals(dt_type)) {
                    dt_str += "격주 ";
                } else if("Z".equals(dt_type)) {
                    dt_str += "기타 ";
                }

                String[] weeks = lectureVo.getDt_week().split(",");
                for(String week : weeks) {
                    if("1".equals(week)) {
                        dt_str += "월, ";
                    } else if("2".equals(week)) {
                        dt_str += "화, ";
                    } else if("3".equals(week)) {
                        dt_str += "수, ";
                    } else if("4".equals(week)) {
                        dt_str += "목, ";
                    } else if("5".equals(week)) {
                        dt_str += "금, ";
                    } else if("6".equals(week)) {
                        dt_str += "토, ";
                    } else if("7".equals(week)) {
                        dt_str += "일, ";
                    }
                }
                lectureVo.setDt_str(StringUtil.deleteLastStr(dt_str.trim(), ','));
                model.addAttribute("lectureVo", lectureVo);
            }
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/magnet/study_hope_insert.do", method = RequestMethod.GET)
    public String senior_magnet_study_hope_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/magnet/study_hope_insert";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int self_counsel_idx = ServletRequestUtils.getIntParameter(request, "self_counsel_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/magnet/study_hope_insert.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            HopeStudyVo hopeStudyVo = new HopeStudyVo();

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    hopeStudyVo.setMob_1(tokens[0]);
                    hopeStudyVo.setMob_2(tokens[1]);
                    hopeStudyVo.setMob_3(tokens[2]);
                }
            }

            String start_dt = DateUtil.getDate(3);
            String end_dt = DateUtil.getMonthMinusFullDate("-", 1);

            hopeStudyVo.setStart_dt(start_dt);
            hopeStudyVo.setEnd_dt(end_dt);

            model.addAttribute("hopeStudyVo", hopeStudyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/magnet/study_hope_insert.do", method = RequestMethod.POST)
    public String senior_magnet_study_hope_inproc(final MultipartHttpServletRequest multiRequest,
                                                 @ModelAttribute("hopeStudyVo") HopeStudyVo hopeStudyVo,
                                                 BindingResult bindingResult,
                                                 Model model,
                                                 SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : hopeStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(hopeStudyVo);
                if(value instanceof String){
                    field.set(hopeStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                hopeStudyVo.setReg_id(loginVo.getUser_id());

                magnetService.insertHopeStudyInfo(hopeStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/magnet/study_hope_list.do");
                model.addAttribute("altmsg", "등록되었습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "등록에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/magnet/study_hope_join_insert.do", method = RequestMethod.POST)
    public String senior_magnet_study_hope_join_inproc(final MultipartHttpServletRequest multiRequest,
                                                 @ModelAttribute("joinStudyVo") JoinStudyVo joinStudyVo,
                                                 BindingResult bindingResult,
                                                 Model model,
                                                 SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : joinStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(joinStudyVo);
                if(value instanceof String){
                    field.set(joinStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                joinStudyVo.setReg_id(loginVo.getUser_id());

                // 예외 처리
                // 1. 등록자는 신청할 수 없다.
                // 2. 중복해서 신청할 수 없다.
                HopeStudyVo hopeStudyVo = magnetService.selectHopeStudyByIdx(joinStudyVo.getHope_study_idx());
                if(hopeStudyVo != null) {
                    if(loginVo.getUser_id().equals(hopeStudyVo.getReg_id())) {
                        model.addAttribute("msg", "alterloc");
                        model.addAttribute("locurl", "/ssem/senior/magnet/study_hope_view.do?hope_study_idx=" + joinStudyVo.getHope_study_idx());
                        model.addAttribute("altmsg", "등록자는 참여하기에 신청할 수 없습니다.");
                        return "common/message";
                    }
                }

                int count = magnetService.selectJoinStudyCount(joinStudyVo);
                if(count != 0) {
                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssem/senior/magnet/study_hope_view.do?hope_study_idx=" + joinStudyVo.getHope_study_idx());
                    model.addAttribute("altmsg", "참여하기는 한번만 가능합니다.");
                    return "common/message";
                }

                magnetService.insertJoinStudyInfo(joinStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/magnet/study_hope_view.do?hope_study_idx=" + joinStudyVo.getHope_study_idx());
                model.addAttribute("altmsg", "등록되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "등록에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/magnet/teach_can_insert.do", method = RequestMethod.GET)
    public String senior_magnet_teach_can_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/magnet/teach_can_insert";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int hope_study_idx = ServletRequestUtils.getIntParameter(request, "hope_study_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/magnet/teach_can_insert.do?hope_study_idx=" + hope_study_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            TeachStudyVo teachStudyVo = new TeachStudyVo();

            teachStudyVo.setHope_study_idx(hope_study_idx);

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    teachStudyVo.setMob_1(tokens[0]);
                    teachStudyVo.setMob_2(tokens[1]);
                    teachStudyVo.setMob_3(tokens[2]);
                }
            }

            // 교육분야
            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            model.addAttribute("teachStudyVo", teachStudyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/magnet/teach_can_insert.do", method = RequestMethod.POST)
    public String senior_magnet_teach_can_inproc(final MultipartHttpServletRequest multiRequest,
                                                @ModelAttribute("teachStudyVo") TeachStudyVo teachStudyVo,
                                                BindingResult bindingResult,
                                                Model model,
                                                SessionStatus status) throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : teachStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(teachStudyVo);
                if(value instanceof String){
                    field.set(teachStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {

                // 강의계획서 등록 정보
                CommonVo plan_file = this.getAttachFileInfoEx(multiRequest, "teach_atch_file_id");
                if (plan_file.isFtype_flag()) {
                    String planFileid = "";
                    if (plan_file.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(plan_file.getTmpfiles(), "TC_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        planFileid = fileMngService.insertFileInfs(result);
                    }

                    teachStudyVo.setTeach_atch_file_id(planFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 강사이력 등록 정보
                CommonVo career_file = this.getAttachFileInfoEx(multiRequest, "career_atch_file_id");
                if (career_file.isFtype_flag()) {
                    String careerFileid = "";
                    if (career_file.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(career_file.getTmpfiles(), "TC_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        careerFileid = fileMngService.insertFileInfs(result);
                    }

                    teachStudyVo.setCareer_atch_file_id(careerFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                teachStudyVo.setReg_id(loginVo.getUser_id());
                magnetService.insertTeachStudyInfo(teachStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/magnet/study_hope_list.do");
                model.addAttribute("altmsg", "등록되었습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "등록에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/senior/magnet/study_share_list.do")
    public String senior_magnet_study_share_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/magnet/study_share_list";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<ChannelStudyVo> itemList = magnetService.selectChannelStudyList(searchVo);
        for(ChannelStudyVo channelStudyVo : itemList) {
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
        }
        int totalCount = magnetService.selectChannelStudyListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/senior/magnet/study_share_view.do", method = RequestMethod.GET)
    public String senior_magnet_study_share_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/magnet/study_share_view";

        int channel_study_idx = ServletRequestUtils.getIntParameter(request, "channel_study_idx", 0);

        ChannelStudyVo channelStudyVo = new ChannelStudyVo();
        channelStudyVo.setChannel_study_idx(channel_study_idx);

        magnetService.updateChannelStudyViewCnt(channelStudyVo);
        channelStudyVo = magnetService.selectChannelStudyInfo(channelStudyVo);

        // 내용 엔터처리
        /*String cont = hopeStudyVo.getCont();
        cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
        hopeStudyVo.setCont(cont);*/

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

        // 이전/다음 목록 가져오기
        ChannelStudyVo next = magnetService.selectNextChannelStudy(channelStudyVo);
        ChannelStudyVo prev = magnetService.selectPrevChannelStudy(channelStudyVo);

        if (next != null) {
            channelStudyVo.setNext(next);
            channelStudyVo.setNext_idx((int)next.getChannel_study_idx());
        }

        if (prev != null) {
            channelStudyVo.setPrev(prev);
            channelStudyVo.setPrev_idx((int)prev.getChannel_study_idx());
        }

        model.addAttribute("channelStudyVo", channelStudyVo);

        return ret_url;
    }
}
