package kr.go.songpa.ssem.controller;

import com.ubintis.api.ApiTokenService;
import com.ubintis.api.ApiUserService;
import com.ubintis.common.util.AddressUtil;
import com.ubintis.common.util.JsonParse;
import com.ubintis.common.util.StrUtil;
import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.model.TnUserInfoVo;
import kr.go.songpa.ssem.service.UserService;
import kr.go.songpa.ssem.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-10-25
 * Description :
 * History :
 * Version :
 */
@Controller
public class LoginController extends CommonController {
    @Autowired
    private UserService userService;

    public LoginController() {
    }

    @RequestMapping(value = "/youth/login/login.do", method = RequestMethod.GET)
    public String youth_login(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/login/login";

        String return_url = ServletRequestUtils.getStringParameter(request, "return_url", "");

        model.addAttribute("return_url", return_url);

        return ret_url;
    }

    @RequestMapping(value = "/youth/login/login.do", method = RequestMethod.POST)
    public String youth_login_proc(@ModelAttribute TnUserInfoVo tnUserInfoVo, HttpServletRequest request, Model model) throws Exception {
        String ret_url = "";

        HttpSession session = request.getSession();

        /*
        String pwd_encoding = CrytoUtil.getInstance().SHA256_Encode(adminLoginVo.getPwd());
        adminLoginVo.setPwd_enc(pwd_encoding);
        */

        int code = this.checkLoginOptions(tnUserInfoVo, request);

        if (code == 9) {
            // 로그인 정보 객체 세션에 저장
            TnUserInfoVo loginVo = userService.selectUserInfo(tnUserInfoVo);

            String url = "";
            if("".equals(tnUserInfoVo.getReturn_url())) {
                url = "/youth/main/main.do";
            } else {
                url = tnUserInfoVo.getReturn_url();
            }

            int count = userService.selectIsTeacherByID(loginVo.getUser_id());
            if(count != 0) {
                loginVo.setTeacher_yn("Y");
            }

            if ("yes".equals(EgovProperties.getProperty("sso.action"))) {
                String errorCode = "";
                String pni_token = "";
                String user_id = loginVo.getUser_id();
                String local_ip = request.getRemoteAddr();

                // API를 이용하여 토큰으로 사용자 정보 조회
                ApiTokenService service = new ApiTokenService();
                errorCode = service.createToken(user_id, local_ip);

                if("".equals(errorCode)) {
                    pni_token = service.getPni_token();
                    return "redirect:/youth/login/ssoLogin.do?pni_token=" + pni_token + "&return_url=" + url;
                } else {
                    // 오류
                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssem/youth/login/login.do");
                    model.addAttribute("altmsg", "SSO 토큰 처리 오류입니다.<br/>관리자에게 문의해 주세요.<br/>" + errorCode);
                    return "common/message";
                }
            }
            session.setAttribute(Constants.LOGIN_VO, loginVo);
            ret_url = "redirect:" + url;
        } else {
            // 오류
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", "/ssem/youth/login/login.do");

            if (code == 1) {
                model.addAttribute("altmsg", "아이디 또는 비밀번호가 일치하지 않습니다.<br/>확인 후 다시 시도해 주세요.");
            } else if (code == 2) {
                String remoteIP = Util.getRemoteAddr(request);
                model.addAttribute("altmsg", remoteIP + "는(은) 허용된 IP가 아닙니다.<br/>관리자에게 문의해 주세요.");
            } else if (code == 3) {
                model.addAttribute("altmsg", "비밀번호를 5회 이상 실패하였습니다.<br/>관리자에게 문의해 주세요.");
            } else if (code == 4) {
                model.addAttribute("altmsg", "탈퇴한 계정입니다.<br/>관리자에게 문의해 주세요.");
            }

            ret_url =  "common/message";
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/login/ssoLogin.do", method = RequestMethod.GET)
    public String youth_ssoLogin(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "";

        String errorCode = "";
        String userData = "";
        String pni_token = StrUtil.NVL(request.getParameter("pni_token"));
        String local_ip = "";

        if(!"".equals(pni_token)) {
            local_ip = AddressUtil.getClientIp(request);
            ApiUserService service = new ApiUserService();
            errorCode = service.executeUserData(pni_token, local_ip);

            if("".equals(errorCode)) {
                userData = service.getUserData();
                if(!"".equals(userData)) {
                    HashMap loginDataMap = JsonParse.parse(userData);

                    String user_id = StrUtil.NVL(loginDataMap.get("user_id"));
                    TnUserInfoVo loginVo = userService.selectUserInfoById(user_id);
                    if(loginVo != null) {
                        HttpSession session = request.getSession();
                        loginVo.setPni_token(pni_token);
                        session.setAttribute(Constants.LOGIN_VO, loginVo);
                        session.setAttribute("pni_token", pni_token);

                        String return_url = ServletRequestUtils.getStringParameter(request, "return_url", "");

                        if("".equals(return_url)) {
                            return_url = "/youth/main/main.do";
                        }

                        ret_url = "redirect:" + return_url;
                    } else {
                        model.addAttribute("msg", "alterloc");
                        model.addAttribute("locurl", "/ssem/youth/login/login.do");
                        model.addAttribute("altmsg", "SSO 로그인 오류입니다.<br/>다시 로그인해주세요.");
                        return "common/message";
                    }
                }
            }
        } else {
            ret_url = "redirect:/youth/main/main.do";
        }
        return ret_url;
    }

    @RequestMapping(value = "/youth/login/logout.do", method = RequestMethod.GET)
    public String admin_logout(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        request.getSession().invalidate();

        model.addAttribute("msg", "alterloc");
        model.addAttribute("locurl", "/ssem/youth/main/main.do");
        model.addAttribute("altmsg", "로그아웃 되었습니다.");

        return "common/message";
    }

    @RequestMapping(value = "/senior/login/login.do", method = RequestMethod.GET)
    public String senior_login(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "/ssem/senior/login/login";

        return ret_url;
    }
}
