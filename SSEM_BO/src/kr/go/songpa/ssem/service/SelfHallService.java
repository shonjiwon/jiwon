package kr.go.songpa.ssem.service;

import kr.go.songpa.ssem.model.*;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service
 * Author : shlee
 * Date : 2020-12-19
 * Description :
 * History :
 * Version :
 */
public interface SelfHallService {
    List<TracProgramVo> selectProgramList(SearchVo searchVo) throws Exception;

    int selectProgramListTotal(SearchVo searchVo) throws Exception;

    TracProgramVo selectProgramInfo(TracProgramVo tracProgramVo) throws Exception;

    List<TracLecturerVo> selectTeacherList(SearchVo searchVo) throws Exception;

    int selectTeacherListTotal(SearchVo searchVo) throws Exception;

    TracLecturerVo selectTeacherInfo(TracLecturerVo tracLecturerVo) throws Exception;

    List<TracLecturerCostVo> selectTeacherPayList(SearchVo searchVo) throws Exception;

    int selectTeacherPayListTotal(SearchVo searchVo) throws Exception;

    TracLecturerCostVo selectTeacherPayInfo(TracLecturerCostVo tracLecturerCostVo) throws Exception;

    List<TracServiceCostVo> selectVolunteerPayList(SearchVo searchVo) throws Exception;

    int selectVolunteerPayListTotal(SearchVo searchVo) throws Exception;

    TracServiceCostVo selectVolunteerPayInfo(TracServiceCostVo tracServiceCostVo) throws Exception;

    List<TracFundMngVo> selectFundList(SearchVo searchVo) throws Exception;

    int selectFundListTotal(SearchVo searchVo) throws Exception;

    List<TracStudentVo> selectStudentList(SearchVo searchVo) throws Exception;

    int selectStudentListTotal(SearchVo searchVo) throws Exception;

    TracStudentVo selectStudentInfo(TracStudentVo tracStudentVo) throws Exception;

    List<TracInoutVo> selectIncomeList(SearchVo searchVo) throws Exception;

    int selectIncomeListTotal(SearchVo searchVo) throws Exception;

    TracInoutVo selectInoutInfo(TracInoutVo tracInoutVo) throws Exception;

    TracStudentVo selectStudentByIdx(long student_seq) throws Exception;

    List<TracInoutVo> selectIncomeListByProgram(long prog_seq) throws Exception;

    List<TracInoutVo> selectOutcomeList(SearchVo searchVo) throws Exception;

    int selectOutcomeListTotal(SearchVo searchVo) throws Exception;

    List<TracInoutVo> selectIncomeListEx(SearchVo searchVo) throws Exception;

    List<TracInoutVo> selectOutcomeListEx(SearchVo searchVo) throws Exception;

    List<TracProgResultVo> selectProgramResultList(SearchVo searchVo) throws Exception;

    int selectProgramResultListTotal(SearchVo searchVo) throws Exception;

    TracProgResultVo selectProgramResultInfo(TracProgResultVo tracProgResultVo) throws Exception;

    TracProgramVo selectProgramByIdx(long prog_seq) throws Exception;

    List<TracInoutVo> selectIncomeListByStudent(long student_seq) throws Exception;

    TracInoutVo selectInoutByIdx(int inout_seq) throws Exception;

    void insertNewTracProgResultVo(NewTracProgResultVo newTracProgResultVo) throws Exception;

    List<NewTracProgResultVo> selectNewProgramResultList(SearchVo searchVo) throws Exception;

    int selectNewProgramResultListTotal(SearchVo searchVo) throws Exception;

    void deleteNewProgramResult(int prog_result_seq) throws Exception;

    List<NewTracProgResultVo> selectNewProgramResultListEx(GroupVo groupVo) throws Exception;

    void deleteNewTracProgResult(GroupVo groupVo) throws Exception;

    NewTracProgResultVo selectNewProgramResultInfoByIdx(int prog_result_seq) throws Exception;

    void updateNewProgramResult(NewTracProgResultVo newTracProgResultVo) throws Exception;

    void insertNewTracLecturerCost(NewTracLecturerCostVo newTracLecturerCostVo) throws Exception;

    List<NewTracLecturerCostVo> selectNewTeacherPaytList(SearchVo searchVo) throws Exception;

    int selectNewTeacherPayListTotal(SearchVo searchVo) throws Exception;

    NewTracLecturerCostVo selectNewTeacherPayInfoByIdx(int lecturer_cost) throws Exception;

    void updateNewTeacherPay(NewTracLecturerCostVo newTracLecturerCostVo) throws Exception;

