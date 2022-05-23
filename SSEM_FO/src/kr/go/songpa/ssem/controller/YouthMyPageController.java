package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.common.SafeHtmlUtil;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.*;
import kr.go.songpa.ssem.util.DateUtil;
import kr.go.songpa.ssem.util.FileMngUtil;
import kr.go.songpa.ssem.util.StringUtil;
import kr.go.songpa.ssem.util.Util;
import lgdacom.XPayClient.XPayClient;
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
import java.util.ArrayList;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-11-03
 * Description :
 * History :
 * Version :
 */
@Controller
public class YouthMyPageController extends CommonController {
    @Autowired
    private UserService userService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    @Autowired
    private CampusService campusService;

    @Autowired
    private AppService appService;

    @Autowired
    private MagnetService magnetService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private ClubService clubService;

    @Autowired
    private BbsService bbsService;

    @Autowired
    private MsgService msgService;

    public YouthMyPageController() {
    }

    @RequestMapping(value = "/youth/mypage/pwd_confirm.do", method = RequestMethod.GET)
    public String youth_pwd_confirm(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/pwd_confirm";

        String return_url = ServletRequestUtils.getStringParameter(request, "return_url", "");

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/pwd_confirm.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            model.addAttribute("return_url", return_url);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/pwd_confirm.do", method = RequestMethod.POST)
    public String youth_pwd_confirm_proc(@ModelAttribute TnUserInfoVo tnUserInfoVo, HttpServletRequest request, Model model) throws Exception {
        String ret_url = "";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        String return_url = ServletRequestUtils.getStringParameter(request, "return_url", "");

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/pwd_confirm.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            int code = this.checkLoginOptions(tnUserInfoVo, request);
            if (code == 9) {
                String url = "";
                if("".equals(tnUserInfoVo.getReturn_url())) {
                    url = "/youth/mypage/program_list.do";
                } else {
                    url = tnUserInfoVo.getReturn_url();
                }

                loginVo.setMypage_check("Y");
                session.setAttribute(Constants.LOGIN_VO, loginVo);
                ret_url = "redirect:" + url;
            } else {
                // 오류
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/pwd_confirm.do");

                if (code == 1) {
                    model.addAttribute("altmsg", "비밀번호가 일치하지 않습니다.<br/>확인 후 다시 시도해 주세요.");
                }

                ret_url =  "common/message";
            }
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/program_list.do")
    public String youth_program_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/program_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/pwd_confirm.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/program_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }
            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // 마이페이지

            List<LectureApyVo> itemList = lectureService.selectLectureApyList(searchVo);
            for(LectureApyVo lectureApyVo : itemList) {
                LectureVo lectureVo = new LectureVo();
                lectureVo.setLecture_idx(lectureApyVo.getLecture_idx());

                lectureVo = lectureService.selectLectureInfo(lectureVo);

                // 교육분야 가져오기
                String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
                lectureVo.setPart_name(part_name);

                // 교육기관 정보
                GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
                lectureVo.setGroup(groupVo);

                lectureApyVo.setLectureVo(lectureVo);
            }
            int totalCount = lectureService.selectLectureApyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
            // 교육분야
            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            // 교육기관
            List<GroupVo> groupList = appService.selectSubGroupListAll();
            model.addAttribute("groupList", groupList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/program_view.do", method = RequestMethod.GET)
    public String youth_program_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/program_view";

        int lecture_apy_idx = ServletRequestUtils.getIntParameter(request, "lecture_apy_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if (loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/program_view.do?lecture_apy_idx=" + lecture_apy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url = "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/program_view.do?lecture_apy_idx=" + lecture_apy_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }
            // 신청 정보
            LectureApyVo lectureApyVo = lectureService.selectLectureApyInfoByIdxEx(lecture_apy_idx);
            model.addAttribute("lectureApyVo", lectureApyVo);

            LectureVo lectureVo = getLectureInfo((int)lectureApyVo.getLecture_idx());

            // 환불 사용자 전화번호 설정
            String mob_no = "";
            if("Y".equals(lectureApyVo.getRefund_apy_yn())) {
                mob_no = lectureApyVo.getRefund_mob_no();
            } else {
                mob_no = loginVo.getMoblphon();
            }
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    lectureVo.setMob_1(tokens[0]);
                    lectureVo.setMob_2(tokens[1]);
                    lectureVo.setMob_3(tokens[2]);
                }
            }

            model.addAttribute("lectureVo", lectureVo);

            // 감면정보 가져오기
            DiscountVo discountVo = null;
            if(lectureApyVo.getDiscount_idx() != 0) {
                discountVo = lectureService.selectDiscountByIdx((int)lectureApyVo.getDiscount_idx());
            }
            model.addAttribute("discountVo", discountVo);

            // 감면 대상 정보
            List<DiscountVo> discountList = new ArrayList<DiscountVo>();
            String discount_str = Util.nvl(lectureVo.getDiscount_str());
            if(!"".equals(discount_str)) {
                String[] tokens = discount_str.split(",");
                for(String token : tokens) {
                    DiscountVo discount = lectureService.selectDiscountByIdx(Integer.parseInt(token));
                    discountList.add(discount);
                }
            }
            model.addAttribute("discountList", discountList);

