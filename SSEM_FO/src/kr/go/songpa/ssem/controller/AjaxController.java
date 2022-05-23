package kr.go.songpa.ssem.controller;

import com.alibaba.fastjson.JSON;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.LectureService;
import kr.go.songpa.ssem.util.DateUtil;
import kr.go.songpa.ssem.util.StringUtil;
import kr.go.songpa.ssem.util.Util;
import lgdacom.XPayClient.XPayClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-11-17
 * Description :
 * History :
 * Version :
 */
@Controller
public class AjaxController extends CommonController {

    @Autowired
    private LectureService lectureService;

    @Autowired
    private AppService appService;

    public AjaxController() {
    }

    @RequestMapping( value = "/ajax/discount_update.do", produces = "text/json; charset=UTF-8" )
    public ResponseEntity<String> scrap_insert(@RequestParam Map<String, Object> parameterMap, HttpServletRequest request, Model model) {

        try {
            int lecture_apy_idx = ServletRequestUtils.getIntParameter(request, "lecture_apy_idx", 0);
            int discount_idx = ServletRequestUtils.getIntParameter(request, "discount_idx", 0);
            int discount_rate = ServletRequestUtils.getIntParameter(request, "discount_rate", 0);
            int fee = ServletRequestUtils.getIntParameter(request, "fee", 0);

            LectureApyVo lectureApyVo = new LectureApyVo();
            lectureApyVo.setLecture_apy_idx(lecture_apy_idx);
            lectureApyVo.setDiscount_idx(discount_idx);
            lectureApyVo.setDiscount_rate(discount_rate);

            lectureService.updateLectureApyDiscountInfo(lectureApyVo);

            lectureApyVo = lectureService.selectLectureApyInfoByIdxEx(lecture_apy_idx);

            LectureVo lectureVo = lectureService.selectLecureInfoByIdx(lectureApyVo.getLecture_idx());

            // 상점아이디 가져오기
            GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());

            // 결제 관련
            String configPath = EgovProperties.getProperty("xpay.config");
            String CST_PLATFORM = EgovProperties.getProperty("xpay.platform");
            String LGD_TIMESTAMP = DateUtil.getDate(1) + DateUtil.getTime();
            String LGD_MID = groupVo.getPay_shop_id();
            String LGD_OID = "SSEM_" + LGD_TIMESTAMP;
            String LGD_AMOUNT = String.valueOf(fee);
            String LGD_HASHDATA = "";
            XPayClient xpay = null;
            PayVo payVo = new PayVo();

            try {
                xpay = new XPayClient();
                xpay.Init(configPath, CST_PLATFORM);

                if("".equals(LGD_TIMESTAMP)) {
                    LGD_TIMESTAMP = xpay.GetTimeStamp();
                }
                LGD_HASHDATA = xpay.GetHashData(LGD_MID, LGD_OID, LGD_AMOUNT, LGD_TIMESTAMP);

                payVo.setLGD_OID(LGD_OID);
                payVo.setLGD_HASHDATA(LGD_HASHDATA);
                payVo.setLGD_TIMESTAMP(LGD_TIMESTAMP);

                //model.addAttribute("payVo", payVo);

            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                xpay = null;
            }

            return new ResponseEntity<String>( JSON.toJSONString( payVo ), HttpStatus.OK );
        }
        catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }
}