    void deleteNewTeacherPay(int lecturer_cost) throws Exception;

    void insertNewVolunteerCost(NewTracServiceCostVo newTracServiceCostVo) throws Exception;

    List<NewTracServiceCostVo> selectNewVolunteerPaytList(SearchVo searchVo) throws Exception;

    int selectNewVolunteerPayListTotal(SearchVo searchVo) throws Exception;

    NewTracServiceCostVo selectNewVolunteerPayInfoByIdx(int service_cost_seq) throws Exception;

    void updateNewVolunteerPay(NewTracServiceCostVo newTracServiceCostVo) throws Exception;

    void deleteNewVolunteerPay(int service_cost_seq) throws Exception;

    void insertNewFundInfo(NewTracFundMngVo newTracFundMngVo) throws Exception;

    List<NewTracFundMngVo> selectNewVFundtList(SearchVo searchVo) throws Exception;

    int selectNewFundListTotal(SearchVo searchVo) throws Exception;

    NewTracFundMngVo selectNewFundInfoByIdx(int fund_mng_seq) throws Exception;

    void updateNewFund(NewTracFundMngVo newTracFundMngVo) throws Exception;

    void deleteNewFund(int fund_mng_seq) throws Exception;

    void insertNewInCost(NewTracInoutVo newTracInoutVo) throws Exception;

    List<NewTracInoutVo> selectNewInCostList(SearchVo searchVo) throws Exception;

    int selectNewInCostListTotal(SearchVo searchVo) throws Exception;

    NewTracInoutVo selectNewInoutByIdx(int inout_seq) throws Exception;

    void updateNewInCost(NewTracInoutVo newTracInoutVo) throws Exception;

    void deleteNewInoutInfo(int inout_seq) throws Exception;

    List<NewTracInoutVo> selectNewInCostListByStudent(long student_idx) throws Exception;

    List<NewTracInoutVo> selectNewInoutByLectureIdx(long lecture_idx) throws Exception;

    NewTracInoutVo selectNewInoutRefundInfo(NewTracInoutVo item) throws Exception;

    List<NewTracInoutVo> selectNewIncomeReportList(GroupVo groupVo) throws Exception;

    void insertNewExpendCost(NewTracInoutVo newTracInoutVo) throws Exception;

    List<NewTracInoutVo> selectPopupIncomeList(SearchVo searchVo) throws Exception;

    int selectPopupIncomeListTotal(SearchVo searchVo) throws Exception;

    void updateNewIncomeRefundByIdx(long ref_seq) throws Exception;

    List<NewTracInoutVo> selectNewExpendList(SearchVo searchVo) throws Exception;

    int selectNewExpendListTotal(SearchVo searchVo) throws Exception;

    void updateNewExpendCost(NewTracInoutVo newTracInoutVo) throws Exception;

    void updateNewExpendRefundByIdx(long inout_seq) throws Exception;

    List<NewTracInoutVo> selectNewIncomeCostList(SearchVo searchVo) throws Exception;

    List<NewTracInoutVo> selectNewExpendCostList(SearchVo searchVo) throws Exception;

    long selectOldPrevInTotal(SearchVo searchVo) throws Exception;

    long selectOldPrevExTotal(SearchVo searchVo) throws Exception;

    long selectNewPrevInTotal(SearchVo searchVo) throws Exception;

    long selectNewPrevExTotal(SearchVo searchVo) throws Exception;

    List<NewTracLecturerCostVo> selectNewTeacherPaytListExcel(SearchVo searchVo) throws Exception;

    List<NewTracServiceCostVo> selectNewVolunteerPaytListExcel(SearchVo searchVo) throws Exception;

    List<NewTracInoutVo> selectNewInCostListExcel(SearchVo searchVo) throws Exception;

    List<NewTracInoutVo> selectNewExpendListExcel(SearchVo searchVo) throws Exception;

    List<TracProgramVo> selectProgramExcelList(SearchVo searchVo) throws Exception;

    List<TracLecturerVo> selectTeacherExcelList(SearchVo searchVo) throws Exception;

    List<TracLecturerCostVo> selectTeacherPayExcelList(SearchVo searchVo) throws Exception;

    List<TracServiceCostVo> selectVolunteerPayExcelList(SearchVo searchVo) throws Exception;

    List<TracStudentVo> selectStudentExcelList(SearchVo searchVo) throws Exception;

    List<TracInoutVo> selectIncomeExcelList(SearchVo searchVo) throws Exception;

    List<TracInoutVo> selectOutcomeExcelList(SearchVo searchVo) throws Exception;
}
