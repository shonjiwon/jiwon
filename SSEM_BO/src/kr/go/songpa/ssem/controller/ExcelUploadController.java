package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.FileMngService;
import kr.go.songpa.ssem.service.LectureService;
import kr.go.songpa.ssem.service.SelfHallService;
import kr.go.songpa.ssem.util.FileMngUtil;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-12-25
 * Description :
 * History :
 * Version :
 */
@Controller
public class ExcelUploadController extends CommonController {
    @Autowired
    private AppService appService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    @Autowired
    private SelfHallService selfHallService;

    @Autowired
    private LectureService lectureService;

    public ExcelUploadController() {
    }

    @RequestMapping(value = "/cont/excel/new_program_profit_excel_upload.do", method = RequestMethod.POST)
    public String new_program_profit_excel_upload(final MultipartHttpServletRequest multiRequest, Model model, SessionStatus status) throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                int group_idx = ServletRequestUtils.getIntParameter(multiRequest, "group_idx", 0);
                String standard_yymm = ServletRequestUtils.getStringParameter(multiRequest, "standard_yymm", "");

                // 엑셀 파일만 처리
                CommonVo cmm = this.getAttachFileInfoExcel(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        // 엑셀 파일 저장
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "EXCEL_", 1, "", EgovProperties.getProperty("ex_upload.file.path"));

