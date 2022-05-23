package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.*;
import kr.go.songpa.ssem.util.DateUtil;
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
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-10-19
 * Description :
 * History :
 * Version :
 */
@Controller
public class PopupController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private MagnetService magnetService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private UserService userService;

    @Autowired
    private CampusService campusService;

    @Autowired
    private SelfHallService selfHallService;

    public PopupController() {

    }

    @RequestMapping("/popup/discount/discount_list.do")
    public String discount_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

        String ret_url = "popup/discount/discount_list";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        SearchVo searchVo = null;
        int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);
        if(group_idx != 0) {
            searchVo = this.getSearch(request, 10, group_idx);
        } else {
            searchVo = this.getSearch(request);
        }

        this.getModel(request, model);

        //int discount_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            List<DiscountVo> itemList = lectureService.selectDiscountListEx(searchVo);
            model.addAttribute("itemList", itemList);

            GroupVo groupVo = lectureService.selectGroupInfoByIdx(group_idx);
            model.addAttribute("groupVo", groupVo);

            // 감면율
            List<String> rateList = Util.getRateList();
            model.addAttribute("rateList", rateList);
        }

        return ret_url;
    }

    @RequestMapping("/popup/discount/discount_select.do")
    public String discount_select(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

        String ret_url = "popup/discount/discount_select";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        SearchVo searchVo = null;
        int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);
        int selected_discount_idx = ServletRequestUtils.getIntParameter(request, "discount_idx", 0);
        int pay_sum = ServletRequestUtils.getIntParameter(request, "pay_sum", 0);
        if(group_idx != 0) {
            searchVo = this.getSearch(request, 10, group_idx);
        } else {
            searchVo = this.getSearch(request);
        }

        this.getModel(request, model);

        //int discount_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            List<DiscountVo> itemList = lectureService.selectDiscountListEx(searchVo);
            model.addAttribute("itemList", itemList);

            model.addAttribute("selected_discount_idx", selected_discount_idx);
            model.addAttribute("pay_sum", pay_sum);

            GroupVo groupVo = lectureService.selectGroupInfoByIdx(group_idx);
            model.addAttribute("groupVo", groupVo);

            // 감면율
            List<String> rateList = Util.getRateList();
            model.addAttribute("rateList", rateList);
        }

        return ret_url;
    }

    @RequestMapping("/popup/teacher/teacher_list.do")
    public String teacher_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "popup/teacher/teacher_list";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = null;
        int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);
        int p_idx = ServletRequestUtils.getIntParameter(request, "p_idx", 0);
        if(group_idx != 0) {
            searchVo = this.getSearch(request, 10, p_idx, group_idx);
        } else {
            searchVo = this.getSearch(request);
        }
        this.getModel(request, model, 10, p_idx, group_idx);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            List<TeacherVo> itemList = lectureService.selectTeacherListEx(searchVo);
            for(TeacherVo teacher : itemList) {
                String code_name = appService.selectCodeByIdx(teacher.getCode_idx());
                teacher.setCode_name(code_name);
            }
            int totalCount = lectureService.selectTeacherListTotalEx(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);

            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping("/popup/room/room_list.do")
    public String room_item_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "popup/room/room_list";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        SearchVo searchVo = null;
        int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);
        if(group_idx != 0) {
            searchVo = this.getSearch(request, 10, group_idx);
        } else {
            searchVo = this.getSearch(request);
        }

        this.getModel(request, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            List<StudyPlaceVo> itemList = lectureService.selectRoomList(searchVo);
            int totalCount = lectureService.selectRoomListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            GroupVo groupVo = lectureService.selectGroupInfoByIdx(group_idx);
            int room_cnt = lectureService.selectRoomCntByGroupIdx(group_idx);
            groupVo.setRoom_cnt(room_cnt);
            model.addAttribute("groupVo", groupVo);
        }

        return ret_url;
    }

    @RequestMapping("/popup/magnet/program_list.do")
    public String program_item_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "popup/magnet/program_list";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if("".equals(searchVo.getSearchVal2())) {
                searchVo.setSearchVal2(String.valueOf(35));
                model.addAttribute("searchVal2", String.valueOf(35));
            }

            if("".equals(searchVo.getSearchVal3())) {
                searchVo.setSearchVal3(String.valueOf(41));
                model.addAttribute("searchVal3", String.valueOf(41));
            }

            if(!"".equals(searchVo.getSearchVal8())) {
                List<String> searchArrayVal = Util.transStringToList(searchVo.getSearchVal8(), " ");
                if(searchArrayVal.size() != 0) {
                    searchVo.setSearchArrayVal(searchArrayVal);
                }
            }

            List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
            for(LectureVo lecture : itemList) {
                String code_name = appService.selectCodeByIdx(lecture.getPart_code_idx());
                lecture.setPart_name(code_name);

                // 요일 정보
                lecture.setWeekList(StringUtil.getWeekStrToWeekCode(lecture.getDt_week()));

                // 프로그램 상태 체크
                // 1. 접수대기 : 접수날짜 도래 하지 않음
                // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                // 5. 교육전 :
                // 6. 교육중 : 교육날짜 내
                // 7. 교육종료 : 교육날짜 지남
                // 8. 외부홈페이지 : 외부 홈페이지일 경우
                int code = Util.getProgramStatus(lecture);
                lecture.setStatus_code(code);
            }
            int totalCount = lectureService.selectLectureListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);

            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            // 교육대상
            List<CodeVo> tgtList = appService.selectCodeList("STUDY_TGT");
            model.addAttribute("tgtList", tgtList);
        }

        return ret_url;
    }

    @RequestMapping("/popup/magnet/can_teach_info.do")
    public String can_teach_info(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "popup/magnet/can_teach_info";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            int teach_study_idx = ServletRequestUtils.getIntParameter(request, "teach_study_idx", 0);

            TeachStudyVo teachStudyVo = magnetService.selectTeachStudyInfoByIdx(teach_study_idx);
            String code_name = appService.selectCodeByIdx(teachStudyVo.getCode_idx());
            teachStudyVo.setCode_name(code_name);

            // 상세내용 엔터처리
            String cont = teachStudyVo.getCont();
            cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
            teachStudyVo.setCont(cont);

            // 강의계획서
            String planFileId = teachStudyVo.getTeach_atch_file_id();
            String plan_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo planfvo = new FileVo();
            planfvo.setAtch_file_id(planFileId);
            List<FileVo> planFileList = fileMngService.selectFileInfs(planfvo);
            for(FileVo fileVo : planFileList){
                fileVo.setFile_src(plan_path + "/" + fileVo.getFile_nm());
            }
            teachStudyVo.setPlanFileList(planFileList);

            // 강사이력
            String careerFileId = teachStudyVo.getCareer_atch_file_id();
            String career_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo careerfvo = new FileVo();
            careerfvo.setAtch_file_id(careerFileId);
            List<FileVo> careerFileList = fileMngService.selectFileInfs(careerfvo);
            for(FileVo fileVo : careerFileList){
                fileVo.setFile_src(career_path + "/" + fileVo.getFile_nm());
            }
            teachStudyVo.setCareerFileList(careerFileList);

            model.addAttribute("teachStudyVo", teachStudyVo);
        }

        return ret_url;
    }

    @RequestMapping("/popup/user/user_list.do")
    public String user_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "popup/user/user_list";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            List<TnUserInfoVo> itemList = userService.selectUserList(searchVo);
            int totalCount = userService.selectUserListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping("/popup/student/student_list.do")
    public String student_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "popup/student/student_list";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            List<StudentVo> itemList = lectureService.selectStudentList(searchVo);
            for(StudentVo studentVo : itemList) {
                if("Y".equals(studentVo.getLike_yn())) {
                    String memo = lectureService.selectStudentMemoByIdx(studentVo.getStudent_idx());
                    // 메모 엔터처리
                    if (!"".equals(Util.nvl(memo))) {
                        memo = memo.replaceAll(System.getProperty("line.separator"), "<br/>");
                        studentVo.setMemo_html(memo);
                    }
                }
            }
            int totalCount = lectureService.selectStudentListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/popup/lecture/reg_room_insert.do", method = RequestMethod.GET)
    public String reg_room_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "popup/lecture/reg_room_insert";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            int study_place_idx = ServletRequestUtils.getIntParameter(request, "study_place_idx", 0);

            // 선택된 강의실 정보를 가져온다.
            StudyPlaceVo studyPlaceVo = lectureService.selectStudyPlaceByIdx(study_place_idx);
            model.addAttribute("studyPlaceVo", studyPlaceVo);

            // 시간
            List<String> hourList = DateUtil.getHourList();
            model.addAttribute("hourList", hourList);

            // 분
            List<String> minList = DateUtil.getMinList();
            model.addAttribute("minList", minList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/popup/lecture/reg_room_insert.do", method = RequestMethod.POST)
    public String reg_room_inproc(final MultipartHttpServletRequest multiRequest,
                                 @ModelAttribute("regStudyPlaceVo") RegStudyPlaceVo regStudyPlaceVo,
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
                regStudyPlaceVo.setReg_id(adminLoginVo.getAdmin_id());

                String ori_save = regStudyPlaceVo.getDt_week();
                String[] tokens = regStudyPlaceVo.getDt_week().split(",");
                for(String token : tokens) {
                    regStudyPlaceVo.setDt_week(token);
                    int check = lectureService.checkRegStudyPlace(regStudyPlaceVo);
                    if(check != 0) {
                        model.addAttribute("msg", "alterSelf");
                        model.addAttribute("altmsg", "이미 추가된 일정이 있습니다.");
                        return ret_url;
                    }
                    check = lectureService.checkLecturePlace(regStudyPlaceVo);
                    if(check != 0) {
                        model.addAttribute("msg", "alterSelf");
                        model.addAttribute("altmsg", "이미 추가된 일정이 있습니다.");
                        return ret_url;
                    }
                }

                regStudyPlaceVo.setDt_week(ori_save);
                lectureService.insertRegStudyPlaceInfo(regStudyPlaceVo);

                model.addAttribute("msg", "alterCloseCReload");
                //model.addAttribute("locurl", "/ssemadmin/cont/lecture/room_status.do?searchVal2=" + adminLoginVo.getP_idx() + "&searchVal3=" + regStudyPlaceVo.getGroup_idx() + "&searchVal4=" + regStudyPlaceVo.getStudy_place_idx());
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

    @RequestMapping(value = "/popup/lecture/reg_room_update.do", method = RequestMethod.GET)
    public String reg_room_upscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "popup/lecture/reg_room_update";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            int reg_study_place_idx = ServletRequestUtils.getIntParameter(request, "reg_study_place_idx", 0);

            // 선택된 강의실 정보를 가져온다.
            RegStudyPlaceVo regStudyPlaceVo = lectureService.selectRegStudyPlaceByIdx(reg_study_place_idx);

            String study_place_name = lectureService.selectStudyPlaceNameByIdx(regStudyPlaceVo.getStudy_place_idx());
            regStudyPlaceVo.setStudy_place_name(study_place_name);

            regStudyPlaceVo.setStart_dt(regStudyPlaceVo.getStart_dt().substring(0, 10));
            regStudyPlaceVo.setEnd_dt(regStudyPlaceVo.getEnd_dt().substring(0, 10));

            // 교육시간 분리
            String start_hour = regStudyPlaceVo.getStart_time().substring(0, 2);
            String start_min = regStudyPlaceVo.getStart_time().substring(3, 5);
            String end_hour = regStudyPlaceVo.getEnd_time().substring(0, 2);
            String end_min = regStudyPlaceVo.getEnd_time().substring(3, 5);

            regStudyPlaceVo.setStart_hour(start_hour);
            regStudyPlaceVo.setStart_min(start_min);
            regStudyPlaceVo.setEnd_hour(end_hour);
            regStudyPlaceVo.setEnd_min(end_min);

            model.addAttribute("regStudyPlaceVo", regStudyPlaceVo);

            // 시간
            List<String> hourList = DateUtil.getHourList();
            model.addAttribute("hourList", hourList);

            // 분
            List<String> minList = DateUtil.getMinList();
            model.addAttribute("minList", minList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/popup/lecture/reg_room_update.do", method = RequestMethod.POST)
    public String reg_room_upproc(final MultipartHttpServletRequest multiRequest,
                                  @ModelAttribute("regStudyPlaceVo") RegStudyPlaceVo regStudyPlaceVo,
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
                regStudyPlaceVo.setUp_id(adminLoginVo.getAdmin_id());

                lectureService.updateRegStudyPlaceInfo(regStudyPlaceVo);

                model.addAttribute("msg", "alterCloseCReload");
                //model.addAttribute("locurl", "/ssemadmin/cont/lecture/room_status.do?searchVal2=" + adminLoginVo.getP_idx() + "&searchVal3=" + regStudyPlaceVo.getGroup_idx() + "&searchVal4=" + regStudyPlaceVo.getStudy_place_idx());
                model.addAttribute("altmsg", "수정되었습니다.");
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

    @RequestMapping(value = "/popup/campus/instrum_rental_view.do", method = RequestMethod.GET)
    public String instrum_rental_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "popup/campus/instrum_rental_view";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            int rental_fty_apy_idx = ServletRequestUtils.getIntParameter(request, "rental_fty_apy_idx", 0);

            RentalFtyApyVo rentalFtyApyVo = campusService.selectRentalFtyApyByIdx(rental_fty_apy_idx);
            // 상점아이디 가져오기
            GroupVo groupVo = appService.selectGruopByIdx(rentalFtyApyVo.getGroup_idx());

            model.addAttribute("rentalFtyApyVo", rentalFtyApyVo);
            model.addAttribute("CST_MID", groupVo.getPay_shop_id());
        }

        return ret_url;
    }

    @RequestMapping("/popup/lecture/program_list.do")
    public String program_teacher_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "popup/lecture/program_list";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            int teacher_idx = ServletRequestUtils.getIntParameter(request, "teacher_idx", 0);
            if(teacher_idx == 0) {
                teacher_idx = Integer.parseInt(searchVo.getSearchVal9());
            }
            model.addAttribute("searchVal9", String.valueOf(teacher_idx));

            if("".equals(searchVo.getSearchVal2())) {
                searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
            }

            if("".equals(searchVo.getSearchVal3())) {
                searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
            }

            List<LectureVo> itemList = lectureService.selectLectureForTeacherList(searchVo);
            for(LectureVo lecture : itemList) {
                // 프로그램 상태 체크
                // 1. 접수대기 : 접수날짜 도래 하지 않음
                // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                // 5. 교육전 :
                // 6. 교육중 : 교육날짜 내
                // 7. 교육종료 : 교육날짜 지남
                // 8. 외부홈페이지 : 외부 홈페이지일 경우
                int code = Util.getProgramStatus(lecture);
                lecture.setStatus_code(code);
            }
            int totalCount = lectureService.selectLectureForTeacherListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);
        }

        return ret_url;
    }

    @RequestMapping("/popup/self/student_list.do")
    public String self_student_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "popup/self/student_list";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);
            if(group_idx == 0) {
                group_idx = Integer.parseInt(searchVo.getSearchVal3());
            }
            int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);
            if(lecture_idx == 0) {
                lecture_idx = Integer.parseInt(searchVo.getSearchVal2());
            }

            String dong_nm = appService.selectGruopByIdx(group_idx).getName();
            String lecture_nm = lectureService.selectLectureNameByIdx(lecture_idx);

            model.addAttribute("dong_nm", dong_nm);
            model.addAttribute("lecture_nm", lecture_nm);

            if("".equals(searchVo.getSearchVal3())) {
                searchVo.setSearchVal3(String.valueOf(group_idx));
                model.addAttribute("searchVal3", String.valueOf(group_idx));
            }

            if("".equals(searchVo.getSearchVal2())) {
                searchVo.setSearchVal2(String.valueOf(lecture_idx));
                model.addAttribute("searchVal2", String.valueOf(lecture_idx));
            }

            List<StudentVo> itemList = lectureService.selectStudentListEx(searchVo);
            for(StudentVo studentVo : itemList) {
                LectureApyVo lectureApyVo = lectureService.selectLectureApyInfoByIdx((int)studentVo.getLecture_apy_idx());
                DiscountVo discountVo = lectureService.selectDiscountByIdx((int)lectureApyVo.getDiscount_idx());

                studentVo.setPay_sum(lectureApyVo.getPay_sum());
                studentVo.setDiscountVo(discountVo);
            }
            int totalCount = lectureService.selectStudentListTotalEx(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping("/popup/self/discount_list.do")
    public String self_discount_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

        String ret_url = "popup/self/discount_list";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            List<DiscountVo> itemList = lectureService.selectDiscountListByGroupIdx(group_idx);
            model.addAttribute("itemList", itemList);

            GroupVo groupVo = lectureService.selectGroupInfoByIdx(group_idx);
            model.addAttribute("groupVo", groupVo);
        }

        return ret_url;
    }

    @RequestMapping("/popup/self/income_list.do")
    public String self_income_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

        String ret_url = "popup/self/income_list";

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);

        if("".equals(searchVo.getSearchKind())) {
            searchVo.setSearchKind(String.valueOf(group_idx));
            model.addAttribute("searchKind", String.valueOf(group_idx));
        }

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            List<NewTracInoutVo> itemList = selfHallService.selectPopupIncomeList(searchVo);
            for(NewTracInoutVo newTracInoutVo : itemList) {
                newTracInoutVo.setInout_cd_nm(appService.selectCodeByIdx(newTracInoutVo.getInout_cd()));
            }
            int totalCount = selfHallService.selectPopupIncomeListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            GroupVo groupVo = lectureService.selectGroupInfoByIdx(group_idx);
            model.addAttribute("groupVo", groupVo);
        }

        return ret_url;
    }
}
