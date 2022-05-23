package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.common.SafeHtmlUtil;
import kr.go.songpa.ssem.model.LawtaxCounselVo;
import kr.go.songpa.ssem.model.PersonBookApyVo;
import kr.go.songpa.ssem.model.SearchVo;
import kr.go.songpa.ssem.model.TnUserInfoVo;
import kr.go.songpa.ssem.service.LawTaxService;
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
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2021-11-06
 * Description :
 * History :
 * Version :
 */
@Controller
public class LawTaxController extends CommonController {

    @Autowired
    private LawTaxService lawTaxService;

    public LawTaxController() {
    }

    @RequestMapping("/senior/lawtax/law_counsel_list.do")
    public String senior_lawtax_law_counsel_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/lawtax/law_counsel_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/lawtax/law_counsel_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            if("".equals(Util.nvl(searchVo.getSearchKind2()))) {
                searchVo.setSearchKind2("L");
            }

            List<LawtaxCounselVo> itemList = lawTaxService.selectLawTaxCounselApyList(searchVo);
            for(LawtaxCounselVo lawtaxCounselVo : itemList) {
                String apy_nm = Util.getMasKName(lawtaxCounselVo.getApy_nm());
                lawtaxCounselVo.setApy_nm(apy_nm);
            }
            int totalCount = lawTaxService.selectLawTaxCounselApyTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/lawtax/law_counsel_inscr.do", method = RequestMethod.GET)
    public String senior_lawtax_law_counsel_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/lawtax/law_counsel_inscr";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/lawtax/law_counsel_inscr.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/lawtax/law_counsel_inscr.do", method = RequestMethod.POST)
    public String senior_lawtax_law_counsel_inproc(final MultipartHttpServletRequest multiRequest,
                                            @ModelAttribute("lawtaxCounselVo") LawtaxCounselVo lawtaxCounselVo,
                                            BindingResult bindingResult,
                                            Model model,
                                            SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : lawtaxCounselVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(lawtaxCounselVo);
                if(value instanceof String){
                    field.set(lawtaxCounselVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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

                /*// 이유 엔터처리
                String reason = personBookApyVo.getReason();
                reason = reason.replaceAll(System.getProperty("line.separator"), "<br/>");
                personBookApyVo.setReason(reason);*/

                lawTaxService.insertLawTaxCounsel(lawtaxCounselVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/lawtax/law_counsel_list.do");
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

    @RequestMapping(value = "/senior/lawtax/law_counsel_view.do", method = RequestMethod.GET)
    public String senior_lawtax_law_counsel_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/lawtax/law_counsel_view";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/lawtax/law_counsel_view.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            int lawtax_idx = ServletRequestUtils.getIntParameter(request, "lawtax_idx", 0);

            LawtaxCounselVo lawtaxCounselVo = new LawtaxCounselVo();
            lawtaxCounselVo.setLawtax_idx(lawtax_idx);
            lawtaxCounselVo.setApy_id(loginVo.getUser_id());

            lawtaxCounselVo = lawTaxService.selectLawTaxCounsel(lawtaxCounselVo);
            if(lawtaxCounselVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/lawtax/law_counsel_list.do");
                model.addAttribute("altmsg", "자신이 작성한 글만 볼수 있습니다..");
                return "common/message";
            }

            // 신청자 메모 엔터처리
            String rpy_cont = lawtaxCounselVo.getRpy_cont();
            if(!"".equals(Util.nvl(rpy_cont))) {
                rpy_cont = rpy_cont.replaceAll(System.getProperty("line.separator"), "<br/>");
                lawtaxCounselVo.setRpy_cont(rpy_cont);
            }

            model.addAttribute("lawtaxCounselVo", lawtaxCounselVo);

        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/lawtax/law_counsel_view.do", method = RequestMethod.POST)
    public String senior_lawtax_law_counsel_view(final MultipartHttpServletRequest multiRequest,
                                                   @ModelAttribute("lawtaxCounselVo") LawtaxCounselVo lawtaxCounselVo,
                                                   BindingResult bindingResult,
                                                   Model model,
                                                   SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {

                lawtaxCounselVo.setUp_id(loginVo.getUser_id());

                lawTaxService.updateLawTaxCounsel(lawtaxCounselVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/lawtax/law_counsel_list.do");
                model.addAttribute("altmsg", "수정되었습니다.");

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "수정에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/lawtax/law_counsel_delete.do", method = RequestMethod.POST)
    public String senior_lawtax_law_counsel_delete(final MultipartHttpServletRequest multiRequest,
                                                   @ModelAttribute("lawtaxCounselVo") LawtaxCounselVo lawtaxCounselVo,
                                                   BindingResult bindingResult,
                                                   Model model,
                                                   SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                lawTaxService.deleteLawTaxCounsel(lawtaxCounselVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/lawtax/law_counsel_list.do");
                model.addAttribute("altmsg", "삭제되었습니다.");

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/senior/lawtax/tax_counsel_list.do")
    public String senior_lawtax_tax_counsel_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/lawtax/tax_counsel_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/lawtax/tax_counsel_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            if("".equals(Util.nvl(searchVo.getSearchKind2()))) {
                searchVo.setSearchKind2("T");
            }

            List<LawtaxCounselVo> itemList = lawTaxService.selectLawTaxCounselApyList(searchVo);
            for(LawtaxCounselVo lawtaxCounselVo : itemList) {
                String apy_nm = Util.getMasKName(lawtaxCounselVo.getApy_nm());
                lawtaxCounselVo.setApy_nm(apy_nm);
            }
            int totalCount = lawTaxService.selectLawTaxCounselApyTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/lawtax/tax_counsel_inscr.do", method = RequestMethod.GET)
    public String senior_lawtax_tax_counsel_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/lawtax/tax_counsel_inscr";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/lawtax/tax_counsel_inscr.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/lawtax/tax_counsel_inscr.do", method = RequestMethod.POST)
    public String senior_lawtax_tax_counsel_inproc(final MultipartHttpServletRequest multiRequest,
                                                   @ModelAttribute("lawtaxCounselVo") LawtaxCounselVo lawtaxCounselVo,
                                                   BindingResult bindingResult,
                                                   Model model,
                                                   SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : lawtaxCounselVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(lawtaxCounselVo);
                if(value instanceof String){
                    field.set(lawtaxCounselVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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

                /*// 이유 엔터처리
                String reason = personBookApyVo.getReason();
                reason = reason.replaceAll(System.getProperty("line.separator"), "<br/>");
                personBookApyVo.setReason(reason);*/

                lawTaxService.insertLawTaxCounsel(lawtaxCounselVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/lawtax/tax_counsel_list.do");
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

    @RequestMapping(value = "/senior/lawtax/tax_counsel_view.do", method = RequestMethod.GET)
    public String senior_lawtax_tax_counsel_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/lawtax/tax_counsel_view";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/lawtax/tax_counsel_view.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            int lawtax_idx = ServletRequestUtils.getIntParameter(request, "lawtax_idx", 0);

            LawtaxCounselVo lawtaxCounselVo = new LawtaxCounselVo();
            lawtaxCounselVo.setLawtax_idx(lawtax_idx);
            lawtaxCounselVo.setApy_id(loginVo.getUser_id());

            lawtaxCounselVo = lawTaxService.selectLawTaxCounsel(lawtaxCounselVo);
            if(lawtaxCounselVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/lawtax/tax_counsel_list.do");
                model.addAttribute("altmsg", "자신이 작성한 글만 볼수 있습니다..");
                return "common/message";
            }

            // 신청자 메모 엔터처리
            String rpy_cont = lawtaxCounselVo.getRpy_cont();
            if(!"".equals(Util.nvl(rpy_cont))) {
                rpy_cont = rpy_cont.replaceAll(System.getProperty("line.separator"), "<br/>");
                lawtaxCounselVo.setRpy_cont(rpy_cont);
            }

            model.addAttribute("lawtaxCounselVo", lawtaxCounselVo);

        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/lawtax/tax_counsel_view.do", method = RequestMethod.POST)
    public String senior_lawtax_tax_counsel_view(final MultipartHttpServletRequest multiRequest,
                                                 @ModelAttribute("lawtaxCounselVo") LawtaxCounselVo lawtaxCounselVo,
                                                 BindingResult bindingResult,
                                                 Model model,
                                                 SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {

                lawtaxCounselVo.setUp_id(loginVo.getUser_id());

                lawTaxService.updateLawTaxCounsel(lawtaxCounselVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/lawtax/tax_counsel_list.do");
                model.addAttribute("altmsg", "수정되었습니다.");

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "수정에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/lawtax/tax_counsel_delete.do", method = RequestMethod.POST)
    public String senior_lawtax_tax_counsel_delete(final MultipartHttpServletRequest multiRequest,
                                                   @ModelAttribute("lawtaxCounselVo") LawtaxCounselVo lawtaxCounselVo,
                                                   BindingResult bindingResult,
                                                   Model model,
                                                   SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                lawTaxService.deleteLawTaxCounsel(lawtaxCounselVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/lawtax/tax_counsel_list.do");
                model.addAttribute("altmsg", "삭제되었습니다.");

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }
}