                        // 1번만 돈다.
                        for(FileVo fileVo : result) {
                            FileInputStream file = new FileInputStream(fileVo.getFile_store_path() + fileVo.getFile_nm());
                            HSSFWorkbook workbook = new HSSFWorkbook(file);

                            // 첫번째 Sheet
                            HSSFSheet sheet = workbook.getSheetAt(0);
                            int rows = sheet.getPhysicalNumberOfRows();
                            for( int rowIndex=8; rowIndex < rows; rowIndex++){
                                HSSFRow row = sheet.getRow(rowIndex); // 각 행을 읽어온다
                                if (row != null) {
                                    int cells = row.getPhysicalNumberOfCells();
                                    NewTracProgResultVo newTracProgResultVo = new NewTracProgResultVo();
                                    for (int columnIndex = 0; columnIndex < cells; columnIndex++) {
                                        HSSFCell cell = row.getCell(columnIndex); // 셀에 담겨있는 값을 읽는다.
                                        if(cell == null) { break; }
                                        String value = "";
                                        switch (cell.getCellType()) { // 각 셀에 담겨있는 데이터의 타입을 체크하고 해당 타입에 맞게 가져온다.
                                            case HSSFCell.CELL_TYPE_NUMERIC:
                                                value = (int)cell.getNumericCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_STRING:
                                                value = cell.getStringCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_BLANK:
                                                value = cell.getBooleanCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_ERROR:
                                                value = cell.getErrorCellValue() + "";
                                                break;
                                        }

                                        // 구분 || 프로그램 || 비과세여부 || 남 || 여 || 성인여성 || 성인남성 || 청소년아동 || 노인 || 수강료(월) || 강사료(시간당) || 강의시간 || 운영횟수
                                        // 감액자(5%) || 감액자(10%) || 감액자(15%) || 감액자(20%) || 감액자(30%) || 감액자(50%) || 감액자(100%) || 기금 || 구비
                                        if(columnIndex == 0) {
                                            newTracProgResultVo.setDiv_cd(value);
                                        } else if(columnIndex == 1) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setLecture_idx(Long.parseLong(value));
                                            }
                                        } else if(columnIndex == 2) {
                                            newTracProgResultVo.setTax_exemption(value);
                                        } else if(columnIndex == 3) {
                                            newTracProgResultVo.setMan_cnt(value);
                                        } else if(columnIndex == 4) {
                                            newTracProgResultVo.setWoman_cnt(value);
                                        } else if(columnIndex == 5) {
                                            newTracProgResultVo.setAdult_woman_cnt(value);
                                        } else if(columnIndex == 6) {
                                            newTracProgResultVo.setAdult_man_cnt(value);
                                        } else if(columnIndex == 7) {
                                            newTracProgResultVo.setYouth_cnt(value);
                                        } else if(columnIndex == 8) {
                                            newTracProgResultVo.setOldman_cnt(value);
                                        } else if(columnIndex == 9) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setTuition_monthly_fee(Long.parseLong(value));
                                            }
                                        } else if(columnIndex == 10) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setLecturer_hourly_fee(Long.parseLong(value));
                                            }
                                        } else if(columnIndex == 11) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setLecture_hour(Long.parseLong(value));
                                            }
                                        } else if(columnIndex == 12) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setOperate_cnt(value);
                                            }
                                        } else if(columnIndex == 13) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setReduce5_cnt(Long.parseLong(value));
                                                newTracProgResultVo.setReduce5_cost((long)(newTracProgResultVo.getReduce5_cnt()*(newTracProgResultVo.getTuition_monthly_fee()*0.05)));
                                            }
                                        } else if(columnIndex == 14) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setReduce10_cnt(Long.parseLong(value));
                                                newTracProgResultVo.setReduce10_cost((long)(newTracProgResultVo.getReduce10_cnt()*(newTracProgResultVo.getTuition_monthly_fee()*0.1)));
                                            }
                                        } else if(columnIndex == 15) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setReduce15_cnt(Long.parseLong(value));
                                                newTracProgResultVo.setReduce15_cost((long)(newTracProgResultVo.getReduce15_cnt()*(newTracProgResultVo.getTuition_monthly_fee()*0.15)));
                                            }
                                        } else if(columnIndex == 16) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setReduce20_cnt(Long.parseLong(value));
                                                newTracProgResultVo.setReduce20_cost((long)(newTracProgResultVo.getReduce20_cnt()*(newTracProgResultVo.getTuition_monthly_fee()*0.2)));
                                            }
                                        } else if(columnIndex == 17) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setReduce25_cnt(Long.parseLong(value));
                                                newTracProgResultVo.setReduce25_cost((long)(newTracProgResultVo.getReduce25_cnt()*(newTracProgResultVo.getTuition_monthly_fee()*0.25)));
                                            }
                                        } else if(columnIndex == 18) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setReduce30_cnt(Long.parseLong(value));
                                                newTracProgResultVo.setReduce30_cost((long)(newTracProgResultVo.getReduce30_cnt()*(newTracProgResultVo.getTuition_monthly_fee()*0.3)));
                                            }
                                        } else if(columnIndex == 19) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setReduce50_cnt(Long.parseLong(value));
                                                newTracProgResultVo.setReduce50_cost((long)(newTracProgResultVo.getReduce50_cnt()*(newTracProgResultVo.getTuition_monthly_fee()*0.5)));
                                            }
                                        } else if(columnIndex == 20) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setReduce100_cnt(Long.parseLong(value));
                                                newTracProgResultVo.setReduce100_cost(newTracProgResultVo.getReduce100_cnt()*(newTracProgResultVo.getTuition_monthly_fee()));
                                            }
                                        } else if(columnIndex == 21) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setLecturer_fund_cost(Long.parseLong(value));
                                            }
                                        } else if(columnIndex == 22) {
                                            if(!"false".equals(value)) {
                                                newTracProgResultVo.setLecturer_exist_cost(Long.parseLong(value));
                                            }
                                        }
                                    }

                                    newTracProgResultVo.setReg_id(adminLoginVo.getAdmin_id());
                                    newTracProgResultVo.setGroup_idx(group_idx);
                                    newTracProgResultVo.setStandard_yymm(standard_yymm);
                                    selfHallService.insertNewTracProgResultVo(newTracProgResultVo);
                                }
                            }
                        }
                    }

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/self/new_program_profit_list.do");
                    model.addAttribute("altmsg", "일괄업로드에 성공하였습니다.");

                } else {
                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/self/new_program_profit_list.do");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", "/ssemadmin/cont/self/new_program_profit_list.do");
            model.addAttribute("altmsg", "등록에 실패하였습니다. <br/>양식파일과 기입된 내용 확인 후 다시 등록해 주세요.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/excel/new_teacher_pay_excel_upload.do", method = RequestMethod.POST)
    public String new_teacher_pay_excel_upload(final MultipartHttpServletRequest multiRequest, Model model, SessionStatus status) throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                // 엑셀 파일만 처리
                CommonVo cmm = this.getAttachFileInfoExcel(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        // 엑셀 파일 저장
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "EXCEL_", 1, "", EgovProperties.getProperty("ex_upload.file.path"));

                        // 1번만 돈다.
                        for(FileVo fileVo : result) {
                            FileInputStream file = new FileInputStream(fileVo.getFile_store_path() + fileVo.getFile_nm());
                            HSSFWorkbook workbook = new HSSFWorkbook(file);

                            // 첫번째 Sheet
                            HSSFSheet sheet = workbook.getSheetAt(0);
                            int rows = sheet.getPhysicalNumberOfRows();
                            for( int rowIndex=7; rowIndex < rows; rowIndex++){
                                HSSFRow row = sheet.getRow(rowIndex); // 각 행을 읽어온다
                                if (row != null) {
                                    int cells = row.getPhysicalNumberOfCells();
                                    for (int columnIndex = 0; columnIndex < cells; columnIndex++) {
                                        HSSFCell cell = row.getCell(columnIndex); // 셀에 담겨있는 값을 읽는다.
                                        String value = "";
                                        switch (cell.getCellType()) { // 각 셀에 담겨있는 데이터의 타입을 체크하고 해당 타입에 맞게 가져온다.
                                            case HSSFCell.CELL_TYPE_NUMERIC:
                                                value = cell.getNumericCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_STRING:
                                                value = cell.getStringCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_BLANK:
                                                value = cell.getBooleanCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_ERROR:
                                                value = cell.getErrorCellValue() + "";
                                                break;
                                        }
                                    }
                                }
                            }
                        }
                    }

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/self/new_teacher_pay_list.do");
                    model.addAttribute("altmsg", "일괄업로드에 성공하였습니다.");

                } else {
                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/self/new_teacher_pay_list.do");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", "/ssemadmin/cont/self/new_teacher_pay_list.do");
            model.addAttribute("altmsg", "일괄업로드에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/excel/new_volunteer_pay_excel_upload.do", method = RequestMethod.POST)
    public String new_volunteer_pay_excel_upload(final MultipartHttpServletRequest multiRequest, Model model, SessionStatus status) throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                int group_idx = ServletRequestUtils.getIntParameter(multiRequest, "group_idx", 0);
                String standard_yymm = ServletRequestUtils.getStringParameter(multiRequest, "standard_yymm", "");

                // 엑셀 파일만 처리
                CommonVo cmm = this.getAttachFileInfoExcel(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        // 엑셀 파일 저장
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "EXCEL_", 1, "", EgovProperties.getProperty("ex_upload.file.path"));

                        // 1번만 돈다.
                        for(FileVo fileVo : result) {
                            FileInputStream file = new FileInputStream(fileVo.getFile_store_path() + fileVo.getFile_nm());
                            HSSFWorkbook workbook = new HSSFWorkbook(file);

                            // 첫번째 Sheet
                            HSSFSheet sheet = workbook.getSheetAt(0);
                            int rows = sheet.getPhysicalNumberOfRows();
                            for( int rowIndex=5; rowIndex < rows; rowIndex++){
                                HSSFRow row = sheet.getRow(rowIndex); // 각 행을 읽어온다
                                if (row != null) {
                                    int cells = row.getPhysicalNumberOfCells();
                                    NewTracServiceCostVo newTracServiceCostVo = new NewTracServiceCostVo();
                                    for (int columnIndex = 0; columnIndex < cells; columnIndex++) {
                                        HSSFCell cell = row.getCell(columnIndex); // 셀에 담겨있는 값을 읽는다.
                                        if(cell == null) { break; }
                                        String value = "";
                                        switch (cell.getCellType()) { // 각 셀에 담겨있는 데이터의 타입을 체크하고 해당 타입에 맞게 가져온다.
                                            case HSSFCell.CELL_TYPE_NUMERIC:
                                                value = (int)cell.getNumericCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_STRING:
                                                value = cell.getStringCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_BLANK:
                                                value = cell.getBooleanCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_ERROR:
                                                value = cell.getErrorCellValue() + "";
                                                break;
                                        }

                                        // 구분 || 생년월일 || 이름 || 근무일수 || 금액 || 비고
                                        if(columnIndex == 0) {
                                            newTracServiceCostVo.setDiv_cd(value);
                                        } else if(columnIndex == 1) {
                                            newTracServiceCostVo.setResi_no(value);
                                        } else if(columnIndex == 2) {
                                            newTracServiceCostVo.setNm(value);
                                        } else if(columnIndex == 3) {
                                            newTracServiceCostVo.setWork_cnt(Long.parseLong(value));
                                        } else if(columnIndex == 4) {
                                            newTracServiceCostVo.setAmount(Long.parseLong(value));
                                        } else if(columnIndex == 5) {
                                            newTracServiceCostVo.setNote(value);
                                        }
                                    }

                                    newTracServiceCostVo.setReg_id(adminLoginVo.getAdmin_id());
                                    newTracServiceCostVo.setGroup_idx(group_idx);
                                    newTracServiceCostVo.setStandard_yymm(standard_yymm);
                                    selfHallService.insertNewVolunteerCost(newTracServiceCostVo);
                                }
                            }
                        }
                    }

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/self/new_volunteer_pay_list.do");
                    model.addAttribute("altmsg", "일괄업로드에 성공하였습니다.");

                } else {
                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/self/new_volunteer_pay_list.do");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", "/ssemadmin/cont/self/new_volunteer_pay_list.do");
            model.addAttribute("altmsg", "등록에 실패하였습니다. <br/>양식파일과 기입된 내용 확인 후 다시 등록해 주세요.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/excel/new_fund_excel_upload.do", method = RequestMethod.POST)
    public String new_fund_excel_upload(final MultipartHttpServletRequest multiRequest, Model model, SessionStatus status) throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                int group_idx = ServletRequestUtils.getIntParameter(multiRequest, "group_idx", 0);
                String standard_yymm = ServletRequestUtils.getStringParameter(multiRequest, "standard_yymm", "");

                // 엑셀 파일만 처리
                CommonVo cmm = this.getAttachFileInfoExcel(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        // 엑셀 파일 저장
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "EXCEL_", 1, "", EgovProperties.getProperty("ex_upload.file.path"));

                        // 1번만 돈다.
                        for(FileVo fileVo : result) {
                            FileInputStream file = new FileInputStream(fileVo.getFile_store_path() + fileVo.getFile_nm());
                            HSSFWorkbook workbook = new HSSFWorkbook(file);

                            // 첫번째 Sheet
                            HSSFSheet sheet = workbook.getSheetAt(0);
                            int rows = sheet.getPhysicalNumberOfRows();
                            for( int rowIndex=5; rowIndex < rows; rowIndex++){
                                HSSFRow row = sheet.getRow(rowIndex); // 각 행을 읽어온다
                                if (row != null) {
                                    int cells = row.getPhysicalNumberOfCells();
                                    NewTracFundMngVo newTracFundMngVo = new NewTracFundMngVo();
                                    for (int columnIndex = 0; columnIndex < cells; columnIndex++) {
                                        HSSFCell cell = row.getCell(columnIndex); // 셀에 담겨있는 값을 읽는다.
                                        if(cell == null) { break; }
                                        String value = "";
                                        switch (cell.getCellType()) { // 각 셀에 담겨있는 데이터의 타입을 체크하고 해당 타입에 맞게 가져온다.
                                            case HSSFCell.CELL_TYPE_NUMERIC:
                                                value = (int)cell.getNumericCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_STRING:
                                                value = cell.getStringCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_BLANK:
                                                value = cell.getBooleanCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_ERROR:
                                                value = cell.getErrorCellValue() + "";
                                                break;
                                        }

                                        // 구분 || 기금잔액 || 비고
                                        if(columnIndex == 0) {
                                            newTracFundMngVo.setDiv_cd(value);
                                        } else if(columnIndex == 1) {
                                            newTracFundMngVo.setAmount(Long.parseLong(value));
                                        } else if(columnIndex == 2) {
                                            newTracFundMngVo.setNote(value);
                                        }
                                    }

                                    newTracFundMngVo.setReg_id(adminLoginVo.getAdmin_id());
                                    newTracFundMngVo.setGroup_idx(group_idx);
                                    newTracFundMngVo.setStandard_yymm(standard_yymm);
                                    selfHallService.insertNewFundInfo(newTracFundMngVo);
                                }
                            }
                        }
                    }

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/self/new_fund_list.do");
                    model.addAttribute("altmsg", "일괄업로드에 성공하였습니다.");

                } else {
                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/self/new_fund_list.do");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", "/ssemadmin/cont/self/new_fund_list.do");
            model.addAttribute("altmsg", "등록에 실패하였습니다. <br/>양식파일과 기입된 내용 확인 후 다시 등록해 주세요.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/excel/new_income_excel_upload.do", method = RequestMethod.POST)
    public String new_income_excel_upload(final MultipartHttpServletRequest multiRequest, Model model, SessionStatus status) throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                int group_idx = ServletRequestUtils.getIntParameter(multiRequest, "group_idx", 0);
                // 엑셀 파일만 처리
                CommonVo cmm = this.getAttachFileInfoExcel(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        // 엑셀 파일 저장
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "EXCEL_", 1, "", EgovProperties.getProperty("ex_upload.file.path"));

                        // 1번만 돈다.
                        for(FileVo fileVo : result) {
                            FileInputStream file = new FileInputStream(fileVo.getFile_store_path() + fileVo.getFile_nm());
                            HSSFWorkbook workbook = new HSSFWorkbook(file);

                            // 첫번째 Sheet
                            HSSFSheet sheet = workbook.getSheetAt(0);
                            int rows = sheet.getPhysicalNumberOfRows();
                            for( int rowIndex=8; rowIndex < rows; rowIndex++){
                                HSSFRow row = sheet.getRow(rowIndex); // 각 행을 읽어온다
                                if (row != null) {
                                    int cells = row.getPhysicalNumberOfCells();
                                    NewTracInoutVo newTracInoutVo = new NewTracInoutVo();
                                    for (int columnIndex = 0; columnIndex < cells; columnIndex++) {
                                        HSSFCell cell = row.getCell(columnIndex); // 셀에 담겨있는 값을 읽는다.
                                        if(cell == null) { break; }
                                        String value = "";
                                        switch (cell.getCellType()) { // 각 셀에 담겨있는 데이터의 타입을 체크하고 해당 타입에 맞게 가져온다.
                                            case HSSFCell.CELL_TYPE_NUMERIC:
                                                value = (int)cell.getNumericCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_STRING:
                                                value = cell.getStringCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_BLANK:
                                                value = cell.getBooleanCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_ERROR:
                                                value = cell.getErrorCellValue() + "";
                                                break;
                                        }

                                        // 프로그램일련번호 || 수입일자 || 구분 || 이름 || 수강기간시작일 || 수강기간종료일 || 수입액 || 정산구분 || 비고
                                        if(columnIndex == 0) {
                                            if(!"false".equals(value)) {
                                                String lecture_nm = lectureService.selectLectureNameByIdx(Long.parseLong(value));
                                                newTracInoutVo.setLecture_nm(lecture_nm);
                                                newTracInoutVo.setLecture_idx(Long.parseLong(value));
                                            }
                                        } else if(columnIndex == 1) {
                                            newTracInoutVo.setStandard_date(value);
                                        } else if(columnIndex == 2) {
                                            newTracInoutVo.setInout_cd(Long.parseLong(value));
                                        } else if(columnIndex == 3) {
                                            newTracInoutVo.setInout_nm(value);
                                        } else if(columnIndex == 4) {
                                            newTracInoutVo.setSdate(value);
                                        } else if(columnIndex == 5) {
                                            newTracInoutVo.setEdate(value);
                                        } else if(columnIndex == 6) {
                                            newTracInoutVo.setInout_cost(Long.parseLong(value));
                                        } else if(columnIndex == 7) {
                                            newTracInoutVo.setAdj_yn(value);
                                        } else if(columnIndex == 8) {
                                            newTracInoutVo.setNote(value);
                                        }
                                    }

                                    newTracInoutVo.setReg_id(adminLoginVo.getAdmin_id());
                                    newTracInoutVo.setGroup_idx(group_idx);
                                    selfHallService.insertNewInCost(newTracInoutVo);
                                }
                            }
                        }
                    }

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/self/new_income_list.do");
                    model.addAttribute("altmsg", "일괄업로드에 성공하였습니다.");

                } else {
                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/self/new_income_list.do");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", "/ssemadmin/cont/self/new_income_list.do");
            model.addAttribute("altmsg", "일괄업로드에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/excel/new_expend_excel_upload.do", method = RequestMethod.POST)
    public String new_expend_excel_upload(final MultipartHttpServletRequest multiRequest, Model model, SessionStatus status) throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                int group_idx = ServletRequestUtils.getIntParameter(multiRequest, "group_idx", 0);

                // 엑셀 파일만 처리
                CommonVo cmm = this.getAttachFileInfoExcel(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        // 엑셀 파일 저장
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "EXCEL_", 1, "", EgovProperties.getProperty("ex_upload.file.path"));

                        // 1번만 돈다.
                        for(FileVo fileVo : result) {
                            FileInputStream file = new FileInputStream(fileVo.getFile_store_path() + fileVo.getFile_nm());
                            HSSFWorkbook workbook = new HSSFWorkbook(file);

                            // 첫번째 Sheet
                            HSSFSheet sheet = workbook.getSheetAt(0);
                            int rows = sheet.getPhysicalNumberOfRows();
                            for( int rowIndex=9; rowIndex < rows; rowIndex++){
                                HSSFRow row = sheet.getRow(rowIndex); // 각 행을 읽어온다
                                if (row != null) {
                                    int cells = row.getPhysicalNumberOfCells();
                                    NewTracInoutVo newTracInoutVo = new NewTracInoutVo();
                                    for (int columnIndex = 0; columnIndex < cells; columnIndex++) {
                                        HSSFCell cell = row.getCell(columnIndex); // 셀에 담겨있는 값을 읽는다.
                                        if(cell == null) { break; }
                                        String value = "";
                                        switch (cell.getCellType()) { // 각 셀에 담겨있는 데이터의 타입을 체크하고 해당 타입에 맞게 가져온다.
                                            case HSSFCell.CELL_TYPE_NUMERIC:
                                                value = (int)cell.getNumericCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_STRING:
                                                value = cell.getStringCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_BLANK:
                                                value = cell.getBooleanCellValue() + "";
                                                break;
                                            case HSSFCell.CELL_TYPE_ERROR:
                                                value = cell.getErrorCellValue() + "";
                                                break;
                                        }

                                        // 지출일자 || 구분 || 지출액 || 이름 || 프로그램일련번호 || 우편번호 || 주소 || 상세주소 || 지출방법 || 은행명 || 계좌번호 || 비고
                                        if(columnIndex == 0) {
                                            newTracInoutVo.setStandard_date(value);
                                        } else if(columnIndex == 1) {
                                            newTracInoutVo.setInout_cd(Long.parseLong(value));
                                        } else if(columnIndex == 2) {
                                            newTracInoutVo.setInout_cost(Long.parseLong(value));
                                        } else if(columnIndex == 3) {
                                            newTracInoutVo.setInout_nm(value);
                                        } else if(columnIndex == 4) {
                                            if(!"false".equals(value)) {
                                                String lecture_nm = lectureService.selectLectureNameByIdx(Long.parseLong(value));
                                                newTracInoutVo.setLecture_nm(lecture_nm);
                                                newTracInoutVo.setLecture_idx(Long.parseLong(value));
                                            }
                                        } else if(columnIndex == 5) {
                                            newTracInoutVo.setPost_no(value);
                                        } else if(columnIndex == 6) {
                                            newTracInoutVo.setAddr(value);
                                        } else if(columnIndex == 7) {
                                            newTracInoutVo.setAddr_detail(value);
                                        } else if(columnIndex == 8) {
                                            newTracInoutVo.setMethod_cd(value);
                                        } else if(columnIndex == 9) {
                                            if(!"false".equals(value)) {
                                                newTracInoutVo.setBank_cd(Long.parseLong(value));
                                            }
                                        } else if(columnIndex == 10) {
                                            if(!"false".equals(value)) {
                                                newTracInoutVo.setBank_no(value);
                                            }
                                        } else if(columnIndex == 11) {
                                            if(!"false".equals(value)) {
                                                newTracInoutVo.setE_note(value);
                                            }
                                        }
                                    }

                                    newTracInoutVo.setReg_id(adminLoginVo.getAdmin_id());
                                    newTracInoutVo.setGroup_idx(group_idx);
                                    selfHallService.insertNewExpendCost(newTracInoutVo);
                                }
                            }
                        }
                    }

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/self/new_expend_list.do");
                    model.addAttribute("altmsg", "일괄업로드에 성공하였습니다.");

                } else {
                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/self/new_expend_list.do");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", "/ssemadmin/cont/self/new_expend_list.do");
            model.addAttribute("altmsg", "등록에 실패하였습니다. <br/>양식파일과 기입된 내용 확인 후 다시 등록해 주세요.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }
}
