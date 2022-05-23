package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.repository.tibero.SelfHallRepository;
import kr.go.songpa.ssem.service.SelfHallService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-12-19
 * Description :
 * History :
 * Version :
 */
@Service
public class SelfHallServiceImpl implements SelfHallService {
    @Autowired
    private SelfHallRepository selfHallRepository;

    @Override
    public List<TracProgramVo> selectProgramList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectProgramList(searchVo);
    }

    @Override
    public int selectProgramListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectProgramListTotal(searchVo);
    }

    @Override
    public TracProgramVo selectProgramInfo(TracProgramVo tracProgramVo) throws Exception {
        return selfHallRepository.selectProgramInfo(tracProgramVo);
    }

    @Override
    public List<TracLecturerVo> selectTeacherList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectTeacherList(searchVo);
    }

    @Override
    public int selectTeacherListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectTeacherListTotal(searchVo);
    }

    @Override
    public TracLecturerVo selectTeacherInfo(TracLecturerVo tracLecturerVo) throws Exception {
        return selfHallRepository.selectTeacherInfo(tracLecturerVo);
    }

    @Override
    public List<TracLecturerCostVo> selectTeacherPayList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectTeacherPayList(searchVo);
    }

    @Override
    public int selectTeacherPayListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectTeacherPayListTotal(searchVo);
    }

    @Override
    public TracLecturerCostVo selectTeacherPayInfo(TracLecturerCostVo tracLecturerCostVo) throws Exception {
        return selfHallRepository.selectTeacherPayInfo(tracLecturerCostVo);
    }

    @Override
    public List<TracServiceCostVo> selectVolunteerPayList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectVolunteerPayList(searchVo);
    }

    @Override
    public int selectVolunteerPayListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectVolunteerPayListTotal(searchVo);
    }

    @Override
    public TracServiceCostVo selectVolunteerPayInfo(TracServiceCostVo tracServiceCostVo) throws Exception {
        return selfHallRepository.selectVolunteerPayInfo(tracServiceCostVo);
    }

    @Override
    public List<TracFundMngVo> selectFundList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectFundList(searchVo);
    }

    @Override
    public int selectFundListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectFundListTotal(searchVo);
    }

    @Override
    public List<TracStudentVo> selectStudentList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectStudentList(searchVo);
    }

    @Override
    public int selectStudentListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectStudentListTotal(searchVo);
    }

    @Override
    public TracStudentVo selectStudentInfo(TracStudentVo tracStudentVo) throws Exception {
        return selfHallRepository.selectStudentInfo(tracStudentVo);
    }

    @Override
    public List<TracInoutVo> selectIncomeList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectIncomeList(searchVo);
    }

    @Override
    public int selectIncomeListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectIncomeListTotal(searchVo);
    }

    @Override
    public TracInoutVo selectInoutInfo(TracInoutVo tracInoutVo) throws Exception {
        return selfHallRepository.selectInoutInfo(tracInoutVo);
    }

    @Override
    public TracStudentVo selectStudentByIdx(long student_seq) throws Exception {
        return selfHallRepository.selectStudentByIdx(student_seq);
    }

    @Override
    public List<TracInoutVo> selectIncomeListByProgram(long prog_seq) throws Exception {
        return selfHallRepository.selectIncomeListByProgram(prog_seq);
    }

    @Override
    public List<TracInoutVo> selectOutcomeList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectOutcomeList(searchVo);
    }

    @Override
    public int selectOutcomeListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectOutcomeListTotal(searchVo);
    }

    @Override
    public List<TracInoutVo> selectIncomeListEx(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectIncomeListEx(searchVo);
    }

    @Override
    public List<TracInoutVo> selectOutcomeListEx(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectOutcomeListEx(searchVo);
    }

    @Override
    public List<TracProgResultVo> selectProgramResultList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectProgramResultList(searchVo);
    }

    @Override
    public int selectProgramResultListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectProgramResultListTotal(searchVo);
    }

    @Override
    public TracProgResultVo selectProgramResultInfo(TracProgResultVo tracProgResultVo) throws Exception {
        return selfHallRepository.selectProgramResultInfo(tracProgResultVo);
    }

    @Override
    public TracProgramVo selectProgramByIdx(long prog_seq) throws Exception {
        return selfHallRepository.selectProgramByIdx(prog_seq);
    }

    @Override
    public List<TracInoutVo> selectIncomeListByStudent(long student_seq) throws Exception {
        return selfHallRepository.selectIncomeListByStudent(student_seq);
    }

    @Override
    public TracInoutVo selectInoutByIdx(int inout_seq) throws Exception {
        return selfHallRepository.selectInoutByIdx(inout_seq);
    }

    @Override
    public void insertNewTracProgResultVo(NewTracProgResultVo newTracProgResultVo) throws Exception {
        selfHallRepository.insertNewTracProgResultVo(newTracProgResultVo);
    }

    @Override
    public List<NewTracProgResultVo> selectNewProgramResultList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewProgramResultList(searchVo);
    }

    @Override
    public int selectNewProgramResultListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewProgramResultListTotal(searchVo);
    }

    @Override
    public void deleteNewProgramResult(int prog_result_seq) throws Exception {
        selfHallRepository.deleteNewProgramResult(prog_result_seq);
    }

    @Override
    public List<NewTracProgResultVo> selectNewProgramResultListEx(GroupVo groupVo) throws Exception {
        return selfHallRepository.selectNewProgramResultListEx(groupVo);
    }

    @Override
    public void deleteNewTracProgResult(GroupVo groupVo) throws Exception {
        selfHallRepository.deleteNewTracProgResult(groupVo);
    }

    @Override
    public NewTracProgResultVo selectNewProgramResultInfoByIdx(int prog_result_seq) throws Exception {
        return selfHallRepository.selectNewProgramResultInfoByIdx(prog_result_seq);
    }

    @Override
    public void updateNewProgramResult(NewTracProgResultVo newTracProgResultVo) throws Exception {
        selfHallRepository.updateNewProgramResult(newTracProgResultVo);
    }

    @Override
    public void insertNewTracLecturerCost(NewTracLecturerCostVo newTracLecturerCostVo) throws Exception {
        selfHallRepository.insertNewTracLecturerCost(newTracLecturerCostVo);
    }

    @Override
    public List<NewTracLecturerCostVo> selectNewTeacherPaytList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewTeacherPaytList(searchVo);
    }

    @Override
    public int selectNewTeacherPayListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewTeacherPayListTotal(searchVo);
    }

    @Override
    public NewTracLecturerCostVo selectNewTeacherPayInfoByIdx(int lecturer_cost) throws Exception {
        return selfHallRepository.selectNewTeacherPayInfoByIdx(lecturer_cost);
    }

    @Override
    public void updateNewTeacherPay(NewTracLecturerCostVo newTracLecturerCostVo) throws Exception {
        selfHallRepository.updateNewTeacherPay(newTracLecturerCostVo);
    }

    @Override
    public void deleteNewTeacherPay(int lecturer_cost) throws Exception {
        selfHallRepository.deleteNewTeacherPay(lecturer_cost);
    }

    @Override
    public void insertNewVolunteerCost(NewTracServiceCostVo newTracServiceCostVo) throws Exception {
        selfHallRepository.insertNewVolunteerCost(newTracServiceCostVo);
    }

    @Override
    public List<NewTracServiceCostVo> selectNewVolunteerPaytList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewVolunteerPaytList(searchVo);
    }

    @Override
    public int selectNewVolunteerPayListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewVolunteerPayListTotal(searchVo);
    }

    @Override
    public NewTracServiceCostVo selectNewVolunteerPayInfoByIdx(int service_cost_seq) throws Exception {
        return selfHallRepository.selectNewVolunteerPayInfoByIdx(service_cost_seq);
    }

    @Override
    public void updateNewVolunteerPay(NewTracServiceCostVo newTracServiceCostVo) throws Exception {
        selfHallRepository.updateNewVolunteerPay(newTracServiceCostVo);
    }

    @Override
    public void deleteNewVolunteerPay(int service_cost_seq) throws Exception {
        selfHallRepository.deleteNewVolunteerPay(service_cost_seq);
    }

    @Override
    public void insertNewFundInfo(NewTracFundMngVo newTracFundMngVo) throws Exception {
        selfHallRepository.insertNewFundInfo(newTracFundMngVo);
    }

    @Override
    public List<NewTracFundMngVo> selectNewVFundtList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewVFundtList(searchVo);
    }

    @Override
    public int selectNewFundListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewFundListTotal(searchVo);
    }

    @Override
    public NewTracFundMngVo selectNewFundInfoByIdx(int fund_mng_seq) throws Exception {
        return selfHallRepository.selectNewFundInfoByIdx(fund_mng_seq);
    }

    @Override
    public void updateNewFund(NewTracFundMngVo newTracFundMngVo) throws Exception {
        selfHallRepository.updateNewFund(newTracFundMngVo);
    }

    @Override
    public void deleteNewFund(int fund_mng_seq) throws Exception {
        selfHallRepository.deleteNewFund(fund_mng_seq);
    }

    @Override
    public void insertNewInCost(NewTracInoutVo newTracInoutVo) throws Exception {
        selfHallRepository.insertNewInCost(newTracInoutVo);
    }

    @Override
    public List<NewTracInoutVo> selectNewInCostList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewInCostList(searchVo);
    }

    @Override
    public int selectNewInCostListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewInCostListTotal(searchVo);
    }

    @Override
    public NewTracInoutVo selectNewInoutByIdx(int inout_seq) throws Exception {
        return selfHallRepository.selectNewInoutByIdx(inout_seq);
    }

    @Override
    public void updateNewInCost(NewTracInoutVo newTracInoutVo) throws Exception {
        selfHallRepository.updateNewInCost(newTracInoutVo);
    }

    @Override
    public void deleteNewInoutInfo(int inout_seq) throws Exception {
        selfHallRepository.deleteNewInoutInfo(inout_seq);
    }

    @Override
    public List<NewTracInoutVo> selectNewInCostListByStudent(long student_idx) throws Exception {
        return selfHallRepository.selectNewInCostListByStudent(student_idx);
    }

    @Override
    public List<NewTracInoutVo> selectNewInoutByLectureIdx(long lecture_idx) throws Exception {
        return selfHallRepository.selectNewInoutByLectureIdx(lecture_idx);
    }

    @Override
    public NewTracInoutVo selectNewInoutRefundInfo(NewTracInoutVo item) throws Exception {
        return selfHallRepository.selectNewInoutRefundInfo(item);
    }

    @Override
    public List<NewTracInoutVo> selectNewIncomeReportList(GroupVo groupVo) throws Exception {
        return selfHallRepository.selectNewIncomeReportList(groupVo);
    }

    @Override
    public void insertNewExpendCost(NewTracInoutVo newTracInoutVo) throws Exception {
        selfHallRepository.insertNewExpendCost(newTracInoutVo);
    }

    @Override
    public List<NewTracInoutVo> selectPopupIncomeList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectPopupIncomeList(searchVo);
    }

    @Override
    public int selectPopupIncomeListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectPopupIncomeListTotal(searchVo);
    }

    @Override
    public void updateNewIncomeRefundByIdx(long ref_seq) throws Exception {
        selfHallRepository.updateNewIncomeRefundByIdx(ref_seq);
    }

    @Override
    public List<NewTracInoutVo> selectNewExpendList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewExpendList(searchVo);
    }

    @Override
    public int selectNewExpendListTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewExpendListTotal(searchVo);
    }

    @Override
    public void updateNewExpendCost(NewTracInoutVo newTracInoutVo) throws Exception {
        selfHallRepository.updateNewExpendCost(newTracInoutVo);
    }

    @Override
    public void updateNewExpendRefundByIdx(long inout_seq) throws Exception {
        selfHallRepository.updateNewExpendRefundByIdx(inout_seq);
    }

    @Override
    public List<NewTracInoutVo> selectNewIncomeCostList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewIncomeCostList(searchVo);
    }

    @Override
    public List<NewTracInoutVo> selectNewExpendCostList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewExpendCostList(searchVo);
    }

    @Override
    public long selectOldPrevInTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectOldPrevInTotal(searchVo);
    }

    @Override
    public long selectOldPrevExTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectOldPrevExTotal(searchVo);
    }

    @Override
    public long selectNewPrevInTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewPrevInTotal(searchVo);
    }

    @Override
    public long selectNewPrevExTotal(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewPrevExTotal(searchVo);
    }

    @Override
    public List<NewTracLecturerCostVo> selectNewTeacherPaytListExcel(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewTeacherPaytListExcel(searchVo);
    }

    @Override
    public List<NewTracServiceCostVo> selectNewVolunteerPaytListExcel(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewVolunteerPaytListExcel(searchVo);
    }

    @Override
    public List<NewTracInoutVo> selectNewInCostListExcel(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewInCostListExcel(searchVo);
    }

    @Override
    public List<NewTracInoutVo> selectNewExpendListExcel(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectNewExpendListExcel(searchVo);
    }

    @Override
    public List<TracProgramVo> selectProgramExcelList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectProgramExcelList(searchVo);
    }

    @Override
    public List<TracLecturerVo> selectTeacherExcelList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectTeacherExcelList(searchVo);
    }

    @Override
    public List<TracLecturerCostVo> selectTeacherPayExcelList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectTeacherPayExcelList(searchVo);
    }

    @Override
    public List<TracServiceCostVo> selectVolunteerPayExcelList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectVolunteerPayExcelList(searchVo);
    }

    @Override
    public List<TracStudentVo> selectStudentExcelList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectStudentExcelList(searchVo);
    }

    @Override
    public List<TracInoutVo> selectIncomeExcelList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectIncomeExcelList(searchVo);
    }

    @Override
    public List<TracInoutVo> selectOutcomeExcelList(SearchVo searchVo) throws Exception {
        return selfHallRepository.selectOutcomeExcelList(searchVo);
    }
}
