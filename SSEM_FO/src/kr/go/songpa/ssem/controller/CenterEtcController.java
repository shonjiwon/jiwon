package kr.go.songpa.ssem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-11-12
 * Description :
 * History :
 * Version :
 */
@Controller
public class CenterEtcController extends CommonController {
    public CenterEtcController() {
    }

    // 청소년교육 - 방송아카데미
    @RequestMapping(value = "/youth/center/broad_acamedy.do", method = RequestMethod.GET)
    public String center_broad_acamedy(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/center/broad_acamedy";

        return ret_url;
    }

    // 청소년교육 - 송파구청소년상담복지센터
    @RequestMapping(value = "/youth/center/youth_counsel.do", method = RequestMethod.GET)
    public String center_youth_counsel(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/center/youth_counsel";

        return ret_url;
    }

    // 청소년교육 - 송파청소년 성문화 센터
    @RequestMapping(value = "/youth/center/gender_culture.do", method = RequestMethod.GET)
    public String center_gender_culture(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/center/gender_culture";

        return ret_url;
    }

    // 청소년교육 - 송파구청소년 지원센터 꿈드림
    @RequestMapping(value = "/youth/center/dream_support.do", method = RequestMethod.GET)
    public String center_dream_support(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/center/dream_support";

        return ret_url;
    }

    // 청소년교육 - 송파어린이문화회관
    @RequestMapping(value = "/youth/center/child_culture.do", method = RequestMethod.GET)
    public String youth_center_child_culture(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/center/child_culture";

        return ret_url;
    }

    // 평생교육 - 송파여성문화회관
    @RequestMapping(value = "/senior/center/woman_culture.do", method = RequestMethod.GET)
    public String senior_center_woman_culture(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/center/woman_culture";

        return ret_url;
    }

    // 평생교육 - 송파생활문화대학
    @RequestMapping(value = "/senior/center/life_culture.do", method = RequestMethod.GET)
    public String senior_center_life_culture(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/center/life_culture";

        return ret_url;
    }

    // 평생교육 - 송파어린이문화회관
    @RequestMapping(value = "/senior/center/child_culture.do", method = RequestMethod.GET)
    public String senior_center_child_culture(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/center/child_culture";

        return ret_url;
    }

    // 평생교육 - 송파가 송파하리 프로젝트
    @RequestMapping(value = "/senior/center/songpaga_info.do", method = RequestMethod.GET)
    public String senior_center_songpaga_info(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/center/songpaga_info";

        return ret_url;
    }
}
