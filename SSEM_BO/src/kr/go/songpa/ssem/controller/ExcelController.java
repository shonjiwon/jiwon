package kr.go.songpa.ssem.controller;

import com.alibaba.fastjson.JSON;
import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.*;
import kr.go.songpa.ssem.util.DateUtil;
import kr.go.songpa.ssem.util.StringUtil;
import kr.go.songpa.ssem.util.Util;
import net.sf.jxls.transformer.XLSTransformer;
import org.apache.poi.hssf.record.crypto.Biff8EncryptionKey;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-10-05
 * Description :
 * History :
 * Version :
 */
@Controller
public class ExcelController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private CampusService campusService;

    @Autowired
    private MagnetService magnetService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private ClubService clubService;

    @Autowired
    private SelfHallService selfHallService;

    @Autowired
    private LawTaxService lawTaxService;

    public ExcelController() {
    }

    @RequestMapping(value="/cont/excel/lecture_list_excel.do", method = RequestMethod.GET)
    public void lecture_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lecture : itemList) {
            String gubun = lecture.getGubun();
            if("J".equals(gubun)) {
                lecture.setGubun("미래교육");
            } else {
                lecture.setGubun("평생교육");
            }

            String code_name = appService.selectCodeByIdx(lecture.getPart_code_idx());
            lecture.setPart_name(code_name);

            // 요일 정보
            String week_list_str = "";
            List<String> weekList = StringUtil.getWeekStrToWeekCode(lecture.getDt_week());
            for(String week : weekList) {
                week_list_str =  week_list_str + " " + week;
            }
            lecture.setWeek_list_str(week_list_str);

            // 신청 방법
            String reg_method_str = lecture.getReg_method();
            reg_method_str = reg_method_str.replace("1", "온라인");
            reg_method_str = reg_method_str.replace("2", "방문");
            reg_method_str = reg_method_str.replace("3", "전화");
            reg_method_str = reg_method_str.replace("4", "외부홈페이지");
            lecture.setReg_method_str(reg_method_str);
            // 프로그램 상태 체크
            // 1. 접수대기 : 접수날짜 도래 하지 않음
            // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
            // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
            // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
            // 5. 교육전 :
            // 6. 교육중 : 교육날짜 내
            // 7. 교육종료 : 교육날짜 지남
            // 8. 외부홈페이지 : 외부 홈페이지일 경우
            int code_val = Util.getProgramStatus(lecture);
            if(code_val == 1) {
                lecture.setStatus_code_str("접수대기");
            } else if(code_val == 2) {
                lecture.setStatus_code_str("신청가능");
            } else if(code_val == 3) {
                lecture.setStatus_code_str("대기신청");
            } else if(code_val == 4) {
                lecture.setStatus_code_str("신청마감");
            } else if(code_val == 5) {
                lecture.setStatus_code_str("교육전");
            } else if(code_val == 6) {
                lecture.setStatus_code_str("교육중");
            } else if(code_val == 7) {
                lecture.setStatus_code_str("교육종료");
            } else if(code_val == 8) {
                lecture.setStatus_code_str("외부홈페이지");
            }

            String use_yn = lecture.getUse_yn();
            if("Y".equals(use_yn)) {
                lecture.setUse_yn("노출");
            } else {
                lecture.setUse_yn("미노출");
            }

            String reg_start_st = lecture.getReg_start_st().substring(0, 16);
            lecture.setReg_start_st(reg_start_st);

            String reg_end_dt = lecture.getReg_end_dt().substring(0, 16);
            lecture.setReg_end_dt(reg_end_dt);
        }
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "lecture_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "프로그램 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/apply_list_excel.do", method = RequestMethod.GET)
    public void apply_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lecture : itemList) {
            String gubun = lecture.getGubun();
            if("J".equals(gubun)) {
                lecture.setGubun("미래교육");
            } else {
                lecture.setGubun("평생교육");
            }

            String code_name = appService.selectCodeByIdx(lecture.getPart_code_idx());
            lecture.setPart_name(code_name);

            // 신청 방법
            String reg_method_str = lecture.getReg_method();
            reg_method_str = reg_method_str.replace("1", "온라인");
            reg_method_str = reg_method_str.replace("2", "방문");
            reg_method_str = reg_method_str.replace("3", "전화");
            reg_method_str = reg_method_str.replace("4", "외부홈페이지");
            lecture.setReg_method_str(reg_method_str);
            // 프로그램 상태 체크
            // 1. 접수대기 : 접수날짜 도래 하지 않음
            // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
            // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
            // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
            // 5. 교육전 :
            // 6. 교육중 : 교육날짜 내
            // 7. 교육종료 : 교육날짜 지남
            // 8. 외부홈페이지 : 외부 홈페이지일 경우
            int code_val = Util.getProgramStatus(lecture);
            if(code_val == 1) {
                lecture.setStatus_code_str("접수대기");
            } else if(code_val == 2) {
                lecture.setStatus_code_str("신청가능");
            } else if(code_val == 3) {
                lecture.setStatus_code_str("대기신청");
            } else if(code_val == 4) {
                lecture.setStatus_code_str("신청마감");
            } else if(code_val == 5) {
                lecture.setStatus_code_str("교육전");
            } else if(code_val == 6) {
                lecture.setStatus_code_str("교육중");
            } else if(code_val == 7) {
                lecture.setStatus_code_str("교육종료");
            } else if(code_val == 8) {
                lecture.setStatus_code_str("외부홈페이지");
            }

            String use_yn = lecture.getUse_yn();
            if("Y".equals(use_yn)) {
                lecture.setUse_yn("노출");
            } else {
                lecture.setUse_yn("미노출");
            }

            String reg_start_st = lecture.getReg_start_st().substring(0, 16);
            lecture.setReg_start_st(reg_start_st);

            String reg_end_dt = lecture.getReg_end_dt().substring(0, 16);
            lecture.setReg_end_dt(reg_end_dt);

            // 모집현황
            String excel_qty = "";
            int internet = (int)lecture.getOnline_qty() - (int)lecture.getOnline_can_qty();
            int wait = (int)lecture.getWait_qty() - (int)lecture.getWait_can_qty();
            int total = internet + wait;
            excel_qty = String.format("%d명 (%d(%d))", total, internet, wait);
            lecture.setExcel_qty(excel_qty);
        }
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "apply_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "신청_접수 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/apply_view_excel.do", method = RequestMethod.GET)
    public void apply_view_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        LectureVo lectureVo = new LectureVo();
        lectureVo.setLecture_idx(lecture_idx);

        lectureVo = lectureService.selectLectureInfo(lectureVo);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForLectureApy(request, 10, String.valueOf(lecture_idx));
        this.getModel(request, model);

        searchVo.setSearchVal7(String.valueOf(lecture_idx));

        List<LectureApyVo> itemList = lectureService.selectLectureApyListExcel(searchVo);
        for(LectureApyVo lectureApyVo : itemList) {
            String apy_no = "SSEM-" + lectureApyVo.getLecture_apy_idx();
            lectureApyVo.setApy_no(apy_no);

            if("".equals(Util.nvl(lectureApyVo.getApy_ref()))) {
                lectureApyVo.setAlt_apy_yn("N");
            } else {
                lectureApyVo.setAlt_apy_yn("Y");
            }

            if("M".equals(lectureApyVo.getApy_gender())) {
                lectureApyVo.setApy_gender("남");
            } else if("F".equals(lectureApyVo.getApy_gender())) {
                lectureApyVo.setApy_gender("여");
            } else {
                lectureApyVo.setApy_gender("-");
            }

            if("1".equals(lectureApyVo.getApy_method())) {
                lectureApyVo.setApy_method("온라인");
            } else if("2".equals(lectureApyVo.getApy_method())) {
                lectureApyVo.setApy_method("방문");
            } else {
                lectureApyVo.setApy_method("전화");
            }

            lectureApyVo.setReg_dt(lectureApyVo.getReg_dt().substring(0, 10));

            if("1".equals(lectureApyVo.getApy_status())) {
                lectureApyVo.setApy_status("신청");
            } else if("2".equals(lectureApyVo.getApy_method())) {
                lectureApyVo.setApy_status("대기신청");
            } else {
                lectureApyVo.setApy_status("신청취소");
            }

            if("1".equals(lectureApyVo.getPay_status())) {
                lectureApyVo.setPay_status("입급대기");
            } else if("2".equals(lectureApyVo.getPay_status())) {
                lectureApyVo.setPay_status("결제완료");
            } else if("3".equals(lectureApyVo.getPay_status())) {
                lectureApyVo.setPay_status("결제취소");
            } else if("4".equals(lectureApyVo.getPay_status())) {
                lectureApyVo.setPay_status("환불신청");
            } else if("5".equals(lectureApyVo.getPay_status())) {
                lectureApyVo.setPay_status("환불처리");
            } else {
                lectureApyVo.setPay_status("무료");
            }

            if("1".equals(lectureApyVo.getAppv_cd())) {
                lectureApyVo.setAppv_cd("승인");
            } else if("2".equals(lectureApyVo.getAppv_cd())) {
                lectureApyVo.setAppv_cd("미승인");
            } else {
                lectureApyVo.setAppv_cd("승인취소");
            }

            if("Y".equals(lectureApyVo.getVaccine_yn())) {
                lectureApyVo.setVaccine_yn("접종");
            } else if("N".equals(lectureApyVo.getVaccine_yn())) {
                lectureApyVo.setVaccine_yn("미접종");
            } else {
                lectureApyVo.setVaccine_yn("-");
            }

            if("".equals(Util.nvl(lectureApyVo.getVaccine_dt()))) {
                lectureApyVo.setVaccine_dt("-");
            }
        }
        int totalCount = lectureService.selectLectureApyListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("lectureVo",lectureVo);
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "lecture_apply_view.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "접수현황 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/lect_student_list_excel.do", method = RequestMethod.GET)
    public void lect_student_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<LectureVo> itemList = lectureService.selectLectureStudentListExcel(searchVo);
        for(LectureVo lecture : itemList) {
            int student_cnt = lectureService.selectLectureStudentCntByIdx(lecture.getLecture_idx());
            lecture.setStudent_cnt(student_cnt);

            String gubun = lecture.getGubun();
            if("J".equals(gubun)) {
                lecture.setGubun("미래교육");
            } else {
                lecture.setGubun("평생교육");
            }

            // 프로그램 상태 체크
            // 1. 접수대기 : 접수날짜 도래 하지 않음
            // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
            // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
            // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
            // 5. 교육전 :
            // 6. 교육중 : 교육날짜 내
            // 7. 교육종료 : 교육날짜 지남
            // 8. 외부홈페이지 : 외부 홈페이지일 경우
            int code_val = Util.getProgramStatus(lecture);
            if(code_val == 1) {
                lecture.setStatus_code_str("접수대기");
            } else if(code_val == 2) {
                lecture.setStatus_code_str("신청가능");
            } else if(code_val == 3) {
                lecture.setStatus_code_str("대기신청");
            } else if(code_val == 4) {
                lecture.setStatus_code_str("신청마감");
            } else if(code_val == 5) {
                lecture.setStatus_code_str("교육전");
            } else if(code_val == 6) {
                lecture.setStatus_code_str("교육중");
            } else if(code_val == 7) {
                lecture.setStatus_code_str("교육종료");
            } else if(code_val == 8) {
                lecture.setStatus_code_str("외부홈페이지");
            }

            lecture.setReg_start_st(lecture.getReg_start_st().substring(0, 10));
            lecture.setReg_end_dt(lecture.getReg_end_dt().substring(0, 10));
        }
        int totalCount = lectureService.selectLectureStudentListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }
        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "lect_student_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                //Workbook workbook = transformer.transformXLS(fis, beans);

                String excelName = "프로그램별 교육생 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/lect_student_view_excel.do", method = RequestMethod.GET)
    public void lect_student_view_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForLectureApy(request, 10, String.valueOf(lecture_idx));
        this.getModel(request, model);

        // 교육생 리스트
        searchVo.setSearchVal7(String.valueOf(lecture_idx));
        searchVo.setSearchVal6("1");

        List<LectureApyVo> itemList = lectureService.selectLectureApyListExcel(searchVo);
        for(LectureApyVo lectureApyVo : itemList) {
            if(!"".equals(lectureApyVo.getApy_ref()) && lectureApyVo.getApy_ref() != null) {
                lectureApyVo.setApy_name(lectureApyVo.getApy_real_name());
                lectureApyVo.setApy_ref("Y");
            } else {
                lectureApyVo.setApy_ref("N");
            }

            String gender = lectureApyVo.getApy_gender();
            if ("M".equals(gender)) {
                lectureApyVo.setApy_gender("남");
            } else if ("F".equals(gender)) {
                lectureApyVo.setApy_gender("여");
            }

            String method = lectureApyVo.getApy_method();
            if ("1".equals(method)) {
                lectureApyVo.setApy_method("온라인");
            } else if ("2".equals(method)) {
                lectureApyVo.setApy_method("방문");
            } else if ("3".equals(method)) {
                lectureApyVo.setApy_method("전화");
            }

            String reg_dt = lectureApyVo.getReg_dt().substring(0, 10);
            lectureApyVo.setReg_dt(reg_dt);

            String cpl_yn = lectureApyVo.getCpl_yn();
            if ("Y".equals(cpl_yn)) {
                lectureApyVo.setCpl_yn("수료");
            } else {
                lectureApyVo.setCpl_yn("미수료");
            }
        }
        int totalCount = lectureService.selectLectureApyListTotalExcel(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "lect_student_view.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                //Workbook workbook = transformer.transformXLS(fis, beans);

                String excelName = "교육생현황 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/student_list_excel.do", method = RequestMethod.GET)
    public void student_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<StudentVo> itemList = lectureService.selectStudentListExcel(searchVo);
        for(StudentVo studentVo : itemList) {
            String gender = studentVo.getGender();
            if("M".equals(gender)) {
                studentVo.setGender("남");
            } else {
                studentVo.setGender("여");
            }

            String reg_dt = studentVo.getReg_dt().substring(0, 10);
            studentVo.setReg_dt(reg_dt);
        }
        int totalCount = lectureService.selectStudentListExcelTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "student_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                //Workbook workbook = transformer.transformXLS(fis, beans);

                String excelName = "수강생 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/student_view_excel.do", method = RequestMethod.GET)
    public void student_view_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        int student_idx = ServletRequestUtils.getIntParameter(request, "student_idx", 0);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForStudent(request, 10, String.valueOf(student_idx));
        this.getModel(request, model);

        StudentVo studentVo = lectureService.selectStudentInfoByIdx(student_idx);

        searchVo.setSearchVal8(studentVo.getUser_id());
        List<LectureApyVo> itemList = lectureService.selectLectureUserHistoryList(searchVo);
        for(LectureApyVo lectureApyVo : itemList) {
            LectureVo lecture = lectureService.selectLectureByIdx(lectureApyVo.getLecture_idx());
            lectureApyVo.setLectureVo(lecture);

            String apy_method = lectureApyVo.getApy_method();
            if("1".equals(apy_method)) {
                lectureApyVo.setApy_method("온라인");
            } else if("2".equals(apy_method)) {
                lectureApyVo.setApy_method("방문");
            } else if("3".equals(apy_method)) {
                lectureApyVo.setApy_method("전화");
            }

            int code_val = Util.getProgramStatus(lecture);
            if(code_val == 1) {
                lecture.setStatus_code_str("접수대기");
            } else if(code_val == 2) {
                lecture.setStatus_code_str("신청가능");
            } else if(code_val == 3) {
                lecture.setStatus_code_str("대기신청");
            } else if(code_val == 4) {
                lecture.setStatus_code_str("신청마감");
            } else if(code_val == 5) {
                lecture.setStatus_code_str("교육전");
            } else if(code_val == 6) {
                lecture.setStatus_code_str("교육중");
            } else if(code_val == 7) {
                lecture.setStatus_code_str("교육종료");
            } else if(code_val == 8) {
                lecture.setStatus_code_str("외부홈페이지");
            }

            String cpl_yn = lectureApyVo.getCpl_yn();
            if ("Y".equals(cpl_yn)) {
                lectureApyVo.setCpl_yn("수료");
            } else {
                lectureApyVo.setCpl_yn("미수료");
            }
        }
        int totalCount = lectureService.selectLectureUserHistoryListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "student_view.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                //Workbook workbook = transformer.transformXLS(fis, beans);

                String excelName = "수강이력 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/teacher_list_excel.do", method = RequestMethod.GET)
    public void teacher_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<TeacherVo> itemList = lectureService.selectTeacherList(searchVo);
        for(TeacherVo teacher : itemList) {
            // 성별
            String gender = teacher.getGender();
            if ("M".equals(gender)) {
                teacher.setGender("남");
            } else if ("F".equals(gender)) {
                teacher.setGender("여");
            }

            // 구분
            String gubun = teacher.getGubun();
            if ("N".equals(gubun)) {
                teacher.setGubun("일반");
            } else if ("S".equals(gubun)) {
                teacher.setGubun("자원봉사자");
            }

            String code_name = appService.selectCodeByIdx(teacher.getCode_idx());
            teacher.setCode_name(code_name);

            // 상태
            String status_txt = teacher.getStatus();
            if ("A".equals(status_txt)) {
                teacher.setStatus("승인");
            } else if ("N".equals(status_txt)) {
                teacher.setStatus("미승인");
            }

            String reg_dt = teacher.getReg_dt().substring(0, 10);
            teacher.setReg_dt(reg_dt);
        }
        int totalCount = lectureService.selectTeacherListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "teacher_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "강사관리 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/teacher_view_excel.do", method = RequestMethod.GET)
    public void teacher_view_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        int teacher_idx = ServletRequestUtils.getIntParameter(request, "teacher_idx", 0);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForTeacher(request, 10, String.valueOf(teacher_idx));
        this.getModel(request, model);

        searchVo.setSearchVal4(String.valueOf(teacher_idx));

        List<LectureVo> itemList = lectureService.selectLectureForTeacherList(searchVo);
        for(LectureVo lectureVo : itemList) {
            int code_val = Util.getProgramStatus(lectureVo);
            if(code_val == 1) {
                lectureVo.setStatus_code_str("접수대기");
            } else if(code_val == 2) {
                lectureVo.setStatus_code_str("신청가능");
            } else if(code_val == 3) {
                lectureVo.setStatus_code_str("대기신청");
            } else if(code_val == 4) {
                lectureVo.setStatus_code_str("신청마감");
            } else if(code_val == 5) {
                lectureVo.setStatus_code_str("교육전");
            } else if(code_val == 6) {
                lectureVo.setStatus_code_str("교육중");
            } else if(code_val == 7) {
                lectureVo.setStatus_code_str("교육종료");
            } else if(code_val == 8) {
                lectureVo.setStatus_code_str("외부홈페이지");
            }
        }
        int totalCount = lectureService.selectLectureForTeacherListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "teacher_view.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "프로그램진행현황 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/hope_study_join_list_excel.do", method = RequestMethod.GET)
    public void hope_study_join_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        int hope_study_idx = ServletRequestUtils.getIntParameter(request, "hope_study_idx", 0);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForMagnet(request, 10, String.valueOf(hope_study_idx));
        this.getModel(request, model);

        // 함께해요 리스트
        searchVo.setSearchVal2(String.valueOf(hope_study_idx));

        List<JoinStudyVo> itemList = magnetService.selectJoinStudyList(searchVo);
        for(JoinStudyVo joinStudyVo : itemList) {
            joinStudyVo.setReg_dt(joinStudyVo.getReg_dt().substring(0, 10));
        }
        int totalCount = magnetService.selectJoinStudyListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "hope_study_join_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "함께해요 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/hope_study_teach_list_excel.do", method = RequestMethod.GET)
    public void hope_study_teach_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        int hope_study_idx = ServletRequestUtils.getIntParameter(request, "hope_study_idx", 0);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForMagnet(request, 10, String.valueOf(hope_study_idx));
        this.getModel(request, model);

        // 함께해요 리스트
        searchVo.setSearchVal2(String.valueOf(hope_study_idx));

        List<TeachStudyVo> itemList = magnetService.selectTeachStudyList(searchVo);
        for(TeachStudyVo teachStudyVo : itemList) {
            String code_name = appService.selectCodeByIdx(teachStudyVo.getCode_idx());
            teachStudyVo.setCode_name(code_name);

            String teach_atch_file_id = teachStudyVo.getTeach_atch_file_id();
            if(teach_atch_file_id == null) {
                teachStudyVo.setTeach_atch_file_id("N");
            } else {
                teachStudyVo.setTeach_atch_file_id("Y");
            }

            String career_atch_file_id = teachStudyVo.getCareer_atch_file_id();
            if(career_atch_file_id == null) {
                teachStudyVo.setCareer_atch_file_id("N");
            } else {
                teachStudyVo.setCareer_atch_file_id("Y");
            }

            String reg_dt = teachStudyVo.getReg_dt().substring(0, 10);
            teachStudyVo.setReg_dt(reg_dt);
        }
        int totalCount = magnetService.selectTeachStudyListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "hope_study_teach_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "가르칠 수 있어요 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/hope_study_list_excel.do", method = RequestMethod.GET)
    public void hope_study_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<HopeStudyVo> itemList = magnetService.selectHopeStudyList(searchVo);
        for(HopeStudyVo hopeStudyVo : itemList) {
            String apy_name = hopeStudyVo.getApy_name();
            apy_name = StringUtil.maskName(apy_name);
            hopeStudyVo.setApy_name(apy_name);

            if(DateUtil.calDates(hopeStudyVo.getClose_dt(), DateUtil.getDate(3)) < 0) {
                hopeStudyVo.setClose_yn("종료");
            } else {
                hopeStudyVo.setClose_yn("진행중");
            }

            if("Y".equals(hopeStudyVo.getSelect_yn())) {
                hopeStudyVo.setSelect_yn("선정");
            } else {
                hopeStudyVo.setSelect_yn("미선정");
            }

            hopeStudyVo.setReg_dt(hopeStudyVo.getReg_dt().substring(0, 10));

            // 함께해요 리스트 개수
            int join_cnt = magnetService.selectJoinStudyCountByIdx(hopeStudyVo.getHope_study_idx());
            hopeStudyVo.setJoin_cnt(join_cnt);

            // 가르칠수 있어요 리스트 개수
            int teach_cnt = magnetService.selectTeachStudyCountByIdx(hopeStudyVo.getHope_study_idx());
            hopeStudyVo.setTeach_cnt(teach_cnt);
        }
        int totalCount = magnetService.selectHopeStudyListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "hope_study_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "배우고싶어요 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/teach_apply_list_excel.do", method = RequestMethod.GET)
    public void teach_apply_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<TeacherApyVo> itemList = magnetService.selectTeachApplyList(searchVo);
        for(TeacherApyVo teacher : itemList) {
            // 상태
            String status_cd = teacher.getStatus();
            if ("A".equals(status_cd)) {
                teacher.setStatus("강사신청");
            } else if ("R".equals(status_cd)) {
                teacher.setStatus("신청확인");
            } else if ("O".equals(status_cd)) {
                teacher.setStatus("강사등록");
            } else if ("C".equals(status_cd)) {
                teacher.setStatus("신청취소");
            }

            // 성별
            String gender = teacher.getApy_gender();
            if ("M".equals(gender)) {
                teacher.setApy_gender("남");
            } else if ("F".equals(gender)) {
                teacher.setApy_gender("여");
            }

            String reg_dt = teacher.getReg_dt().substring(0, 10);
            teacher.setReg_dt(reg_dt);

            String up_dt = "";
            if(teacher.getUp_dt() != null) {
                up_dt = teacher.getUp_dt().substring(0, 10);
            } else {
                up_dt = "-";
            }
            teacher.setUp_dt(up_dt);
        }
        int totalCount = magnetService.selectTeachApplyistTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "teach_apply_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "강사신청 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/person_reg_list_excel.do", method = RequestMethod.GET)
    public void person_reg_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearchEx(request, -6, 0);
        this.getModelEx(request, model, -6, -0);

        List<PersonBookRegVo> itemList = campusService.selectPersonBookRegList(searchVo);
        int totalCount = campusService.selectPersonBookRegListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();

        for(PersonBookRegVo personBookRegVo : itemList) {

            // 분류
            String cate_cd = personBookRegVo.getCate_cd();
            if ("J".equals(cate_cd)) {
                personBookRegVo.setCate_cd("진로직업");
            } else if ("C".equals(cate_cd)) {
                personBookRegVo.setCate_cd("문화예술");
            } else if ("H".equals(cate_cd)) {
                personBookRegVo.setCate_cd("인문교양");
            } else if ("P".equals(cate_cd)) {
                personBookRegVo.setCate_cd("인성심리");
            } else if ("E".equals(cate_cd)) {
                personBookRegVo.setCate_cd("전문인");
            } else if ("Z".equals(cate_cd)) {
                personBookRegVo.setCate_cd("기타");
            }

            String gender = personBookRegVo.getReg_gender();
            if ("M".equals(gender)) {
                personBookRegVo.setReg_gender("남자");
            } else if ("F".equals(gender)) {
                personBookRegVo.setReg_gender("여자");
            }

            String age = personBookRegVo.getReg_age();
            if ("1".equals(age)) {
                personBookRegVo.setReg_age("10대");
            } else if ("2".equals(age)) {
                personBookRegVo.setReg_age("20대");
            } else if ("3".equals(age)) {
                personBookRegVo.setReg_age("30대");
            } else if ("4".equals(age)) {
                personBookRegVo.setReg_age("40대");
            } else if ("5".equals(age)) {
                personBookRegVo.setReg_age("50대");
            } else if ("6".equals(age)) {
                personBookRegVo.setReg_age("60대");
            } else if ("7".equals(age)) {
                personBookRegVo.setReg_age("70대");
            } else if ("8".equals(age)) {
                personBookRegVo.setReg_age("80대");
            } else if ("9".equals(age)) {
                personBookRegVo.setReg_age("90대");
            }

            // 상태
            String status_cd = personBookRegVo.getStatus();
            if ("A".equals(status_cd)) {
                personBookRegVo.setStatus("신청대기");
            } else if ("P".equals(status_cd)) {
                personBookRegVo.setStatus("신청확인");
            } else if ("O".equals(status_cd)) {
                personBookRegVo.setStatus("인물도서확정");
            } else if ("C".equals(status_cd)) {
                personBookRegVo.setStatus("신청취소");
            }

            String reg_dt = personBookRegVo.getReg_dt().substring(0, 10);
            personBookRegVo.setReg_dt(reg_dt);
        }

        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "person_reg_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "등록신청관리 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/person_apply_list_excel.do", method = RequestMethod.GET)
    public void person_apply_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<PersonBookApyVo> itemList = campusService.selectPersonBookApplyList(searchVo);
        int totalCount = campusService.selectPersonBookApplyListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();

        for(PersonBookApyVo person : itemList) {
            // 신청경로
            String gubun = person.getGubun();
            if ("N".equals(gubun)) {
                person.setGubun("인물도서");
            } else if ("S".equals(gubun)) {
                person.setGubun("학교로찾아가는인물도서");
            }

            // 분류
            String cate_cd = person.getCate_cd();
            if ("J".equals(cate_cd)) {
                person.setCate_cd("진로직업");
            } else if ("C".equals(cate_cd)) {
                person.setCate_cd("문화예술");
            } else if ("H".equals(cate_cd)) {
                person.setCate_cd("인문교양");
            } else if ("P".equals(cate_cd)) {
                person.setCate_cd("인성심리");
            } else if ("E".equals(cate_cd)) {
                person.setCate_cd("전문인");
            } else if ("Z".equals(cate_cd)) {
                person.setCate_cd("기타");
            }

            // 상태
            String status_cd = person.getStatus();
            if ("A".equals(status_cd)) {
                person.setStatus("신청대기");
            } else if ("P".equals(status_cd)) {
                person.setStatus("신청조율");
            } else if ("O".equals(status_cd)) {
                person.setStatus("열람확정");
            } else if ("C".equals(status_cd)) {
                person.setStatus("신청취소");
            }
        }

        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "person_apply_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "열람신청관리 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/instrum_donation_list_excel.do", method = RequestMethod.GET)
    public void instrum_donation_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<InstrumDntVo> itemList = campusService.selectInstrumDntList(searchVo);
        int totalCount = campusService.selectInstrumDntListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();

        // 연체여부 판단
        for(InstrumDntVo instrumDntVo : itemList) {

            // 악기유형
            String instrum_gubun = instrumDntVo.getGubun();
            if ("A".equals(instrum_gubun)) {
                instrumDntVo.setGubun("건반악기");
            } else if ("B".equals(instrum_gubun)) {
                instrumDntVo.setGubun("관악기");
            } else if ("C".equals(instrum_gubun)) {
                instrumDntVo.setGubun("타악기");
            } else if ("D".equals(instrum_gubun)) {
                instrumDntVo.setGubun("현악기");
            } else if ("E".equals(instrum_gubun)) {
                instrumDntVo.setGubun("MIDI장비");
            } else if ("K".equals(instrum_gubun)) {
                instrumDntVo.setGubun("국악기");
            } else if ("Z".equals(instrum_gubun)) {
                instrumDntVo.setGubun("기타");
            }

            // 상태
            String status_cd = instrumDntVo.getStatus();
            if ("A".equals(status_cd)) {
                instrumDntVo.setStatus("기증신청");
            } else if ("R".equals(status_cd)) {
                instrumDntVo.setStatus("기증확인");
            } else if ("O".equals(status_cd)) {
                instrumDntVo.setStatus("기증완료");
            } else if ("C".equals(status_cd)) {
                instrumDntVo.setStatus("기증취소");
            }

            String reg_dt = instrumDntVo.getReg_dt().substring(0, 10);
            instrumDntVo.setReg_dt(reg_dt);
        }

        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "instrum_donation_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "악기기증 관리 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/instrum_apply_list_excel.do", method = RequestMethod.GET)
    public void instrum_apply_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<InstrumApyVo> itemList = campusService.selectInstrumApyList(searchVo);
        int totalCount = campusService.selectInstrumApyListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();

        // 연체여부 판단
        for(InstrumApyVo apply : itemList) {
            // 구분
            String gubun = apply.getGubun();
            if ("P".equals(gubun)) {
                apply.setGubun("개인");
            } else if ("G".equals(gubun)) {
                apply.setGubun("단체");
            }

            // 악기유형
            String instrum_gubun = apply.getInstrum_gubun();
            if ("A".equals(instrum_gubun)) {
                apply.setInstrum_gubun("건반악기");
            } else if ("B".equals(instrum_gubun)) {
                apply.setInstrum_gubun("관악기");
            } else if ("C".equals(instrum_gubun)) {
                apply.setInstrum_gubun("타악기");
            } else if ("D".equals(instrum_gubun)) {
                apply.setInstrum_gubun("현악기");
            } else if ("E".equals(instrum_gubun)) {
                apply.setInstrum_gubun("MIDI장비");
            } else if ("K".equals(instrum_gubun)) {
                apply.setInstrum_gubun("국악기");
            } else if ("Z".equals(instrum_gubun)) {
                apply.setInstrum_gubun("기타");
            }

            // 상태
            String status_cd = apply.getStatus();
            if ("A".equals(status_cd)) {
                apply.setStatus("신청");
            } else if ("R".equals(status_cd)) {
                apply.setStatus("신청취소");
            } else if ("O".equals(status_cd)) {
                apply.setStatus("승인");
            } else if ("C".equals(status_cd)) {
                apply.setStatus("승인취소");
            }

            // 결재 상태
            String pay_status = apply.getPay_status();
            if ("A".equals(pay_status)) {
                apply.setPay_status("결제대기");
            } else if ("B".equals(pay_status)) {
                apply.setPay_status("결제완료");
            } else if ("C".equals(pay_status)) {
                apply.setPay_status("환불신청");
            } else if ("D".equals(pay_status)) {
                apply.setPay_status("환불처리");
            }

            String today = Util.getDate(3);
            if("N".equals(apply.getReturn_yn())) {
                long late_day = DateUtil.calDates(today, apply.getRental_end_dt());
                if( late_day > 0) {
                    apply.setLate_yn("Y");
                    apply.setLate_day(late_day);
                } else {
                    apply.setLate_yn("N");
                }
            } else {
                apply.setLate_yn("-");
            }

            String reg_dt = apply.getReg_dt().substring(0, 10);
            apply.setReg_dt(reg_dt);
        }

        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "instrum_apply_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "악기대여 신청관리 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/club_apply_list_excel.do", method = RequestMethod.GET)
    public void club_apply_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<ClubVo> itemList = clubService.selectClubList(searchVo);
        for(ClubVo club : itemList) {
            if("R".equals(club.getStatus())) {
                club.setStatus("신청대기");
            } else if("C".equals(club.getStatus())) {
                club.setStatus("신청확인");
            } else if("O".equals(club.getStatus())) {
                club.setStatus("동아리확정");
            } else if("N".equals(club.getStatus())) {
                club.setStatus("신청취소");
            }

            club.setReg_dt(club.getReg_dt().substring(0, 10));
            if(club.getUp_dt() != null) {
                club.setUp_dt(club.getUp_dt().substring(0, 10));
            } else {
                club.setUp_dt("-");
            }
        }
        int totalCount = clubService.selectClubListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "club_apply_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "동아리신청 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/self_counsel_list_excel.do", method = RequestMethod.GET)
    public void self_counsel_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<SelfCounselVo> itemList = campusService.selectSelfEduCounselList(searchVo);
        for(SelfCounselVo selfCounselVo : itemList) {

            if("J".equals(selfCounselVo.getGubun())) {
                selfCounselVo.setGubun("진로");
            } else if("S".equals(selfCounselVo.getGubun())) {
                selfCounselVo.setGubun("자기주도학습");
            }

            if("A".equals(selfCounselVo.getStatus())) {
                selfCounselVo.setStatus("예약접수");
            } else if("R".equals(selfCounselVo.getStatus())) {
                selfCounselVo.setStatus("예약완료");
            } else if("O".equals(selfCounselVo.getStatus())) {
                selfCounselVo.setStatus("상담완료");
            } else if("C".equals(selfCounselVo.getStatus())) {
                selfCounselVo.setStatus("예약취소");
            }

            selfCounselVo.setReg_dt(selfCounselVo.getReg_dt().substring(0, 10));
        }
        int totalCount = campusService.selectSelfEduCounselListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "self_counsel_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "온라인 상담예약 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/old_program_mng.do", method = RequestMethod.GET)
    public void old_program_mng_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        List<TracProgramVo> itemList = selfHallService.selectProgramExcelList(searchVo);
        for(TracProgramVo tracProgramVo : itemList) {
            tracProgramVo.setCourse_sdate(DateUtil.dateFormat(tracProgramVo.getCourse_sdate()));
            tracProgramVo.setCourse_edate(DateUtil.dateFormat(tracProgramVo.getCourse_edate()));

            String div_cd  = tracProgramVo.getDiv_cd();
            if("10100001".equals(div_cd)) {
                tracProgramVo.setDiv_cd("어학");
            } else if("10100002".equals(div_cd)) {
                tracProgramVo.setDiv_cd("전통");
            } else if("10100003".equals(div_cd)) {
                tracProgramVo.setDiv_cd("공예");
            } else if("10100004".equals(div_cd)) {
                tracProgramVo.setDiv_cd("댄스");
            } else if("10100005".equals(div_cd)) {
                tracProgramVo.setDiv_cd("체조/체육");
            } else if("10100006".equals(div_cd)) {
                tracProgramVo.setDiv_cd("미술/음악");
            } else if("10100007".equals(div_cd)) {
                tracProgramVo.setDiv_cd("어린이/청소년");
            } else if("10100008".equals(div_cd)) {
                tracProgramVo.setDiv_cd("기타");
            } else if("10100009".equals(div_cd)) {
                tracProgramVo.setDiv_cd("주민자치교육");
            }

            tracProgramVo.setDong_cd(Util.getDongName(tracProgramVo.getDong_cd()));
        }
        int totalCount = selfHallService.selectProgramListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "old_program_mng.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "(구)프로그램관리 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/old_teacher_mng.do", method = RequestMethod.GET)
    public void old_teacher_mng_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        List<TracLecturerVo> itemList = selfHallService.selectTeacherExcelList(searchVo);
        for(TracLecturerVo tracLecturerVo : itemList) {
            tracLecturerVo.setBirthday(DateUtil.dateFormat(tracLecturerVo.getBirthday()));
            tracLecturerVo.setAgree_sdate(DateUtil.dateFormat(tracLecturerVo.getAgree_sdate()));
            tracLecturerVo.setAgree_edate(DateUtil.dateFormat(tracLecturerVo.getAgree_edate()));

            String div_cd  = tracLecturerVo.getDiv_cd();
            if("10100001".equals(div_cd)) {
                tracLecturerVo.setDiv_cd("어학");
            } else if("10100002".equals(div_cd)) {
                tracLecturerVo.setDiv_cd("전통");
            } else if("10100003".equals(div_cd)) {
                tracLecturerVo.setDiv_cd("공예");
            } else if("10100004".equals(div_cd)) {
                tracLecturerVo.setDiv_cd("댄스");
            } else if("10100005".equals(div_cd)) {
                tracLecturerVo.setDiv_cd("체조/체육");
            } else if("10100006".equals(div_cd)) {
                tracLecturerVo.setDiv_cd("미술/음악");
            } else if("10100007".equals(div_cd)) {
                tracLecturerVo.setDiv_cd("어린이/청소년");
            } else if("10100008".equals(div_cd)) {
                tracLecturerVo.setDiv_cd("기타");
            } else if("10100009".equals(div_cd)) {
                tracLecturerVo.setDiv_cd("주민자치교육");
            }

            String field_cd  = tracLecturerVo.getField_cd();
            if("10200001".equals(field_cd)) {
                tracLecturerVo.setField_cd("일반");
            } else if("10200002".equals(field_cd)) {
                tracLecturerVo.setField_cd("자원봉사자");
            }

            String sex  = tracLecturerVo.getSex();
            if("M".equals(sex)) {
                tracLecturerVo.setSex("남");
            } else if("F".equals(sex)) {
                tracLecturerVo.setSex("여");
            }
        }
        int totalCount = selfHallService.selectTeacherListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "old_teacher_mng.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "(구)강사관리 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/old_program_profit_list.do", method = RequestMethod.GET)
    public void old_program_profit_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        List<TracProgResultVo> itemList = selfHallService.selectProgramResultList(searchVo);
        for(TracProgResultVo tracProgResultVo : itemList) {
            tracProgResultVo.setDong_cd(Util.getDongName(tracProgResultVo.getDong_cd()));
        }
        int totalCount = selfHallService.selectProgramResultListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "old_program_profit_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "(구)프로그램실적등록 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/old_teacher_pay_list.do", method = RequestMethod.GET)
    public void old_teacher_pay_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        String start_dt = searchVo.getSearchSDate();
        if(start_dt.length() > 8) {
            searchVo.setSearchSDate(start_dt.substring(0, 7));
        }

        List<TracLecturerCostVo> itemList = selfHallService.selectTeacherPayExcelList(searchVo);
        for(TracLecturerCostVo tracLecturerCostVo : itemList) {
            tracLecturerCostVo.setDong_cd(Util.getDongName(tracLecturerCostVo.getDong_cd()));
        }
        int totalCount = selfHallService.selectTeacherPayListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "old_teacher_pay_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "(구)강사료 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/old_volunteer_pay_list.do", method = RequestMethod.GET)
    public void old_volunteer_pay_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        String start_dt = searchVo.getSearchSDate();
        if(start_dt.length() > 8) {
            searchVo.setSearchSDate(start_dt.substring(0, 7));
        }

        List<TracServiceCostVo> itemList = selfHallService.selectVolunteerPayExcelList(searchVo);
        for(TracServiceCostVo tracServiceCostVo : itemList) {
            tracServiceCostVo.setResi_no(DateUtil.dateFormat(tracServiceCostVo.getResi_no()));

            String div_cd  = tracServiceCostVo.getDiv_cd();
            if("10500001".equals(div_cd)) {
                tracServiceCostVo.setDiv_cd("회계담당");
            } else if("10500002".equals(div_cd)) {
                tracServiceCostVo.setDiv_cd("야간개방등");
            } else if("10500003".equals(div_cd)) {
                tracServiceCostVo.setDiv_cd("주말개방자 등");
            }

            tracServiceCostVo.setDong_cd(Util.getDongName(tracServiceCostVo.getDong_cd()));
        }
        int totalCount = selfHallService.selectVolunteerPayListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "old_volunteer_pay_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "(구)자원봉사활동비 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/old_fund_list.do", method = RequestMethod.GET)
    public void old_fund_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        String start_dt = searchVo.getSearchSDate();
        if(start_dt.length() > 8) {
            searchVo.setSearchSDate(start_dt.substring(0, 7));
        }

        int totAmount = 0;
        List<TracFundMngVo> itemList = selfHallService.selectFundList(searchVo);
        for(TracFundMngVo tracFundMngVo : itemList) {
            int amount = (int)tracFundMngVo.getAmount();
            totAmount += amount;

            tracFundMngVo.setStandard_yymm(tracFundMngVo.getStandard_yymm().substring(0, 4) + "년 " + tracFundMngVo.getStandard_yymm().substring(4, 6) + "월");

            String div_cd  = tracFundMngVo.getDiv_cd();
            if("10600001".equals(div_cd)) {
                tracFundMngVo.setDiv_cd("일반");
            } else if("10600002".equals(div_cd)) {
                tracFundMngVo.setDiv_cd("헬스장");
            }

            tracFundMngVo.setDong_cd(Util.getDongName(tracFundMngVo.getDong_cd()));
        }
        int totalCount = selfHallService.selectFundListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);
        beans.put("totAmount",totAmount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "old_fund_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "(구)기금등록 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/old_student_list.do", method = RequestMethod.GET)
    public void old_student_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        String start_dt = searchVo.getSearchSDate();
        if(start_dt.length() > 8) {
            searchVo.setSearchSDate(start_dt.substring(0, 7));
        }

        List<TracStudentVo> itemList = selfHallService.selectStudentExcelList(searchVo);
        for(TracStudentVo tracStudentVo : itemList) {
            if(!"".equals(Util.nvl(tracStudentVo.getStudent_resino()))) {
                tracStudentVo.setStudent_resino(DateUtil.dateFormat(tracStudentVo.getStudent_resino()));
            }

            String sex  = tracStudentVo.getSex();
            if("M".equals(sex)) {
                tracStudentVo.setSex("남");
            } else if("F".equals(sex)) {
                tracStudentVo.setSex("여");
            }

            tracStudentVo.setDong_cd(Util.getDongName(tracStudentVo.getDong_cd()));
        }
        int totalCount = selfHallService.selectStudentListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "old_student_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "(구)수강생등록 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/old_income_list.do", method = RequestMethod.GET)
    public void old_income_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        List<TracInoutVo> itemList = selfHallService.selectIncomeExcelList(searchVo);
        for(TracInoutVo tracInoutVo : itemList) {
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

                    String sex = tracStudentVo.getSex();
                    if("M".equals(sex)) {
                        tracStudentVo.setSex("남");
                    } else if("F".equals(sex)) {
                        tracStudentVo.setSex("여");
                    }
                }

                tracInoutVo.setTracStudentVo(tracStudentVo);
            }

            tracInoutVo.setDong_cd(Util.getDongName(tracInoutVo.getDong_cd()));
        }
        int totalCount = selfHallService.selectIncomeListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "old_income_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "(구)수입등록 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/old_expend_list.do", method = RequestMethod.GET)
    public void old_expend_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        List<TracInoutVo> itemList = selfHallService.selectOutcomeExcelList(searchVo);
        for(TracInoutVo tracInoutVo : itemList) {
            if(!"".equals(Util.nvl(tracInoutVo.getStandard_date()))) {
                tracInoutVo.setStandard_date(DateUtil.dateFormat(tracInoutVo.getStandard_date()));
            }

            tracInoutVo.setDong_cd(Util.getDongName(tracInoutVo.getDong_cd()));
        }
        int totalCount = selfHallService.selectOutcomeListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "old_expend_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "(구)지출등록 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/old_inout_report.do", method = RequestMethod.GET)
    public void old_inout_report_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

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

        int ex_total = 0;
        List<TracInoutVo> exList = selfHallService.selectOutcomeListEx(searchVo);
        for(TracInoutVo ex : exList) {
            ex.setDong_cd(Util.getDongName(ex.getDong_cd()));
            int ammout = (int)ex.getAmount();
            ex_total += ammout;
        }

        // 전기 이월 금액
        long in_prev_total = selfHallService.selectOldPrevInTotal(searchVo);
        long ex_prev_total = selfHallService.selectOldPrevExTotal(searchVo);
        long prev_total = in_prev_total - ex_prev_total;

        String dong_cd = searchVo.getSearchKind();
        if("".equals(dong_cd)) {
            dong_cd = "전체";
        } else {
            dong_cd = Util.getDongName(dong_cd);
        }

        String sdate = searchVo.getSearchSDate();
        String edate = searchVo.getSearchEDate();

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("inList",inList);
        beans.put("in_total",in_total);
        beans.put("exList",exList);
        beans.put("ex_total",ex_total);
        beans.put("dong_cd",dong_cd);
        beans.put("sdate",sdate);
        beans.put("edate",edate);
        beans.put("prev_total",prev_total);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "old_inout_report.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "(구)수입 및 지출내역 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/old_student_view.do", method = RequestMethod.GET)
    public void old_student_view_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        int student_seq = ServletRequestUtils.getIntParameter(request, "student_seq", 0);
        String searchVal10 = ServletRequestUtils.getStringParameter(request, "searchVal10", "");

        List<TracInoutVo> itemList = selfHallService.selectIncomeListByStudent(student_seq);
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

            String adj_yn = item.getAdj_yn();
            if("Y".equals(adj_yn)) {
                item.setAdj_yn("완료");
            } else {
                item.setAdj_yn("미완료");
            }
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "old_student_view.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVal10);
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "(구)수강자등록 수강이력 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/course_report.do", method = RequestMethod.GET)
    public void course_report_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {

        int inout_seq = ServletRequestUtils.getIntParameter(request, "inout_seq", 0);

        TracInoutVo tracInoutVo = selfHallService.selectInoutByIdx(inout_seq);

        TracStudentVo tracStudentVo = selfHallService.selectStudentByIdx(tracInoutVo.getStudent_seq());
        TracProgramVo tracProgramVo = selfHallService.selectProgramByIdx(tracInoutVo.getProg_seq());

        tracProgramVo.setCourse_sdate(DateUtil.dateFormatHangul(tracProgramVo.getCourse_sdate()));
        tracProgramVo.setCourse_edate(DateUtil.dateFormatHangul(tracProgramVo.getCourse_edate()));

        if(!"".equals(Util.nvl(tracStudentVo.getStudent_resino()))) {
            tracStudentVo.setStudent_resino(DateUtil.dateFormatHangul(tracStudentVo.getStudent_resino()));
        }
        tracInoutVo.setDong_cd(Util.getDongName(tracInoutVo.getDong_cd()));

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("tracInoutVo",tracInoutVo);
        beans.put("tracStudentVo",tracStudentVo);
        beans.put("tracProgramVo",tracProgramVo);
        beans.put("today",DateUtil.getDate(4));
        beans.put("admin_name",adminLoginVo.getName());
        beans.put("admin_telno",adminLoginVo.getTel_no());
        beans.put("cost",StringUtil.getCostFormat((int)tracInoutVo.getAmount()));

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "course_report.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                //엑셀명 지정
                String excelName = "(구)수강증" + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/old_expend_report.do", method = RequestMethod.GET)
    public void old_expend_report_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {

        int inout_seq = ServletRequestUtils.getIntParameter(request, "inout_seq", 0);

        TracInoutVo tracInoutVo = selfHallService.selectInoutByIdx(inout_seq);

        String today = DateUtil.dateFormatHangul(tracInoutVo.getStandard_date());

        tracInoutVo.setStandard_date(DateUtil.dateFormatEx(tracInoutVo.getStandard_date()));
        tracInoutVo.setDong_cd(Util.getDongName(tracInoutVo.getDong_cd()));

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("tracInoutVo",tracInoutVo);
        beans.put("today",today);
        beans.put("cost",StringUtil.getCostFormat((int)tracInoutVo.getAmount()));

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "old_expend_report.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                //엑셀명 지정
                String excelName = "(구)지출결의서" + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/new_program_profit_list.do", method = RequestMethod.GET)
    public void new_program_profit_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

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

        List<NewTracProgResultVo> itemList = selfHallService.selectNewProgramResultList(searchVo);
        for(NewTracProgResultVo newTracProgResultVo : itemList) {
            newTracProgResultVo.setDong_nm(appService.selectGruopByIdx(newTracProgResultVo.getGroup_idx()).getName());
            newTracProgResultVo.setLecture_nm(lectureService.selectLectureNameByIdx(newTracProgResultVo.getLecture_idx()));

            String div_cd = newTracProgResultVo.getDiv_cd();
            if("1".equals(div_cd)) {
                newTracProgResultVo.setDiv_cd("문화여가");
            } else if("2".equals(div_cd)) {
                newTracProgResultVo.setDiv_cd("인문교양");
            }
        }
        int totalCount = selfHallService.selectNewProgramResultListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "new_program_profit_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "프로그램실적등록 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/new_teacher_pay_list.do", method = RequestMethod.GET)
    public void new_teacher_pay_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        String end_dt = searchVo.getSearchEDate();
        if(end_dt.length() > 8) {
            searchVo.setSearchEDate(end_dt.substring(0, 7));
        }

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

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

        List<NewTracLecturerCostVo> itemList = selfHallService.selectNewTeacherPaytListExcel(searchVo);
        for(NewTracLecturerCostVo newTracLecturerCostVo : itemList) {
            newTracLecturerCostVo.setDong_nm(appService.selectGruopByIdx(newTracLecturerCostVo.getGroup_idx()).getName());
        }
        int totalCount = selfHallService.selectNewTeacherPayListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "new_teacher_pay_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "강사료신청 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/new_volunteer_pay_list.do", method = RequestMethod.GET)
    public void new_volunteer_pay_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        String end_dt = searchVo.getSearchEDate();
        if(end_dt.length() > 8) {
            searchVo.setSearchEDate(end_dt.substring(0, 7));
        }

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

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

        List<NewTracServiceCostVo> itemList = selfHallService.selectNewVolunteerPaytListExcel(searchVo);
        for(NewTracServiceCostVo newTracServiceCostVo : itemList) {
            newTracServiceCostVo.setDong_nm(appService.selectGruopByIdx(newTracServiceCostVo.getGroup_idx()).getName());
            String div_cd = newTracServiceCostVo.getDiv_cd();
            if("1".equals(div_cd)) {
                newTracServiceCostVo.setDiv_cd("회계지원");
            } else if("2".equals(div_cd)) {
                newTracServiceCostVo.setDiv_cd("야간개방");
            } else if("3".equals(div_cd)) {
                newTracServiceCostVo.setDiv_cd("주말개방");
            }
        }
        int totalCount = selfHallService.selectNewVolunteerPayListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "new_volunteer_pay_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "자원봉사활동비 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/new_fund_list.do", method = RequestMethod.GET)
    public void new_fund_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        String end_dt = searchVo.getSearchEDate();
        if(end_dt.length() > 8) {
            searchVo.setSearchEDate(end_dt.substring(0, 7));
        }

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

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

        int tot_amount = 0;
        List<NewTracFundMngVo> itemList = selfHallService.selectNewVFundtList(searchVo);
        for(NewTracFundMngVo newTracFundMngVo : itemList) {
            newTracFundMngVo.setDong_nm(appService.selectGruopByIdx(newTracFundMngVo.getGroup_idx()).getName());
            newTracFundMngVo.setStandard_yymm(newTracFundMngVo.getStandard_yymm().substring(0, 4) + "년 " + newTracFundMngVo.getStandard_yymm().substring(5, 7) + "월");
            tot_amount += newTracFundMngVo.getAmount();
            String div_cd = newTracFundMngVo.getDiv_cd();
            if("1".equals(div_cd)) {
                newTracFundMngVo.setDiv_cd("일반");
            } else if("2".equals(div_cd)) {
                newTracFundMngVo.setDiv_cd("헬스장");
            }
        }
        int totalCount = selfHallService.selectNewFundListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);
        beans.put("tot_amount",tot_amount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "new_fund_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "기금등록 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/new_income_list.do", method = RequestMethod.GET)
    public void new_income_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

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

        List<NewTracInoutVo> itemList = selfHallService.selectNewInCostListExcel(searchVo);
        for(NewTracInoutVo newTracInoutVo : itemList) {
            newTracInoutVo.setDong_nm(appService.selectGruopByIdx(newTracInoutVo.getGroup_idx()).getName());
            newTracInoutVo.setInout_cd_nm(appService.selectCodeByIdx(newTracInoutVo.getInout_cd()));
        }
        int totalCount = selfHallService.selectNewInCostListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "new_income_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "수입등록 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/new_course_report.do", method = RequestMethod.GET)
    public void new_course_report_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {

        int inout_seq = ServletRequestUtils.getIntParameter(request, "inout_seq", 0);

        NewTracInoutVo newTracInoutVo = selfHallService.selectNewInoutByIdx(inout_seq);

        newTracInoutVo.setDong_nm(appService.selectGruopByIdx(newTracInoutVo.getGroup_idx()).getName());

        newTracInoutVo.setSdate(DateUtil.dateFormatHangulEx(newTracInoutVo.getSdate()));
        newTracInoutVo.setEdate(DateUtil.dateFormatHangulEx(newTracInoutVo.getEdate()));

        if(newTracInoutVo.getLecture_idx() != 0) {
            LectureVo lectureVo = lectureService.selectLectureByIdx(newTracInoutVo.getLecture_idx());
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

            newTracInoutVo.setLecture_time(StringUtil.deleteLastStr(dt_str.trim(), ',') + " " + lectureVo.getStart_time() + " ~ " + lectureVo.getEnd_time());
        }

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("newTracInoutVo",newTracInoutVo);
        beans.put("today",DateUtil.getDate(4));
        beans.put("admin_name",adminLoginVo.getName());
        beans.put("admin_telno",adminLoginVo.getTel_no());
        beans.put("cost",StringUtil.getCostFormat((int)newTracInoutVo.getInout_cost()));

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "new_course_report.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                //엑셀명 지정
                String excelName = "수강증" + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/new_attend_report.do", method = RequestMethod.GET)
    public void new_attend_report_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {

        int inout_seq = ServletRequestUtils.getIntParameter(request, "inout_seq", 0);

        NewTracInoutVo newTracInoutVo = selfHallService.selectNewInoutByIdx(inout_seq);

        List<NewTracInoutVo> itemList = selfHallService.selectNewInoutByLectureIdx(newTracInoutVo.getLecture_idx());

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("newTracInoutVo",newTracInoutVo);
        beans.put("itemList",itemList);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "new_attend_report.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                //엑셀명 지정
                String excelName = "출석부" + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/new_income_report.do", method = RequestMethod.GET)
    public void new_income_report_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {

        String sdate = ServletRequestUtils.getStringParameter(request, "sdate", "");
        int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);

        int total_cost = 0;
        String name = "";
        GroupVo groupVo = new GroupVo();
        groupVo.setSdate(sdate);
        groupVo.setGroup_idx(group_idx);
        List<NewTracInoutVo> itemList = selfHallService.selectNewIncomeReportList(groupVo);
        for(NewTracInoutVo newTracInoutVo : itemList) {
            total_cost += newTracInoutVo.getInout_cost();
            name = newTracInoutVo.getInout_nm();
        }
        String dong_nm = appService.selectGruopByIdx(group_idx).getName();

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("total_cost",total_cost);
        beans.put("dong_nm",dong_nm);
        beans.put("sdate",DateUtil.dateFormatEx2(sdate));
        beans.put("sdate_hangul",DateUtil.dateFormatHangulEx(sdate));
        beans.put("year",sdate.substring(0, 4));
        beans.put("name",name);
        beans.put("item_size",itemList.size() - 1);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "new_income_report.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                //엑셀명 지정
                String excelName = "수입결의서 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/new_expend_list.do", method = RequestMethod.GET)
    public void new_expend_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 15);
        this.getModel(request, model, 15);

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

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

        List<NewTracInoutVo> itemList = selfHallService.selectNewExpendListExcel(searchVo);
        for(NewTracInoutVo newTracInoutVo : itemList) {
            newTracInoutVo.setDong_nm(appService.selectGruopByIdx(newTracInoutVo.getGroup_idx()).getName());
            newTracInoutVo.setInout_cd_nm(appService.selectCodeByIdx(newTracInoutVo.getInout_cd()));
        }
        int totalCount = selfHallService.selectNewExpendListTotal(searchVo);
        if(searchVo.getPageIndex() != 1) {
            totalCount = totalCount - (searchVo.getPageIndex() - 1) * searchVo.getPageSize();
        }

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "new_expend_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "지출등록 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/new_expend_report.do", method = RequestMethod.GET)
    public void new_expend_report_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {

        int inout_seq = ServletRequestUtils.getIntParameter(request, "inout_seq", 0);

        NewTracInoutVo newTracInoutVo = selfHallService.selectNewInoutByIdx(inout_seq);

        String today = DateUtil.dateFormatHangulEx(newTracInoutVo.getStandard_date());

        newTracInoutVo.setStandard_date(DateUtil.dateFormatEx2(newTracInoutVo.getStandard_date()));
        newTracInoutVo.setDong_nm(appService.selectGruopByIdx(newTracInoutVo.getGroup_idx()).getName());

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("newTracInoutVo",newTracInoutVo);
        beans.put("today",today);
        beans.put("cost",StringUtil.getCostFormat((int)newTracInoutVo.getInout_cost()));
        beans.put("year",today.substring(0, 4));
        beans.put("bank_nm",appService.selectCodeByIdx(newTracInoutVo.getBank_cd()));

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "new_expend_report.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                //엑셀명 지정
                String excelName = "지출결의서" + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/new_inout_report.do", method = RequestMethod.GET)
    public void new_inout_report_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

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

        int in_total = 0;
        List<NewTracInoutVo> inList = selfHallService.selectNewIncomeCostList(searchVo);
        for(NewTracInoutVo in : inList) {
            in.setDong_nm(appService.selectGruopByIdx(in.getGroup_idx()).getName());
            in.setInout_cd_nm(appService.selectCodeByIdx(in.getInout_cd()));

            int ammout = (int)in.getInout_cost();
            in_total += ammout;
        }

        int ex_total = 0;
        List<NewTracInoutVo> exList = selfHallService.selectNewExpendCostList(searchVo);
        for(NewTracInoutVo ex : exList) {
            ex.setDong_nm(appService.selectGruopByIdx(ex.getGroup_idx()).getName());
            ex.setInout_cd_nm(appService.selectCodeByIdx(ex.getInout_cd()));

            int ammout = (int)ex.getInout_cost();
            ex_total += ammout;
        }

        // 전기 이월 금액
        long in_prev_total = selfHallService.selectNewPrevInTotal(searchVo);
        long ex_prev_total = selfHallService.selectNewPrevExTotal(searchVo);
        long prev_total = in_prev_total - ex_prev_total;

        String group_idx = searchVo.getSearchKind();
        String dong_nm = "";
        if("".equals(group_idx)) {
            dong_nm = "전체";
        } else {
            dong_nm = appService.selectGruopByIdx(Integer.parseInt(group_idx)).getName();
        }

        String sdate = searchVo.getSearchSDate();
        String edate = searchVo.getSearchEDate();

        // 전기이월액 OLD
        int prev_total_old = Util.getPrevSumOld(searchVo.getSearchKind());

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("inList",inList);
        beans.put("in_total",in_total);
        beans.put("exList",exList);
        beans.put("ex_total",ex_total);
        beans.put("dong_nm",dong_nm);
        beans.put("sdate",sdate);
        beans.put("edate",edate);
        beans.put("prev_total",prev_total);
        beans.put("prev_total_old",prev_total_old);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "new_inout_report.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "수입 및 지출내역 목록 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/lawtax_list.do", method = RequestMethod.GET)
    public void lawtax_list_excel_save(HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception {

        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<LawtaxCounselVo> itemList = lawTaxService.selectLawTaxList(searchVo);
        for(LawtaxCounselVo lawtaxCounselVo : itemList) {
            String gbn = lawtaxCounselVo.getGbn();
            if("L".equals(gbn)) {
                lawtaxCounselVo.setGbn("법률");
            } else {
                lawtaxCounselVo.setGbn("세무");
            }

            String status = lawtaxCounselVo.getStatus();
            if("A".equals(status)) {
                lawtaxCounselVo.setStatus("신청");
                lawtaxCounselVo.setUp_dt("-");
            } else if("P".equals(status)) {
                lawtaxCounselVo.setStatus("처리 중");
                lawtaxCounselVo.setUp_dt("-");
            } else {
                lawtaxCounselVo.setStatus("답변완료");
                lawtaxCounselVo.setUp_dt(lawtaxCounselVo.getUp_dt().substring(0, 10));
            }

            lawtaxCounselVo.setReg_dt(lawtaxCounselVo.getReg_dt().substring(0, 10));
        }
        int totalCount = lawTaxService.selectLawTaxListTotal(searchVo);

        Map<String,Object> beans = new HashMap<String,Object>();
        beans.put("itemList",itemList);
        beans.put("Total",totalCount);

        XLSTransformer transformer = new XLSTransformer();
        String filename = EgovProperties.getProperty("excel.file.path") + "lawtax_list.xls";

        if(!filename.contains("../")) {
            File uFile = new File(filename);
            FileInputStream fis = new FileInputStream(uFile);
            try {
                HSSFWorkbook workbook = (HSSFWorkbook)transformer.transformXLS(fis, beans);
                Biff8EncryptionKey.setCurrentUserPassword(searchVo.getSearchVal10());
                workbook.writeProtectWorkbook(Biff8EncryptionKey.getCurrentUserPassword(), "");
                //엑셀명 지정
                String excelName = "법률세무상담 리스트 " + Util.getDate(3);

                if (!(excelName.contains("\r\n"))) {
                    //response.setHeader("Content-Type", "application/octet-stream");
                    response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(excelName + ".xls", "UTF-8").replaceAll("\\+", "%20"));
                    response.setContentType("application/x-msexcel");

                    workbook.write(response.getOutputStream());
                }
            } catch (IOException e) {
            } catch (Exception e) {
            } finally {
                try {
                    fis.close();
                } catch (IOException e) {
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();

            return;
        }
    }

    @RequestMapping(value="/cont/excel/private_insert.do", method = RequestMethod.POST)
    public ResponseEntity<String> private_insert(HttpServletRequest request, HttpServletResponse response,
                                                @ModelAttribute("statPrivateVo") StatPrivateVo statPrivateVo,
                                                BindingResult bindingResult,
                                                Model model,
                                                SessionStatus status)  throws Exception {

        try {
            HttpSession session = request.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            // DB 입력
            statPrivateVo.setGroup_idx(adminLoginVo.getGroup_idx());
            statPrivateVo.setAdmin_id(adminLoginVo.getAdmin_id());
            statPrivateVo.setName(adminLoginVo.getName());

            insertPrivateInfo(statPrivateVo);

            return new ResponseEntity<String>( JSON.toJSONString( statPrivateVo.getStat_private_idx() ), HttpStatus.OK );

        } catch ( Exception e ) {
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }

    private void insertPrivateInfo(StatPrivateVo statPrivateVo) throws Exception {
        // DB 입력
        String reason = statPrivateVo.getReason();
        if ("1".equals(reason)) {
            statPrivateVo.setReason_txt("교육 프로그램 관련 업무");
        } else if ("2".equals(reason)) {
            statPrivateVo.setReason_txt("시설 및 장비 대여 관련 업무");
        } else if ("3".equals(reason)) {
            statPrivateVo.setReason_txt("온라인 상담 예약 관련 업무");
        } else if ("4".equals(reason)) {
            statPrivateVo.setReason_txt("구민(회원) 민원처리");
        } else if ("5".equals(reason)) {

        }

        appService.insertPrivateInfo(statPrivateVo);
    }

    /*private ByteArrayOutputStream encrypt(ByteArrayOutputStream byteArrayOutputStream, String password) {
        try {
            InputStream inputStream = new ByteArrayInputStream(byteArrayOutputStream.toByteArray());
            POIFSFileSystem fs = new POIFSFileSystem();
            EncryptionInfo info = new EncryptionInfo(EncryptionMode.agile);
            Encryptor enc = info.getEncryptor();
            enc.confirmPassword(password);
            OPCPackage opc = OPCPackage.open(inputStream);
            OutputStream os = enc.getDataStream(fs);
            opc.save(os);
            opc.close();

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            fs.writeFilesystem(outputStream);
            outputStream.close();
            return outputStream;
        } catch (IOException e) {
            throw new RuntimeException();
        } catch (InvalidFormatException e) {
            throw new RuntimeException();
        } catch (GeneralSecurityException e) {
            throw new RuntimeException();
        }
    }*/
}
