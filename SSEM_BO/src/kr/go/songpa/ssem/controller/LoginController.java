package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.model.AdminLoginVo;
import kr.go.songpa.ssem.model.StatConVo;
import kr.go.songpa.ssem.service.AdminService;
import kr.go.songpa.ssem.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-09-10
 * Description :
 * History :
 * Version :
 */
@Controller
public class LoginController extends CommonController {
    @Autowired
    private AdminService adminService;

    public LoginController() {
    }

    @RequestMapping(value = "/login/login.do", method = RequestMethod.GET)
    public String admin_login(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "login/login";

        return ret_url;
    }

    @RequestMapping(value = "/login/login.do", method = RequestMethod.POST)
    public String admin_login_proc(@ModelAttribute AdminLoginVo adminLoginVo, HttpServletRequest request, Model model) throws Exception {
        String ret_url = "";

        HttpSession session = request.getSession();

        /*
        String pwd_encoding = CrytoUtil.getInstance().SHA256_Encode(adminLoginVo.getPwd());
        adminLoginVo.setPwd_enc(pwd_encoding);
        */

        int code = this.checkLoginOptions(adminLoginVo, request);

        if (code == 9) {
            // 로그인 정보 객체 세션에 저장
            adminLoginVo = adminService.selectAdminInfo(adminLoginVo);

            // 최종 로그인 정보 갱신
            adminLoginVo.setLast_login_ip(Util.getRemoteAddr(request));
            adminService.updateLoginSuccessInfo(adminLoginVo);
            // 관리자 접속 정보 입력
            StatConVo statConVo = this.getConnectInfo(adminLoginVo, request);
            adminService.insertAdminConInfo(statConVo);
            // 권한정보
            /*String idx = Util.getSubString(adminLoginVo.getMenu_info(), ",");
            String url = adminService.selectMenuUrl(Integer.valueOf(idx));*/

            String url = "/cont/admin/history.do";
            session.setAttribute(Constants.ADMIN_LOGIN_VO, adminLoginVo);
            ret_url = "redirect:" + url;
        } else {
            // 오류
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", "/ssemadmin/login/login.do");

            if (code == 1) {
                model.addAttribute("altmsg", "아이디 또는 비밀번호가 일치하지 않습니다.<br/>확인 후 다시 시도해 주세요.");
            } else if (code == 2) {
                String remoteIP = Util.getRemoteAddr(request);
                model.addAttribute("altmsg", remoteIP + "는(은) 허용된 IP가 아닙니다.<br/>관리자에게 문의해 주세요.");
            } else if (code == 3) {
                model.addAttribute("altmsg", "비밀번호를 5회 이상 실패하였습니다.<br/>관리자에게 문의해 주세요.");
            } else if (code == 4) {
                model.addAttribute("altmsg", "승인대기 중인 계정입니다.<br/>관리자에게 문의해 주세요..");
            } else if (code == 5) {
                model.addAttribute("altmsg", "미사용 계정입니다.<br/>관리자에게 문의해 주세요.");
            }

            ret_url =  "common/message";
        }

        return ret_url;
    }

    @RequestMapping(value = "/login/logout.do", method = RequestMethod.GET)
    public String admin_logout(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        request.getSession().invalidate();

        model.addAttribute("msg", "alterloc");
        model.addAttribute("locurl", "/ssemadmin/login/login.do");
        model.addAttribute("altmsg", "로그아웃 되었습니다.");
        return "common/message";
    }
}
