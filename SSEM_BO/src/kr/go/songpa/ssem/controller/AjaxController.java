package kr.go.songpa.ssem.controller;

import com.alibaba.fastjson.JSON;
import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.*;
import kr.go.songpa.ssem.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-09-14
 * Description :
 * History :
 * Version :
 */
@Controller
public class AjaxController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private AdminService adminService;

    @Autowired
    private BbsService bbsService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private SelfHallService selfHallService;

    public AjaxController() {
    }

    @RequestMapping( value = "/ajax/sub_group_list.do", produces = "text/json; charset=UTF-8" )
    public ResponseEntity<String> sub_group_list(@RequestParam Map<String, Object> parameterMap, HttpServletRequest request, Model model) {

        try {
            long p_idx = ServletRequestUtils.getLongParameter(request, "p_idx", 0);
            List<GroupVo> subGroupList = appService.getSubGroupList(p_idx);

            return new ResponseEntity<String>( JSON.toJSONString( subGroupList ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping(value="/ajax/admin_id_check.do", method = RequestMethod.POST)
    public ResponseEntity<String> admin_id_check(HttpServletRequest request, HttpServletResponse response, Model model, SessionStatus status) {

        try {
            String admin_id = ServletRequestUtils.getStringParameter(request, "admin_id", "");

            int count = adminService.checkAdminrId(admin_id);

            return new ResponseEntity<String>( JSON.toJSONString( count ), HttpStatus.OK );
        } catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping( value = "/ajax/admin_rule_list.do", produces = "text/json; charset=UTF-8" )
    public ResponseEntity<String> admin_rule_list(@RequestParam Map<String, Object> parameterMap, HttpServletRequest request, Model model) {

        try {
            String type = ServletRequestUtils.getStringParameter(request, "type", "");
            List<AdminRuleVo> ruleList = adminService.getRuleListByType(type);

            return new ResponseEntity<String>( JSON.toJSONString( ruleList ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping( value = "/ajax/admin_init_pwd.do", produces = "text/json; charset=UTF-8" )
    public ResponseEntity<String> admin_init_pwd(@RequestParam Map<String, Object> parameterMap, HttpServletRequest request, Model model) {

        try {

            HttpSession session = request.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            String admin_id = ServletRequestUtils.getStringParameter(request, "admin_id", "");
            String mob_no = ServletRequestUtils.getStringParameter(request, "mob_no", "");

            String temp_pwd = Util.getPwdTemp(mob_no);
            AdminVo adminVo = new AdminVo();
            adminVo.setPwd(temp_pwd);
            adminVo.setAdmin_id(admin_id);
            adminVo.setUp_id(adminLoginVo.getAdmin_id());

            int count = adminService.updateAdminPwd(adminVo);

            return new ResponseEntity<String>( JSON.toJSONString( count ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping(value="/ajax/main_use_setting.do", method = RequestMethod.POST)
    public ResponseEntity<String> main_use_setting(HttpServletRequest request, HttpServletResponse response, Model model
            , @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo
            , BindingResult bindingResult
            , SessionStatus status
    )  throws Exception {

        try {
            String[] main_id_arr = ServletRequestUtils.getStringParameters(request, "main_id");

            for(int i = 0; i < main_id_arr.length; i ++) {
                bbsService.updateMainUseY(Integer.parseInt(main_id_arr[i]));
            }

            return new ResponseEntity<String>( JSON.toJSONString( true ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping(value="/ajax/main_cancel_setting.do", method = RequestMethod.POST)
    public ResponseEntity<String> main_cancel_setting(HttpServletRequest request, HttpServletResponse response, Model model
            , @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo
            , BindingResult bindingResult
            , SessionStatus status
    )  throws Exception {

        try {
            String[] main_id_arr = ServletRequestUtils.getStringParameters(request, "main_y_id");

            for(int i = 0; i < main_id_arr.length; i ++) {
                bbsService.updateMainUseN(Integer.parseInt(main_id_arr[i]));
            }

            return new ResponseEntity<String>( JSON.toJSONString( true ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping(value="/ajax/appv_setting.do", method = RequestMethod.POST)
    public ResponseEntity<String> appv_setting(HttpServletRequest request, HttpServletResponse response, Model model
            , @ModelAttribute("lectureApyVo") LectureApyVo lectureApyVo
            , BindingResult bindingResult
            , SessionStatus status
    )  throws Exception {

        try {
            String[] apply_id_arr = ServletRequestUtils.getStringParameters(request, "apply_id");

            for(int i = 0; i < apply_id_arr.length; i ++) {
                lectureService.updateLectureAppvByIdx(Integer.parseInt(apply_id_arr[i]));

                lectureApyVo = lectureService.selectLectureApyInfoByIdx(Integer.parseInt(apply_id_arr[i]));
                // 승인 등록시 수강생 등록 프로세스 거칠 것
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

                        GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                        studentLectVo.setP_idx(groupVo.getP_idx());

                        lectureService.insertStudentLectInfo(studentLectVo);
                    } else {
                        lectureService.insertStudentInfo(studentVo);

                        StudentLectVo studentLectVo = new StudentLectVo();

                        studentLectVo.setStudent_idx(studentVo.getStudent_idx());
                        studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                        studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());

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
                    if(student != null) {
                        StudentLectVo studentLectVo = new StudentLectVo();

                        studentLectVo.setStudent_idx(student.getStudent_idx());
                        studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                        studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());

                        GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                        studentLectVo.setP_idx(groupVo.getP_idx());

                        lectureService.insertStudentLectInfo(studentLectVo);
                    } else {
                        lectureService.insertStudentInfo(studentVo);

                        StudentLectVo studentLectVo = new StudentLectVo();

                        studentLectVo.setStudent_idx(studentVo.getStudent_idx());
                        studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                        studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());

                        GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                        studentLectVo.setP_idx(groupVo.getP_idx());

                        lectureService.insertStudentLectInfo(studentLectVo);
                    }
                }


            }

            return new ResponseEntity<String>( JSON.toJSONString( true ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping(value="/ajax/completed_setting.do", method = RequestMethod.POST)
    public ResponseEntity<String> completed_setting(HttpServletRequest request, HttpServletResponse response, Model model
            , @ModelAttribute("lectureApyVo") LectureApyVo lectureApyVo
            , BindingResult bindingResult
            , SessionStatus status
    )  throws Exception {

        try {
            String[] apply_id_arr = ServletRequestUtils.getStringParameters(request, "apply_id");

            for(int i = 0; i < apply_id_arr.length; i ++) {
                lectureService.updateLectureCompletedByIdx(Integer.parseInt(apply_id_arr[i]));
            }

            return new ResponseEntity<String>( JSON.toJSONString( true ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping( value = "/ajax/room_list.do", produces = "text/json; charset=UTF-8" )
    public ResponseEntity<String> room_list(@RequestParam Map<String, Object> parameterMap, HttpServletRequest request, Model model) {

        try {
            long group_idx = ServletRequestUtils.getLongParameter(request, "group_idx", 0);
            List<StudyPlaceVo> roomList = appService.selectStudyPlaceList(group_idx);

            return new ResponseEntity<String>( JSON.toJSONString( roomList ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping( value = "/ajax/copy_program.do", produces = "text/json; charset=UTF-8" )
    public ResponseEntity<String> copy_program(@RequestParam Map<String, Object> parameterMap, HttpServletRequest request, Model model) {

        try {
            String[] main_id_arr = ServletRequestUtils.getStringParameters(request, "main_id");

            for(int i = 0; i < main_id_arr.length; i ++) {
                LectureVo lectureVo = lectureService.selectLectureByIdx(Long.parseLong(main_id_arr[i]));

                lectureVo.setReg_start_st(lectureVo.getReg_start_st().substring(0, 16));
                lectureVo.setReg_end_dt(lectureVo.getReg_end_dt().substring(0, 16));

                lectureVo.setName("[복사] " + lectureVo.getName());

                lectureService.insertLectureInfo(lectureVo);
            }

            return new ResponseEntity<String>( JSON.toJSONString( true ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping( value = "/ajax/program_list.do", produces = "text/json; charset=UTF-8" )
    public ResponseEntity<String> program_list(@RequestParam Map<String, Object> parameterMap, HttpServletRequest request, Model model) {

        try {
            int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);
            String sdate = ServletRequestUtils.getStringParameter(request, "sdate", "");
            String gubun = ServletRequestUtils.getStringParameter(request, "gubun", "");

            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(group_idx);
            groupVo.setSdate(sdate);
            groupVo.setGubun(gubun);

            List<LectureVo> itemList = lectureService.selectLectureListEx(groupVo);

            return new ResponseEntity<String>( JSON.toJSONString( itemList ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping( value = "/ajax/program_date.do", produces = "text/json; charset=UTF-8" )
    public ResponseEntity<String> program_date(@RequestParam Map<String, Object> parameterMap, HttpServletRequest request, Model model) {

        try {
            int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

            LectureVo lectureVo  = lectureService.selectLectureByIdx(lecture_idx);

            String date = lectureVo.getStart_dt() + " ~ " + lectureVo.getEnd_dt();

            return new ResponseEntity<String>( JSON.toJSONString( date ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping( value = "/ajax/program_info.do", produces = "text/json; charset=UTF-8" )
    public ResponseEntity<String> program_info(@RequestParam Map<String, Object> parameterMap, HttpServletRequest request, Model model) {

        try {
            int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

            LectureVo lectureVo  = lectureService.selectLectureByIdx(lecture_idx);

            return new ResponseEntity<String>( JSON.toJSONString( lectureVo ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping(value="/ajax/new_program_profit_delete.do", method = RequestMethod.POST)
    public ResponseEntity<String> new_program_profit_delete(HttpServletRequest request, HttpServletResponse response, Model model
            , @ModelAttribute("newTracProgResultVo") NewTracProgResultVo newTracProgResultVo
            , BindingResult bindingResult
            , SessionStatus status
    )  throws Exception {

        try {
            String[] apply_id_arr = ServletRequestUtils.getStringParameters(request, "apply_id");

            for(int i = 0; i < apply_id_arr.length; i ++) {
                selfHallService.deleteNewProgramResult(Integer.parseInt(apply_id_arr[i]));
            }

            return new ResponseEntity<String>( JSON.toJSONString( true ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    @RequestMapping(value="/ajax/new_fund_delete.do", method = RequestMethod.POST)
    public ResponseEntity<String> new_fund_delete(HttpServletRequest request, HttpServletResponse response, Model model
            , @ModelAttribute("newTracFundMngVo") NewTracFundMngVo newTracFundMngVo
            , BindingResult bindingResult
            , SessionStatus status
    )  throws Exception {

        try {
            String[] apply_id_arr = ServletRequestUtils.getStringParameters(request, "apply_id");

            for(int i = 0; i < apply_id_arr.length; i ++) {
                selfHallService.deleteNewFund(Integer.parseInt(apply_id_arr[i]));
            }

            return new ResponseEntity<String>( JSON.toJSONString( true ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }
}
