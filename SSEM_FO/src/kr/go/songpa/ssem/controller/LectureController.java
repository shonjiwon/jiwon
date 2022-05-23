package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.common.SafeHtmlUtil;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.FileMngService;
import kr.go.songpa.ssem.service.LectureService;
import kr.go.songpa.ssem.service.MsgService;
import kr.go.songpa.ssem.util.DateUtil;
import kr.go.songpa.ssem.util.StringUtil;
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
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-11-10
 * Description :
 * History :
 * Version :
 */
@Controller
public class LectureController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private MsgService msgService;

    public LectureController() {
    }

    @RequestMapping("/youth/program/lecture_list.do")
    public String youth_program_lecture_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/program/lecture_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        for (Field field : searchVo.getClass().getDeclaredFields()){
            field.setAccessible(true);
            Object value=field.get(searchVo);
            if(value instanceof String){
                field.set(searchVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
            }
        }

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : itemList) {
            //교육대상 가져오기
            List<String> array_tgt = new ArrayList<String>();
            String tgt_code = lectureVo.getTgt_code();
            String[] tokens = tgt_code.split(",");
            for(String code : tokens) {
                String code_txt = appService.selectCodeByIdx(Integer.parseInt(code));
                array_tgt.add(code_txt);
            }
            lectureVo.setArray_tgt(array_tgt);

            // 교육분야 가져오기
            String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
            lectureVo.setPart_name(part_name);

            // 좋아요
            int love_cnt = lectureService.selectLoveCount(lectureVo.getLecture_idx());
            lectureVo.setLove_cnt(love_cnt);

            // 좋아요 본인여부
            if(loginVo != null) {
                LoveVo love = new LoveVo();
                love.setLecture_idx(lectureVo.getLecture_idx());
                love.setReg_id(loginVo.getUser_id());
                int check = lectureService.selectLoveCountBySelf(love);
                if(check != 0) {
                    lectureVo.setLove_self_yn("Y");
                }
            }

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

            // 조직 정보
            GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
            lectureVo.setGroup(groupVo);

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
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        // 교육대상
        List<CodeVo> tgtList = appService.selectCodeList("STUDY_TGT");
        model.addAttribute("tgtList", tgtList);

        // 교육분야
        List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
        model.addAttribute("codeList", codeList);

        // 교육기관
        List<GroupVo> groupList = appService.selectSubGroupListAll();
        model.addAttribute("groupList", groupList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/program/lecture_view.do", method = RequestMethod.GET)
    public String youth_program_lecture_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/program/lecture_view";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        LectureVo lectureVo = getLectureInfo(lecture_idx);

        // 좋아요 본인여부
        if(loginVo != null) {
            LoveVo love = new LoveVo();
            love.setLecture_idx(lecture_idx);
            love.setReg_id(loginVo.getUser_id());
            int check = lectureService.selectLoveCountBySelf(love);
            if(check != 0) {
                lectureVo.setLove_self_yn("Y");
            }
        }

        // 첨부파일 처리
        String atchFileId = lectureVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        lectureVo.setFileList(fileVoList);

        model.addAttribute("lectureVo", lectureVo);

        return ret_url;
    }

    @RequestMapping(value = "/youth/program/lecture_preview.do", method = RequestMethod.GET)
    public String youth_program_lecture_preview(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/program/lecture_preview";

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        LectureVo lectureVo = getLectureInfo(lecture_idx);

        // 첨부파일 처리
        String atchFileId = lectureVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        lectureVo.setFileList(fileVoList);

        model.addAttribute("lectureVo", lectureVo);

        return ret_url;
    }

    @RequestMapping(value = "/youth/program/lecture_love_insert.do", method = RequestMethod.POST)
    public String youth_future_love_inproc(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("loveVo") LoveVo loveVo,
                                     BindingResult bindingResult,
                                     Model model,
                                     SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/program/lecture_view.do?lecture_idx=" + loveVo.getLecture_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                loveVo.setReg_id(loginVo.getUser_id());

                int count = lectureService.checkLoveDupByUserId(loveVo);
                if(count == 0) {
                    lectureService.insertLoveInfo(loveVo);

                    model.addAttribute("msg", "loc");
                    model.addAttribute("locurl", "/ssem/youth/program/lecture_view.do?lecture_idx=" + loveVo.getLecture_idx());
                } else {
                    lectureService.deleteLoveInfo(loveVo);

                    model.addAttribute("msg", "loc");
                    model.addAttribute("locurl", "/ssem/youth/program/lecture_view.do?lecture_idx=" + loveVo.getLecture_idx());
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/program/lecture_insert.do", method = RequestMethod.GET)
    public String youth_program_lecture_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/program/lecture_insert";

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/program/lecture_insert.do?lecture_idx=" + lecture_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            LectureVo lectureVo = getLectureInfo(lecture_idx);

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokenList = mob_no.split("-");
                    lectureVo.setMob_1(tokenList[0]);
                    lectureVo.setMob_2(tokenList[1]);
                    lectureVo.setMob_3(tokenList[2]);
                }
            }

            model.addAttribute("lectureVo", lectureVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/program/lecture_insert.do", method = RequestMethod.POST)
    public String youth_program_lecture_inproc(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("lectureApyVo") LectureApyVo lectureApyVo,
                                     BindingResult bindingResult,
                                     Model model,
                                     SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/program/lecture_insert.do?lecture_idx=" + lectureApyVo.getLecture_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                lectureApyVo.setReg_id(loginVo.getUser_id());
                // 결제 전에는 예약신청으로 판단하며, 예약 후 2일 이내에 결제하지 않으면 자동 취소됩니다.
                // 일반신청시 신청인원으로 판단하며 온라인 신청인원 수를 줄입니다.
                // 대기신청시 대기신청인원 수를 줄입니다.
                // 중요! 동일 아이디로 2번 신청할 수 없다.
                // 만 14세 이상 연령제한이 있는 조건 확인하여 체크한다.
                if("L".equals(lectureApyVo.getAge_type())) {
                    if(DateUtil.getRealAge(loginVo.getBrthdy()) < 14) {
                        model.addAttribute("msg", "alterloc");
                        model.addAttribute("locurl", "/ssem/youth/program/lecture_list.do");
                        model.addAttribute("altmsg", "만14세 이상만 신청하실 수 있습니다.");
                        return "common/message";
                    }
                }
                int check_same = lectureService.checkLectureApySame(lectureApyVo);
                if(check_same == 0) {
                    if ("2".equals(lectureApyVo.getApy_type())) {
                        // 정상신청
                        int online_can_qty = lectureService.checkOnlineCanQtyByIdx(lectureApyVo.getLecture_idx());
                        if (online_can_qty != 0) {
                            if("S".equals(lectureApyVo.getFee_type())) {
                                lectureApyVo.setPay_status("1");
                                lectureApyVo.setAppv_cd("2");
                            } else {
                                lectureApyVo.setPay_status("6");
                                lectureApyVo.setAppv_cd("1");
                            }
                            lectureApyVo.setApy_status("1");
                            lectureApyVo.setApy_gender(loginVo.getSex());
                            lectureApyVo.setApy_birth(loginVo.getBrthdy());

                            lectureService.insertLectureApyInfo(lectureApyVo);
                            lectureService.updateOnlineCanQtyMinusByIdx(lectureApyVo.getLecture_idx());

                            // 자동 승인인 경우 수강생 테이블에 데이터 등록 한다. /////////////////////////////
                            if("1".equals(lectureApyVo.getAppv_cd())) {
                                // 데이터 입력
                                StudentVo studentVo = new StudentVo();

                                studentVo.setPostcode(lectureApyVo.getPostcode());
                                studentVo.setAddr1(lectureApyVo.getApy_addr1());
                                studentVo.setAddr2(lectureApyVo.getApy_addr2());
                                if(lectureApyVo.getApy_ref() == null || "".equals(lectureApyVo.getApy_ref())) {
                                    studentVo.setUser_id(lectureApyVo.getApy_id());
                                    studentVo.setName(lectureApyVo.getApy_name());
                                    studentVo.setBirth(lectureApyVo.getApy_birth());
                                    studentVo.setGender(lectureApyVo.getApy_gender());
                                    studentVo.setMob_no(lectureApyVo.getApy_mob_no());

                                    studentVo.setRef_yn("N");

                                    // !!!매우 중요!!!
                                    // 송파구청 회원 아이디 기준으로 등록된 수강생은 강의 데이터만 입력한다. (본인 신청인 경우)
                                    StudentVo student = lectureService.selectStudentInfoByID(lectureApyVo.getApy_id());
                                    if(student != null) {
                                        StudentLectVo studentLectVo = new StudentLectVo();

                                        studentLectVo.setStudent_idx(student.getStudent_idx());
                                        studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                                        studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                                        GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setP_idx(groupVo.getP_idx());

                                        lectureService.insertStudentLectInfo(studentLectVo);
                                    } else {
                                        lectureService.insertStudentInfo(studentVo);

                                        StudentLectVo studentLectVo = new StudentLectVo();

                                        studentLectVo.setStudent_idx(studentVo.getStudent_idx());
                                        studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                                        studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                                        GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setP_idx(groupVo.getP_idx());

                                        lectureService.insertStudentLectInfo(studentLectVo);
                                    }
                                } else {
                                    studentVo.setName(lectureApyVo.getApy_real_name());
                                    studentVo.setMob_no(lectureApyVo.getApy_ref_mob_no());

                                    studentVo.setRef_yn("Y");

                                    studentVo.setRef_id(lectureApyVo.getApy_id());
                                    studentVo.setRef_name(lectureApyVo.getApy_name());
                                    studentVo.setRef_rel(lectureApyVo.getApy_ref());
                                    studentVo.setRef_mob_no(lectureApyVo.getApy_mob_no());

                                    // !!!매우 중요!!!
                                    // 이름과 전화번호 기준으로 등록된 수강생은 강의 데이터만 입력한다. (대리 신청인 경우)
                                    StudentVo student = lectureService.selectStudentInfo(studentVo);
                                    if (student != null) {
                                        StudentLectVo studentLectVo = new StudentLectVo();

                                        studentLectVo.setStudent_idx(student.getStudent_idx());
                                        studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                                        studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                                        GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setP_idx(groupVo.getP_idx());

                                        lectureService.insertStudentLectInfo(studentLectVo);
                                    } else {
                                        lectureService.insertStudentInfo(studentVo);

                                        StudentLectVo studentLectVo = new StudentLectVo();

                                        studentLectVo.setStudent_idx(studentVo.getStudent_idx());
                                        studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                                        studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                                        GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setP_idx(groupVo.getP_idx());

                                        lectureService.insertStudentLectInfo(studentLectVo);
                                    }
                                }
                            }
                            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                            // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            if("yes".equals(EgovProperties.getProperty("msg.send"))) {
                                LectureVo lectureVo = lectureService.selectLecureInfoByIdx(lectureApyVo.getLecture_idx());
                                StudyPlaceVo studyPlaceVo = lectureService.selectStudyPlaceByIdx(lectureVo.getStudy_place_idx());
                                GroupVo groupVo = lectureService.selectGroupInfoByIdx((int) lectureVo.getGroup_idx());

                                StringBuffer sb = new StringBuffer();
                                sb.append("[송파구청 송파쌤(SSEM)]");
                                sb.append("\r\n");
                                sb.append(String.format("%s님의 프로그램 신청이 완료되었습니다.", lectureApyVo.getApy_name()));
                                sb.append("\r\n");
                                sb.append("<신청내역>");
                                sb.append("\r\n");
                                sb.append(String.format("- 프로그램: %s", lectureVo.getName()));
                                sb.append("\r\n");
                                sb.append(String.format("- 교육장소: %s", studyPlaceVo.getName()));
                                sb.append("\r\n");
                                sb.append("프로그램 신청 확인은 마이페이지에서 확인이 가능합니다.");
                                sb.append("\r\n");
                                sb.append("감사합니다.");
                                sb.append("\r\n");
                                sb.append(String.format("☎ 문의: %s", groupVo.getTel_no()));
                                sb.append("\r\n");
                                sb.append(String.format("송파쌤(SSEM) %s", groupVo.getName()));

                                msgService.sendMsgKakao("프로그램 신청완료", sb.toString(), lectureApyVo.getApy_name(), lectureApyVo.getApy_mob_no().replaceAll("-", ""), "10205");
                            }
                            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                            model.addAttribute("msg", "alterloc");
                            model.addAttribute("locurl", "/ssem/youth/program/lecture_insert_ok.do?lecture_idx=" + lectureApyVo.getLecture_idx());
                            model.addAttribute("altmsg", "신청되었습니다.");
                        } else {
                            model.addAttribute("msg", "alterloc");
                            model.addAttribute("locurl", "/ssem/youth/program/lecture_list.do");
                            model.addAttribute("altmsg", "온라인 신청이 마감되었습니다.");
                            return "common/message";
                        }
                    } else if ("3".equals(lectureApyVo.getApy_type())) {
                        // 대기신청
                        int wait_can_qty = lectureService.checkWaitCanQtyByIdx(lectureApyVo.getLecture_idx());
                        if (wait_can_qty != 0) {
                            if("S".equals(lectureApyVo.getFee_type())) {
                                lectureApyVo.setPay_status("1");
                            } else {
                                lectureApyVo.setPay_status("6");
                            }
                            lectureApyVo.setApy_status("2");
                            lectureApyVo.setAppv_cd("2");
                            lectureApyVo.setApy_gender(loginVo.getSex());
                            lectureApyVo.setApy_birth(loginVo.getBrthdy());

                            lectureService.insertLectureApyInfo(lectureApyVo);
                            lectureService.updateWaitCanQtyMinusByIdx(lectureApyVo.getLecture_idx());

                            // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            if("yes".equals(EgovProperties.getProperty("msg.send"))) {
                                LectureVo lectureVo = lectureService.selectLecureInfoByIdx(lectureApyVo.getLecture_idx());
                                StudyPlaceVo studyPlaceVo = lectureService.selectStudyPlaceByIdx(lectureVo.getStudy_place_idx());
                                GroupVo groupVo = lectureService.selectGroupInfoByIdx((int) lectureVo.getGroup_idx());

                                StringBuffer sb = new StringBuffer();
                                sb.append("[송파구청 송파쌤(SSEM)]");
                                sb.append("\r\n");
                                sb.append(String.format("%s님의 프로그램 대기신청이 완료되었습니다.", lectureApyVo.getApy_name()));
                                sb.append("\r\n");
                                sb.append("<신청내역>");
                                sb.append("\r\n");
                                sb.append(String.format("- 프로그램: %s", lectureVo.getName()));
                                sb.append("\r\n");
                                sb.append(String.format("- 현재 대기번호는 %d 명입니다.", lectureVo.getWait_qty() - lectureVo.getWait_can_qty()));
                                sb.append("\r\n");
                                sb.append(String.format("☎ 문의: %s", groupVo.getTel_no()));
                                sb.append("\r\n");
                                sb.append(String.format("송파쌤(SSEM) %s", groupVo.getName()));

                                msgService.sendMsgKakao("프로그램 대기신청완료", sb.toString(), lectureApyVo.getApy_name(), lectureApyVo.getApy_mob_no().replaceAll("-", ""), "10207");
                            }
                            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                            model.addAttribute("msg", "alterloc");
                            model.addAttribute("locurl", "/ssem/youth/program/lecture_insert_ok.do?lecture_idx=" + lectureApyVo.getLecture_idx());
                            model.addAttribute("altmsg", "대기자 신청이 완료되었습니다.");
                        } else {
                            model.addAttribute("msg", "alterloc");
                            model.addAttribute("locurl", "/ssem/youth/program/lecture_list.do");
                            model.addAttribute("altmsg", "대기자 신청이 마감되었습니다.");
                            return "common/message";
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssem/youth/program/lecture_list.do");
                    model.addAttribute("altmsg", "동일 아이디로 신청한 내역이 있습니다. 마이페이지에서 확인 해 주세요.");
                    return "common/message";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "신청에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/program/lecture_insert_ok.do", method = RequestMethod.GET)
    public String youth_program_lecture_insert_ok(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/program/lecture_insert_ok";

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if (loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/program/lecture_insert_ok.do?lecture_idx=" + lecture_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url = "common/message";
        } else {
            LectureVo lectureVo = getLectureInfo(lecture_idx);

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokenList = mob_no.split("-");
                    lectureVo.setMob_1(tokenList[0]);
                    lectureVo.setMob_2(tokenList[1]);
                    lectureVo.setMob_3(tokenList[2]);
                }
            }

            model.addAttribute("lectureVo", lectureVo);

            // 신청 정보
            LectureApyVo lectureApyVo = new LectureApyVo();
            lectureApyVo.setLecture_idx(lectureVo.getLecture_idx());
            lectureApyVo.setReg_id(loginVo.getUser_id());

            lectureApyVo = lectureService.selectLectureApyInfoByIdx(lectureApyVo);
            model.addAttribute("lectureApyVo", lectureApyVo);

            // 감면 대상 정보
            List<DiscountVo> discountList = new ArrayList<DiscountVo>();
            String discount_str = Util.nvl(lectureVo.getDiscount_str());
            if(!"".equals(discount_str)) {
                String[] tokens = discount_str.split(",");
                for(String token : tokens) {
                    DiscountVo discountVo = lectureService.selectDiscountByIdx(Integer.parseInt(token));
                    discountList.add(discountVo);
                }
            }
            model.addAttribute("discountList", discountList);

            // 상점아이디 가져오기
            GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());

            // 결제 관련
            String configPath = EgovProperties.getProperty("xpay.config");
            String CST_PLATFORM = EgovProperties.getProperty("xpay.platform");
            String LGD_TIMESTAMP = DateUtil.getDate(1) + DateUtil.getTime();
            String LGD_MID = groupVo.getPay_shop_id();
            String LGD_OID = "SSEM_" + LGD_TIMESTAMP;
            String LGD_AMOUNT = String.valueOf(lectureVo.getFee());
            String LGD_HASHDATA = "";
            XPayClient xpay = null;
            try {
                xpay = new XPayClient();
                xpay.Init(configPath, CST_PLATFORM);

                if("".equals(LGD_TIMESTAMP)) {
                    LGD_TIMESTAMP = xpay.GetTimeStamp();
                }
                LGD_HASHDATA = xpay.GetHashData(LGD_MID, LGD_OID, LGD_AMOUNT, LGD_TIMESTAMP);

                PayVo payVo = new PayVo();
                payVo.setLGD_OID(LGD_OID);
                payVo.setLGD_HASHDATA(LGD_HASHDATA);
                payVo.setLGD_TIMESTAMP(LGD_TIMESTAMP);

                model.addAttribute("payVo", payVo);

            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                xpay = null;
            }

            model.addAttribute("CST_PLATFORM", CST_PLATFORM);
            model.addAttribute("LGD_MID", LGD_MID);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/program/lecture_pay_ok.do", method = RequestMethod.GET)
    public String youth_program_lecture_pay_ok(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/program/lecture_pay_ok";

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if (loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/program/lecture_pay_ok.do?lecture_idx=" + lecture_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url = "common/message";
        } else {

            LectureVo lectureVo = getLectureInfo(lecture_idx);
            model.addAttribute("lectureVo", lectureVo);

            // 신청 정보
            LectureApyVo lectureApyVo = new LectureApyVo();
            lectureApyVo.setLecture_idx(lectureVo.getLecture_idx());
            lectureApyVo.setReg_id(loginVo.getUser_id());

            lectureApyVo = lectureService.selectLectureApyInfoByIdx(lectureApyVo);
            model.addAttribute("lectureApyVo", lectureApyVo);

            // 감면정보 가져오기
            DiscountVo discountVo = null;
            if(lectureApyVo.getDiscount_idx() != 0) {
                discountVo = lectureService.selectDiscountByIdx((int)lectureApyVo.getDiscount_idx());
            }
            model.addAttribute("discountVo", discountVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/program/lecture_pay_ok.do", method = RequestMethod.POST)
    public String youth_lecture_pay_ok(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("payVo") PayVo payVo,
                                     BindingResult bindingResult,
                                     Model model,
                                     SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            String configPath = EgovProperties.getProperty("xpay.config");
            String LGD_MID = payVo.getCST_MID();

            XPayClient xpay = new XPayClient();
            boolean isInitOK = xpay.Init(configPath, payVo.getCST_PLATFORM());

            if( !isInitOK ) {
                //API 초기화 실패 화면처리
                    /*out.println( "결제요청을 초기화 하는데 실패하였습니다.<br>");
                    out.println( "토스페이먼츠에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.<br>");
                    out.println( "mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.<br><br>");
                    out.println( "문의전화 토스페이먼츠 1544-7772<br>");*/
                return ret_url;

            }else{
                try{

                    // (3) Init_TX: 메모리에 mall.conf, lgdacom.conf 할당 및 트랜잭션의 고유한 키 TXID 생성
                    xpay.Init_TX(LGD_MID);
                    xpay.Set("LGD_TXNAME", "PaymentByKey");
                    xpay.Set("LGD_PAYKEY", payVo.getLGD_PAYKEY());

                    //금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
                    //String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
                    //xpay.Set("LGD_AMOUNTCHECKYN", "Y");
                    //xpay.Set("LGD_AMOUNT", DB_AMOUNT);

                }catch(Exception e) {
                        /*out.println("토스페이먼츠 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
                        out.println(""+e.getMessage());*/
                    e.printStackTrace();
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "저장에 실패하였습니다.");
                    return ret_url;
                }
            }

            if(loginVo == null) {
                xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/program/lecture_insert_ok.do?lecture_idx=" + payVo.getLecture_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                LectureApyVo lectureApyVo = new LectureApyVo();

                if ( xpay.TX() ) {
                    //1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
                    // (5) DB에 인증요청 결과 처리
                    if( "0000".equals( xpay.m_szResCode ) ) {
                        // 통신상의 문제가 없을시
                        // 최종결제요청 결과 성공 DB처리(LGD_RESPCODE 값에 따라 결제가 성공인지, 실패인지 DB처리)
                        //out.println("최종결제요청 성공, DB처리하시기 바랍니다.<br>");
                        //최종결제요청 결과를 DB처리합니다. (결제성공 또는 실패 모두 DB처리 가능)
                        //상점내 DB에 어떠한 이유로 처리를 하지 못한경우 false로 변경해 주세요.
                        lectureApyVo.setLecture_apy_idx(payVo.getLecture_apy_idx());
                        lectureApyVo.setPay_sucs_yn("Y");
                        lectureApyVo.setPay_sum(Integer.parseInt(xpay.Response("LGD_AMOUNT",0)));
                        lectureApyVo.setTrade_code(xpay.Response("LGD_TID",0));
                        lectureApyVo.setPay_code(payVo.getLGD_PAYKEY());
                        lectureApyVo.setUp_id(loginVo.getUser_id());
                        lectureApyVo.setDiscount_idx(payVo.getDiscount_idx());
                        lectureApyVo.setDiscount_rate(payVo.getDiscount_rate());

                        int check_sucs = lectureService.updateLectureApyPayResult(lectureApyVo);
                        if( check_sucs == 0 ) {

                            xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
                            //out.println( "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0) + "<br>");
                            //out.println( "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0) + "<p>");
                            if( "0000".equals( xpay.m_szResCode ) ) {
                                //out.println("자동취소가 정상적으로 완료 되었습니다.<br>");
                            }else{
                                //out.println("자동취소가 정상적으로 처리되지 않았습니다.<br>");
                            }
                        } else {
                            model.addAttribute("msg", "loc");
                            model.addAttribute("locurl", "/ssem/youth/program/lecture_pay_ok.do?lecture_idx=" + payVo.getLecture_idx());
                            ret_url = "common/message";
                        }

                    } else {
                        lectureApyVo.setPay_sucs_yn("N");
                        lectureApyVo.setUp_id(loginVo.getUser_id());
                        lectureService.updateLectureApyPayResult(lectureApyVo);
                        model.addAttribute("msg", "alterBack");
                        model.addAttribute("altmsg", "저장에 실패하였습니다.");
                        return ret_url;
                        //통신상의 문제 발생(최종결제요청 결과 실패 DB처리)
                        //out.println("최종결제요청 결과 실패, DB처리하시기 바랍니다.<br>");
                    }
                } else {
                    //2)API 요청실패 화면처리
                    /*out.println( "결제요청이 실패하였습니다.  <br>");
                    out.println( "TX 결제요청 Response_code = " + xpay.m_szResCode + "<br>");
                    out.println( "TX 결제요청 Response_msg = " + xpay.m_szResMsg + "<p>");*/
                    //최종결제요청 결과 실패 DB처리
                    /*out.println("최종결제요청 결과 실패 DB처리하시기 바랍니다.<br>");*/
                    lectureApyVo.setPay_sucs_yn("N");
                    lectureApyVo.setUp_id(loginVo.getUser_id());
                    lectureService.updateLectureApyPayResult(lectureApyVo);
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "저장에 실패하였습니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/senior/program/lecture_list.do")
    public String senior_program_lecture_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/program/lecture_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 홈페이지 구분
        searchVo.setSearchVal4("S");

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : itemList) {

            //교육대상 가져오기
            List<String> array_tgt = new ArrayList<String>();
            String tgt_code = lectureVo.getTgt_code();
            String[] tokens = tgt_code.split(",");
            for(String code : tokens) {
                String code_txt = appService.selectCodeByIdx(Integer.parseInt(code));
                array_tgt.add(code_txt);
            }
            lectureVo.setArray_tgt(array_tgt);

            // 교육분야 가져오기
            String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
            lectureVo.setPart_name(part_name);

            // 좋아요
            int love_cnt = lectureService.selectLoveCount(lectureVo.getLecture_idx());
            lectureVo.setLove_cnt(love_cnt);

            // 좋아요 본인여부
            if(loginVo != null) {
                LoveVo love = new LoveVo();
                love.setLecture_idx(lectureVo.getLecture_idx());
                love.setReg_id(loginVo.getUser_id());
                int check = lectureService.selectLoveCountBySelf(love);
                if(check != 0) {
                    lectureVo.setLove_self_yn("Y");
                }
            }

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

            // 조직 정보
            GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
            lectureVo.setGroup(groupVo);

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
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        // 교육대상
        List<CodeVo> tgtList = appService.selectCodeList("STUDY_TGT");
        model.addAttribute("tgtList", tgtList);

        // 교육분야
        List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
        model.addAttribute("codeList", codeList);

        // 교육기관
        List<GroupVo> groupList = appService.selectSubGroupListAll();
        model.addAttribute("groupList", groupList);

        return ret_url;
    }

    @RequestMapping(value = "/senior/program/lecture_view.do", method = RequestMethod.GET)
    public String senior_program_lecture_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/program/lecture_view";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        LectureVo lectureVo = getLectureInfo(lecture_idx);

        // 좋아요 본인여부
        if(loginVo != null) {
            LoveVo love = new LoveVo();
            love.setLecture_idx(lecture_idx);
            love.setReg_id(loginVo.getUser_id());
            int check = lectureService.selectLoveCountBySelf(love);
            if(check != 0) {
                lectureVo.setLove_self_yn("Y");
            }
        }

        // 첨부파일 처리
        String atchFileId = lectureVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        lectureVo.setFileList(fileVoList);

        model.addAttribute("lectureVo", lectureVo);

        return ret_url;
    }

    @RequestMapping(value = "/senior/program/lecture_preview.do", method = RequestMethod.GET)
    public String senior_program_lecture_preview(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/program/lecture_preview";

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        LectureVo lectureVo = getLectureInfo(lecture_idx);

        // 첨부파일 처리
        String atchFileId = lectureVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        lectureVo.setFileList(fileVoList);

        model.addAttribute("lectureVo", lectureVo);

        return ret_url;
    }

    @RequestMapping(value = "/senior/program/lecture_love_insert.do", method = RequestMethod.POST)
    public String senior_future_love_inproc(final MultipartHttpServletRequest multiRequest,
                                           @ModelAttribute("loveVo") LoveVo loveVo,
                                           BindingResult bindingResult,
                                           Model model,
                                           SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/program/lecture_view.do?lecture_idx=" + loveVo.getLecture_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                loveVo.setReg_id(loginVo.getUser_id());

                int count = lectureService.checkLoveDupByUserId(loveVo);
                if(count == 0) {
                    lectureService.insertLoveInfo(loveVo);

                    model.addAttribute("msg", "loc");
                    model.addAttribute("locurl", "/ssem/senior/program/lecture_view.do?lecture_idx=" + loveVo.getLecture_idx());
                } else {
                    lectureService.deleteLoveInfo(loveVo);

                    model.addAttribute("msg", "loc");
                    model.addAttribute("locurl", "/ssem/senior/program/lecture_view.do?lecture_idx=" + loveVo.getLecture_idx());
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/program/lecture_insert.do", method = RequestMethod.GET)
    public String senior_program_lecture_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/program/lecture_insert";

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/program/lecture_insert.do?lecture_idx=" + lecture_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            LectureVo lectureVo = getLectureInfo(lecture_idx);

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokenList = mob_no.split("-");
                    lectureVo.setMob_1(tokenList[0]);
                    lectureVo.setMob_2(tokenList[1]);
                    lectureVo.setMob_3(tokenList[2]);
                }
            }

            model.addAttribute("lectureVo", lectureVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/program/lecture_insert.do", method = RequestMethod.POST)
    public String senior_program_lecture_inproc(final MultipartHttpServletRequest multiRequest,
                                               @ModelAttribute("lectureApyVo") LectureApyVo lectureApyVo,
                                               BindingResult bindingResult,
                                               Model model,
                                               SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/program/lecture_insert.do?lecture_idx=" + lectureApyVo.getLecture_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                lectureApyVo.setReg_id(loginVo.getUser_id());
                // 결제 전에는 예약신청으로 판단하며, 예약 후 2일 이내에 결제하지 않으면 자동 취소됩니다.
                // 일반신청시 신청인원으로 판단하며 온라인 신청인원 수를 줄입니다.
                // 대기신청시 대기신청인원 수를 줄입니다.
                // 중요! 동일 아이디로 2번 신청할 수 없다.
                // 만 14세 이상 연령제한이 있는 조건 확인하여 체크한다.
                if("L".equals(lectureApyVo.getAge_type())) {
                    if(DateUtil.getRealAge(loginVo.getBrthdy()) < 14) {
                        model.addAttribute("msg", "alterloc");
                        model.addAttribute("locurl", "/ssem/youth/program/lecture_list.do");
                        model.addAttribute("altmsg", "만14세 이상만 신청하실 수 있습니다.");
                        return "common/message";
                    }
                }

                int check_same = lectureService.checkLectureApySame(lectureApyVo);
                if(check_same == 0) {
                    if ("2".equals(lectureApyVo.getApy_type())) {
                        // 정상신청
                        int online_can_qty = lectureService.checkOnlineCanQtyByIdx(lectureApyVo.getLecture_idx());
                        if (online_can_qty != 0) {
                            if("S".equals(lectureApyVo.getFee_type())) {
                                lectureApyVo.setPay_status("1");
                                lectureApyVo.setAppv_cd("2");
                            } else {
                                lectureApyVo.setPay_status("6");
                                lectureApyVo.setAppv_cd("1");
                            }
                            lectureApyVo.setApy_status("1");
                            lectureApyVo.setApy_gender(loginVo.getSex());
                            lectureApyVo.setApy_birth(loginVo.getBrthdy());

                            lectureService.insertLectureApyInfo(lectureApyVo);
                            lectureService.updateOnlineCanQtyMinusByIdx(lectureApyVo.getLecture_idx());

                            // 자동 승인인 경우 수강생 테이블에 데이터 등록 한다. /////////////////////////////
                            if("1".equals(lectureApyVo.getAppv_cd())) {
                                // 데이터 입력
                                StudentVo studentVo = new StudentVo();

                                studentVo.setPostcode(lectureApyVo.getPostcode());
                                studentVo.setAddr1(lectureApyVo.getApy_addr1());
                                studentVo.setAddr2(lectureApyVo.getApy_addr2());
                                if(lectureApyVo.getApy_ref() == null || "".equals(lectureApyVo.getApy_ref())) {
                                    studentVo.setUser_id(lectureApyVo.getApy_id());
                                    studentVo.setName(lectureApyVo.getApy_name());
                                    studentVo.setBirth(lectureApyVo.getApy_birth());
                                    studentVo.setGender(lectureApyVo.getApy_gender());
                                    studentVo.setMob_no(lectureApyVo.getApy_mob_no());

                                    studentVo.setRef_yn("N");

                                    // !!!매우 중요!!!
                                    // 송파구청 회원 아이디 기준으로 등록된 수강생은 강의 데이터만 입력한다. (본인 신청인 경우)
                                    StudentVo student = lectureService.selectStudentInfoByID(lectureApyVo.getApy_id());
                                    if(student != null) {
                                        StudentLectVo studentLectVo = new StudentLectVo();

                                        studentLectVo.setStudent_idx(student.getStudent_idx());
                                        studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                                        studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                                        GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setP_idx(groupVo.getP_idx());

                                        lectureService.insertStudentLectInfo(studentLectVo);
                                    } else {
                                        lectureService.insertStudentInfo(studentVo);

                                        StudentLectVo studentLectVo = new StudentLectVo();

                                        studentLectVo.setStudent_idx(studentVo.getStudent_idx());
                                        studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                                        studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                                        GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setP_idx(groupVo.getP_idx());

                                        lectureService.insertStudentLectInfo(studentLectVo);
                                    }
                                } else {
                                    studentVo.setName(lectureApyVo.getApy_real_name());
                                    studentVo.setMob_no(lectureApyVo.getApy_ref_mob_no());

                                    studentVo.setRef_yn("Y");

                                    studentVo.setRef_id(lectureApyVo.getApy_id());
                                    studentVo.setRef_name(lectureApyVo.getApy_name());
                                    studentVo.setRef_rel(lectureApyVo.getApy_ref());
                                    studentVo.setRef_mob_no(lectureApyVo.getApy_mob_no());

                                    // !!!매우 중요!!!
                                    // 이름과 전화번호 기준으로 등록된 수강생은 강의 데이터만 입력한다. (대리 신청인 경우)
                                    StudentVo student = lectureService.selectStudentInfo(studentVo);
                                    if (student != null) {
                                        StudentLectVo studentLectVo = new StudentLectVo();

                                        studentLectVo.setStudent_idx(student.getStudent_idx());
                                        studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                                        studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                                        GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setP_idx(groupVo.getP_idx());

                                        lectureService.insertStudentLectInfo(studentLectVo);
                                    } else {
                                        lectureService.insertStudentInfo(studentVo);

                                        StudentLectVo studentLectVo = new StudentLectVo();

                                        studentLectVo.setStudent_idx(studentVo.getStudent_idx());
                                        studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                                        studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                                        GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                                        studentLectVo.setP_idx(groupVo.getP_idx());

                                        lectureService.insertStudentLectInfo(studentLectVo);
                                    }
                                }
                            }
                            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                            // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            if("yes".equals(EgovProperties.getProperty("msg.send"))) {
                                LectureVo lectureVo = lectureService.selectLecureInfoByIdx(lectureApyVo.getLecture_idx());
                                StudyPlaceVo studyPlaceVo = lectureService.selectStudyPlaceByIdx(lectureVo.getStudy_place_idx());
                                GroupVo groupVo = lectureService.selectGroupInfoByIdx((int) lectureVo.getGroup_idx());

                                StringBuffer sb = new StringBuffer();
                                sb.append("[송파구청 송파쌤(SSEM)]");
                                sb.append("\r\n");
                                sb.append(String.format("%s님의 프로그램 신청이 완료되었습니다.", lectureApyVo.getApy_name()));
                                sb.append("\r\n");
                                sb.append("<신청내역>");
                                sb.append("\r\n");
                                sb.append(String.format("- 프로그램: %s", lectureVo.getName()));
                                sb.append("\r\n");
                                sb.append(String.format("- 교육장소: %s", studyPlaceVo.getName()));
                                sb.append("\r\n");
                                sb.append("프로그램 신청 확인은 마이페이지에서 확인이 가능합니다.");
                                sb.append("\r\n");
                                sb.append("감사합니다.");
                                sb.append("\r\n");
                                sb.append(String.format("☎ 문의: %s", groupVo.getTel_no()));
                                sb.append("\r\n");
                                sb.append(String.format("송파쌤(SSEM) %s", groupVo.getName()));

                                msgService.sendMsgKakao("프로그램 신청완료", sb.toString(), lectureApyVo.getApy_name(), lectureApyVo.getApy_mob_no().replaceAll("-", ""), "10205");
                            }
                            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                            model.addAttribute("msg", "alterloc");
                            model.addAttribute("locurl", "/ssem/senior/program/lecture_insert_ok.do?lecture_idx=" + lectureApyVo.getLecture_idx());
                            model.addAttribute("altmsg", "신청되었습니다.");
                        } else {
                            model.addAttribute("msg", "alterloc");
                            model.addAttribute("locurl", "/ssem/senior/program/lecture_list.do");
                            model.addAttribute("altmsg", "온라인 신청이 마감되었습니다.");
                            return "common/message";
                        }
                    } else if ("3".equals(lectureApyVo.getApy_type())) {
                        // 대기신청
                        int wait_can_qty = lectureService.checkWaitCanQtyByIdx(lectureApyVo.getLecture_idx());
                        if (wait_can_qty != 0) {
                            if("S".equals(lectureApyVo.getFee_type())) {
                                lectureApyVo.setPay_status("1");
                            } else {
                                lectureApyVo.setPay_status("6");
                            }
                            lectureApyVo.setApy_status("2");
                            lectureApyVo.setAppv_cd("2");
                            lectureApyVo.setApy_gender(loginVo.getSex());
                            lectureApyVo.setApy_birth(loginVo.getBrthdy());

                            lectureService.insertLectureApyInfo(lectureApyVo);
                            lectureService.updateWaitCanQtyMinusByIdx(lectureApyVo.getLecture_idx());

                            // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            if("yes".equals(EgovProperties.getProperty("msg.send"))) {
                                LectureVo lectureVo = lectureService.selectLecureInfoByIdx(lectureApyVo.getLecture_idx());
                                StudyPlaceVo studyPlaceVo = lectureService.selectStudyPlaceByIdx(lectureVo.getStudy_place_idx());
                                GroupVo groupVo = lectureService.selectGroupInfoByIdx((int) lectureVo.getGroup_idx());

                                StringBuffer sb = new StringBuffer();
                                sb.append("[송파구청 송파쌤(SSEM)]");
                                sb.append("\r\n");
                                sb.append(String.format("%s님의 프로그램 대기신청이 완료되었습니다.", lectureApyVo.getApy_name()));
                                sb.append("\r\n");
                                sb.append("<신청내역>");
                                sb.append("\r\n");
                                sb.append(String.format("- 프로그램: %s", lectureVo.getName()));
                                sb.append("\r\n");
                                sb.append(String.format("- 현재 대기번호는 %d 명입니다.", lectureVo.getWait_qty() - lectureVo.getWait_can_qty()));
                                sb.append("\r\n");
                                sb.append(String.format("☎ 문의: %s", groupVo.getTel_no()));
                                sb.append("\r\n");
                                sb.append(String.format("송파쌤(SSEM) %s", groupVo.getName()));

                                msgService.sendMsgKakao("프로그램 대기신청완료", sb.toString(), lectureApyVo.getApy_name(), lectureApyVo.getApy_mob_no().replaceAll("-", ""), "10207");
                            }
                            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                            model.addAttribute("msg", "alterloc");
                            model.addAttribute("locurl", "/ssem/senior/program/lecture_insert_ok.do?lecture_idx=" + lectureApyVo.getLecture_idx());
                            model.addAttribute("altmsg", "대기자 신청이 완료되었습니다.");
                        } else {
                            model.addAttribute("msg", "alterloc");
                            model.addAttribute("locurl", "/ssem/senior/program/lecture_list.do");
                            model.addAttribute("altmsg", "대기자 신청이 마감되었습니다.");
                            return "common/message";
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssem/senior/program/lecture_list.do");
                    model.addAttribute("altmsg", "동일 아이디로 신청한 내역이 있습니다. 마이페이지에서 확인 해 주세요.");
                    return "common/message";
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "신청에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/program/lecture_insert_ok.do", method = RequestMethod.GET)
    public String senior_program_lecture_insert_ok(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/program/lecture_insert_ok";

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if (loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/program/lecture_insert_ok.do?lecture_idx=" + lecture_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url = "common/message";
        } else {
            LectureVo lectureVo = getLectureInfo(lecture_idx);

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokenList = mob_no.split("-");
                    lectureVo.setMob_1(tokenList[0]);
                    lectureVo.setMob_2(tokenList[1]);
                    lectureVo.setMob_3(tokenList[2]);
                }
            }

            model.addAttribute("lectureVo", lectureVo);

            // 신청 정보
            LectureApyVo lectureApyVo = new LectureApyVo();
            lectureApyVo.setLecture_idx(lectureVo.getLecture_idx());
            lectureApyVo.setReg_id(loginVo.getUser_id());

            lectureApyVo = lectureService.selectLectureApyInfoByIdx(lectureApyVo);
            model.addAttribute("lectureApyVo", lectureApyVo);

            // 감면 대상 정보
            List<DiscountVo> discountList = new ArrayList<DiscountVo>();
            String discount_str = Util.nvl(lectureVo.getDiscount_str());
            if(!"".equals(discount_str)) {
                String[] tokens = discount_str.split(",");
                for(String token : tokens) {
                    DiscountVo discountVo = lectureService.selectDiscountByIdx(Integer.parseInt(token));
                    discountList.add(discountVo);
                }
            }
            model.addAttribute("discountList", discountList);

            // 상점아이디 가져오기
            GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());

            // 결제 관련
            String configPath = EgovProperties.getProperty("xpay.config");
            String CST_PLATFORM = EgovProperties.getProperty("xpay.platform");
            String LGD_TIMESTAMP = DateUtil.getDate(1) + DateUtil.getTime();
            String LGD_MID = groupVo.getPay_shop_id();
            String LGD_OID = "SSEM_" + LGD_TIMESTAMP;
            String LGD_AMOUNT = String.valueOf(lectureVo.getFee());
            String LGD_HASHDATA = "";
            XPayClient xpay = null;
            try {
                xpay = new XPayClient();
                xpay.Init(configPath, CST_PLATFORM);

                if("".equals(LGD_TIMESTAMP)) {
                    LGD_TIMESTAMP = xpay.GetTimeStamp();
                }
                LGD_HASHDATA = xpay.GetHashData(LGD_MID, LGD_OID, LGD_AMOUNT, LGD_TIMESTAMP);

                PayVo payVo = new PayVo();
                payVo.setLGD_OID(LGD_OID);
                payVo.setLGD_HASHDATA(LGD_HASHDATA);
                payVo.setLGD_TIMESTAMP(LGD_TIMESTAMP);

                model.addAttribute("payVo", payVo);

            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                xpay = null;
            }

            model.addAttribute("CST_PLATFORM", CST_PLATFORM);
            model.addAttribute("LGD_MID", LGD_MID);
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/program/lecture_pay_ok.do", method = RequestMethod.GET)
    public String senior_program_lecture_pay_ok(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/program/lecture_pay_ok";

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if (loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/program/lecture_pay_ok.do?lecture_idx=" + lecture_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url = "common/message";
        } else {

            LectureVo lectureVo = getLectureInfo(lecture_idx);
            model.addAttribute("lectureVo", lectureVo);

            // 신청 정보
            LectureApyVo lectureApyVo = new LectureApyVo();
            lectureApyVo.setLecture_idx(lectureVo.getLecture_idx());
            lectureApyVo.setReg_id(loginVo.getUser_id());

            lectureApyVo = lectureService.selectLectureApyInfoByIdx(lectureApyVo);
            model.addAttribute("lectureApyVo", lectureApyVo);

            // 감면정보 가져오기
            DiscountVo discountVo = null;
            if(lectureApyVo.getDiscount_idx() != 0) {
                discountVo = lectureService.selectDiscountByIdx((int)lectureApyVo.getDiscount_idx());
            }
            model.addAttribute("discountVo", discountVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/program/lecture_pay_ok.do", method = RequestMethod.POST)
    public String senior_lecture_pay_ok(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("payVo") PayVo payVo,
                                       BindingResult bindingResult,
                                       Model model,
                                       SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            String configPath = EgovProperties.getProperty("xpay.config");
            String LGD_MID = payVo.getCST_MID();
            XPayClient xpay = new XPayClient();
            boolean isInitOK = xpay.Init(configPath, payVo.getCST_PLATFORM());

            if( !isInitOK ) {
                //API 초기화 실패 화면처리
                    /*out.println( "결제요청을 초기화 하는데 실패하였습니다.<br>");
                    out.println( "토스페이먼츠에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.<br>");
                    out.println( "mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.<br><br>");
                    out.println( "문의전화 토스페이먼츠 1544-7772<br>");*/
                return ret_url;

            }else{
                try{

                    // (3) Init_TX: 메모리에 mall.conf, lgdacom.conf 할당 및 트랜잭션의 고유한 키 TXID 생성
                    xpay.Init_TX(LGD_MID);
                    xpay.Set("LGD_TXNAME", "PaymentByKey");
                    xpay.Set("LGD_PAYKEY", payVo.getLGD_PAYKEY());

                    //금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
                    //String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
                    //xpay.Set("LGD_AMOUNTCHECKYN", "Y");
                    //xpay.Set("LGD_AMOUNT", DB_AMOUNT);

                }catch(Exception e) {
                        /*out.println("토스페이먼츠 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
                        out.println(""+e.getMessage());*/
                    e.printStackTrace();
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "저장에 실패하였습니다.");
                    return ret_url;
                }
            }

            if(loginVo == null) {
                xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/program/lecture_insert_ok.do?lecture_idx=" + payVo.getLecture_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                LectureApyVo lectureApyVo = new LectureApyVo();

                if ( xpay.TX() ) {
                    //1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
                    // (5) DB에 인증요청 결과 처리
                    if( "0000".equals( xpay.m_szResCode ) ) {
                        // 통신상의 문제가 없을시
                        // 최종결제요청 결과 성공 DB처리(LGD_RESPCODE 값에 따라 결제가 성공인지, 실패인지 DB처리)
                        //out.println("최종결제요청 성공, DB처리하시기 바랍니다.<br>");
                        //최종결제요청 결과를 DB처리합니다. (결제성공 또는 실패 모두 DB처리 가능)
                        //상점내 DB에 어떠한 이유로 처리를 하지 못한경우 false로 변경해 주세요.
                        lectureApyVo.setLecture_apy_idx(payVo.getLecture_apy_idx());
                        lectureApyVo.setPay_sucs_yn("Y");
                        lectureApyVo.setPay_sum(Integer.parseInt(xpay.Response("LGD_AMOUNT",0)));
                        lectureApyVo.setTrade_code(xpay.Response("LGD_TID",0));
                        lectureApyVo.setPay_code(payVo.getLGD_PAYKEY());
                        lectureApyVo.setUp_id(loginVo.getUser_id());
                        lectureApyVo.setDiscount_idx(payVo.getDiscount_idx());
                        lectureApyVo.setDiscount_rate(payVo.getDiscount_rate());

                        int check_sucs = lectureService.updateLectureApyPayResult(lectureApyVo);
                        if( check_sucs == 0 ) {

                            xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
                            //out.println( "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0) + "<br>");
                            //out.println( "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0) + "<p>");
                            if( "0000".equals( xpay.m_szResCode ) ) {
                                //out.println("자동취소가 정상적으로 완료 되었습니다.<br>");
                            }else{
                                //out.println("자동취소가 정상적으로 처리되지 않았습니다.<br>");
                            }
                        } else {
                            model.addAttribute("msg", "loc");
                            model.addAttribute("locurl", "/ssem/senior/program/lecture_pay_ok.do?lecture_idx=" + payVo.getLecture_idx());
                            ret_url = "common/message";
                        }

                    } else {
                        lectureApyVo.setPay_sucs_yn("N");
                        lectureApyVo.setUp_id(loginVo.getUser_id());
                        lectureService.updateLectureApyPayResult(lectureApyVo);
                        model.addAttribute("msg", "alterBack");
                        model.addAttribute("altmsg", "저장에 실패하였습니다.");
                        return ret_url;
                        //통신상의 문제 발생(최종결제요청 결과 실패 DB처리)
                        //out.println("최종결제요청 결과 실패, DB처리하시기 바랍니다.<br>");
                    }
                } else {
                    //2)API 요청실패 화면처리
                    /*out.println( "결제요청이 실패하였습니다.  <br>");
                    out.println( "TX 결제요청 Response_code = " + xpay.m_szResCode + "<br>");
                    out.println( "TX 결제요청 Response_msg = " + xpay.m_szResMsg + "<p>");*/
                    //최종결제요청 결과 실패 DB처리
                    /*out.println("최종결제요청 결과 실패 DB처리하시기 바랍니다.<br>");*/
                    lectureApyVo.setPay_sucs_yn("N");
                    lectureApyVo.setUp_id(loginVo.getUser_id());
                    lectureService.updateLectureApyPayResult(lectureApyVo);
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "저장에 실패하였습니다.");
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

    private LectureVo getLectureInfo(int lecture_idx) throws Exception {
        LectureVo lectureVo = new LectureVo();
        lectureVo.setLecture_idx(lecture_idx);

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

        // 교육분야 가져오기
        String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
        lectureVo.setPart_name(part_name);

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

        // 조직 정보
        GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
        lectureVo.setGroup(groupVo);

        // 시설 정보
        StudyPlaceVo place = lectureService.selectStudyPlaceByIdx(lectureVo.getStudy_place_idx());
        lectureVo.setPlace(place);

        // 감면 정보
        List<DiscountVo> array_discount = new ArrayList<DiscountVo>();
        if(lectureVo.getDiscount_str() != null) {
            String[] discounts = lectureVo.getDiscount_str().split(",");
            for (String discount : discounts) {
                DiscountVo dis = lectureService.selectDiscountByIdx(Integer.valueOf(discount));
                array_discount.add(dis);
            }
        }
        lectureVo.setArray_discount(array_discount);

        // 강사 정보
        TeacherVo teacher = lectureService.selectTeacherInfoByIdx(lectureVo.getTeacher_idx());
        if(teacher != null) {
            // 첨부파일 처리
            String atchFileId = teacher.getPic_atch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for (FileVo fileVo : fileVoList) {
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            teacher.setPicFileList(fileVoList);

            // 주요경력 엔터처리
            String career = teacher.getCareer();
            if(!"".equals(Util.nvl(career))) {
                career = career.replaceAll(System.getProperty("line.separator"), "<br/>");
                teacher.setCareer(career);
            }

            teacher.setLecture_idx(lectureVo.getLecture_idx());

            // score => 0 : 평가 없음
            // score => 1 : 금
            // score => 2 : 은
            // score => 3 : 동
            int score = 0;
            int total_cnt = lectureService.selectTeacherScoreTotalCnt(teacher);
            if(total_cnt != 0) {
                int total_score = lectureService.selectTeacherScoreTotal(teacher);
                score = Util.getTeacherScore(total_cnt, total_score);
            } else {
                score = 0;
            }
            teacher.setScore(score);

            lectureVo.setTeacher(teacher);
        }

        // 특이사항 엔터처리
        String desc_txt = lectureVo.getDesc_txt();
        if(!"".equals(Util.nvl(desc_txt))) {
            desc_txt = desc_txt.replaceAll(System.getProperty("line.separator"), "<br/>");
            lectureVo.setDesc_txt(desc_txt);
        }

        // 환불정책 엔터처리
        String refund_txt = lectureVo.getRefund_txt();
        if(!"".equals(Util.nvl(refund_txt))) {
            refund_txt = refund_txt.replaceAll(System.getProperty("line.separator"), "<br/>");
            lectureVo.setRefund_txt(refund_txt);
        }

        // 좋아요 카운트
        int love_cnt = lectureService.selectLoveCount(lectureVo.getLecture_idx());
        lectureVo.setLove_cnt(love_cnt);

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

        return lectureVo;
    }
}
