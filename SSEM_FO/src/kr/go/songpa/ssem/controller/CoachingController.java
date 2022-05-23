package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.common.SafeHtmlUtil;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.CoachService;
import kr.go.songpa.ssem.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Field;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2021-06-11
 * Description :
 * History :
 * Version :
 */

@Controller
public class CoachingController extends CommonController {

    @Autowired
    private CoachService coachService;

    public CoachingController() {
    }

    @RequestMapping("/youth/coach/coach_list.do")
    public String youth_coach_coach_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/coach/coach_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/coach/coach_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            List<CoachVo> itemList = coachService.selectCoachList(searchVo);
            int totalCount = coachService.selectCoachListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            CoachRoomVo coachRoomVo = coachService.selectCoachRoomInfo();
            model.addAttribute("coachRoomVo", coachRoomVo);
        }

        return ret_url;
    }

    @RequestMapping("/senior/coach/coach_list.do")
    public String senior_coach_coach_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/coach/coach_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/coach/coach_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            List<CoachVo> itemList = coachService.selectCoachList(searchVo);
            int totalCount = coachService.selectCoachListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            CoachRoomVo coachRoomVo = coachService.selectCoachRoomInfo();
            model.addAttribute("coachRoomVo", coachRoomVo);
        }

        return ret_url;
    }
}