            // 상점아이디 가져오기
            GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());

            // 결제 관련
            String configPath = EgovProperties.getProperty("xpay.config");
            String CST_PLATFORM = EgovProperties.getProperty("xpay.platform");
            String LGD_TIMESTAMP = DateUtil.getDate(1) + DateUtil.getTime();
            String LGD_MID = groupVo.getPay_shop_id();
            String LGD_OID = "SSEM_" + LGD_TIMESTAMP;
            String LGD_AMOUNT = String.valueOf(lectureVo.getFee());
            String LGD_HASHDATA = "";
            XPayClient xpay = null;
            try {
                xpay = new XPayClient();
                xpay.Init(configPath, CST_PLATFORM);

                if("".equals(LGD_TIMESTAMP)) {
                    LGD_TIMESTAMP = xpay.GetTimeStamp();
                }
                LGD_HASHDATA = xpay.GetHashData(LGD_MID, LGD_OID, LGD_AMOUNT, LGD_TIMESTAMP);

                PayVo payVo = new PayVo();
                payVo.setLGD_OID(LGD_OID);
                payVo.setLGD_HASHDATA(LGD_HASHDATA);
                payVo.setLGD_TIMESTAMP(LGD_TIMESTAMP);

                model.addAttribute("payVo", payVo);

            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                xpay = null;
            }

            model.addAttribute("CST_PLATFORM", CST_PLATFORM);
            model.addAttribute("LGD_MID", LGD_MID);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/program_payment.do", method = RequestMethod.POST)
    public String youth_program_pay_ok(final MultipartHttpServletRequest multiRequest,
                                 @ModelAttribute("payVo") PayVo payVo,
                                 BindingResult bindingResult,
                                 Model model,
                                 SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            String configPath = EgovProperties.getProperty("xpay.config");
            String LGD_MID = payVo.getCST_MID();

            XPayClient xpay = new XPayClient();
            boolean isInitOK = xpay.Init(configPath, payVo.getCST_PLATFORM());

            if( !isInitOK ) {
                //API 초기화 실패 화면처리
                    /*out.println( "결제요청을 초기화 하는데 실패하였습니다.<br>");
                    out.println( "토스페이먼츠에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.<br>");
                    out.println( "mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.<br><br>");
                    out.println( "문의전화 토스페이먼츠 1544-7772<br>");*/
                return ret_url;

            }else{
                try{

                    // (3) Init_TX: 메모리에 mall.conf, lgdacom.conf 할당 및 트랜잭션의 고유한 키 TXID 생성
                    xpay.Init_TX(LGD_MID);
                    xpay.Set("LGD_TXNAME", "PaymentByKey");
                    xpay.Set("LGD_PAYKEY", payVo.getLGD_PAYKEY());

                    //금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
                    //String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
                    //xpay.Set("LGD_AMOUNTCHECKYN", "Y");
                    //xpay.Set("LGD_AMOUNT", DB_AMOUNT);

                }catch(Exception e) {
                        /*out.println("토스페이먼츠 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
                        out.println(""+e.getMessage());*/
                    e.printStackTrace();
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "저장에 실패하였습니다.");
                    return ret_url;
                }
            }

            if(loginVo == null) {
                xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/program_view.do?lecture_apy_idx=" + payVo.getLecture_apy_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                LectureApyVo lectureApyVo = new LectureApyVo();

                if ( xpay.TX() ) {
                    //1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
                    // (5) DB에 인증요청 결과 처리
                    if( "0000".equals( xpay.m_szResCode ) ) {
                        // 통신상의 문제가 없을시
                        // 최종결제요청 결과 성공 DB처리(LGD_RESPCODE 값에 따라 결제가 성공인지, 실패인지 DB처리)
                        //out.println("최종결제요청 성공, DB처리하시기 바랍니다.<br>");
                        //최종결제요청 결과를 DB처리합니다. (결제성공 또는 실패 모두 DB처리 가능)
                        //상점내 DB에 어떠한 이유로 처리를 하지 못한경우 false로 변경해 주세요.
                        lectureApyVo.setLecture_apy_idx(payVo.getLecture_apy_idx());
                        lectureApyVo.setPay_sucs_yn("Y");
                        lectureApyVo.setPay_sum(Integer.parseInt(xpay.Response("LGD_AMOUNT",0)));
                        lectureApyVo.setTrade_code(xpay.Response("LGD_TID",0));
                        lectureApyVo.setPay_code(payVo.getLGD_PAYKEY());
                        lectureApyVo.setUp_id(loginVo.getUser_id());
                        lectureApyVo.setDiscount_idx(payVo.getDiscount_idx());
                        lectureApyVo.setDiscount_rate(payVo.getDiscount_rate());

                        int check_sucs = lectureService.updateLectureApyPayResult(lectureApyVo);
                        if( check_sucs == 0 ) {

                            xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
                            //out.println( "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0) + "<br>");
                            //out.println( "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0) + "<p>");
                            if( "0000".equals( xpay.m_szResCode ) ) {
                                //out.println("자동취소가 정상적으로 완료 되었습니다.<br>");
                            }else{
                                //out.println("자동취소가 정상적으로 처리되지 않았습니다.<br>");
                            }
                        } else {
                            model.addAttribute("msg", "loc");
                            model.addAttribute("locurl", "/ssem/youth/mypage/program_view.do?lecture_apy_idx=" + payVo.getLecture_apy_idx());
                            ret_url = "common/message";
                        }

                    } else {
                        lectureApyVo.setPay_sucs_yn("N");
                        lectureApyVo.setUp_id(loginVo.getUser_id());
                        lectureService.updateLectureApyPayResult(lectureApyVo);
                        model.addAttribute("msg", "alterBack");
                        model.addAttribute("altmsg", "저장에 실패하였습니다.");
                        return ret_url;
                        //통신상의 문제 발생(최종결제요청 결과 실패 DB처리)
                        //out.println("최종결제요청 결과 실패, DB처리하시기 바랍니다.<br>");
                    }
                } else {
                    //2)API 요청실패 화면처리
                    /*out.println( "결제요청이 실패하였습니다.  <br>");
                    out.println( "TX 결제요청 Response_code = " + xpay.m_szResCode + "<br>");
                    out.println( "TX 결제요청 Response_msg = " + xpay.m_szResMsg + "<p>");*/
                    //최종결제요청 결과 실패 DB처리
                    /*out.println("최종결제요청 결과 실패 DB처리하시기 바랍니다.<br>");*/
                    lectureApyVo.setPay_sucs_yn("N");
                    lectureApyVo.setUp_id(loginVo.getUser_id());
                    lectureService.updateLectureApyPayResult(lectureApyVo);
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "저장에 실패하였습니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/program_payment_cancel.do", method = RequestMethod.POST)
    public String youth_program_pay_cancel(final MultipartHttpServletRequest multiRequest,
                                 @ModelAttribute("payVo") PayVo payVo,
                                 BindingResult bindingResult,
                                 Model model,
                                 SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            String configPath = EgovProperties.getProperty("xpay.config");
            String LGD_MID = payVo.getCST_MID();

            XPayClient xpay = new XPayClient();
            boolean isInitOK = xpay.Init(configPath, payVo.getCST_PLATFORM());

            if( !isInitOK ) {
                return ret_url;
            }else{
                try{
                    // (3) Init_TX: 메모리에 mall.conf, lgdacom.conf 할당 및 트랜잭션의 고유한 키 TXID 생성
                    xpay.Init_TX(LGD_MID);
                    xpay.Set("LGD_TXNAME", "Cancel");
                    xpay.Set("LGD_TID", payVo.getLGD_TID());

                    //금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
                    //String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
                    //xpay.Set("LGD_AMOUNTCHECKYN", "Y");
                    //xpay.Set("LGD_AMOUNT", DB_AMOUNT);

                } catch(Exception e) {
                        /*out.println("토스페이먼츠 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
                        out.println(""+e.getMessage());*/
                    e.printStackTrace();
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "결제 취소에 실패하였습니다.");
                    return ret_url;
                }
            }

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/program_view.do?lecture_apy_idx=" + payVo.getLecture_apy_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                if ( xpay.TX() ) {
                    LectureApyVo lectureApyVo = new LectureApyVo();
                    lectureApyVo.setLecture_apy_idx(payVo.getLecture_apy_idx());
                    lectureApyVo.setUp_id(loginVo.getUser_id());
                    lectureApyVo.setPay_status("3");
                    // 결제 취소시 신청취소와 동일하게 처리함
                    int check_sucs = lectureService.updateLectureApyPayCancel(lectureApyVo);
                    if( check_sucs == 0 ) {
                        model.addAttribute("msg", "alterBack");
                        model.addAttribute("altmsg", "결제취소에 실패하였습니다.");
                        return ret_url;
                    } else {
                        // 신청 취소시 수량 관련 업데이트 (+1)
                        lectureService.updateOnlineCanQtyPlusByIdx(payVo.getLecture_idx());

                        model.addAttribute("msg", "alterloc");
                        model.addAttribute("locurl", "/ssem/youth/mypage/program_view.do?lecture_apy_idx=" + payVo.getLecture_apy_idx());
                        model.addAttribute("altmsg", "결제 취소되었습니다.");
                        return "common/message";
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "결제취소에 실패하였습니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "결제취소에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/program_apy_cancel.do", method = RequestMethod.POST)
    public String youth_program_apy_cancel(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("payVo") PayVo payVo,
                                     BindingResult bindingResult,
                                     Model model,
                                     SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/program_view.do?lecture_apy_idx=" + payVo.getLecture_apy_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {

                LectureVo lectureVo = lectureService.selectLecureInfoByIdx(payVo.getLecture_idx());
                LectureApyVo lectureApyVo = lectureService.selectLectureApyInfoByIdxEx((int)payVo.getLecture_apy_idx());
                // 무료 프로그램인시 수강생 정보 삭제
                // 데이터 삭제
                // 1. 수강한 강의가 남아 있는 경우 해당 프로그램 이력만 삭제
                // 2. 수강한 강의가 없는 경우 수강생 데이터도 삭제
                if("F".equals(lectureVo.getFee_type())) {
                    StudentVo studentVo = new StudentVo();
                    if (lectureApyVo.getApy_ref() == null || "".equals(lectureApyVo.getApy_ref())) {
                        studentVo.setUser_id(lectureApyVo.getApy_id());
                        // 본인신청
                        int count = lectureService.selectStudentLectCheckByID(studentVo);
                        StudentVo delete_student = lectureService.selectStudentInfoByID(lectureApyVo.getApy_id());

                        delete_student.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                        StudentLectVo delete_lect = lectureService.selectStudentLectInfo(delete_student);

                        if (count == 1) {
                            lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                            lectureService.deleteStudentInfoByIdx(delete_student.getStudent_idx());
                        } else {
                            lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                        }
                    } else {
                        studentVo.setName(lectureApyVo.getApy_real_name());
                        studentVo.setMob_no(lectureApyVo.getApy_ref_mob_no());
                        // 대리신청
                        int count = lectureService.selectStudentLectCheck(studentVo);
                        StudentVo delete_student = lectureService.selectStudentInfoByID(lectureApyVo.getApy_id());
                        delete_student.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                        StudentLectVo delete_lect = lectureService.selectStudentLectInfo(delete_student);
                        if (count == 1) {
                            lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                            lectureService.deleteStudentInfoByIdx(delete_student.getStudent_idx());
                        } else {
                            lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                        }
                    }
                }

                // 결제 취소시 신청취소와 동일하게 처리함
                int check_sucs = lectureService.updateLectureApyCancelByIdx(payVo.getLecture_apy_idx());
                if( check_sucs == 0 ) {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "신청취소에 실패하였습니다.");
                    return ret_url;
                } else {
                    // 신청 취소시 수량 관련 업데이트 (+1)
                    lectureService.updateOnlineCanQtyPlusByIdx(payVo.getLecture_idx());

                    // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    if("yes".equals(EgovProperties.getProperty("msg.send"))) {
                        GroupVo groupVo = lectureService.selectGroupInfoByIdx((int) lectureVo.getGroup_idx());

                        StringBuffer sb = new StringBuffer();
                        sb.append("[송파구청 송파쌤(SSEM)]");
                        sb.append("\r\n");
                        sb.append(String.format("%s님의 프로그램 신청이 취소되었습니다.", lectureApyVo.getApy_name()));
                        sb.append("\r\n");
                        sb.append("<취소내역>");
                        sb.append("\r\n");
                        sb.append(String.format("- 프로그램: %s", lectureVo.getName()));
                        sb.append("\r\n");
                        sb.append("감사합니다.");
                        sb.append("\r\n");
                        sb.append(String.format("☎ 문의: %s", groupVo.getTel_no()));
                        sb.append("\r\n");
                        sb.append(String.format("송파쌤(SSEM) %s", groupVo.getName()));

                        msgService.sendMsgKakao("신청취소 안내", sb.toString(), lectureApyVo.getApy_name(), lectureApyVo.getApy_mob_no().replaceAll("-", ""), "10206");
                    }
                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssem/youth/mypage/program_view.do?lecture_apy_idx=" + payVo.getLecture_apy_idx());
                    model.addAttribute("altmsg", "신청 취소되었습니다.");
                    return "common/message";
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "신청취소에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/program_apy_refund.do", method = RequestMethod.POST)
    public String youth_program_apy_refund(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("lectureApyVo") LectureApyVo lectureApyVo,
                                     BindingResult bindingResult,
                                     Model model,
                                     SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/program_view.do?lecture_apy_idx=" + lectureApyVo.getLecture_apy_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                lectureService.updateLectureApyRefund(lectureApyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/program_view.do?lecture_apy_idx=" + lectureApyVo.getLecture_apy_idx());
                model.addAttribute("altmsg", "환불신청이 되었습니다.");
                return "common/message";
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "환불신청에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/attend_list.do")
    public String youth_attend_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/attend_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/pwd_confirm.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/attend_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }
            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // 마이페이지

            List<LectureApyVo> itemList = lectureService.selectLectureHistoryList(searchVo);
            for(LectureApyVo lectureApyVo : itemList) {
                LectureVo lectureVo = new LectureVo();
                lectureVo.setLecture_idx(lectureApyVo.getLecture_idx());

                lectureVo = lectureService.selectLectureInfo(lectureVo);

                // 교육분야 가져오기
                String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
                lectureVo.setPart_name(part_name);

                // 교육기관 정보
                GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
                lectureVo.setGroup(groupVo);

                // 프로그램 상태 체크
                // 1. 접수대기 : 접수날짜 도래 하지 않음
                // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                // 5. 교육전 :
                // 6. 교육중 : 교육날짜 내
                // 7. 교육종료 : 교육날짜 지남
                // 8. 외부홈페이지 : 외부 홈페이지일 경우
                int code = Util.getProgramStatus(lectureVo);
                lectureVo.setStatus_code(code);

                lectureApyVo.setLectureVo(lectureVo);
            }
            int totalCount = lectureService.selectLectureHistoryListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 교육분야
            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            // 교육기관
            List<GroupVo> groupList = appService.selectSubGroupListAll();
            model.addAttribute("groupList", groupList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/attend_view.do", method = RequestMethod.GET)
    public String youth_attend_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/attend_view";

        int lecture_apy_idx = ServletRequestUtils.getIntParameter(request, "lecture_apy_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if (loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/attend_view.do?lecture_apy_idx=" + lecture_apy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url = "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/attend_view.do?lecture_apy_idx="  + lecture_apy_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            // 신청 정보
            LectureApyVo lectureApyVo = lectureService.selectLectureApyInfoByIdxEx(lecture_apy_idx);
            model.addAttribute("lectureApyVo", lectureApyVo);

            LectureVo lectureVo = getLectureInfo((int)lectureApyVo.getLecture_idx());

            // 교육기관 정보
            GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
            lectureVo.setGroup(groupVo);

            // 교육분야 가져오기
            String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
            lectureVo.setPart_name(part_name);

            // 프로그램 상태 체크
            // 1. 접수대기 : 접수날짜 도래 하지 않음
            // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
            // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
            // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
            // 5. 교육전 :
            // 6. 교육중 : 교육날짜 내
            // 7. 교육종료 : 교육날짜 지남
            // 8. 외부홈페이지 : 외부 홈페이지일 경우
            int code = Util.getProgramStatus(lectureVo);
            lectureVo.setStatus_code(code);

            // 교육 장소 정보
            StudyPlaceVo place = lectureService.selectStudyPlaceByIdx(lectureVo.getStudy_place_idx());
            lectureVo.setPlace(place);

            // 교육시간
            String dt_str = "";
            String dt_type = lectureVo.getDt_type();
            if("W".equals(dt_type)) {
                dt_str += "매주 ";
            } else if("T".equals(dt_type)) {
                dt_str += "격주 ";
            } else if("Z".equals(dt_type)) {
                dt_str += "기타 ";
            }

            String[] weeks = lectureVo.getDt_week().split(",");
            for(String week : weeks) {
                if("1".equals(week)) {
                    dt_str += "월, ";
                } else if("2".equals(week)) {
                    dt_str += "화, ";
                } else if("3".equals(week)) {
                    dt_str += "수, ";
                } else if("4".equals(week)) {
                    dt_str += "목, ";
                } else if("5".equals(week)) {
                    dt_str += "금, ";
                } else if("6".equals(week)) {
                    dt_str += "토, ";
                } else if("7".equals(week)) {
                    dt_str += "일, ";
                }
            }
            lectureVo.setDt_str(StringUtil.deleteLastStr(dt_str.trim(), ','));

            model.addAttribute("lectureVo", lectureVo);

            // 감면정보 가져오기
            DiscountVo discountVo = null;
            if(lectureApyVo.getDiscount_idx() != 0) {
                discountVo = lectureService.selectDiscountByIdx((int)lectureApyVo.getDiscount_idx());
            }
            model.addAttribute("discountVo", discountVo);
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/teacher_love_list.do")
    public String youth_teacher_love_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/teacher_love_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/pwd_confirm.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/teacher_love_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }
            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // 마이페이지

            List<LectureApyVo> itemList = lectureService.selectLectureHistoryList(searchVo);
            for(LectureApyVo lectureApyVo : itemList) {
                LectureVo lectureVo = new LectureVo();
                lectureVo.setLecture_idx(lectureApyVo.getLecture_idx());

                lectureVo = lectureService.selectLectureInfo(lectureVo);

                // 교육분야 가져오기
                String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
                lectureVo.setPart_name(part_name);

                // 교육기관 정보
                GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
                lectureVo.setGroup(groupVo);

                // 프로그램 상태 체크
                // 1. 접수대기 : 접수날짜 도래 하지 않음
                // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                // 5. 교육전 :
                // 6. 교육중 : 교육날짜 내
                // 7. 교육종료 : 교육날짜 지남
                // 8. 외부홈페이지 : 외부 홈페이지일 경우
                int code = Util.getProgramStatus(lectureVo);
                lectureVo.setStatus_code(code);

                lectureApyVo.setLectureVo(lectureVo);
            }
            int totalCount = lectureService.selectLectureHistoryListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 교육분야
            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            // 교육기관
            List<GroupVo> groupList = appService.selectSubGroupListAll();
            model.addAttribute("groupList", groupList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/teacher_love_view.do", method = RequestMethod.GET)
    public String youth_teacher_love_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/teacher_love_view";

        int lecture_apy_idx = ServletRequestUtils.getIntParameter(request, "lecture_apy_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if (loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/teacher_love_view.do?lecture_apy_idx=" + lecture_apy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url = "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/teacher_love_view.do?lecture_apy_idx=" + lecture_apy_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }
            // 신청 정보
            LectureApyVo lectureApyVo = lectureService.selectLectureApyInfoByIdxEx(lecture_apy_idx);
            model.addAttribute("lectureApyVo", lectureApyVo);

            LectureVo lectureVo = getLectureInfo((int)lectureApyVo.getLecture_idx());

            // 교육기관 정보
            GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
            lectureVo.setGroup(groupVo);

            // 교육분야 가져오기
            String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
            lectureVo.setPart_name(part_name);

            // 프로그램 상태 체크
            // 1. 접수대기 : 접수날짜 도래 하지 않음
            // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
            // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
            // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
            // 5. 교육전 :
            // 6. 교육중 : 교육날짜 내
            // 7. 교육종료 : 교육날짜 지남
            // 8. 외부홈페이지 : 외부 홈페이지일 경우
            int code = Util.getProgramStatus(lectureVo);
            lectureVo.setStatus_code(code);

            // 교육 장소 정보
            StudyPlaceVo place = lectureService.selectStudyPlaceByIdx(lectureVo.getStudy_place_idx());
            lectureVo.setPlace(place);

            // 교육시간
            String dt_str = "";
            String dt_type = lectureVo.getDt_type();
            if("W".equals(dt_type)) {
                dt_str += "매주 ";
            } else if("T".equals(dt_type)) {
                dt_str += "격주 ";
            } else if("Z".equals(dt_type)) {
                dt_str += "기타 ";
            }

            String[] weeks = lectureVo.getDt_week().split(",");
            for(String week : weeks) {
                if("1".equals(week)) {
                    dt_str += "월, ";
                } else if("2".equals(week)) {
                    dt_str += "화, ";
                } else if("3".equals(week)) {
                    dt_str += "수, ";
                } else if("4".equals(week)) {
                    dt_str += "목, ";
                } else if("5".equals(week)) {
                    dt_str += "금, ";
                } else if("6".equals(week)) {
                    dt_str += "토, ";
                } else if("7".equals(week)) {
                    dt_str += "일, ";
                }
            }
            lectureVo.setDt_str(StringUtil.deleteLastStr(dt_str.trim(), ','));

            model.addAttribute("lectureVo", lectureVo);

            // 감면정보 가져오기
            DiscountVo discountVo = null;
            if(lectureApyVo.getDiscount_idx() != 0) {
                discountVo = lectureService.selectDiscountByIdx((int)lectureApyVo.getDiscount_idx());
            }
            model.addAttribute("discountVo", discountVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/teacher_love_view.do", method = RequestMethod.POST)
    public String youth_teacher_love_view_proc(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("lectureVo") LectureVo lectureVo,
                                    BindingResult bindingResult,
                                    Model model,
                                    SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : hopeStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(hopeStudyVo);
                if(value instanceof String){
                    field.set(hopeStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                lectureVo.setReg_id(loginVo.getUser_id());

                lectureService.insertTeacherLoveInfo(lectureVo);

                // 강사만족도 평가 여부 업데이트
                lectureService.updateLectureApyTeacherLoveByIdx(lectureVo.getLecture_apy_idx());

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/teacher_love_view_ok.do?lecture_apy_idx=" + lectureVo.getLecture_apy_idx());
                model.addAttribute("altmsg", "강사 만족도를 평가해 주셔서 감사합니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "강사 만족도 평가에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/teacher_love_view_ok.do", method = RequestMethod.GET)
    public String youth_teacher_love_view_ok(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/teacher_love_view_ok";

        int lecture_apy_idx = ServletRequestUtils.getIntParameter(request, "lecture_apy_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if (loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/teacher_love_view_ok.do?lecture_apy_idx=" + lecture_apy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url = "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/teacher_love_view_ok.do?lecture_apy_idx=" + lecture_apy_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            // 신청 정보
            LectureApyVo lectureApyVo = lectureService.selectLectureApyInfoByIdxEx(lecture_apy_idx);
            model.addAttribute("lectureApyVo", lectureApyVo);

            LectureVo lectureVo = getLectureInfo((int)lectureApyVo.getLecture_idx());

            // 교육기관 정보
            GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
            lectureVo.setGroup(groupVo);

            // 교육분야 가져오기
            String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
            lectureVo.setPart_name(part_name);

            // 프로그램 상태 체크
            // 1. 접수대기 : 접수날짜 도래 하지 않음
            // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
            // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
            // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
            // 5. 교육전 :
            // 6. 교육중 : 교육날짜 내
            // 7. 교육종료 : 교육날짜 지남
            // 8. 외부홈페이지 : 외부 홈페이지일 경우
            int code = Util.getProgramStatus(lectureVo);
            lectureVo.setStatus_code(code);

            // 교육 장소 정보
            StudyPlaceVo place = lectureService.selectStudyPlaceByIdx(lectureVo.getStudy_place_idx());
            lectureVo.setPlace(place);

            // 교육시간
            String dt_str = "";
            String dt_type = lectureVo.getDt_type();
            if("W".equals(dt_type)) {
                dt_str += "매주 ";
            } else if("T".equals(dt_type)) {
                dt_str += "격주 ";
            } else if("Z".equals(dt_type)) {
                dt_str += "기타 ";
            }

            String[] weeks = lectureVo.getDt_week().split(",");
            for(String week : weeks) {
                if("1".equals(week)) {
                    dt_str += "월, ";
                } else if("2".equals(week)) {
                    dt_str += "화, ";
                } else if("3".equals(week)) {
                    dt_str += "수, ";
                } else if("4".equals(week)) {
                    dt_str += "목, ";
                } else if("5".equals(week)) {
                    dt_str += "금, ";
                } else if("6".equals(week)) {
                    dt_str += "토, ";
                } else if("7".equals(week)) {
                    dt_str += "일, ";
                }
            }
            lectureVo.setDt_str(StringUtil.deleteLastStr(dt_str.trim(), ','));

            model.addAttribute("lectureVo", lectureVo);

            // 감면정보 가져오기
            DiscountVo discountVo = null;
            if(lectureApyVo.getDiscount_idx() != 0) {
                discountVo = lectureService.selectDiscountByIdx((int)lectureApyVo.getDiscount_idx());
            }
            model.addAttribute("discountVo", discountVo);

            // 강사 만족도 정보
            TeacherSatisfactionVo teacherSatisfactionVo = new TeacherSatisfactionVo();
            teacherSatisfactionVo.setLecture_idx(lectureVo.getLecture_idx());
            teacherSatisfactionVo.setReg_id(loginVo.getUser_id());
            teacherSatisfactionVo.setTeacher_idx(lectureVo.getTeacher_idx());

            teacherSatisfactionVo = lectureService.selectTeacherLove(teacherSatisfactionVo);
            // score => 0 : 평가 없음
            // score => 1 : 금
            // score => 2 : 은
            // score => 3 : 동
            TeacherVo teacher = new TeacherVo();
            teacher.setLecture_idx(lectureVo.getLecture_idx());
            teacher.setTeacher_idx(lectureVo.getTeacher_idx());

            int score = 0;
            int total_cnt = lectureService.selectTeacherScoreTotalCnt(teacher);
            if(total_cnt != 0) {
                int total_score = lectureService.selectTeacherScoreTotal(teacher);
                score = Util.getTeacherScore(total_cnt, total_score);
            } else {
                score = 0;
            }
            teacherSatisfactionVo.setAvg_score(score);

            model.addAttribute("teacherSatisfactionVo", teacherSatisfactionVo);
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/teacher_history_list.do")
    public String youth_teacher_hisotry_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/teacher_history_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/pwd_confirm.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/teacher_history_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }
            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // 마이페이지

            List<LectureVo> itemList = lectureService.selectLectureTeachHistoryList(searchVo);
            for(LectureVo lectureVo : itemList) {
                // 프로그램 상태 체크
                // 1. 접수대기 : 접수날짜 도래 하지 않음
                // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                // 5. 교육전 :
                // 6. 교육중 : 교육날짜 내
                // 7. 교육종료 : 교육날짜 지남
                // 8. 외부홈페이지 : 외부 홈페이지일 경우
                int code = Util.getProgramStatus(lectureVo);
                lectureVo.setStatus_code(code);
            }
            int totalCount = lectureService.selectLectureTeachHistoryListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 교육기관
            List<GroupVo> groupList = appService.selectSubGroupListAll();
            model.addAttribute("groupList", groupList);
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/hope_study_list.do")
    public String youth_hope_study_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/hope_study_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/hope_study_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/hope_study_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // gubun 값

            List<HopeStudyVo> itemList = magnetService.selectHopeStudyList(searchVo);
            for(HopeStudyVo hopeStudyVo : itemList) {
                String apy_name = hopeStudyVo.getApy_name();
                apy_name = StringUtil.maskName(apy_name);
                hopeStudyVo.setApy_name(apy_name);

                if(DateUtil.calDates(hopeStudyVo.getClose_dt(), DateUtil.getDate(3)) < 0) {
                    hopeStudyVo.setClose_yn("Y");
                }

                // 함께해요 리스트 개수
                int join_cnt = magnetService.selectJoinStudyCountByIdx(hopeStudyVo.getHope_study_idx());
                hopeStudyVo.setJoin_cnt(join_cnt);
            }
            int totalCount = magnetService.selectHopeStudyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/hope_study_insert.do", method = RequestMethod.GET)
    public String youth_hope_study_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/hope_study_insert";

        int hope_study_idx = ServletRequestUtils.getIntParameter(request, "hope_study_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/hope_study_insert.do?hope_study_idx=" + hope_study_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/hope_study_insert.do?hope_study_idx=" + hope_study_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            HopeStudyVo hopeStudyVo = new HopeStudyVo();
            hopeStudyVo.setHope_study_idx(hope_study_idx);

            magnetService.updateHopeStudyViewCnt(hopeStudyVo);
            hopeStudyVo = magnetService.selectHopeStudyInfo(hopeStudyVo);

            String apy_name = hopeStudyVo.getApy_name();
            apy_name = StringUtil.maskName(apy_name);
            hopeStudyVo.setApy_name(apy_name);

            if (DateUtil.calDates(hopeStudyVo.getClose_dt(), DateUtil.getDate(3)) < 0) {
                hopeStudyVo.setClose_yn("Y");
            }

            String mob_no = hopeStudyVo.getApy_mob_no();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    hopeStudyVo.setMob_1(tokens[0]);
                    hopeStudyVo.setMob_2(tokens[1]);
                    hopeStudyVo.setMob_3(tokens[2]);
                }
            }

            // 배우고 싶어요 신청 회원 목록
            List<JoinStudyVo> joinList = magnetService.selectJoinListByIdx(hope_study_idx);
            for(JoinStudyVo joinStudyVo : joinList) {
                String apy_id = StringUtil.maskUserId(joinStudyVo.getApy_id());
                joinStudyVo.setApy_id(apy_id);
            }

            model.addAttribute("hopeStudyVo", hopeStudyVo);
            model.addAttribute("joinList", joinList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/hope_study_insert.do", method = RequestMethod.POST)
    public String youth_hope_study_inproc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("hopeStudyVo") HopeStudyVo hopeStudyVo,
                                        BindingResult bindingResult,
                                        Model model,
                                        SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : hopeStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(hopeStudyVo);
                if(value instanceof String){
                    field.set(hopeStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                hopeStudyVo.setUp_id(loginVo.getUser_id());

                magnetService.updateHopeStudyInfo(hopeStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/hope_study_list.do");
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

    @RequestMapping(value = "/youth/mypage/hope_study_cancel.do", method = RequestMethod.POST)
    public String youth_hope_study_cancel(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("hopeStudyVo") HopeStudyVo hopeStudyVo,
                                        BindingResult bindingResult,
                                        Model model,
                                        SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : hopeStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(hopeStudyVo);
                if(value instanceof String){
                    field.set(hopeStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                hopeStudyVo.setUp_id(loginVo.getUser_id());
                hopeStudyVo.setUse_yn("N");

                magnetService.updateHopeStudyCancel(hopeStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/hope_study_list.do");
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

    @RequestMapping("/youth/mypage/teach_apply_list.do")
    public String youth_teach_apply_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/teach_apply_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/teach_apply_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/teach_apply_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return  "common/message";
            }

            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // gubun 값

            List<TeachStudyVo> itemList = magnetService.selectTeachStudyList(searchVo);
            for(TeachStudyVo teachStudyVo : itemList) {
                if (DateUtil.calDates(teachStudyVo.getStudy_end_dt(), DateUtil.getDate(3)) < 0) {
                    teachStudyVo.setClose_yn("Y");
                }
            }
            int totalCount = magnetService.selectTeachStudyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/teach_apply_insert.do", method = RequestMethod.GET)
    public String youth_teach_apply_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/teach_apply_insert";

        int teach_study_idx = ServletRequestUtils.getIntParameter(request, "teach_study_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/teach_apply_insert.do?teach_study_idx=" + teach_study_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/teach_apply_insert.do?teach_study_idx=" + teach_study_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            TeachStudyVo teachStudyVo = new TeachStudyVo();
            teachStudyVo.setTeach_study_idx(teach_study_idx);

            teachStudyVo = magnetService.selectTeachStudyInfo(teachStudyVo);

            HopeStudyVo hopeStudyVo = magnetService.selectHopeStudyByIdx(teachStudyVo.getHope_study_idx());

            if (DateUtil.calDates(hopeStudyVo.getClose_dt(), DateUtil.getDate(3)) < 0) {
                hopeStudyVo.setClose_yn("Y");
            }

            String mob_no = teachStudyVo.getApy_mob_no();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    teachStudyVo.setMob_1(tokens[0]);
                    teachStudyVo.setMob_2(tokens[1]);
                    teachStudyVo.setMob_3(tokens[2]);
                }
            }

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

            // 상세내용 엔터처리
            String cont = hopeStudyVo.getCont();
            if(!"".equals(Util.nvl(cont))) {
                cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
                hopeStudyVo.setCont(cont);
            }

            // 배우고 싶어요 신청 회원 목록
            int join_cnt = magnetService.selectJoinStudyCountByIdx(teachStudyVo.getHope_study_idx());
            hopeStudyVo.setJoin_cnt(join_cnt);

            // 교육분야
            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            model.addAttribute("hopeStudyVo", hopeStudyVo);
            model.addAttribute("teachStudyVo", teachStudyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/teach_apply_insert.do", method = RequestMethod.POST)
    public String youth_teach_apply_inproc(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("teachStudyVo") TeachStudyVo teachStudyVo,
                                    BindingResult bindingResult,
                                    Model model,
                                    SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : teachStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(teachStudyVo);
                if(value instanceof String){
                    field.set(teachStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                teachStudyVo.setUp_id(loginVo.getUser_id());

                // 강의 계획서 파일 처리
                CommonVo cmm = this.getAttachFileInfoEx(multiRequest, "teach_atch_file_id");
                if(cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(teachStudyVo.getTeach_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if (chkList.size() > 0) {
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "TS_", cnt, teachStudyVo.getTeach_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        } else {
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "TS_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            teachStudyVo.setTeach_atch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(teachStudyVo.getTeach_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            teachStudyVo.setTeach_atch_file_id("");
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 강사이력 계획서 파일 처리
                CommonVo career_cmm = this.getAttachFileInfoEx(multiRequest, "career_atch_file_id");
                if(career_cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (career_cmm.getChkcnt() > 0) {

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(teachStudyVo.getCareer_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if (chkList.size() > 0) {
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(career_cmm.getTmpfiles(), "TS_", cnt, teachStudyVo.getCareer_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        } else {
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(career_cmm.getTmpfiles(), "TS_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            teachStudyVo.setCareer_atch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(teachStudyVo.getCareer_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            teachStudyVo.setCareer_atch_file_id("");
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                magnetService.updateTeachStudyInfo(teachStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/teach_apply_list.do");
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

    @RequestMapping(value = "/youth/mypage/teach_apply_cancel.do", method = RequestMethod.POST)
    public String youth_teach_apply_cancel(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("teachStudyVo") TeachStudyVo teachStudyVo,
                                    BindingResult bindingResult,
                                    Model model,
                                    SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : teachStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(teachStudyVo);
                if(value instanceof String){
                    field.set(teachStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                teachStudyVo.setUp_id(loginVo.getUser_id());
                teachStudyVo.setUse_yn("N");

                magnetService.updateTeachStudyCancel(teachStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/teach_apply_list.do");
                model.addAttribute("altmsg", "가르칠 수 있어요 신청이 취소되었습니다.");

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "신청 취소에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/together_study_list.do")
    public String youth_together_study_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/together_study_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/together_study_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/together_study_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return  "common/message";
            }

            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // gubun 값

            List<JoinStudyVo> itemList = magnetService.selectJoinStudyList(searchVo);
            for(JoinStudyVo JoinStudyVo : itemList) {
                HopeStudyVo hopeStudyVo = magnetService.selectHopeStudyByIdx(JoinStudyVo.getHope_study_idx());

                String apy_name = hopeStudyVo.getApy_name();
                apy_name = StringUtil.maskName(apy_name);
                hopeStudyVo.setApy_name(apy_name);

                if(DateUtil.calDates(hopeStudyVo.getClose_dt(), DateUtil.getDate(3)) < 0) {
                    hopeStudyVo.setClose_yn("Y");
                }

                // 함께해요 리스트 개수
                int join_cnt = magnetService.selectJoinStudyCountByIdx(hopeStudyVo.getHope_study_idx());
                hopeStudyVo.setJoin_cnt(join_cnt);

                JoinStudyVo.setHopeStudyVo(hopeStudyVo);
            }
            int totalCount = magnetService.selectJoinStudyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/together_study_insert.do", method = RequestMethod.GET)
    public String youth_together_study_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/together_study_insert";

        int join_study_idx = ServletRequestUtils.getIntParameter(request, "join_study_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/together_study_insert.do?join_study_idx=" + join_study_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/together_study_insert.do?join_study_idx=" + join_study_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            JoinStudyVo joinStudyVo = new JoinStudyVo();
            joinStudyVo.setJoin_study_idx(join_study_idx);

            joinStudyVo = magnetService.selectJoinStudyInfo(joinStudyVo);

            HopeStudyVo hopeStudyVo = new HopeStudyVo();
            hopeStudyVo.setHope_study_idx(joinStudyVo.getHope_study_idx());

            hopeStudyVo = magnetService.selectHopeStudyInfo(hopeStudyVo);

            String mob_no = joinStudyVo.getApy_mob_no();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    joinStudyVo.setMob_1(tokens[0]);
                    joinStudyVo.setMob_2(tokens[1]);
                    joinStudyVo.setMob_3(tokens[2]);
                }
            }

            // 배우고 싶어요 신청 회원 목록
            int join_cnt = magnetService.selectJoinStudyCountByIdx(joinStudyVo.getHope_study_idx());
            hopeStudyVo.setJoin_cnt(join_cnt);

            joinStudyVo.setHopeStudyVo(hopeStudyVo);

            model.addAttribute("joinStudyVo", joinStudyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/together_study_insert.do", method = RequestMethod.POST)
    public String youth_together_study_inproc(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("hopeStudyVo") JoinStudyVo joinStudyVo,
                                    BindingResult bindingResult,
                                    Model model,
                                    SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : joinStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(joinStudyVo);
                if(value instanceof String){
                    field.set(joinStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                joinStudyVo.setUp_id(loginVo.getUser_id());

                magnetService.updateJoinStudyInfo(joinStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/together_study_list.do");
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

    @RequestMapping(value = "/youth/mypage/together_study_cancel.do", method = RequestMethod.POST)
    public String youth_together_study_cancel(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("hopeStudyVo") JoinStudyVo joinStudyVo,
                                        BindingResult bindingResult,
                                        Model model,
                                        SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : joinStudyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(joinStudyVo);
                if(value instanceof String){
                    field.set(joinStudyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                magnetService.deleteJoinStudyInfo(joinStudyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/together_study_list.do");
                model.addAttribute("altmsg", "함께배워요 참여가 취소되었습니다..");
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "참여 취소에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/person_book_list.do")
    public String youth_person_book_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/person_book_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/person_book_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/person_book_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // gubun 값

            List<PersonBookApyVo> itemList = campusService.selectPersonBookApyList(searchVo);
            int totalCount = campusService.selectPersonBookApyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/person_book_insert.do", method = RequestMethod.GET)
    public String youth_person_book_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/person_book_insert";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int person_book_apy_idx = ServletRequestUtils.getIntParameter(request, "person_book_apy_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/person_book_insert.do?person_book_apy_idx=" + person_book_apy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/person_book_insert.do?person_book_apy_idx=" + person_book_apy_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            PersonBookApyVo personBookApyVo = new PersonBookApyVo();
            personBookApyVo.setPerson_book_apy_idx(person_book_apy_idx);

            campusService.updatePersonBookApplyViewCnt(personBookApyVo);
            personBookApyVo = campusService.selectPersonBookApplyInfo(personBookApyVo);

            // 해킹 처리
            if(!personBookApyVo.getReg_id().equals(loginVo.getUser_id())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/person_book_list.do");
                model.addAttribute("altmsg", "잘못된 접근입니다.<br/>계속적인 시도 시 사용에 제약이 있을 수 있습니다.");
                ret_url =  "common/message";
            }

            String mob_no = personBookApyVo.getApy_mob_no();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    personBookApyVo.setMob_1(tokens[0]);
                    personBookApyVo.setMob_2(tokens[1]);
                    personBookApyVo.setMob_3(tokens[2]);
                }
            }

            // 주소 분리
            String postcode = StringUtil.getPostCode(personBookApyVo.getPlc());
            String addr = StringUtil.getAddr(personBookApyVo.getPlc(), postcode);

            personBookApyVo.setPostcode(postcode);
            personBookApyVo.setAddr(addr);

            model.addAttribute("personBookApyVo", personBookApyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/person_book_insert.do", method = RequestMethod.POST)
    public String youth_person_book_inproc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("personBookApyVo") PersonBookApyVo personBookApyVo,
                                         BindingResult bindingResult,
                                         Model model,
                                         SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : personBookApyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(personBookApyVo);
                if(value instanceof String){
                    field.set(personBookApyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                personBookApyVo.setUp_id(loginVo.getUser_id());

                campusService.updatePersonBookApyInfo(personBookApyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/person_book_list.do");
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

    @RequestMapping(value = "/youth/mypage/person_book_cancel.do", method = RequestMethod.POST)
    public String youth_person_book_cancel(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("personBookApyVo") PersonBookApyVo personBookApyVo,
                                         BindingResult bindingResult,
                                         Model model,
                                         SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : personBookApyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(personBookApyVo);
                if(value instanceof String){
                    field.set(personBookApyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                personBookApyVo.setUp_id(loginVo.getUser_id());

                campusService.updatePersonBookApyInfoCancel(personBookApyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/person_book_list.do");
                model.addAttribute("altmsg", "인물도서 열람신청이 취소되었습니다.");

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "취소에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/person_reg_list.do")
    public String youth_person_reg_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/person_reg_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/person_reg_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/person_reg_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // gubun 값

            List<PersonBookRegVo> itemList = campusService.selectPersonBookRegList(searchVo);
            int totalCount = campusService.selectPersonBookRegListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/person_reg_insert.do", method = RequestMethod.GET)
    public String youth_person_reg_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/person_reg_insert";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int person_book_reg_idx = ServletRequestUtils.getIntParameter(request, "person_book_reg_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/person_reg_insert.do?person_book_reg_idx=" + person_book_reg_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/person_reg_insert.do?person_book_reg_idx=" + person_book_reg_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            PersonBookRegVo personBookRegVo = new PersonBookRegVo();
            personBookRegVo.setPerson_book_reg_idx(person_book_reg_idx);

            personBookRegVo = campusService.selectPersonBookRegInfo(personBookRegVo);

            // 해킹 처리
            if(!personBookRegVo.getReg_id().equals(loginVo.getUser_id())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/person_reg_list.do");
                model.addAttribute("altmsg", "잘못된 접근입니다.<br/>계속적인 시도 시 사용에 제약이 있을 수 있습니다.");
                ret_url =  "common/message";
            }

            // 사진 파일
            // 첨부파일 처리
            String atchFileId = personBookRegVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            personBookRegVo.setFileList(fileVoList);

            // 후대폰 번호
            String mob_no = personBookRegVo.getReg_mob_no();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    personBookRegVo.setMob_1(tokens[0]);
                    personBookRegVo.setMob_2(tokens[1]);
                    personBookRegVo.setMob_3(tokens[2]);
                }
            }

            // 전화번호
            String tel_no = personBookRegVo.getReg_tel_no();
            if(!"".equals(tel_no) && tel_no != null) {
                String[] tokens = tel_no.split("-");
                personBookRegVo.setTel_1(tokens[0]);
                personBookRegVo.setTel_2(tokens[1]);
                personBookRegVo.setTel_3(tokens[2]);
            }

            // 주소 분리
            String postcode = StringUtil.getPostCode(personBookRegVo.getReg_addr());
            String addr = StringUtil.getAddr(personBookRegVo.getReg_addr(), postcode);

            personBookRegVo.setPostcode(postcode);
            personBookRegVo.setAddr(addr);

            // 대표경력
            String career = personBookRegVo.getCareer();
            career = career.replaceAll("<br/>", System.getProperty("line.separator"));
            personBookRegVo.setCareer(career);

            // 소개글
            String intro = personBookRegVo.getIntro();
            intro = intro.replaceAll("<br/>", System.getProperty("line.separator"));
            personBookRegVo.setIntro(intro);

            // 이메일 분리
            String email = personBookRegVo.getReg_email();
            if(!"".equals(email)) {
                String[] tokens = email.split("@");
                String email_id = tokens[0];
                String email_domain = tokens[1];

                personBookRegVo.setEmail_id(email_id);
                personBookRegVo.setEmail_domain(email_domain);
            }

            model.addAttribute("personBookRegVo", personBookRegVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/person_reg_insert.do", method = RequestMethod.POST)
    public String youth_person_reg_inproc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("personBookRegVo") PersonBookRegVo personBookRegVo,
                                         BindingResult bindingResult,
                                         Model model,
                                         SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : personBookRegVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(personBookRegVo);
                if(value instanceof String){
                    field.set(personBookRegVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookRegVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_",cnt, personBookRegVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            personBookRegVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(personBookRegVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            personBookRegVo.setAtch_file_id("");
                        }
                    }

                    personBookRegVo.setUp_id(loginVo.getUser_id());

                    // 경력 엔터처리
                    String career = personBookRegVo.getCareer();
                    if(!"".equals(Util.nvl(career))) {
                        career = career.replaceAll(System.getProperty("line.separator"), "<br/>");
                        personBookRegVo.setCareer(career);
                    }

                    // 소개글
                    String intro = personBookRegVo.getIntro();
                    if(!"".equals(Util.nvl(intro))) {
                        intro = intro.replaceAll(System.getProperty("line.separator"), "<br/>");
                        personBookRegVo.setIntro(intro);
                    }

                    campusService.updatePersonBookRegInfo(personBookRegVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssem/youth/mypage/person_reg_list.do");
                    model.addAttribute("altmsg", "수정되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "수정에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/person_reg_cancel.do", method = RequestMethod.POST)
    public String youth_person_reg_cancel(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("personBookRegVo") PersonBookRegVo personBookRegVo,
                                         BindingResult bindingResult,
                                         Model model,
                                         SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : personBookRegVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(personBookRegVo);
                if(value instanceof String){
                    field.set(personBookRegVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                personBookRegVo.setUp_id(loginVo.getUser_id());

                campusService.updatePersonBookRegInfoCancel(personBookRegVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/person_reg_list.do");
                model.addAttribute("altmsg", "인물도서 등록 신청이 취소되었습니다.");

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "취소에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/instrum_rental_list.do")
    public String youth_instrum_rental_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/instrum_rental_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/instrum_rental_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/instrum_rental_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // gubun 값

            List<InstrumApyVo> itemList = campusService.selectInstrumApyList(searchVo);
            int totalCount = campusService.selectInstrumApyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/instrum_rental_insert.do", method = RequestMethod.GET)
    public String youth_instrum_rental_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/instrum_rental_insert";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int instrum_apy_idx = ServletRequestUtils.getIntParameter(request, "instrum_apy_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/instrum_rental_insert.do?instrum_apy_idx=" + instrum_apy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/instrum_rental_insert.do?instrum_apy_idx=" + instrum_apy_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            InstrumApyVo instrumApyVo = new InstrumApyVo();
            instrumApyVo.setInstrum_apy_idx(instrum_apy_idx);

            instrumApyVo = campusService.selectInstrumApyInfo(instrumApyVo);

            InstrumVo instrumVo = campusService.selectInstrumInfoByIdx(instrumApyVo.getInstrum_idx());
            instrumApyVo.setInstrumVo(instrumVo);

            instrumApyVo.setQty_diff(instrumApyVo.getRental_qty());

            // 해킹 처리
            if(!instrumApyVo.getReg_id().equals(loginVo.getUser_id())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/instrum_rental_list.do");
                model.addAttribute("altmsg", "잘못된 접근입니다.<br/>계속적인 시도 시 사용에 제약이 있을 수 있습니다.");
                ret_url =  "common/message";
            }

            String mob_no = instrumApyVo.getApy_mob_no();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    instrumApyVo.setMob_1(tokens[0]);
                    instrumApyVo.setMob_2(tokens[1]);
                    instrumApyVo.setMob_3(tokens[2]);
                }
            }

            // 전화번호
            String tel_no = instrumApyVo.getApy_tel_no();
            if(!"".equals(tel_no) && tel_no != null) {
                String[] tokens = tel_no.split("-");
                instrumApyVo.setTel_1(tokens[0]);
                instrumApyVo.setTel_2(tokens[1]);
                instrumApyVo.setTel_3(tokens[2]);
            }

            // 주소 분리
            String postcode = StringUtil.getPostCode(instrumApyVo.getApy_addr());
            String addr = StringUtil.getAddr(instrumApyVo.getApy_addr(), postcode);

            instrumApyVo.setPostcode(postcode);
            instrumApyVo.setAddr(addr);

            // 이메일 분리
            String email = instrumApyVo.getApy_email();
            if(!"".equals(email)) {
                String[] tokens = email.split("@");
                String email_id = tokens[0];
                String email_domain = tokens[1];

                instrumApyVo.setEmail_id(email_id);
                instrumApyVo.setEmail_domain(email_domain);
            }

            // 부모전화번호
            String parent_mob_no = instrumApyVo.getApy_parent_mob_no();
            if(!"".equals(parent_mob_no) && parent_mob_no != null) {
                String[] tokens = parent_mob_no.split("-");
                instrumApyVo.setParent_mob_1(tokens[0]);
                instrumApyVo.setParent_mob_2(tokens[1]);
                instrumApyVo.setParent_mob_3(tokens[2]);
            }

            model.addAttribute("instrumApyVo", instrumApyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/instrum_rental_insert.do", method = RequestMethod.POST)
    public String youth_instrum_rental_inproc(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("instrumApyVo") InstrumApyVo instrumApyVo,
                                    BindingResult bindingResult,
                                    Model model,
                                    SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : instrumApyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(instrumApyVo);
                if(value instanceof String){
                    field.set(instrumApyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                instrumApyVo.setUp_id(loginVo.getUser_id());

                // 대여목적 엔터처리
                String purpose = instrumApyVo.getPurpose();
                if(!"".equals(Util.nvl(purpose))) {
                    purpose = purpose.replaceAll(System.getProperty("line.separator"), "<br/>");
                    instrumApyVo.setPurpose(purpose);
                }

                String start_dt = instrumApyVo.getRental_start_dt();
                if (DateUtil.calDates(start_dt, DateUtil.getDate(3)) < 2) {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "악기대여는 대여 희망하는 날의 <br/>이틀전까지 신청하실 수 있습니다.");
                    return ret_url;
                }

                campusService.updateInstrumRentalInfo(instrumApyVo);

                // 대여 수량 변동 적용
                campusService.updateInstrumRentalQtyDiff(instrumApyVo);


                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/instrum_rental_list.do");
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

    @RequestMapping(value = "/youth/mypage/instrum_rental_cancel.do", method = RequestMethod.POST)
    public String youth_instrum_rental_cancel(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("instrumApyVo") InstrumApyVo instrumApyVo,
                                    BindingResult bindingResult,
                                    Model model,
                                    SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : instrumApyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(instrumApyVo);
                if(value instanceof String){
                    field.set(instrumApyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                instrumApyVo.setUp_id(loginVo.getUser_id());

                campusService.updateInstrumRentalCancel(instrumApyVo);

                // 신청 수량 업데이트
                campusService.updateInstrumRentalQtyEx(instrumApyVo);

                // 신청취소시 메세지 발송
                // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                if ("yes".equals(EgovProperties.getProperty("msg.send"))) {
                    InstrumApyVo apply = campusService.selectInstrumApyInfoByIdx((int)instrumApyVo.getInstrum_apy_idx());
                    InstrumVo instrumVo = campusService.selectInstrumInfoByIdx(apply.getInstrum_idx());

                    StringBuffer sb = new StringBuffer();
                    sb.append("[송파구청 송파쌤(SSEM)]");
                    sb.append("\r\n");
                    sb.append(String.format("%s님의 악기대여 신청이 취소되었습니다.", apply.getApy_nm()));
                    sb.append("\r\n");
                    sb.append("<취소내역>");
                    sb.append("\r\n");
                    sb.append(String.format("- 악기명: %s", instrumVo.getName()));
                    sb.append("\r\n");
                    sb.append(String.format("- 대여수량: %d", apply.getRental_qty()));
                    sb.append("\r\n");
                    sb.append(String.format("- 대여기간: %s~%s", apply.getRental_start_dt(), apply.getRental_end_dt()));
                    sb.append("\r\n");
                    sb.append("신청취소 확인은 마이페이지에서 확인이 가능합니다.");
                    sb.append("\r\n");
                    sb.append("감사합니다.");
                    sb.append("\r\n");
                    sb.append("☎ 문의: 송파쌤(SSEM) 악기도서관 02-2147-2544");

                    msgService.sendMsgKakao("악기대여 신청취소", sb.toString(), apply.getApy_nm(), apply.getApy_mob_no().replaceAll("-", ""), "UMS_2021061514563772590");
                }
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/instrum_rental_list.do");
                model.addAttribute("altmsg", "악기대여 신청이 취소되었습니다.");

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "취소에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/room_rental_list.do")
    public String youth_room_rental_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/room_rental_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/room_rental_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/room_rental_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // gubun 값

            List<RentalFtyApyVo> itemList = campusService.selectRentalFtyApyList(searchVo);
            int totalCount = campusService.selectRentalFtyApyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/room_rental_view.do", method = RequestMethod.GET)
    public String youth_room_rental_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/room_rental_view";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int rental_fty_apy_idx = ServletRequestUtils.getIntParameter(request, "rental_fty_apy_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/room_rental_view.do?rental_fty_apy_idx=" + rental_fty_apy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/room_rental_view.do?rental_fty_apy_idx=" + rental_fty_apy_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            RentalFtyApyVo rentalFtyApyVo = campusService.selectRentalFtyApyByIdx(rental_fty_apy_idx);
            RentalFtyVo rentalFtyVo = campusService.selectRentalFtyByIdx((int)rentalFtyApyVo.getRental_fty_idx());

            //썸네일 처리
            String thumbFileId = rentalFtyVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            rentalFtyVo.setThumbFileList(thumbFileList);

            // 시설안내 엔터처리
            String cont = rentalFtyVo.getCont();
            if(!"".equals(Util.nvl(cont))) {
                cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
                rentalFtyVo.setCont(cont);
            }

            // 해킹 처리
            if(!rentalFtyApyVo.getApy_id().equals(loginVo.getUser_id())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/room_rental_list.do");
                model.addAttribute("altmsg", "잘못된 접근입니다.<br/>계속적인 시도 시 사용에 제약이 있을 수 있습니다.");
                ret_url =  "common/message";
            }

            model.addAttribute("rentalFtyApyVo", rentalFtyApyVo);
            model.addAttribute("rentalFtyVo", rentalFtyVo);
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/instrum_donation_list.do")
    public String youth_instrum_donation_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/instrum_donation_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/instrum_donation_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/instrum_donation_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // gubun 값

            List<InstrumDntVo> itemList = campusService.selectInstrumDntList(searchVo);
            int totalCount = campusService.selectInstrumDntListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/instrum_donation_insert.do", method = RequestMethod.GET)
    public String youth_instrum_donation_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/instrum_donation_insert";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int instrum_dnt_idx = ServletRequestUtils.getIntParameter(request, "instrum_dnt_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/instrum_donation_insert.do?instrum_dnt_idx=" + instrum_dnt_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/instrum_donation_insert.do?instrum_dnt_idx=" + instrum_dnt_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            InstrumDntVo instrumDntVo = new InstrumDntVo();
            instrumDntVo.setInstrum_dnt_idx(instrum_dnt_idx);

            instrumDntVo = campusService.selectInstrumDntInfo(instrumDntVo);

            // 해킹 처리
            if(!instrumDntVo.getReg_id().equals(loginVo.getUser_id())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/instrum_donation_list.do");
                model.addAttribute("altmsg", "잘못된 접근입니다.<br/>계속적인 시도 시 사용에 제약이 있을 수 있습니다.");
                ret_url =  "common/message";
            }

            String mob_no = instrumDntVo.getDnt_mob_no();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    instrumDntVo.setMob_1(tokens[0]);
                    instrumDntVo.setMob_2(tokens[1]);
                    instrumDntVo.setMob_3(tokens[2]);
                }
            }

            // 악기사진
            String atchFileId = instrumDntVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            instrumDntVo.setFileList(fileVoList);

            model.addAttribute("instrumDntVo", instrumDntVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/instrum_donation_insert.do", method = RequestMethod.POST)
    public String youth_instrum_donation_inproc(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("instrumDntVo") InstrumDntVo instrumDntVo,
                                    BindingResult bindingResult,
                                    Model model,
                                    SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : instrumDntVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(instrumDntVo);
                if(value instanceof String){
                    field.set(instrumDntVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                // 첨부파일 처리
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(instrumDntVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_",cnt, instrumDntVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PB_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            instrumDntVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(instrumDntVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            instrumDntVo.setAtch_file_id("");
                        }
                    }

                    instrumDntVo.setUp_id(loginVo.getUser_id());

                    campusService.updateInstrumDntInfo(instrumDntVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssem/youth/mypage/instrum_donation_list.do");
                    model.addAttribute("altmsg", "수정되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "수정에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/instrum_donation_cancel.do", method = RequestMethod.POST)
    public String youth_instrum_donation_cancel(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("instrumDntVo") InstrumDntVo instrumDntVo,
                                    BindingResult bindingResult,
                                    Model model,
                                    SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : instrumDntVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(instrumDntVo);
                if(value instanceof String){
                    field.set(instrumDntVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                instrumDntVo.setUp_id(loginVo.getUser_id());

                campusService.updateInstrumDntCancel(instrumDntVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/instrum_donation_list.do");
                model.addAttribute("altmsg", "악기기증 신청이 취소되었습니다.");

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "취소에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/online_counsel_list.do")
    public String youth_online_counsel_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/online_counsel_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/online_counsel_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/online_counsel_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // gubun 값

            List<SelfCounselVo> itemList = campusService.selectSelfEduCounselList(searchVo);
            int totalCount = campusService.selectSelfEduCounselListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/online_counsel_insert.do", method = RequestMethod.GET)
    public String youth_online_counsel_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/online_counsel_insert";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int self_counsel_idx = ServletRequestUtils.getIntParameter(request, "self_counsel_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/online_counsel_insert.do?self_counsel_idx=" + self_counsel_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/online_counsel_insert.do?self_counsel_idx=" + self_counsel_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            SelfCounselVo selfCounselVo = new SelfCounselVo();
            selfCounselVo.setSelf_counsel_idx(self_counsel_idx);

            selfCounselVo = campusService.selectSelfEduCounselInfo(selfCounselVo);

            // 해킹 처리
            if(!selfCounselVo.getReg_id().equals(loginVo.getUser_id())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/online_counsel_insert.do");
                model.addAttribute("altmsg", "잘못된 접근입니다.<br/>계속적인 시도 시 사용에 제약이 있을 수 있습니다.");
                ret_url =  "common/message";
            }

            String mob_no = selfCounselVo.getApy_mob_no();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    selfCounselVo.setMob_1(tokens[0]);
                    selfCounselVo.setMob_2(tokens[1]);
                    selfCounselVo.setMob_3(tokens[2]);
                }
            }

            // 희망 상담일 파싱
            String meet_dt = selfCounselVo.getMeet_dt();
            if(!"".equals(meet_dt) && meet_dt != null) {
                String meet_date_str = meet_dt.substring(0, 10);
                String meet_day_str = meet_dt.substring(13, 15);

                selfCounselVo.setMeet_date_str(meet_date_str);
                selfCounselVo.setMeet_day_str(meet_day_str);
            }

            // 통화가능시간 파싱
            String able_phone_time = selfCounselVo.getAble_phone_time();
            if(!"".equals(able_phone_time) && able_phone_time != null) {
                String able_start_time = able_phone_time.substring(0, 2);
                String able_end_time = able_phone_time.substring(6, 8);

                selfCounselVo.setAble_start_time(able_start_time);
                selfCounselVo.setAble_end_time(able_end_time);
            }

            // 첨부파일 처리
            String atchFileId = selfCounselVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            selfCounselVo.setFileList(fileVoList);

            model.addAttribute("selfCounselVo", selfCounselVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/online_counsel_insert.do", method = RequestMethod.POST)
    public String youth_online_counsel_inproc(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("selfCounselVo") SelfCounselVo selfCounselVo,
                                          BindingResult bindingResult,
                                          Model model,
                                          SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : selfCounselVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(selfCounselVo);
                if(value instanceof String){
                    field.set(selfCounselVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                // 첨부 파일 처리
                CommonVo career_cmm = this.getAttachFileInfoEx(multiRequest, "atch_file_id");
                if(career_cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (career_cmm.getChkcnt() > 0) {

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(selfCounselVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if (chkList.size() > 0) {
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(career_cmm.getTmpfiles(), "SELF_", cnt, selfCounselVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        } else {
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(career_cmm.getTmpfiles(), "SELF_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            selfCounselVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(selfCounselVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            selfCounselVo.setAtch_file_id("");
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                selfCounselVo.setUp_id(loginVo.getUser_id());

                campusService.updateSelfEduCounselInfo(selfCounselVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/online_counsel_list.do");
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

    @RequestMapping(value = "/youth/mypage/online_counsel_cancel.do", method = RequestMethod.POST)
    public String youth_online_counsel_cancel(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("selfCounselVo") SelfCounselVo selfCounselVo,
                                          BindingResult bindingResult,
                                          Model model,
                                          SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : selfCounselVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(selfCounselVo);
                if(value instanceof String){
                    field.set(selfCounselVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                selfCounselVo.setUp_id(loginVo.getUser_id());

                campusService.updateSelfEduCounselCancel(selfCounselVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/online_counsel_list.do");
                model.addAttribute("altmsg", "온라인 상담예약이 취소되었습니다.");

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "취소에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/circle_reg_list.do")
    public String youth_circle_reg_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/circle_reg_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/circle_reg_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/circle_reg_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchVal8(loginVo.getUser_id()); // gubun 값

            List<ClubVo> itemList = clubService.selectClubList(searchVo);
            int totalCount = clubService.selectClubListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            List<CodeVo> codeList = appService.selectCodeList("CLUB_CATE");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/circle_reg_insert.do", method = RequestMethod.GET)
    public String youth_circle_reg_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/circle_reg_insert";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int club_idx = ServletRequestUtils.getIntParameter(request, "club_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/circle_reg_insert.do?club_idx=" + club_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/circle_reg_insert.do?club_idx=" + club_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            ClubVo clubVo = new ClubVo();
            clubVo.setClub_idx(club_idx);

            clubVo = clubService.selectClubInfo(clubVo);

            String mob_no = clubVo.getApy_mob_no();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    clubVo.setMob_1(tokens[0]);
                    clubVo.setMob_2(tokens[1]);
                    clubVo.setMob_3(tokens[2]);
                }
            }

            // 첨부파일
            String planFileId = clubVo.getAtch_file_id();
            String plan_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo planfvo = new FileVo();
            planfvo.setAtch_file_id(planFileId);
            List<FileVo> planFileList = fileMngService.selectFileInfs(planfvo);
            for(FileVo fileVo : planFileList){
                fileVo.setFile_src(plan_path + "/" + fileVo.getFile_nm());
            }
            clubVo.setFileList(planFileList);

            model.addAttribute("clubVo", clubVo);

            List<CodeVo> codeList = appService.selectCodeList("CLUB_CATE");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/circle_reg_insert.do", method = RequestMethod.POST)
    public String youth_circle_reg_inproc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("clubVo") ClubVo clubVo,
                                        BindingResult bindingResult,
                                        Model model,
                                        SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : clubVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(clubVo);
                if(value instanceof String){
                    field.set(clubVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/circle_reg_insert.do?club_idx=" + clubVo.getClub_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {

                // 첨부 파일 처리
                CommonVo career_cmm = this.getAttachFileInfo(multiRequest);
                if(career_cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (career_cmm.getChkcnt() > 0) {

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(clubVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if (chkList.size() > 0) {
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(career_cmm.getTmpfiles(), "CL_", cnt, clubVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        } else {
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(career_cmm.getTmpfiles(), "CL_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            clubVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(clubVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            clubVo.setAtch_file_id("");
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                clubVo.setUp_id(loginVo.getUser_id());

                clubService.updateClubInfoEx(clubVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/circle_reg_list.do");
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

    @RequestMapping(value = "/youth/mypage/circle_reg_cancel.do", method = RequestMethod.POST)
    public String youth_circle_reg_cancel(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("clubVo") ClubVo clubVo,
                                          BindingResult bindingResult,
                                          Model model,
                                          SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : clubVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(clubVo);
                if(value instanceof String){
                    field.set(clubVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/circle_reg_insert.do?club_idx=" + clubVo.getClub_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                clubVo.setUp_id(loginVo.getUser_id());
                clubVo.setStatus("N");

                clubService.updateClubInfo(clubVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/mypage/circle_reg_list.do");
                model.addAttribute("altmsg", "평생학습동아리 신청이 취소되었습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "수정에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/youth/mypage/survey_list.do")
    public String youth_survey_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/survey_list";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/survey_list.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if(!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/survey_list.do");
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            // 파라미터 세팅
            SearchVo searchVo = this.getSearch(request);
            this.getModel(request, model);

            searchVo.setSearchKind("Y");
            searchVo.setSearchKind3(loginVo.getUser_id());

            List<SvyMstVo> itemList = bbsService.selectSurveyListForUser(searchVo);
            for(SvyMstVo survey : itemList) {
                // 접수유무 확인
                String today = Util.getDate(1);
                if (Integer.valueOf(today) < Integer.valueOf(survey.getStart_dt().substring(0, 10).replaceAll("-", ""))) {
                    survey.setSrv_yn("예정");
                } else if (Integer.valueOf(today) > Integer.valueOf(survey.getEnd_dt().substring(0, 10).replaceAll("-", ""))) {
                    survey.setSrv_yn("종료");
                } else {
                    survey.setSrv_yn("진행 중");
                }
            }
            int totalCount = bbsService.selectSurveyListForUserTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/survey_view.do", method = RequestMethod.GET)
    public String youth_survey_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/mypage/survey_view";

        int svy_idx = ServletRequestUtils.getIntParameter(request, "svy_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/survey_view.do?svy_idx=" + svy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            if (!"Y".equals(loginVo.getMypage_check())) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_pwd_confirm_url + "?return_url=/youth/mypage/survey_view.do?svy_idx=" + svy_idx);
                model.addAttribute("altmsg", "비밀번호 확인 후 조회가 가능합니다.");
                return "common/message";
            }

            SvyMstVo svyMstVo = new SvyMstVo();
            svyMstVo.setSvy_idx(svy_idx);

            svyMstVo = bbsService.selectSurvey(svyMstVo);

            List<SvyQstVo> questList = bbsService.selectQuestList(svyMstVo);
            for(SvyQstVo quest : questList) {
                List<SvyItemVo> itemList = bbsService.selectItemList(quest);

                for(SvyItemVo item : itemList) {
                    List<SvyRpyVo> replyList = bbsService.selectReplyList(item);
                    int item_cnt = replyList.size();
                    int tot_cnt = bbsService.selectQuestTotalReply(item);

                    if(tot_cnt == 0) break;

                    double percent = (double) item_cnt / (double) tot_cnt * 100.0;

                    item.setTot_reply_cnt(item_cnt);
                    item.setReply_percent(String.format("%.2f", percent) + "%");

                    item.setReplyList(replyList);
                }

                quest.setItemList(itemList);
            }

            svyMstVo.setQuestList(questList);

            model.addAttribute("svyMstVo", svyMstVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/mypage/act_print.do", method = RequestMethod.GET)
    public String youth_act_print(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "print";

        int lecture_apy_idx = ServletRequestUtils.getIntParameter(request, "lecture_apy_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/mypage/attend_view.do?lecture_apy_idx=" + lecture_apy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            // 신청 정보
            LectureApyVo lectureApyVo = lectureService.selectLectureApyInfoByIdxEx(lecture_apy_idx);
            model.addAttribute("lectureApyVo", lectureApyVo);

            LectureVo lectureVo = getLectureInfo((int)lectureApyVo.getLecture_idx());

            // 교육기관 정보
            GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
            lectureVo.setGroup(groupVo);

            // 교육분야 가져오기
            String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
            lectureVo.setPart_name(part_name);

            // 프린트 일자
            String print_date = DateUtil.getDate(4);
            lectureVo.setPrint_date(print_date);

            model.addAttribute("lectureVo", lectureVo);
        }

        return ret_url;
    }

    private LectureVo getLectureInfo(int lecture_idx) throws Exception {
        LectureVo lectureVo = new LectureVo();
        lectureVo.setLecture_idx(lecture_idx);

        lectureVo = lectureService.selectLectureInfo(lectureVo);

        //교육대상 가져오기
        List<String> array_tgt = new ArrayList<String>();
        String tgt_code = lectureVo.getTgt_code();
        String[] tokens = tgt_code.split(",");
        for(String code : tokens) {
            String code_txt = appService.selectCodeByIdx(Integer.parseInt(code));
            array_tgt.add(code_txt);
        }
        lectureVo.setArray_tgt(array_tgt);

        // 교육분야 가져오기
        String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
        lectureVo.setPart_name(part_name);

        // 교육시간
        String dt_str = "";
        String dt_type = lectureVo.getDt_type();
        if("W".equals(dt_type)) {
            dt_str += "매주 ";
        } else if("T".equals(dt_type)) {
            dt_str += "격주 ";
        } else if("Z".equals(dt_type)) {
            dt_str += "기타 ";
        }

        String[] weeks = lectureVo.getDt_week().split(",");
        for(String week : weeks) {
            if("1".equals(week)) {
                dt_str += "월, ";
            } else if("2".equals(week)) {
                dt_str += "화, ";
            } else if("3".equals(week)) {
                dt_str += "수, ";
            } else if("4".equals(week)) {
                dt_str += "목, ";
            } else if("5".equals(week)) {
                dt_str += "금, ";
            } else if("6".equals(week)) {
                dt_str += "토, ";
            } else if("7".equals(week)) {
                dt_str += "일, ";
            }
        }
        lectureVo.setDt_str(StringUtil.deleteLastStr(dt_str.trim(), ','));

        // 접수방법
        String reg_method_str = "";
        String[] methods = lectureVo.getReg_method().split(",");
        for(String method : methods) {
            if("1".equals(method)) {
                reg_method_str += "온라인, ";
            } else if("2".equals(method)) {
                reg_method_str += "방문, ";
            } else if("3".equals(method)) {
                reg_method_str += "전화, ";
            } else if("4".equals(method)) {
                reg_method_str += "외부홈페이지, ";
            }
        }
        lectureVo.setReg_method_str(StringUtil.deleteLastStr(reg_method_str.trim(), ','));

        // 조직 정보
        GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
        lectureVo.setGroup(groupVo);

        // 시설 정보
        StudyPlaceVo place = lectureService.selectStudyPlaceByIdx(lectureVo.getStudy_place_idx());
        lectureVo.setPlace(place);

        // 감면 정보
        List<DiscountVo> array_discount = new ArrayList<DiscountVo>();
        if(lectureVo.getDiscount_str() != null) {
            String[] discounts = lectureVo.getDiscount_str().split(",");
            for (String discount : discounts) {
                DiscountVo dis = lectureService.selectDiscountByIdx(Integer.valueOf(discount));
                array_discount.add(dis);
            }
        }
        lectureVo.setArray_discount(array_discount);

        // 강사 정보
        TeacherVo teacher = lectureService.selectTeacherInfoByIdx(lectureVo.getTeacher_idx());
        if(teacher != null) {
            // 첨부파일 처리
            String atchFileId = teacher.getPic_atch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for (FileVo fileVo : fileVoList) {
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            teacher.setPicFileList(fileVoList);

            // 주요경력 엔터처리
            String career = teacher.getCareer();
            if(!"".equals(Util.nvl(career))) {
                career = career.replaceAll(System.getProperty("line.separator"), "<br/>");
                teacher.setCareer(career);
            }

            teacher.setLecture_idx(lectureVo.getLecture_idx());

            // score => 0 : 평가 없음
            // score => 1 : 금
            // score => 2 : 은
            // score => 3 : 동
            int score = 0;
            int total_cnt = lectureService.selectTeacherScoreTotalCnt(teacher);
            if(total_cnt != 0) {
                int total_score = lectureService.selectTeacherScoreTotal(teacher);
                score = Util.getTeacherScore(total_cnt, total_score);
            } else {
                score = 0;
            }
            teacher.setScore(score);

            lectureVo.setTeacher(teacher);
        }

        // 특이사항 엔터처리
        String desc_txt = lectureVo.getDesc_txt();
        if(!"".equals(Util.nvl(desc_txt))) {
            desc_txt = desc_txt.replaceAll(System.getProperty("line.separator"), "<br/>");
            lectureVo.setDesc_txt(desc_txt);
        }

        // 환불정책 엔터처리
        String refund_txt = lectureVo.getRefund_txt();
        if(!"".equals(Util.nvl(refund_txt))) {
            refund_txt = refund_txt.replaceAll(System.getProperty("line.separator"), "<br/>");
            lectureVo.setRefund_txt(refund_txt);
        }

        // 좋아요 카운트
        int love_cnt = lectureService.selectLoveCount(lectureVo.getLecture_idx());
        lectureVo.setLove_cnt(love_cnt);

        // 프로그램 상태 체크
        // 1. 접수대기 : 접수날짜 도래 하지 않음
        // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
        // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
        // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
        // 5. 교육전 :
        // 6. 교육중 : 교육날짜 내
        // 7. 교육종료 : 교육날짜 지남
        // 8. 외부홈페이지 : 외부 홈페이지일 경우
        int code = Util.getProgramStatus(lectureVo);
        lectureVo.setStatus_code(code);

        return lectureVo;
    }
}
