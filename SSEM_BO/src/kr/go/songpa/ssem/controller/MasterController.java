package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AdminService;
import kr.go.songpa.ssem.service.AppService;
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
 * Date : 2020-09-10
 * Description :
 * History :
 * Version :
 */
@Controller
public class MasterController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private AdminService adminService;

    public MasterController() {
    }

    @RequestMapping("/cont/master/admin_list.do")
    public String admin_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/master/admin_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            // 부서정보 가져오기
            //List<GroupVo> subGroupList = appService.getSubGroupList(masterGroupList.get(0).getGroup_idx());

            List<AdminVo> adminList = adminService.selectAdminList(searchVo);
            int totalCount = adminService.selectAdminListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", adminList);

            model.addAttribute("masterGroupList", masterGroupList);
            //model.addAttribute("subGroupList", subGroupList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/master/admin_inscr.do", method = RequestMethod.GET)
    public String admin_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/master/admin_inscr";
        String menu_url = "cont/master/admin_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/master/admin_inscr.do", method = RequestMethod.POST)
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
                // 암호화 임시 자동 생성
                String temp_pwd = Util.getPwdTemp(adminVo.getMob_no());
                adminVo.setPwd(temp_pwd);
                adminVo.setReg_id(adminLoginVo.getAdmin_id());

                adminService.insertAdminInfo(adminVo);

                setStatUpInfo(adminVo, "계정생성(마스터관리자)", adminLoginVo.getAdmin_id());

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/master/admin_list.do");
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

    @RequestMapping(value = "/cont/master/admin_view.do", method = RequestMethod.GET)
    public String admin_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/master/admin_view";
        String menu_url = "cont/master/admin_list";
        String in_url = "/" + menu_url + Constants.global_ext;

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            String admin_id = ServletRequestUtils.getStringParameter(request, "admin_id", "");
            AdminVo adminVo = adminService.selectAdminById(admin_id);

            model.addAttribute("adminVo", adminVo);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/master/admin_view.do", method = RequestMethod.POST)
    public String admin_view_proc(final MultipartHttpServletRequest multiRequest,
                               @ModelAttribute("adminVo") AdminVo adminVo,
                               BindingResult bindingResult,
                               Model model,
                               SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        HttpSession session = multiRequest.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        try {

            // 이전데이터랑 비교
            AdminVo adminVoOld = adminService.selectAdminById(adminVo.getAdmin_id());

            adminVo.setUp_id(adminLoginVo.getAdmin_id());
            adminVo.setApp_yn("Y");

            adminService.updateAdminInfo(adminVo);

            // 사용(활성화)
            if("N".equals(adminVoOld.getStatus()) && "Y".equals(adminVo.getStatus())) {
                setStatUpInfo(adminVo, "사용(활성화)", adminLoginVo.getAdmin_id());
            }

            if("Y".equals(adminVoOld.getStatus()) && "N".equals(adminVo.getStatus())) {
                setStatUpInfo(adminVo, "미사용(비활성화)", adminLoginVo.getAdmin_id());
            }

            if(!Util.nvl(adminVoOld.getType()).equals(adminVo.getType())) {
                setStatUpInfo(adminVo, "유형변경(" + Util.admintype(Util.nvl(adminVoOld.getType())) + " → " + Util.admintype(adminVo.getType()) + ")", adminLoginVo.getAdmin_id());
            }

            if(adminVoOld.getAdmin_rule_idx() != adminVo.getAdmin_rule_idx()) {
                String oldGrpName = "";
                if(!"0".equals(Util.nvl(adminVoOld.getAdmin_rule_idx()))) {
                    oldGrpName = adminService.selectAdminRuleInfoByIdx(adminVoOld.getAdmin_rule_idx());
                } else {
                    oldGrpName = "신규가입자";
                }
                String newGrpName = adminService.selectAdminRuleInfoByIdx(adminVo.getAdmin_rule_idx());
                setStatUpInfo(adminVo, "그룹변경(" + oldGrpName + " → " + newGrpName + ")", adminLoginVo.getAdmin_id());
            }

            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", "/ssemadmin/cont/master/admin_list.do");
            model.addAttribute("altmsg", "수정하였습니다.");

        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "수정에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/master/admin_delete.do", method = RequestMethod.POST)
    public String admin_delete_proc(final MultipartHttpServletRequest multiRequest,
                                  @ModelAttribute("adminVo") AdminVo adminVo,
                                  BindingResult bindingResult,
                                  Model model,
                                  SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        HttpSession session = multiRequest.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        try {
            adminVo.setUp_id(adminLoginVo.getAdmin_id());
            adminVo.setDel_yn("Y");

            adminService.updateAdminInfo(adminVo);

            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", "/ssemadmin/cont/master/admin_list.do");
            model.addAttribute("altmsg", "삭제하였습니다.");

        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/master/role_list.do")
    public String role_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/master/role_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<AdminRuleVo> adminRuleList = adminService.selectAdminRuleList(searchVo);
            int totalCount = adminService.selectAdminRuleListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", adminRuleList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/master/role_inscr.do", method = RequestMethod.GET)
    public String role_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/master/role_inscr";
        String menu_url = "cont/master/role_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/master/role_inscr.do", method = RequestMethod.POST)
    public String role_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("adminRuleVo") AdminRuleVo adminRuleVo,
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
                adminRuleVo.setReg_id(adminLoginVo.getAdmin_id());

                String menu_info = Util.getArrayToStr(adminRuleVo.getMenu_array());
                adminRuleVo.setMenu_info(menu_info);

                adminService.insertAdminRuleInfo(adminRuleVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/master/role_list.do");
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

    @RequestMapping(value = "/cont/master/role_view.do", method = RequestMethod.GET)
    public String role_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/master/role_view";
        String menu_url = "cont/master/role_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int admin_rule_idx = ServletRequestUtils.getIntParameter(request, "admin_rule_idx", 0);

            AdminRuleVo adminRuleVo = new AdminRuleVo();
            adminRuleVo.setAdmin_rule_idx(admin_rule_idx);

            adminRuleVo = adminService.selectAdminRuleInfo(adminRuleVo);

            String menu_info = adminRuleVo.getMenu_info();
            String[] tokens = menu_info.split(",");
            MenuIndexVo menuIndexVo = setMenuIndex(tokens);

            adminRuleVo.setMenu_array(tokens);
            adminRuleVo.setMenuIndexVo(menuIndexVo);

            model.addAttribute("adminRuleVo", adminRuleVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/master/role_view.do", method = RequestMethod.POST)
    public String role_view_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("adminRuleVo") AdminRuleVo adminRuleVo,
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

                adminRuleVo.setUp_id(adminLoginVo.getAdmin_id());

                String menu_info = Util.getArrayToStr(adminRuleVo.getMenu_array());
                adminRuleVo.setMenu_info(menu_info);

                adminService.updateAdminRuleInfo(adminRuleVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/master/role_list.do");
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

    @RequestMapping(value = "/cont/master/group_list.do", method = RequestMethod.GET)
    public String group_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/master/group_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            // 소속 리스트
            List<GroupVo> groupList = appService.selectGroupList();
            for(GroupVo group : groupList) {
                List<GroupVo> subGroupList = appService.selectSubGroupList(group);
                group.setSubGroupList(subGroupList);
            }
            model.addAttribute("groupList", groupList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/master/group_main_update.do", method = RequestMethod.POST)
    public String group_main_update_proc(final MultipartHttpServletRequest multiRequest,
                                 @ModelAttribute("groupVo") GroupVo groupVo,
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

                groupVo.setUp_id(adminLoginVo.getAdmin_id());

                appService.updateGroupMainInfo(groupVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/master/group_list.do");
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

    @RequestMapping(value = "/cont/master/group_sub_update.do", method = RequestMethod.POST)
    public String group_sub_update_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("groupVo") GroupVo groupVo,
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

                groupVo.setUp_id(adminLoginVo.getAdmin_id());
                if(!"".equals(groupVo.getTel_1())) {
                    groupVo.setTel_no(groupVo.getTel_1() + "-" + groupVo.getTel_2() + "-" + groupVo.getTel_3());
                }

                appService.updateGroupSubInfo(groupVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/master/group_list.do");
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

    @RequestMapping(value = "/cont/master/group_new_insert.do", method = RequestMethod.POST)
    public String group_new_insert_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("groupVo") GroupVo groupVo,
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

                groupVo.setReg_id(adminLoginVo.getAdmin_id());
                if(!"".equals(groupVo.getTel_1())) {
                    groupVo.setTel_no(groupVo.getTel_1() + "-" + groupVo.getTel_2() + "-" + groupVo.getTel_3());
                }

                // 소속 정보 입력
                appService.insertGroupMainInfo(groupVo);

                groupVo.setP_idx(groupVo.getGroup_idx());

                appService.insertGroupSubInfo(groupVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/master/group_list.do");
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

    @RequestMapping(value = "/cont/master/group_add_insert.do", method = RequestMethod.POST)
    public String group_add_insert_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("groupVo") GroupVo groupVo,
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

                groupVo.setReg_id(adminLoginVo.getAdmin_id());
                if(!"".equals(groupVo.getTel_1())) {
                    groupVo.setTel_no(groupVo.getTel_1() + "-" + groupVo.getTel_2() + "-" + groupVo.getTel_3());
                }

                appService.insertGroupSubInfo(groupVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/master/group_list.do");
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

    @RequestMapping("/cont/master/log_con_list.do")
    public String log_con_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/master/log_con_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<StatConVo> itemList = appService.selectStatConList(searchVo);
            int totalCount = appService.selectStatConListTotal(searchVo);
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

    @RequestMapping("/cont/master/log_rule_list.do")
    public String log_rule_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/master/log_rule_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<StatUpVo> itemList = appService.selectStatUpList(searchVo);
            for(StatUpVo item : itemList) {
                AdminVo adminVo = adminService.selectAdminById(item.getReg_id());
                item.setReg_nm(adminVo.getName());
            }
            int totalCount = appService.selectStatUpListTotal(searchVo);
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

    @RequestMapping(value = "/cont/master/log_act_list.do", method = RequestMethod.GET)
    public String log_act_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/master/log_act_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }
        }

        return ret_url;
    }

    @RequestMapping("/cont/master/log_private_list.do")
    public String log_private_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/master/log_private_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<StatPrivateVo> itemList = appService.selectStatPrivateList(searchVo);
            int totalCount = appService.selectStatPrivateListTotal(searchVo);
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

    private MenuIndexVo setMenuIndex(String[] arrMenu) {
        MenuIndexVo menuIndexVo = new MenuIndexVo();

        for(String token : arrMenu) {
            if ("1".equals(token)) { menuIndexVo.setMenu_1("Y"); }
            else if ("2".equals(token)) { menuIndexVo.setMenu_2("Y"); }
            else if ("3".equals(token)) { menuIndexVo.setMenu_3("Y"); }
            else if ("4".equals(token)) { menuIndexVo.setMenu_4("Y"); }
            else if ("5".equals(token)) { menuIndexVo.setMenu_5("Y"); }
            else if ("6".equals(token)) { menuIndexVo.setMenu_6("Y"); }
            else if ("7".equals(token)) { menuIndexVo.setMenu_7("Y"); }
            else if ("8".equals(token)) { menuIndexVo.setMenu_8("Y"); }
            else if ("9".equals(token)) { menuIndexVo.setMenu_9("Y"); }
            else if ("10".equals(token)) { menuIndexVo.setMenu_10("Y"); }
            else if ("11".equals(token)) { menuIndexVo.setMenu_11("Y"); }
            else if ("12".equals(token)) { menuIndexVo.setMenu_12("Y"); }
            else if ("13".equals(token)) { menuIndexVo.setMenu_13("Y"); }
            else if ("14".equals(token)) { menuIndexVo.setMenu_14("Y"); }
            else if ("15".equals(token)) { menuIndexVo.setMenu_15("Y"); }
            else if ("16".equals(token)) { menuIndexVo.setMenu_16("Y"); }
            else if ("17".equals(token)) { menuIndexVo.setMenu_17("Y"); }
            else if ("18".equals(token)) { menuIndexVo.setMenu_18("Y"); }
            else if ("19".equals(token)) { menuIndexVo.setMenu_19("Y"); }
            else if ("20".equals(token)) { menuIndexVo.setMenu_20("Y"); }
            else if ("21".equals(token)) { menuIndexVo.setMenu_21("Y"); }
            else if ("22".equals(token)) { menuIndexVo.setMenu_22("Y"); }
            else if ("23".equals(token)) { menuIndexVo.setMenu_23("Y"); }
            else if ("24".equals(token)) { menuIndexVo.setMenu_24("Y"); }
            else if ("25".equals(token)) { menuIndexVo.setMenu_25("Y"); }
            else if ("26".equals(token)) { menuIndexVo.setMenu_26("Y"); }
            else if ("27".equals(token)) { menuIndexVo.setMenu_27("Y"); }
            else if ("28".equals(token)) { menuIndexVo.setMenu_28("Y"); }
            else if ("29".equals(token)) { menuIndexVo.setMenu_29("Y"); }
            else if ("30".equals(token)) { menuIndexVo.setMenu_30("Y"); }
            else if ("31".equals(token)) { menuIndexVo.setMenu_31("Y"); }
            else if ("32".equals(token)) { menuIndexVo.setMenu_32("Y"); }
            else if ("33".equals(token)) { menuIndexVo.setMenu_33("Y"); }
            else if ("34".equals(token)) { menuIndexVo.setMenu_34("Y"); }
            else if ("35".equals(token)) { menuIndexVo.setMenu_35("Y"); }
            else if ("36".equals(token)) { menuIndexVo.setMenu_36("Y"); }
            else if ("37".equals(token)) { menuIndexVo.setMenu_37("Y"); }
            else if ("38".equals(token)) { menuIndexVo.setMenu_38("Y"); }
            else if ("39".equals(token)) { menuIndexVo.setMenu_39("Y"); }
            else if ("40".equals(token)) { menuIndexVo.setMenu_40("Y"); }
            else if ("41".equals(token)) { menuIndexVo.setMenu_41("Y"); }
            else if ("42".equals(token)) { menuIndexVo.setMenu_42("Y"); }
            else if ("43".equals(token)) { menuIndexVo.setMenu_43("Y"); }
            else if ("44".equals(token)) { menuIndexVo.setMenu_44("Y"); }
            else if ("45".equals(token)) { menuIndexVo.setMenu_45("Y"); }
            else if ("46".equals(token)) { menuIndexVo.setMenu_46("Y"); }
            else if ("47".equals(token)) { menuIndexVo.setMenu_47("Y"); }
            else if ("48".equals(token)) { menuIndexVo.setMenu_48("Y"); }
            else if ("49".equals(token)) { menuIndexVo.setMenu_49("Y"); }
            else if ("50".equals(token)) { menuIndexVo.setMenu_50("Y"); }
            else if ("51".equals(token)) { menuIndexVo.setMenu_51("Y"); }
            else if ("52".equals(token)) { menuIndexVo.setMenu_52("Y"); }
            else if ("53".equals(token)) { menuIndexVo.setMenu_53("Y"); }
            else if ("54".equals(token)) { menuIndexVo.setMenu_54("Y"); }
            else if ("55".equals(token)) { menuIndexVo.setMenu_55("Y"); }
            else if ("56".equals(token)) { menuIndexVo.setMenu_56("Y"); }
            else if ("57".equals(token)) { menuIndexVo.setMenu_57("Y"); }
            else if ("58".equals(token)) { menuIndexVo.setMenu_58("Y"); }
            else if ("59".equals(token)) { menuIndexVo.setMenu_59("Y"); }
            else if ("60".equals(token)) { menuIndexVo.setMenu_60("Y"); }
            else if ("61".equals(token)) { menuIndexVo.setMenu_61("Y"); }
            else if ("62".equals(token)) { menuIndexVo.setMenu_62("Y"); }
            else if ("63".equals(token)) { menuIndexVo.setMenu_63("Y"); }
            else if ("64".equals(token)) { menuIndexVo.setMenu_64("Y"); }
            else if ("65".equals(token)) { menuIndexVo.setMenu_65("Y"); }
            else if ("66".equals(token)) { menuIndexVo.setMenu_66("Y"); }
            else if ("67".equals(token)) { menuIndexVo.setMenu_67("Y"); }
            else if ("68".equals(token)) { menuIndexVo.setMenu_68("Y"); }
            else if ("69".equals(token)) { menuIndexVo.setMenu_69("Y"); }
            else if ("70".equals(token)) { menuIndexVo.setMenu_70("Y"); }
            else if ("71".equals(token)) { menuIndexVo.setMenu_71("Y"); }
            else if ("72".equals(token)) { menuIndexVo.setMenu_72("Y"); }
            else if ("73".equals(token)) { menuIndexVo.setMenu_73("Y"); }
            else if ("74".equals(token)) { menuIndexVo.setMenu_74("Y"); }
            else if ("75".equals(token)) { menuIndexVo.setMenu_75("Y"); }
            else if ("76".equals(token)) { menuIndexVo.setMenu_76("Y"); }
            else if ("77".equals(token)) { menuIndexVo.setMenu_77("Y"); }
            else if ("78".equals(token)) { menuIndexVo.setMenu_78("Y"); }
            else if ("79".equals(token)) { menuIndexVo.setMenu_79("Y"); }
            else if ("80".equals(token)) { menuIndexVo.setMenu_80("Y"); }
            else if ("81".equals(token)) { menuIndexVo.setMenu_81("Y"); }
            else if ("82".equals(token)) { menuIndexVo.setMenu_82("Y"); }
            else if ("83".equals(token)) { menuIndexVo.setMenu_83("Y"); }
            else if ("84".equals(token)) { menuIndexVo.setMenu_84("Y"); }
            else if ("85".equals(token)) { menuIndexVo.setMenu_85("Y"); }
            else if ("86".equals(token)) { menuIndexVo.setMenu_86("Y"); }
            else if ("87".equals(token)) { menuIndexVo.setMenu_87("Y"); }
            else if ("88".equals(token)) { menuIndexVo.setMenu_88("Y"); }
            else if ("89".equals(token)) { menuIndexVo.setMenu_89("Y"); }
            else if ("90".equals(token)) { menuIndexVo.setMenu_90("Y"); }
            else if ("91".equals(token)) { menuIndexVo.setMenu_91("Y"); }
            else if ("92".equals(token)) { menuIndexVo.setMenu_92("Y"); }
            else if ("93".equals(token)) { menuIndexVo.setMenu_93("Y"); }
            else if ("94".equals(token)) { menuIndexVo.setMenu_94("Y"); }
            else if ("95".equals(token)) { menuIndexVo.setMenu_95("Y"); }
            else if ("96".equals(token)) { menuIndexVo.setMenu_96("Y"); }
            else if ("97".equals(token)) { menuIndexVo.setMenu_97("Y"); }
            else if ("98".equals(token)) { menuIndexVo.setMenu_98("Y"); }
            else if ("99".equals(token)) { menuIndexVo.setMenu_99("Y"); }
            else if ("100".equals(token)) { menuIndexVo.setMenu_100("Y"); }
            else if ("101".equals(token)) { menuIndexVo.setMenu_101("Y"); }
            else if ("102".equals(token)) { menuIndexVo.setMenu_102("Y"); }
            else if ("103".equals(token)) { menuIndexVo.setMenu_103("Y"); }
            else if ("104".equals(token)) { menuIndexVo.setMenu_104("Y"); }
            else if ("105".equals(token)) { menuIndexVo.setMenu_105("Y"); }
            else if ("106".equals(token)) { menuIndexVo.setMenu_106("Y"); }
            else if ("107".equals(token)) { menuIndexVo.setMenu_107("Y"); }
            else if ("108".equals(token)) { menuIndexVo.setMenu_108("Y"); }
            else if ("109".equals(token)) { menuIndexVo.setMenu_109("Y"); }
            else if ("110".equals(token)) { menuIndexVo.setMenu_110("Y"); }
            else if ("111".equals(token)) { menuIndexVo.setMenu_111("Y"); }
            else if ("112".equals(token)) { menuIndexVo.setMenu_112("Y"); }
            else if ("113".equals(token)) { menuIndexVo.setMenu_113("Y"); }
            else if ("114".equals(token)) { menuIndexVo.setMenu_114("Y"); }
            else if ("115".equals(token)) { menuIndexVo.setMenu_115("Y"); }
        }

        return menuIndexVo;
    }
    private void setStatUpInfo(AdminVo adminVo, String reason, String reg_id) throws Exception {
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
        statUpVo.setCont(reason);
        statUpVo.setReg_id(reg_id);

        appService.insertStatUpInfo(statUpVo);
    }

}
