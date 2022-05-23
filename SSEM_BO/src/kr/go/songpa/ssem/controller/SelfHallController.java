package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.LectureService;
import kr.go.songpa.ssem.service.SelfHallService;
import kr.go.songpa.ssem.util.DateUtil;
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
 * Date : 2020-12-14
 * Description :
 * History :
 * Version :
 */
@Controller
public class SelfHallController extends CommonController {

    @Autowired
    private SelfHallService selfHallService;

    @Autowired
    private AppService appService;

    @Autowired
    private LectureService lectureService;

    public SelfHallController() {
    }

    @RequestMapping("/cont/self/new_program_profit_list.do")
    public String new_program_profit_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_program_profit_list";
        String in_url = "/" + ret_url + Constants.global_ext;

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        String end_dt = searchVo.getSearchEDate();
        if(end_dt.length() > 8) {
            searchVo.setSearchEDate(end_dt.substring(0, 7));
        }

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"S".equals(adminLoginVo.getType())) {
                if ("".equals(searchVo.getSearchKind())) {
                    searchVo.setSearchKind(String.valueOf(adminLoginVo.getGroup_idx()));
                    model.addAttribute("searchKind", String.valueOf(adminLoginVo.getGroup_idx()));
                }
            } else {
                /*if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }*/
            }


            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int tot_member = 0; // 수강인원
            float tot_pay = 0.0F; // 당초책정 강사료
            int tot_amount = 0; // 수강료징수액
            int tot_pay_fee = 0; // 지급강사료
            int tot_fund = 0; // 적립기금
            List<NewTracProgResultVo> itemList = selfHallService.selectNewProgramResultList(searchVo);
            for(NewTracProgResultVo newTracProgResultVo : itemList) {
                newTracProgResultVo.setDong_nm(appService.selectGruopByIdx(newTracProgResultVo.getGroup_idx()).getName());
                newTracProgResultVo.setLecture_nm(lectureService.selectLectureNameByIdx(newTracProgResultVo.getLecture_idx()));

                if("".equals(Util.nvl(newTracProgResultVo.getMan_cnt()))) {
                    newTracProgResultVo.setMan_cnt("0");
                }

                if("".equals(Util.nvl(newTracProgResultVo.getWoman_cnt()))) {
                    newTracProgResultVo.setWoman_cnt("0");
                }

                if(!"".equals(Util.nvl(newTracProgResultVo.getMan_cnt())) && !"".equals(Util.nvl(newTracProgResultVo.getWoman_cnt()))) {
                    int temp_fee = (int) ((Integer.parseInt(newTracProgResultVo.getMan_cnt()) + Integer.parseInt(newTracProgResultVo.getWoman_cnt())) * newTracProgResultVo.getTuition_monthly_fee());
                    int discount_fee = (int) (newTracProgResultVo.getReduce5_cost() + newTracProgResultVo.getReduce10_cost() + newTracProgResultVo.getReduce15_cost() + newTracProgResultVo.getReduce20_cost() + newTracProgResultVo.getReduce25_cost() + newTracProgResultVo.getReduce30_cost() + newTracProgResultVo.getReduce50_cost() + newTracProgResultVo.getReduce100_cost());
                    if(!"".equals(Util.nvl(newTracProgResultVo.getOperate_cnt()))) {
                        tot_pay = tot_pay + (newTracProgResultVo.getLecturer_hourly_fee() * newTracProgResultVo.getLecture_hour() * Integer.parseInt(newTracProgResultVo.getOperate_cnt()));
                    } else {
                        tot_pay = tot_pay + (newTracProgResultVo.getLecturer_hourly_fee() * newTracProgResultVo.getLecture_hour() * 0);
                    }
                    tot_amount = tot_amount + (int) (temp_fee - discount_fee);
                    tot_pay_fee = tot_pay_fee + (int) (
                        (newTracProgResultVo.getLecturer_fund_cost() + newTracProgResultVo.getLecturer_exist_cost())
                        -
                        ((newTracProgResultVo.getLecturer_fund_cost() + newTracProgResultVo.getLecturer_exist_cost()) * 0.03)
                        -
                        ((newTracProgResultVo.getLecturer_fund_cost() + newTracProgResultVo.getLecturer_exist_cost()) * 0.03 * 0.1)
                    );
                    tot_fund = tot_fund + (int) (temp_fee - discount_fee - newTracProgResultVo.getLecturer_fund_cost());
                    tot_member = tot_member + Integer.parseInt(newTracProgResultVo.getMan_cnt()) + Integer.parseInt(newTracProgResultVo.getWoman_cnt());
                }
            }
            int totalCount = selfHallService.selectNewProgramResultListTotal(searchVo);

            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
            model.addAttribute("tot_member", tot_member);
            model.addAttribute("tot_pay", tot_pay);
            model.addAttribute("tot_amount", tot_amount);
            model.addAttribute("tot_pay_fee", tot_pay_fee);
            model.addAttribute("tot_fund", tot_fund);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_program_profit_inscr.do", method = RequestMethod.GET)
    public String new_program_profit_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_program_profit_inscr";
        String menu_url = "cont/self/new_program_profit_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            String sdate = ServletRequestUtils.getStringParameter(request, "sdate", "");
            model.addAttribute("sdate", sdate);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_program_profit_inscr.do", method = RequestMethod.POST)
    public String new_program_profit_inproc(final MultipartHttpServletRequest multiRequest,
                                 @ModelAttribute("newTracProgResultVo") NewTracProgResultVo newTracProgResultVo,
                                 BindingResult bindingResult,
                                 Model model,
                                 SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {

                if(newTracProgResultVo.getGroup_idx() == 0) {
                    newTracProgResultVo.setGroup_idx(adminLoginVo.getGroup_idx());
                }

                newTracProgResultVo.setReg_id(adminLoginVo.getAdmin_id());

                selfHallService.insertNewTracProgResultVo(newTracProgResultVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_program_profit_list.do");
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

    @RequestMapping(value = "/cont/self/new_program_profit_copy.do", method = RequestMethod.GET)
    public String new_program_profit_copy(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "common/message";

        try {
            HttpSession session = request.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {

                String sdate = ServletRequestUtils.getStringParameter(request, "sdate", "");
                int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);

                // 기준 년월에 해당하는 데이터가 존재할 시 데이터를 삭제한다.
                GroupVo groupVo = new GroupVo();
                groupVo.setSdate(sdate);
                groupVo.setGroup_idx(group_idx);

                selfHallService.deleteNewTracProgResult(groupVo);

                // 기준년월 한달전 데이터 자동 입력한다.
                String old_sdate = DateUtil.getMonthMinusEx(sdate, "-", -1);
                groupVo.setSdate(old_sdate);

                List<NewTracProgResultVo> itemList = selfHallService.selectNewProgramResultListEx(groupVo);
                for(NewTracProgResultVo newTracProgResultVo : itemList) {
                    newTracProgResultVo.setStandard_yymm(sdate);

                    selfHallService.insertNewTracProgResultVo(newTracProgResultVo);
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_program_profit_list.do");
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_program_profit_view.do", method = RequestMethod.GET)
    public String new_program_profit_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_program_profit_view";
        String menu_url = "cont/self/new_program_profit_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int prog_result_seq = ServletRequestUtils.getIntParameter(request, "prog_result_seq", 0);

            NewTracProgResultVo newTracProgResultVo = selfHallService.selectNewProgramResultInfoByIdx(prog_result_seq);

            model.addAttribute("newTracProgResultVo", newTracProgResultVo);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_program_profit_view.do", method = RequestMethod.POST)
    public String new_program_profit_view_proc(final MultipartHttpServletRequest multiRequest,
                                            @ModelAttribute("newTracProgResultVo") NewTracProgResultVo newTracProgResultVo,
                                            BindingResult bindingResult,
                                            Model model,
                                            SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                if(newTracProgResultVo.getGroup_idx() == 0) {
                    newTracProgResultVo.setGroup_idx(adminLoginVo.getGroup_idx());
                }

                newTracProgResultVo.setUp_id(adminLoginVo.getAdmin_id());

                selfHallService.updateNewProgramResult(newTracProgResultVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_program_profit_list.do");
                model.addAttribute("altmsg", "수정 되었습니다.");
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

    @RequestMapping(value = "/cont/self/new_program_profit_delete.do", method = RequestMethod.POST)
    public String new_program_profit_delete(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("newTracProgResultVo") NewTracProgResultVo newTracProgResultVo,
                                        BindingResult bindingResult,
                                        Model model,
                                        SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                selfHallService.deleteNewProgramResult((int)newTracProgResultVo.getProg_result_seq());

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_program_profit_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/new_teacher_pay_list.do")
    public String new_teacher_pay_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_teacher_pay_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        String end_dt = searchVo.getSearchEDate();
        if(end_dt.length() > 8) {
            searchVo.setSearchEDate(end_dt.substring(0, 7));
        }

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"S".equals(adminLoginVo.getType())) {
                if ("".equals(searchVo.getSearchKind())) {
                    searchVo.setSearchKind(String.valueOf(adminLoginVo.getGroup_idx()));
                    model.addAttribute("searchKind", String.valueOf(adminLoginVo.getGroup_idx()));
                }
            } else {
                /*if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }*/
            }
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<NewTracLecturerCostVo> itemList = selfHallService.selectNewTeacherPaytList(searchVo);
            for(NewTracLecturerCostVo newTracLecturerCostVo : itemList) {
                newTracLecturerCostVo.setDong_nm(appService.selectGruopByIdx(newTracLecturerCostVo.getGroup_idx()).getName());
            }
            int totalCount = selfHallService.selectNewTeacherPayListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 15);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_teacher_pay_inscr.do", method = RequestMethod.GET)
    public String new_teacher_pay_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_teacher_pay_inscr";
        String menu_url = "cont/self/new_teacher_pay_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            String sdate = ServletRequestUtils.getStringParameter(request, "sdate", "");
            model.addAttribute("sdate", sdate);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_teacher_pay_inscr.do", method = RequestMethod.POST)
    public String new_teacher_pay_inproc(final MultipartHttpServletRequest multiRequest,
                                           @ModelAttribute("newTracLecturerCostVo") NewTracLecturerCostVo newTracLecturerCostVo,
                                           BindingResult bindingResult,
                                           Model model,
                                           SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {

                if(newTracLecturerCostVo.getGroup_idx() == 0) {
                    newTracLecturerCostVo.setGroup_idx(adminLoginVo.getGroup_idx());
                }

                newTracLecturerCostVo.setReg_id(adminLoginVo.getAdmin_id());

                selfHallService.insertNewTracLecturerCost(newTracLecturerCostVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_teacher_pay_list.do");
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

    @RequestMapping(value = "/cont/self/new_teacher_pay_view.do", method = RequestMethod.GET)
    public String new_teacher_pay_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_teacher_pay_view";
        String menu_url = "cont/self/new_teacher_pay_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int lecturer_cost = ServletRequestUtils.getIntParameter(request, "lecturer_cost", 0);

            NewTracLecturerCostVo newTracLecturerCostVo = selfHallService.selectNewTeacherPayInfoByIdx(lecturer_cost);

            model.addAttribute("newTracLecturerCostVo", newTracLecturerCostVo);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_teacher_pay_view.do", method = RequestMethod.POST)
    public String new_teacher_pay_view_proc(final MultipartHttpServletRequest multiRequest,
                                               @ModelAttribute("newTracLecturerCostVo") NewTracLecturerCostVo newTracLecturerCostVo,
                                               BindingResult bindingResult,
                                               Model model,
                                               SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                if(newTracLecturerCostVo.getGroup_idx() == 0) {
                    newTracLecturerCostVo.setGroup_idx(adminLoginVo.getGroup_idx());
                }

                newTracLecturerCostVo.setUp_id(adminLoginVo.getAdmin_id());

                selfHallService.updateNewTeacherPay(newTracLecturerCostVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_teacher_pay_list.do");
                model.addAttribute("altmsg", "수정 되었습니다.");
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

    @RequestMapping(value = "/cont/self/new_teacher_pay_delete.do", method = RequestMethod.POST)
    public String new_teacher_pay_delete(final MultipartHttpServletRequest multiRequest,
                                            @ModelAttribute("newTracLecturerCostVo") NewTracLecturerCostVo newTracLecturerCostVo,
                                            BindingResult bindingResult,
                                            Model model,
                                            SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                selfHallService.deleteNewTeacherPay((int)newTracLecturerCostVo.getLecturer_cost());

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_teacher_pay_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_teacher_pay_auto.do", method = RequestMethod.GET)
    public String new_teacher_pay_auto(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_teacher_pay_auto";
        String menu_url = "cont/self/new_teacher_pay_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            String sdate = ServletRequestUtils.getStringParameter(request, "sdate", "");
            int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);

            GroupVo param = new GroupVo();
            param.setSdate(sdate);
            param.setGroup_idx(group_idx);

            int lecture_cnt = 0;
            int classroom_cnt = 0;
            int teacher_cnt = 0;
            int apply_amount = 0;
            List<NewTracProgResultVo> itemList = selfHallService.selectNewProgramResultListEx(param);
            for(NewTracProgResultVo newTracProgResultVo : itemList) {
                if(newTracProgResultVo.getLecturer_exist_cost() != 0) {
                    classroom_cnt = classroom_cnt + Integer.parseInt(newTracProgResultVo.getMan_cnt()) + Integer.parseInt(newTracProgResultVo.getWoman_cnt());
                    apply_amount = apply_amount + (int) newTracProgResultVo.getLecturer_exist_cost();
                    lecture_cnt++;
                    teacher_cnt++;
                }
            }

            NewTracLecturerCostVo newTracLecturerCostVo = new NewTracLecturerCostVo();
            newTracLecturerCostVo.setStandard_yymm(sdate);
            newTracLecturerCostVo.setGroup_idx(group_idx);
            newTracLecturerCostVo.setClassroom_cnt(classroom_cnt);
            newTracLecturerCostVo.setLecture_cnt(lecture_cnt);
            newTracLecturerCostVo.setTeacher_cnt(teacher_cnt);
            newTracLecturerCostVo.setApply_amount(apply_amount);

            model.addAttribute("newTracLecturerCostVo", newTracLecturerCostVo);
            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_teacher_pay_auto_update.do", method = RequestMethod.GET)
    public String new_teacher_pay_auto_update(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_teacher_pay_view";
        String menu_url = "cont/self/new_teacher_pay_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            String sdate = ServletRequestUtils.getStringParameter(request, "sdate", "");
            int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);
            int lecturer_cost = ServletRequestUtils.getIntParameter(request, "lecturer_cost", 0);

            GroupVo param = new GroupVo();
            param.setSdate(sdate);
            param.setGroup_idx(group_idx);

            int lecture_cnt = 0;
            int classroom_cnt = 0;
            int teacher_cnt = 0;
            int apply_amount = 0;
            List<NewTracProgResultVo> itemList = selfHallService.selectNewProgramResultListEx(param);
            for(NewTracProgResultVo newTracProgResultVo : itemList) {
                if(newTracProgResultVo.getLecturer_exist_cost() != 0) {
                    classroom_cnt = classroom_cnt + Integer.parseInt(newTracProgResultVo.getMan_cnt()) + Integer.parseInt(newTracProgResultVo.getWoman_cnt());
                    apply_amount = apply_amount + (int) newTracProgResultVo.getLecturer_exist_cost();
                    lecture_cnt++;
                    teacher_cnt++;
                }
            }

            NewTracLecturerCostVo newTracLecturerCostVo = new NewTracLecturerCostVo();
            newTracLecturerCostVo.setLecturer_cost(lecturer_cost);
            newTracLecturerCostVo.setStandard_yymm(sdate);
            newTracLecturerCostVo.setGroup_idx(group_idx);
            newTracLecturerCostVo.setClassroom_cnt(classroom_cnt);
            newTracLecturerCostVo.setLecture_cnt(lecture_cnt);
            newTracLecturerCostVo.setTeacher_cnt(teacher_cnt);
            newTracLecturerCostVo.setApply_amount(apply_amount);

            model.addAttribute("newTracLecturerCostVo", newTracLecturerCostVo);
            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/new_volunteer_pay_list.do")
    public String new_volunteer_pay_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_volunteer_pay_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        String end_dt = searchVo.getSearchEDate();
        if(end_dt.length() > 8) {
            searchVo.setSearchEDate(end_dt.substring(0, 7));
        }
        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"S".equals(adminLoginVo.getType())) {
                if ("".equals(searchVo.getSearchKind())) {
                    searchVo.setSearchKind(String.valueOf(adminLoginVo.getGroup_idx()));
                    model.addAttribute("searchKind", String.valueOf(adminLoginVo.getGroup_idx()));
                }
            } else {
                /*if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }*/
            }

            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<NewTracServiceCostVo> itemList = selfHallService.selectNewVolunteerPaytList(searchVo);
            for(NewTracServiceCostVo newTracServiceCostVo : itemList) {
                newTracServiceCostVo.setDong_nm(appService.selectGruopByIdx(newTracServiceCostVo.getGroup_idx()).getName());
            }
            int totalCount = selfHallService.selectNewVolunteerPayListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 15);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_volunteer_pay_inscr.do", method = RequestMethod.GET)
    public String new_volunteer_pay_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_volunteer_pay_inscr";
        String menu_url = "cont/self/new_volunteer_pay_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            String sdate = ServletRequestUtils.getStringParameter(request, "sdate", "");
            model.addAttribute("sdate", sdate);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_volunteer_pay_inscr.do", method = RequestMethod.POST)
    public String new_volunteer_pay_inproc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("newTracServiceCostVo") NewTracServiceCostVo newTracServiceCostVo,
                                         BindingResult bindingResult,
                                         Model model,
                                         SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {

                if(newTracServiceCostVo.getGroup_idx() == 0) {
                    newTracServiceCostVo.setGroup_idx(adminLoginVo.getGroup_idx());
                }

                newTracServiceCostVo.setReg_id(adminLoginVo.getAdmin_id());

                selfHallService.insertNewVolunteerCost(newTracServiceCostVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_volunteer_pay_list.do");
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

    @RequestMapping(value = "/cont/self/new_volunteer_pay_view.do", method = RequestMethod.GET)
    public String new_volunteer_pay_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_volunteer_pay_view";
        String menu_url = "cont/self/new_volunteer_pay_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int service_cost_seq = ServletRequestUtils.getIntParameter(request, "service_cost_seq", 0);

            NewTracServiceCostVo newTracServiceCostVo = selfHallService.selectNewVolunteerPayInfoByIdx(service_cost_seq);

            model.addAttribute("newTracServiceCostVo", newTracServiceCostVo);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_volunteer_pay_view.do", method = RequestMethod.POST)
    public String new_volunteer_pay_view_proc(final MultipartHttpServletRequest multiRequest,
                                            @ModelAttribute("newTracServiceCostVo") NewTracServiceCostVo newTracServiceCostVo,
                                            BindingResult bindingResult,
                                            Model model,
                                            SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                if(newTracServiceCostVo.getGroup_idx() == 0) {
                    newTracServiceCostVo.setGroup_idx(adminLoginVo.getGroup_idx());
                }

                newTracServiceCostVo.setUp_id(adminLoginVo.getAdmin_id());

                selfHallService.updateNewVolunteerPay(newTracServiceCostVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_volunteer_pay_list.do");
                model.addAttribute("altmsg", "수정 되었습니다.");
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

    @RequestMapping(value = "/cont/self/new_volunteer_pay_delete.do", method = RequestMethod.POST)
    public String new_volunteer_pay_delete(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("newTracServiceCostVo") NewTracServiceCostVo newTracServiceCostVo,
                                         BindingResult bindingResult,
                                         Model model,
                                         SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                selfHallService.deleteNewVolunteerPay((int)newTracServiceCostVo.getService_cost_seq());

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_volunteer_pay_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_volunteer_pay_copy.do", method = RequestMethod.GET)
    public String new_volunteer_pay_copy(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_volunteer_pay_copy";
        String menu_url = "cont/self/new_volunteer_pay_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int service_cost_seq = ServletRequestUtils.getIntParameter(request, "service_cost_seq", 0);

            NewTracServiceCostVo newTracServiceCostVo = selfHallService.selectNewVolunteerPayInfoByIdx(service_cost_seq);

            model.addAttribute("newTracServiceCostVo", newTracServiceCostVo);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/new_income_list.do")
    public String new_income_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_income_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"S".equals(adminLoginVo.getType())) {
                if ("".equals(searchVo.getSearchKind3())) {
                    searchVo.setSearchKind3(String.valueOf(adminLoginVo.getGroup_idx()));
                    model.addAttribute("searchKind3", String.valueOf(adminLoginVo.getGroup_idx()));
                }
            } else {
                /*if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }*/
            }

            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<NewTracInoutVo> itemList = selfHallService.selectNewInCostList(searchVo);
            for(NewTracInoutVo newTracInoutVo : itemList) {
                newTracInoutVo.setDong_nm(appService.selectGruopByIdx(newTracInoutVo.getGroup_idx()).getName());
                newTracInoutVo.setInout_cd_nm(appService.selectCodeByIdx(newTracInoutVo.getInout_cd()));
            }
            int totalCount = selfHallService.selectNewInCostListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 15);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);

            // 수입구분
            List<CodeVo> codeList = appService.selectCodeList("IN_DIV_CD");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_income_inscr.do", method = RequestMethod.GET)
    public String new_income_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_income_inscr";
        String menu_url = "cont/self/new_income_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);

            // 수입구분
            List<CodeVo> codeList = appService.selectCodeList("IN_DIV_CD");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_income_inscr.do", method = RequestMethod.POST)
    public String new_income_inproc(final MultipartHttpServletRequest multiRequest,
                                           @ModelAttribute("newTracInoutVo") NewTracInoutVo newTracInoutVo,
                                           BindingResult bindingResult,
                                           Model model,
                                           SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {

                if(newTracInoutVo.getGroup_idx() == 0) {
                    newTracInoutVo.setGroup_idx(adminLoginVo.getGroup_idx());
                }

                newTracInoutVo.setReg_id(adminLoginVo.getAdmin_id());

                selfHallService.insertNewInCost(newTracInoutVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_income_list.do");
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

    @RequestMapping(value = "/cont/self/new_income_view.do", method = RequestMethod.GET)
    public String new_income_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_income_view";
        String menu_url = "cont/self/new_income_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int inout_seq = ServletRequestUtils.getIntParameter(request, "inout_seq", 0);

            NewTracInoutVo newTracInoutVo = selfHallService.selectNewInoutByIdx(inout_seq);
            if(newTracInoutVo.getStudent_idx() != 0) {
                List<NewTracInoutVo> itemList = selfHallService.selectNewInCostListByStudent(newTracInoutVo.getStudent_idx());
                for(NewTracInoutVo item : itemList) {
                    // 환불일, 환불금액 찾기
                    NewTracInoutVo refund = selfHallService.selectNewInoutRefundInfo(item);
                    if(refund != null) {
                        item.setRefund_cost(refund.getInout_cost());
                        item.setRefund_dt(refund.getStandard_date());
                    }
                }
                model.addAttribute("itemList", itemList);
            }
            model.addAttribute("newTracInoutVo", newTracInoutVo);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);

            // 수입구분
            List<CodeVo> codeList = appService.selectCodeList("IN_DIV_CD");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_income_view.do", method = RequestMethod.POST)
    public String new_income_view_proc(final MultipartHttpServletRequest multiRequest,
                                              @ModelAttribute("newTracInoutVo") NewTracInoutVo newTracInoutVo,
                                              BindingResult bindingResult,
                                              Model model,
                                              SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                if(newTracInoutVo.getGroup_idx() == 0) {
                    newTracInoutVo.setGroup_idx(adminLoginVo.getGroup_idx());
                }

                newTracInoutVo.setUp_id(adminLoginVo.getAdmin_id());

                selfHallService.updateNewInCost(newTracInoutVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_income_list.do");
                model.addAttribute("altmsg", "수정 되었습니다.");
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

    @RequestMapping(value = "/cont/self/new_income_delete.do", method = RequestMethod.POST)
    public String new_income_delete(final MultipartHttpServletRequest multiRequest,
                                           @ModelAttribute("newTracInoutVo") NewTracInoutVo newTracInoutVo,
                                           BindingResult bindingResult,
                                           Model model,
                                           SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                selfHallService.deleteNewInoutInfo((int)newTracInoutVo.getInout_seq());

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_income_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_income_copy.do", method = RequestMethod.GET)
    public String new_income_copy(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_income_copy";
        String menu_url = "cont/self/new_income_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int inout_seq = ServletRequestUtils.getIntParameter(request, "inout_seq", 0);

            NewTracInoutVo newTracInoutVo = selfHallService.selectNewInoutByIdx(inout_seq);
            model.addAttribute("newTracInoutVo", newTracInoutVo);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);

            // 수입구분
            List<CodeVo> codeList = appService.selectCodeList("IN_DIV_CD");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/new_expend_list.do")
    public String new_expend_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_expend_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"S".equals(adminLoginVo.getType())) {
                if ("".equals(searchVo.getSearchKind2())) {
                    searchVo.setSearchKind2(String.valueOf(adminLoginVo.getGroup_idx()));
                    model.addAttribute("searchKind2", String.valueOf(adminLoginVo.getGroup_idx()));
                }
            } else {
                /*if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }*/
            }
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<NewTracInoutVo> itemList = selfHallService.selectNewExpendList(searchVo);
            for(NewTracInoutVo newTracInoutVo : itemList) {
                newTracInoutVo.setDong_nm(appService.selectGruopByIdx(newTracInoutVo.getGroup_idx()).getName());
                newTracInoutVo.setInout_cd_nm(appService.selectCodeByIdx(newTracInoutVo.getInout_cd()));
            }
            int totalCount = selfHallService.selectNewExpendListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 15);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);

            // 지출구분
            List<CodeVo> codeList = appService.selectCodeList("OUT_DIV_CD");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_expend_inscr.do", method = RequestMethod.GET)
    public String new_expend_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_expend_inscr";
        String menu_url = "cont/self/new_expend_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);

            // 지출구분
            List<CodeVo> codeList = appService.selectCodeList("OUT_DIV_CD");
            model.addAttribute("codeList", codeList);

            // 은행구분
            List<CodeVo> bankList = appService.selectCodeList("BANK_CD");
            model.addAttribute("bankList", bankList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_expend_inscr.do", method = RequestMethod.POST)
    public String new_expend_inproc(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("newTracInoutVo") NewTracInoutVo newTracInoutVo,
                                    BindingResult bindingResult,
                                    Model model,
                                    SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {

                if(newTracInoutVo.getGroup_idx() == 0) {
                    newTracInoutVo.setGroup_idx(adminLoginVo.getGroup_idx());
                }

                newTracInoutVo.setReg_id(adminLoginVo.getAdmin_id());

                selfHallService.insertNewExpendCost(newTracInoutVo);

                if(newTracInoutVo.getRef_seq() != 0) {
                    selfHallService.updateNewIncomeRefundByIdx(newTracInoutVo.getRef_seq());
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_expend_list.do");
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

    @RequestMapping(value = "/cont/self/new_expend_view.do", method = RequestMethod.GET)
    public String new_expend_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_expend_view";
        String menu_url = "cont/self/new_expend_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int inout_seq = ServletRequestUtils.getIntParameter(request, "inout_seq", 0);

            NewTracInoutVo newTracInoutVo = selfHallService.selectNewInoutByIdx(inout_seq);
            model.addAttribute("newTracInoutVo", newTracInoutVo);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);

            // 지출구분
            List<CodeVo> codeList = appService.selectCodeList("OUT_DIV_CD");
            model.addAttribute("codeList", codeList);

            // 은행구분
            List<CodeVo> bankList = appService.selectCodeList("BANK_CD");
            model.addAttribute("bankList", bankList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_expend_view.do", method = RequestMethod.POST)
    public String new_expend_view_proc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("newTracInoutVo") NewTracInoutVo newTracInoutVo,
                                       BindingResult bindingResult,
                                       Model model,
                                       SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                if(newTracInoutVo.getGroup_idx() == 0) {
                    newTracInoutVo.setGroup_idx(adminLoginVo.getGroup_idx());
                }

                newTracInoutVo.setUp_id(adminLoginVo.getAdmin_id());

                selfHallService.updateNewExpendCost(newTracInoutVo);

                if(newTracInoutVo.getRef_seq() != newTracInoutVo.getOld_ref_seq()) {
                    // 환불 정보 업데이트 - 다시 돌린다
                    selfHallService.updateNewExpendRefundByIdx(newTracInoutVo.getOld_ref_seq());
                    if(newTracInoutVo.getRef_seq() != 0) {
                        selfHallService.updateNewIncomeRefundByIdx(newTracInoutVo.getRef_seq());
                    }
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_expend_list.do");
                model.addAttribute("altmsg", "수정 되었습니다.");
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

    @RequestMapping(value = "/cont/self/new_expend_delete.do", method = RequestMethod.POST)
    public String new_expend_delete(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("newTracInoutVo") NewTracInoutVo newTracInoutVo,
                                    BindingResult bindingResult,
                                    Model model,
                                    SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                selfHallService.deleteNewInoutInfo((int)newTracInoutVo.getInout_seq());

                if(newTracInoutVo.getRef_seq() != 0) {
                    // 환불 정보 업데이트 - 다시 돌린다
                    selfHallService.updateNewExpendRefundByIdx(newTracInoutVo.getRef_seq());
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_expend_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_expend_copy.do", method = RequestMethod.GET)
    public String new_expend_copy(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_expend_copy";
        String menu_url = "cont/self/new_expend_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int inout_seq = ServletRequestUtils.getIntParameter(request, "inout_seq", 0);

            NewTracInoutVo newTracInoutVo = selfHallService.selectNewInoutByIdx(inout_seq);
            model.addAttribute("newTracInoutVo", newTracInoutVo);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);

            // 지출구분
            List<CodeVo> codeList = appService.selectCodeList("OUT_DIV_CD");
            model.addAttribute("codeList", codeList);

            // 은행구분
            List<CodeVo> bankList = appService.selectCodeList("BANK_CD");
            model.addAttribute("bankList", bankList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/new_inout_report.do")
    public String new_inout_report(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_inout_report";
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
            if(!"S".equals(adminLoginVo.getType())) {
                if ("".equals(searchVo.getSearchKind())) {
                    searchVo.setSearchKind(String.valueOf(adminLoginVo.getGroup_idx()));
                    model.addAttribute("searchKind", String.valueOf(adminLoginVo.getGroup_idx()));
                }
            } else {
                /*if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }*/
            }
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                searchVo.setSearchKind(String.valueOf(adminLoginVo.getGroup_idx()));
                model.addAttribute("searchKind", String.valueOf(adminLoginVo.getGroup_idx()));
            }

            int in_total = 0;
            List<NewTracInoutVo> inList = selfHallService.selectNewIncomeCostList(searchVo);
            for(NewTracInoutVo in : inList) {
                in.setDong_nm(appService.selectGruopByIdx(in.getGroup_idx()).getName());
                in.setInout_cd_nm(appService.selectCodeByIdx(in.getInout_cd()));

                int ammout = (int)in.getInout_cost();
                in_total += ammout;
            }
            model.addAttribute("inList", inList);
            model.addAttribute("in_total", in_total);

            int ex_total = 0;
            List<NewTracInoutVo> exList = selfHallService.selectNewExpendCostList(searchVo);
            for(NewTracInoutVo ex : exList) {
                ex.setDong_nm(appService.selectGruopByIdx(ex.getGroup_idx()).getName());
                ex.setInout_cd_nm(appService.selectCodeByIdx(ex.getInout_cd()));

                int ammout = (int)ex.getInout_cost();
                ex_total += ammout;
            }
            model.addAttribute("exList", exList);
            model.addAttribute("ex_total", ex_total);

            // 전기 이월 금액
            long in_prev_total = selfHallService.selectNewPrevInTotal(searchVo);
            long ex_prev_total = selfHallService.selectNewPrevExTotal(searchVo);
            long prev_total = in_prev_total - ex_prev_total;

            model.addAttribute("prev_total", prev_total);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);

            // 전기이월액 OLD
            int prev_total_old = Util.getPrevSumOld(searchVo.getSearchKind());
            model.addAttribute("prev_total_old", prev_total_old);

            // 수입구분
            List<CodeVo> inCodeList = appService.selectCodeList("IN_DIV_CD");
            model.addAttribute("inCodeList", inCodeList);

            // 지출구분
            List<CodeVo> exCodeList = appService.selectCodeList("OUT_DIV_CD");
            model.addAttribute("exCodeList", exCodeList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/new_fund_list.do")
    public String new_fund_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_fund_list";
        String in_url = "/" + ret_url + Constants.global_ext;

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        String end_dt = searchVo.getSearchEDate();
        if(end_dt.length() > 8) {
            searchVo.setSearchEDate(end_dt.substring(0, 7));
        }

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"S".equals(adminLoginVo.getType())) {
                if ("".equals(searchVo.getSearchKind())) {
                    searchVo.setSearchKind(String.valueOf(adminLoginVo.getGroup_idx()));
                    model.addAttribute("searchKind", String.valueOf(adminLoginVo.getGroup_idx()));
                }
            } else {
                /*if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }*/
            }
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int tot_amount = 0;
            List<NewTracFundMngVo> itemList = selfHallService.selectNewVFundtList(searchVo);
            for(NewTracFundMngVo newTracFundMngVo : itemList) {
                newTracFundMngVo.setDong_nm(appService.selectGruopByIdx(newTracFundMngVo.getGroup_idx()).getName());
                tot_amount += newTracFundMngVo.getAmount();
            }
            int totalCount = selfHallService.selectNewFundListTotal(searchVo);

            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
            model.addAttribute("tot_amount", tot_amount);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_fund_inscr.do", method = RequestMethod.GET)
    public String new_fund_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_fund_inscr";
        String menu_url = "cont/self/new_fund_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            String sdate = ServletRequestUtils.getStringParameter(request, "sdate", "");
            model.addAttribute("sdate", sdate);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_fund_inscr.do", method = RequestMethod.POST)
    public String new_fund_inproc(final MultipartHttpServletRequest multiRequest,
                                           @ModelAttribute("newTracFundMngVo") NewTracFundMngVo newTracFundMngVo,
                                           BindingResult bindingResult,
                                           Model model,
                                           SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {

                if(newTracFundMngVo.getGroup_idx() == 0) {
                    newTracFundMngVo.setGroup_idx(adminLoginVo.getGroup_idx());
                }

                newTracFundMngVo.setReg_id(adminLoginVo.getAdmin_id());

                selfHallService.insertNewFundInfo(newTracFundMngVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_fund_list.do");
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

    @RequestMapping(value = "/cont/self/new_fund_view.do", method = RequestMethod.GET)
    public String new_fund_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/new_fund_view";
        String menu_url = "cont/self/new_fund_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int fund_mng_seq = ServletRequestUtils.getIntParameter(request, "fund_mng_seq", 0);

            NewTracFundMngVo newTracFundMngVo = selfHallService.selectNewFundInfoByIdx(fund_mng_seq);

            model.addAttribute("newTracFundMngVo", newTracFundMngVo);

            // 자치회관 동 정보
            GroupVo groupVo = new GroupVo();
            groupVo.setGroup_idx(1);
            List<GroupVo> dongList = appService.selectSubGroupList(groupVo);
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/new_fund_view.do", method = RequestMethod.POST)
    public String new_fund_view_proc(final MultipartHttpServletRequest multiRequest,
                                              @ModelAttribute("newTracFundMngVo") NewTracFundMngVo newTracFundMngVo,
                                              BindingResult bindingResult,
                                              Model model,
                                              SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                if(newTracFundMngVo.getGroup_idx() == 0) {
                    newTracFundMngVo.setGroup_idx(adminLoginVo.getGroup_idx());
                }

                newTracFundMngVo.setUp_id(adminLoginVo.getAdmin_id());

                selfHallService.updateNewFund(newTracFundMngVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_fund_list.do");
                model.addAttribute("altmsg", "수정 되었습니다.");
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

    @RequestMapping(value = "/cont/self/new_fund_delete.do", method = RequestMethod.POST)
    public String new_fund_delete(final MultipartHttpServletRequest multiRequest,
                                           @ModelAttribute("newTracFundMngVo") NewTracFundMngVo newTracFundMngVo,
                                           BindingResult bindingResult,
                                           Model model,
                                           SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                selfHallService.deleteNewFund((int)newTracFundMngVo.getFund_mng_seq());

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/self/new_fund_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/old_program_mng.do")
    public String old_program_mng(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_program_mng";
        String in_url = "/" + ret_url + Constants.global_ext;

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        String start_dt = searchVo.getSearchSDate();
        if(start_dt.length() > 8) {
            searchVo.setSearchSDate(start_dt.substring(0, 7));
        }

        String end_dt = searchVo.getSearchEDate();
        if(end_dt.length() > 8) {
            searchVo.setSearchEDate(end_dt.substring(0, 7));
        }

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                searchVo.setSearchKind(Util.getDongCode(adminLoginVo.getGrp_name()));
                model.addAttribute("searchKind", Util.getDongCode(adminLoginVo.getGrp_name()));
            }

            List<TracProgramVo> itemList = selfHallService.selectProgramList(searchVo);
            for(TracProgramVo tracProgramVo : itemList) {
                tracProgramVo.setCourse_sdate(DateUtil.dateFormat(tracProgramVo.getCourse_sdate()));
                tracProgramVo.setCourse_edate(DateUtil.dateFormat(tracProgramVo.getCourse_edate()));

                tracProgramVo.setDong_cd(Util.getDongName(tracProgramVo.getDong_cd()));
            }
            int totalCount = selfHallService.selectProgramListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 15);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 동리스트
            List<DongVo> dongList = Util.getDongList();
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/old_program_mng_view.do", method = RequestMethod.GET)
    public String old_program_mng_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_program_mng_view";
        String menu_url = "cont/self/old_program_mng";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int prog_seq = ServletRequestUtils.getIntParameter(request, "prog_seq", 0);

            TracProgramVo tracProgramVo = new TracProgramVo();
            tracProgramVo.setProg_seq(prog_seq);

            tracProgramVo = selfHallService.selectProgramInfo(tracProgramVo);

            tracProgramVo.setCourse_sdate(DateUtil.dateFormat(tracProgramVo.getCourse_sdate()));
            tracProgramVo.setCourse_edate(DateUtil.dateFormat(tracProgramVo.getCourse_edate()));

            tracProgramVo.setDong_cd(Util.getDongName(tracProgramVo.getDong_cd()));

            model.addAttribute("tracProgramVo", tracProgramVo);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/old_teacher_mng.do")
    public String old_teacher_mng(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_teacher_mng";
        String in_url = "/" + ret_url + Constants.global_ext;

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                searchVo.setSearchKind(Util.getDongCode(adminLoginVo.getGrp_name()));
                model.addAttribute("searchKind", Util.getDongCode(adminLoginVo.getGrp_name()));
            }

            List<TracLecturerVo> itemList = selfHallService.selectTeacherList(searchVo);
            for(TracLecturerVo tracLecturerVo : itemList) {
                tracLecturerVo.setBirthday(DateUtil.dateFormat(tracLecturerVo.getBirthday()));
                tracLecturerVo.setAgree_sdate(DateUtil.dateFormat(tracLecturerVo.getAgree_sdate()));
                tracLecturerVo.setAgree_edate(DateUtil.dateFormat(tracLecturerVo.getAgree_edate()));

                tracLecturerVo.setDong_cd(Util.getDongName(tracLecturerVo.getDong_cd()));
            }
            int totalCount = selfHallService.selectTeacherListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 15);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 동리스트
            List<DongVo> dongList = Util.getDongList();
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/old_teacher_mng_view.do", method = RequestMethod.GET)
    public String old_teacher_mng_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_teacher_mng_view";
        String menu_url = "cont/self/old_teacher_mng";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int lecturer_seq = ServletRequestUtils.getIntParameter(request, "lecturer_seq", 0);

            TracLecturerVo tracLecturerVo = new TracLecturerVo();
            tracLecturerVo.setLecturer_seq(lecturer_seq);

            tracLecturerVo = selfHallService.selectTeacherInfo(tracLecturerVo);

            tracLecturerVo.setBirthday(DateUtil.dateFormat(tracLecturerVo.getBirthday()));
            tracLecturerVo.setAgree_sdate(DateUtil.dateFormat(tracLecturerVo.getAgree_sdate()));
            tracLecturerVo.setAgree_edate(DateUtil.dateFormat(tracLecturerVo.getAgree_edate()));

            tracLecturerVo.setDong_cd(Util.getDongName(tracLecturerVo.getDong_cd()));

            model.addAttribute("tracLecturerVo", tracLecturerVo);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/old_program_profit_list.do")
    public String old_program_profit_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_program_profit_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        String start_dt = searchVo.getSearchSDate();
        if(start_dt.length() > 8) {
            searchVo.setSearchSDate(start_dt.substring(0, 7));
        }

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                searchVo.setSearchKind(Util.getDongCode(adminLoginVo.getGrp_name()));
                model.addAttribute("searchKind", Util.getDongCode(adminLoginVo.getGrp_name()));
            }

            int tot_member = 0; // 수강인원
            int tot_collect_amount = 0; // 수강료징수액
            int tot_support_amount = 0; // 적립기금
            List<TracProgResultVo> itemList = selfHallService.selectProgramResultList(searchVo);
            for(TracProgResultVo tracProgResultVo : itemList) {
                tracProgResultVo.setDong_cd(Util.getDongName(tracProgResultVo.getDong_cd()));
                tot_collect_amount += tracProgResultVo.getCollect_amount();
                tot_support_amount += tracProgResultVo.getSupport_amount();
                tot_member = tot_member + Integer.parseInt(tracProgResultVo.getMan_cnt()) + Integer.parseInt(tracProgResultVo.getWoman_cnt());
            }
            int totalCount = selfHallService.selectProgramResultListTotal(searchVo);

            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
            model.addAttribute("tot_collect_amount", tot_collect_amount);
            model.addAttribute("tot_support_amount", tot_support_amount);
            model.addAttribute("tot_member", tot_member);

            // 동리스트
            List<DongVo> dongList = Util.getDongList();
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/old_program_profit_view.do", method = RequestMethod.GET)
    public String old_program_profit_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_program_profit_view";
        String menu_url = "cont/self/old_program_profit_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int prog_result_seq = ServletRequestUtils.getIntParameter(request, "prog_result_seq", 0);

            TracProgResultVo tracProgResultVo = new TracProgResultVo();
            tracProgResultVo.setProg_result_seq(prog_result_seq);

            tracProgResultVo = selfHallService.selectProgramResultInfo(tracProgResultVo);

            TracProgramVo tracProgramVo = selfHallService.selectProgramByIdx(tracProgResultVo.getProg_seq());
            tracProgResultVo.setTracProgramVo(tracProgramVo);

            tracProgResultVo.setDong_cd(Util.getDongName(tracProgResultVo.getDong_cd()));

            model.addAttribute("tracProgResultVo", tracProgResultVo);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/old_teacher_pay_list.do")
    public String old_teacher_pay_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_teacher_pay_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        String start_dt = searchVo.getSearchSDate();
        if(start_dt.length() > 8) {
            searchVo.setSearchSDate(start_dt.substring(0, 7));
        }

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                searchVo.setSearchKind(Util.getDongCode(adminLoginVo.getGrp_name()));
                model.addAttribute("searchKind", Util.getDongCode(adminLoginVo.getGrp_name()));
            }

            List<TracLecturerCostVo> itemList = selfHallService.selectTeacherPayList(searchVo);
            for(TracLecturerCostVo tracLecturerCostVo : itemList) {
                tracLecturerCostVo.setDong_cd(Util.getDongName(tracLecturerCostVo.getDong_cd()));
            }
            int totalCount = selfHallService.selectTeacherPayListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 15);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 동리스트
            List<DongVo> dongList = Util.getDongList();
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/old_teacher_pay_view.do", method = RequestMethod.GET)
    public String old_teacher_pay_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_teacher_pay_view";
        String menu_url = "cont/self/old_teacher_pay_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int lecturer_cost = ServletRequestUtils.getIntParameter(request, "lecturer_cost", 0);

            TracLecturerCostVo tracLecturerCostVo = new TracLecturerCostVo();
            tracLecturerCostVo.setLecturer_cost(lecturer_cost);

            tracLecturerCostVo = selfHallService.selectTeacherPayInfo(tracLecturerCostVo);

            tracLecturerCostVo.setDong_cd(Util.getDongName(tracLecturerCostVo.getDong_cd()));

            model.addAttribute("tracLecturerCostVo", tracLecturerCostVo);

        }

        return ret_url;
    }

    @RequestMapping("/cont/self/old_volunteer_pay_list.do")
    public String old_volunteer_pay_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_volunteer_pay_list";
        String in_url = "/" + ret_url + Constants.global_ext;

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        String start_dt = searchVo.getSearchSDate();
        if(start_dt.length() > 8) {
            searchVo.setSearchSDate(start_dt.substring(0, 7));
        }

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                searchVo.setSearchKind(Util.getDongCode(adminLoginVo.getGrp_name()));
                model.addAttribute("searchKind", Util.getDongCode(adminLoginVo.getGrp_name()));
            }

            List<TracServiceCostVo> itemList = selfHallService.selectVolunteerPayList(searchVo);
            for(TracServiceCostVo tracServiceCostVo : itemList) {
                tracServiceCostVo.setResi_no(DateUtil.dateFormat(tracServiceCostVo.getResi_no()));

                tracServiceCostVo.setDong_cd(Util.getDongName(tracServiceCostVo.getDong_cd()));
            }
            int totalCount = selfHallService.selectVolunteerPayListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 15);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 동리스트
            List<DongVo> dongList = Util.getDongList();
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/old_volunteer_pay_view.do", method = RequestMethod.GET)
    public String old_volunteer_pay_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_volunteer_pay_view";
        String menu_url = "cont/self/old_volunteer_pay_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int service_cost_seq = ServletRequestUtils.getIntParameter(request, "service_cost_seq", 0);

            TracServiceCostVo tracServiceCostVo = new TracServiceCostVo();
            tracServiceCostVo.setService_cost_seq(service_cost_seq);

            tracServiceCostVo = selfHallService.selectVolunteerPayInfo(tracServiceCostVo);

            tracServiceCostVo.setResi_no(DateUtil.dateFormat(tracServiceCostVo.getResi_no()));
            tracServiceCostVo.setDong_cd(Util.getDongName(tracServiceCostVo.getDong_cd()));

            model.addAttribute("tracServiceCostVo", tracServiceCostVo);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/old_fund_list.do")
    public String old_fund_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_fund_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        String start_dt = searchVo.getSearchSDate();
        if(start_dt.length() > 8) {
            searchVo.setSearchSDate(start_dt.substring(0, 7));
        }

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                searchVo.setSearchKind(Util.getDongCode(adminLoginVo.getGrp_name()));
                model.addAttribute("searchKind", Util.getDongCode(adminLoginVo.getGrp_name()));
            }

            int totAmount = 0;
            List<TracFundMngVo> itemList = selfHallService.selectFundList(searchVo);
            for(TracFundMngVo tracFundMngVo : itemList) {
                int amount = (int)tracFundMngVo.getAmount();
                totAmount += amount;

                tracFundMngVo.setStandard_yymm(tracFundMngVo.getStandard_yymm().substring(0, 4) + "년 " + tracFundMngVo.getStandard_yymm().substring(4, 6) + "월");
                tracFundMngVo.setDong_cd(Util.getDongName(tracFundMngVo.getDong_cd()));
            }
            int totalCount = selfHallService.selectFundListTotal(searchVo);

            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
            model.addAttribute("totAmount", totAmount);

            // 동리스트
            List<DongVo> dongList = Util.getDongList();
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/old_student_list.do")
    public String old_student_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_student_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        String start_dt = searchVo.getSearchSDate();
        if(start_dt.length() > 8) {
            searchVo.setSearchSDate(start_dt.substring(0, 7));
        }

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                searchVo.setSearchKind(Util.getDongCode(adminLoginVo.getGrp_name()));
                model.addAttribute("searchKind", Util.getDongCode(adminLoginVo.getGrp_name()));
            }

            List<TracStudentVo> itemList = selfHallService.selectStudentList(searchVo);
            for(TracStudentVo tracStudentVo : itemList) {
                if(!"".equals(Util.nvl(tracStudentVo.getStudent_resino()))) {
                    tracStudentVo.setStudent_resino(DateUtil.dateFormat(tracStudentVo.getStudent_resino()));
                }

                tracStudentVo.setDong_cd(Util.getDongName(tracStudentVo.getDong_cd()));
            }
            int totalCount = selfHallService.selectStudentListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 15);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 동리스트
            List<DongVo> dongList = Util.getDongList();
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/old_student_view.do", method = RequestMethod.GET)
    public String old_student_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_student_view";
        String menu_url = "cont/self/old_student_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int student_seq = ServletRequestUtils.getIntParameter(request, "student_seq", 0);

            TracStudentVo tracStudentVo = new TracStudentVo();
            tracStudentVo.setStudent_seq(student_seq);

            tracStudentVo = selfHallService.selectStudentInfo(tracStudentVo);

            if(!"".equals(Util.nvl(tracStudentVo.getStudent_resino()))) {
                tracStudentVo.setStudent_resino(DateUtil.dateFormat(tracStudentVo.getStudent_resino()));
            }

            tracStudentVo.setDong_cd(Util.getDongName(tracStudentVo.getDong_cd()));

            model.addAttribute("tracStudentVo", tracStudentVo);

            List<TracInoutVo> itemList = selfHallService.selectIncomeListByStudent(tracStudentVo.getStudent_seq());
            for(TracInoutVo item : itemList) {
                if(!"".equals(Util.nvl(item.getStandard_date()))) {
                    item.setStandard_date(DateUtil.dateFormat(item.getStandard_date()));
                }

                if(!"".equals(Util.nvl(item.getSdate()))) {
                    item.setSdate(DateUtil.dateFormat(item.getSdate()));
                }

                if(!"".equals(Util.nvl(item.getEdate()))) {
                    item.setEdate(DateUtil.dateFormat(item.getEdate()));
                }
            }

            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/old_income_list.do")
    public String old_income_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_income_list";
        String in_url = "/" + ret_url + Constants.global_ext;

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                searchVo.setSearchKind(Util.getDongCode(adminLoginVo.getGrp_name()));
                model.addAttribute("searchKind", Util.getDongCode(adminLoginVo.getGrp_name()));
            }

            List<TracInoutVo> itemList = selfHallService.selectIncomeList(searchVo);
            for(TracInoutVo tracInoutVo : itemList) {
                if(!"".equals(Util.nvl(tracInoutVo.getStandard_date()))) {
                    tracInoutVo.setStandard_date(DateUtil.dateFormat(tracInoutVo.getStandard_date()));
                }

                tracInoutVo.setDong_cd(Util.getDongName(tracInoutVo.getDong_cd()));
            }
            int totalCount = selfHallService.selectIncomeListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 15);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 동리스트
            List<DongVo> dongList = Util.getDongList();
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/old_income_view.do", method = RequestMethod.GET)
    public String old_income_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_income_view";
        String menu_url = "cont/self/old_income_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int inout_seq = ServletRequestUtils.getIntParameter(request, "inout_seq", 0);

            TracInoutVo tracInoutVo = new TracInoutVo();
            tracInoutVo.setInout_seq(inout_seq);

            tracInoutVo = selfHallService.selectInoutInfo(tracInoutVo);

            if(!"".equals(Util.nvl(tracInoutVo.getStandard_date()))) {
                tracInoutVo.setStandard_date(DateUtil.dateFormat(tracInoutVo.getStandard_date()));
            }

            if(!"".equals(Util.nvl(tracInoutVo.getSdate()))) {
                tracInoutVo.setSdate(DateUtil.dateFormat(tracInoutVo.getSdate()));
            }

            if(!"".equals(Util.nvl(tracInoutVo.getEdate()))) {
                tracInoutVo.setEdate(DateUtil.dateFormat(tracInoutVo.getEdate()));
            }

            if(Util.nvl(tracInoutVo.getStudent_seq(), 0) != 0) {
                TracStudentVo tracStudentVo = selfHallService.selectStudentByIdx(tracInoutVo.getStudent_seq());
                if(tracStudentVo != null) {
                    if (!"".equals(Util.nvl(tracStudentVo.getStudent_resino()))) {
                        tracStudentVo.setStudent_resino(DateUtil.dateFormat(tracStudentVo.getStudent_resino()));
                    }
                }

                tracInoutVo.setTracStudentVo(tracStudentVo);

                List<TracInoutVo> itemList = selfHallService.selectIncomeListByStudent(tracInoutVo.getStudent_seq());
                for(TracInoutVo item : itemList) {
                    if(!"".equals(Util.nvl(item.getStandard_date()))) {
                        item.setStandard_date(DateUtil.dateFormat(item.getStandard_date()));
                    }

                    if(!"".equals(Util.nvl(item.getSdate()))) {
                        item.setSdate(DateUtil.dateFormat(item.getSdate()));
                    }

                    if(!"".equals(Util.nvl(item.getEdate()))) {
                        item.setEdate(DateUtil.dateFormat(item.getEdate()));
                    }
                }

                model.addAttribute("itemList", itemList);
            }

            /*if(Util.nvl(tracInoutVo.getProg_seq(), 0) != 0) {
                List<TracInoutVo> itemList = selfHallService.selectIncomeListByProgram(tracInoutVo.getProg_seq());
                for(TracInoutVo item : itemList) {
                    if(!"".equals(Util.nvl(item.getStandard_date()))) {
                        item.setStandard_date(DateUtil.dateFormat(item.getStandard_date()));
                    }

                    if(!"".equals(Util.nvl(item.getSdate()))) {
                        item.setSdate(DateUtil.dateFormat(item.getSdate()));
                    }

                    if(!"".equals(Util.nvl(item.getEdate()))) {
                        item.setEdate(DateUtil.dateFormat(item.getEdate()));
                    }
                }

                model.addAttribute("itemList", itemList);
            }*/

            tracInoutVo.setDong_cd(Util.getDongName(tracInoutVo.getDong_cd()));

            model.addAttribute("tracInoutVo", tracInoutVo);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/old_expend_list.do")
    public String old_expend_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_expend_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                searchVo.setSearchKind(Util.getDongCode(adminLoginVo.getGrp_name()));
                model.addAttribute("searchKind", Util.getDongCode(adminLoginVo.getGrp_name()));
            }

            List<TracInoutVo> itemList = selfHallService.selectOutcomeList(searchVo);
            for(TracInoutVo tracInoutVo : itemList) {
                if(Util.nvl(tracInoutVo.getProg_seq(), 0) != 0) {
                    TracProgramVo tracProgramVo = selfHallService.selectProgramByIdx(tracInoutVo.getProg_seq());
                    if(tracProgramVo != null) {
                        tracInoutVo.setProg_nm(tracProgramVo.getProg_nm());
                    }
                }

                if(!"".equals(Util.nvl(tracInoutVo.getStandard_date()))) {
                    tracInoutVo.setStandard_date(DateUtil.dateFormat(tracInoutVo.getStandard_date()));
                }

                tracInoutVo.setDong_cd(Util.getDongName(tracInoutVo.getDong_cd()));
            }
            int totalCount = selfHallService.selectOutcomeListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 15);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 동리스트
            List<DongVo> dongList = Util.getDongList();
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/self/old_expend_view.do", method = RequestMethod.GET)
    public String old_expend_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_expend_view";
        String menu_url = "cont/self/old_expend_list";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int inout_seq = ServletRequestUtils.getIntParameter(request, "inout_seq", 0);

            TracInoutVo tracInoutVo = new TracInoutVo();
            tracInoutVo.setInout_seq(inout_seq);

            tracInoutVo = selfHallService.selectInoutInfo(tracInoutVo);

            if(Util.nvl(tracInoutVo.getProg_seq(), 0) != 0) {
                TracProgramVo tracProgramVo = selfHallService.selectProgramByIdx(tracInoutVo.getProg_seq());
                tracInoutVo.setProg_nm(tracProgramVo.getProg_nm());
            }

            if(!"".equals(Util.nvl(tracInoutVo.getStandard_date()))) {
                tracInoutVo.setStandard_date(DateUtil.dateFormat(tracInoutVo.getStandard_date()));
            }

            if(!"".equals(Util.nvl(tracInoutVo.getSdate()))) {
                tracInoutVo.setSdate(DateUtil.dateFormat(tracInoutVo.getSdate()));
            }

            if(!"".equals(Util.nvl(tracInoutVo.getEdate()))) {
                tracInoutVo.setEdate(DateUtil.dateFormat(tracInoutVo.getEdate()));
            }

            if(Util.nvl(tracInoutVo.getStudent_seq(), 0) != 0) {
                TracStudentVo tracStudentVo = selfHallService.selectStudentByIdx(tracInoutVo.getStudent_seq());
                if(tracStudentVo != null) {
                    if (!"".equals(Util.nvl(tracStudentVo.getStudent_resino()))) {
                        tracStudentVo.setStudent_resino(DateUtil.dateFormat(tracStudentVo.getStudent_resino()));
                    }
                }

                tracInoutVo.setTracStudentVo(tracStudentVo);
            }

            if(Util.nvl(tracInoutVo.getProg_seq(), 0) != 0) {
                List<TracInoutVo> itemList = selfHallService.selectIncomeListByProgram(tracInoutVo.getProg_seq());
                for(TracInoutVo item : itemList) {
                    if(!"".equals(Util.nvl(item.getStandard_date()))) {
                        item.setStandard_date(DateUtil.dateFormat(item.getStandard_date()));
                    }

                    if(!"".equals(Util.nvl(item.getSdate()))) {
                        item.setSdate(DateUtil.dateFormat(item.getSdate()));
                    }

                    if(!"".equals(Util.nvl(item.getEdate()))) {
                        item.setEdate(DateUtil.dateFormat(item.getEdate()));
                    }
                }

                model.addAttribute("itemList", itemList);
            }

            tracInoutVo.setDong_cd(Util.getDongName(tracInoutVo.getDong_cd()));

            model.addAttribute("tracInoutVo", tracInoutVo);
        }

        return ret_url;
    }

    @RequestMapping("/cont/self/old_inout_report.do")
    public String old_inout_report(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/self/old_inout_report";
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
            if (!"".equals(menuMstVo.getRet_url())) {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                searchVo.setSearchKind(Util.getDongCode(adminLoginVo.getGrp_name()));
                model.addAttribute("searchKind", Util.getDongCode(adminLoginVo.getGrp_name()));
            }

            int in_total = 0;
            List<TracInoutVo> inList = selfHallService.selectIncomeListEx(searchVo);
            for(TracInoutVo in : inList) {
                in.setDong_cd(Util.getDongName(in.getDong_cd()));

                int ammout = (int)in.getAmount();
                in_total += ammout;
            }
            model.addAttribute("inList", inList);
            model.addAttribute("in_total", in_total);

            int ex_total = 0;
            List<TracInoutVo> exList = selfHallService.selectOutcomeListEx(searchVo);
            for(TracInoutVo ex : exList) {
                ex.setDong_cd(Util.getDongName(ex.getDong_cd()));

                int ammout = (int)ex.getAmount();
                ex_total += ammout;
            }
            model.addAttribute("exList", exList);
            model.addAttribute("ex_total", ex_total);

            // 전기 이월 금액
            long in_prev_total = selfHallService.selectOldPrevInTotal(searchVo);
            long ex_prev_total = selfHallService.selectOldPrevExTotal(searchVo);
            long prev_total = in_prev_total - ex_prev_total;

            model.addAttribute("prev_total", prev_total);

            // 동리스트
            List<DongVo> dongList = Util.getDongList();
            model.addAttribute("dongList", dongList);
        }

        return ret_url;
    }
}
