package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AdminService;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.MsgService;
import kr.go.songpa.ssem.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
 * Date : 2020-09-10
 * Description :
 * History :
 * Version :
 */
@Controller
public class AdminController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private AdminService adminService;

    @Autowired
    private MsgService msgService;

    public AdminController() {
    }

    @RequestMapping(value = "/admin/join.do", method = RequestMethod.GET)
    public String admin_join(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "admin/join";

        List<GroupVo> masterGroupList = appService.getMasterGroupList();
        List<GroupVo> subGroupList = appService.getSubGroupList(masterGroupList.get(0).getGroup_idx());
        List<String> telList = Util.getLocalTelNo();

        model.addAttribute("masterGroupList", masterGroupList);
        model.addAttribute("subGroupList", subGroupList);
        model.addAttribute("telList", telList);

        return ret_url;
    }

    @RequestMapping(value = "/admin/join.do", method = RequestMethod.POST)
    public String admin_join_inproc(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("adminVo") AdminVo adminVo,
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

            // 암호화 임시 자동 생성
            String temp_pwd = Util.getPwdTemp(adminVo.getMob_no());

            adminVo.setPwd(temp_pwd);
            adminVo.setApp_yn("N");
            adminVo.setApy_path("U");
            adminVo.setStatus("N");
            adminService.insertAdminInfo(adminVo);

            // 권한변경이력 입력
            setStatUpInfo(adminVo, "1");

            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", "/ssemadmin/login/login.do");
            model.addAttribute("altmsg", "가입요청이 완료되었습니다.<br/>로그인 및 사용은 관리자 승인 이후 가능합니다.");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "가입요청이 실패 하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/admin/mypage.do", method = RequestMethod.GET)
    public String admin_mypage(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/admin/mypage";
        String menu_url = "cont/master/admin_list";
        String in_url = "/" + menu_url + Constants.global_ext;

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "1");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            AdminVo adminVo = adminService.selectAdminById(adminLoginVo.getAdmin_id());
            model.addAttribute("adminVo", adminVo);

            /*CustomSmsSendVo customSmsSendVo = new CustomSmsSendVo();
            customSmsSendVo.setUser_id("ssem_id");
            customSmsSendVo.setSchedule_type("0");
            customSmsSendVo.setTitle("테스트");
            customSmsSendVo.setMsg_content("외부시스템 SMS 전송테스트");
            customSmsSendVo.setCalling_num("0211112222");
            customSmsSendVo.setTgt_nm("김길동");
            customSmsSendVo.setPhone_num("01022223333");
            msgService.sendMsgKakao(customSmsSendVo);*/
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/admin/mypage.do", method = RequestMethod.POST)
    public String admin_inproc(final MultipartHttpServletRequest multiRequest,
                               @ModelAttribute("adminVo") AdminVo adminVo,
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
                // 현재 비밀번호 확인
                int count = adminService.selectCurrentPwd(adminVo);
                if(count != 1) {
                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/admin/mypage.do");
                    model.addAttribute("altmsg", "현재비밀번호가 일치하지 않습니다.");

                    return "common/message";
                }

                adminService.updateAdminInfoEx(adminVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/admin/mypage.do");
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

    @RequestMapping(value = "/cont/admin/history.do", method = RequestMethod.GET)
    public String admin_history(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/admin/history";
        String menu_url = "cont/master/admin_list";
        String in_url = "/" + menu_url + Constants.global_ext;

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "1");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

            ret_url =  "common/message";
        } else {
        }

        return ret_url;
    }

    private void setStatUpInfo(AdminVo adminVo, String type) throws Exception {
        // type 1 => 계정생성(가입요청)
        // type 2 => 계정생성(마스터관리자)
        // type 3 => 사용(활성화)
        // type 4 => 미사용(비활성화)
        // type 5 => 유형변경(이전등급 -> 변경등급)
        // type 6 => 그룹변경(이전그룹 -> 변경그룹)

        StatUpVo statUpVo = new StatUpVo();
        statUpVo.setGroup_idx(adminVo.getGroup_idx());
        statUpVo.setAdmin_id(adminVo.getAdmin_id());
        statUpVo.setName(adminVo.getName());
        statUpVo.setCont("계정생성(가입요청)");
        statUpVo.setReg_id(adminVo.getAdmin_id());

        appService.insertStatUpInfo(statUpVo);
    }
}
