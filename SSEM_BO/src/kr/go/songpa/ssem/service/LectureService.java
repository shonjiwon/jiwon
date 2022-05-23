package kr.go.songpa.ssem.service;

import kr.go.songpa.ssem.model.*;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service
 * Author : shlee
 * Date : 2020-10-15
 * Description :
 * History :
 * Version :
 */
public interface LectureService {
    List<GroupVo> selectGroupDiscountList(SearchVo searchVo) throws Exception;

    int selectGroupDiscountListTotal(SearchVo searchVo) throws Exception;

    List<DiscountVo> selectDiscountList(SearchVo searchVo) throws Exception;

    int selectDiscountListTotal(SearchVo searchVo) throws Exception;

    GroupVo selectGroupInfoByIdx(int group_idx) throws Exception;

    void insertDiscountInfo(DiscountVo discountVo) throws Exception;

    void updateDiscountInfo(DiscountVo discountVo) throws Exception;

    int selectDiscountUseYn(DiscountVo discountVo) throws Exception;

    void deleteDiscountInfo(DiscountVo discountVo) throws Exception;

    List<GroupVo> selectGroupRoomList(SearchVo searchVo) throws Exception;

    int selectGroupRoomListTotal(SearchVo searchVo) throws Exception;

    List<StudyPlaceVo> selectRoomList(SearchVo searchVo) throws Exception;

    int selectRoomListTotal(SearchVo searchVo) throws Exception;

    int selectRoomCntByGroupIdx(int group_idx) throws Exception;

    void insertRoomInfo(StudyPlaceVo studyPlaceVo) throws Exception;

    int selectRoomUseYn(StudyPlaceVo studyPlaceVo) throws Exception;

    void deleteRoomInfo(StudyPlaceVo studyPlaceVo) throws Exception;

    void updateRoomInfo(StudyPlaceVo studyPlaceVo) throws Exception;

    List<TeacherVo> selectTeacherList(SearchVo searchVo) throws Exception;

    int selectTeacherListTotal(SearchVo searchVo) throws Exception;

    List<TeacherVo> selectTeacherListEx(SearchVo searchVo) throws Exception;

    int selectTeacherListTotalEx(SearchVo searchVo) throws Exception;

    void insertTeacherInfo(TeacherVo teacherVo) throws Exception;

    TeacherVo selectTeacherInfo(TeacherVo teacherVo) throws Exception;

    void updateTeacherInfo(TeacherVo teacherVo) throws Exception;

    int selectTeacherUseYn(TeacherVo teacherVo) throws Exception;

    void deleteTeacherInfo(TeacherVo teacherVo) throws Exception;

    List<LectureVo> selectLectureList(SearchVo searchVo) throws Exception;

    int selectLectureListTotal(SearchVo searchVo) throws Exception;

    void insertLectureInfo(LectureVo lectureVo) throws Exception;

    List<DiscountVo> selectDiscountListEx(SearchVo searchVo) throws Exception;

    LectureVo selectLectureInfo(LectureVo lectureVo) throws Exception;

    String selectLectureNameByIdx(long lecture_idx) throws Exception;

    int selectLectureApyCountByIdx(long lecture_idx) throws Exception;

    void deleteLectureInfoByIdx(long lecture_idx) throws Exception;

    String selectTeacherNameByIdx(long teacher_idx) throws Exception;

    String selectStudyPlaceNameByIdx(long study_place_idx) throws Exception;

    void updateLectureInfo(LectureVo lectureVo) throws Exception;

    DiscountVo selectDiscountByIdx(int parseInt) throws Exception;

    LectureVo selectLectureByIdx(long lecture_idx) throws Exception;

    int selectLectureApyCancelCnttByIdx(int lecture_idx) throws Exception;

    int selectLecturePayWaitCntByIdx(int lecture_idx) throws Exception;

    int selectLecturePayOkCntByIdx(int lecture_idx) throws Exception;

    int selectLecturePayCancelCntByIdx(int lecture_idx) throws Exception;

    int selectLectureRefundApyCntByIdx(int lecture_idx) throws Exception;

    int selectLectureRefundOkCntByIdx(int lecture_idx) throws Exception;

    int selectLectureAppvOkCntByIdx(int lecture_idx) throws Exception;

    int selectLectureAppvCancelCntByIdx(int lecture_idx) throws Exception;

    int selectLectureAppvNoCntByIdx(int lecture_idx) throws Exception;

    List<LectureApyVo> selectLectureApyList(SearchVo searchVo) throws Exception;

    int selectLectureApyListTotal(SearchVo searchVo) throws Exception;

    void updateLectureAppvByIdx(int lecture_apy_idx) throws Exception;

    void insertLectureApyInfo(LectureApyVo lectureApyVo) throws Exception;

    LectureApyVo selectLectureApyInfoByIdx(int lecture_apy_idx) throws Exception;

    List<LectureApyVo> selectLectureUserHistoryList(SearchVo searchVo) throws Exception;

    int selectLectureUserHistoryListTotal(SearchVo searchVo) throws Exception;

    void updateLectureApyInfo(LectureApyVo lectureApyVo) throws Exception;

    List<LectureVo> selectLectureStudentList(SearchVo searchVo) throws Exception;

    int selectLectureStudentListTotal(SearchVo searchVo) throws Exception;

    int selectLectureStudentCntByIdx(long lecture_idx) throws Exception;

    void updateLectureCompletedByIdx(int lecture_apy_idx) throws Exception;

    void updateLectureApyCompleteInfo(LectureApyVo lectureApyVo) throws Exception;

    void insertStudentInfo(StudentVo studentVo) throws Exception;

    void insertStudentLectInfo(StudentLectVo studentLectVo) throws Exception;

    StudentVo selectStudentInfoByID(String apy_id) throws Exception;

    StudentVo selectStudentInfo(StudentVo studentVo) throws Exception;

    int selectStudentLectCheckByID(StudentVo studentVo) throws Exception;

    int selectStudentLectCheck(StudentVo studentVo) throws Exception;

    void deleteStudentLectInfoByIdx(long student_idx) throws Exception;

    void deleteStudentInfoByIdx(long student_idx) throws Exception;

    StudentLectVo selectStudentLectInfo(StudentVo delete_student) throws Exception;

    List<StudentVo> selectStudentList(SearchVo searchVo) throws Exception;

    int selectStudentListTotal(SearchVo searchVo) throws Exception;

    StudentVo selectStudentInfoByIdx(int student_idx) throws Exception;

    void updateStudentInfo(StudentVo studentVo) throws Exception;

    int selectTeacherScoreTotalCnt(TeacherVo teacherVo) throws Exception;

    int selectTeacherScoreTotal(TeacherVo teacherVo) throws Exception;

    String selectStudentMemoByIdx(long student_idx) throws Exception;

    List<LectureVo> selectLectureRoomList(SearchVo searchVo) throws Exception;

    StudyPlaceVo selectStudyPlaceByIdx(int study_place_idx) throws Exception;

    void insertRegStudyPlaceInfo(RegStudyPlaceVo regStudyPlaceVo) throws Exception;

    List<RegStudyPlaceVo> selectRegStudyPlaceList(SearchVo searchVo) throws Exception;

    RegStudyPlaceVo selectRegStudyPlaceByIdx(int reg_study_place_idx) throws Exception;

    void updateRegStudyPlaceInfo(RegStudyPlaceVo regStudyPlaceVo) throws Exception;

    List<LectureVo> selectLectureForTeacherList(SearchVo searchVo) throws Exception;

    int selectLectureForTeacherListTotal(SearchVo searchVo) throws Exception;

    void updateLectureForTeacher(LectureVo lectureVo) throws Exception;

    LectureVo selectLecureInfoByIdx(long lecture_idx) throws Exception;

    List<LectureApyVo> selectLectureApyListAutoCancel() throws Exception;

    void updateLectureAutoCancel(long lecture_apy_idx) throws Exception;

    List<LectureVo> selectLectureListEx(GroupVo groupVo) throws Exception;

    List<StudentVo> selectStudentListEx(SearchVo searchVo) throws Exception;

    int selectStudentListTotalEx(SearchVo searchVo) throws Exception;

    List<DiscountVo> selectDiscountListByGroupIdx(int group_idx) throws Exception;

    int checkRegStudyPlace(RegStudyPlaceVo regStudyPlaceVo) throws Exception;

    int checkLecturePlace(RegStudyPlaceVo regStudyPlaceVo) throws Exception;

    void updateVisitCanQtyMinusByIdx(long lecture_idx) throws Exception;

    void updateTelCanQtyMinusByIdx(long lecture_idx) throws Exception;

    void updateOnlineCanQtyPlusByIdx(long lecture_idx) throws Exception;

    void updateVisitCanQtyPlusByIdx(long lecture_idx) throws Exception;

    void updateTelCanQtyPlusByIdx(long lecture_idx) throws Exception;

    void updateOnlineCanQtyMinusByIdx(long lecture_idx) throws Exception;

    int selectLectureFreeOkCntByIdx(int lecture_idx) throws Exception;

    void updateWaitCanQtyPlusByIdx(long lecture_idx) throws Exception;

    void updateWaitCanQtyMinusByIdx(long lecture_idx) throws Exception;

    List<StudentVo> selectStudentListExcel(SearchVo searchVo) throws Exception;

    int selectStudentListExcelTotal(SearchVo searchVo) throws Exception;

    List<LectureVo> selectLectureListExcel(SearchVo searchVo) throws Exception;

    List<LectureVo> selectLectureStudentListExcel(SearchVo searchVo) throws Exception;

    List<LectureApyVo> selectLectureApyListExcel(SearchVo searchVo) throws Exception;

    int selectLectureApyListTotalExcel(SearchVo searchVo) throws Exception;

    StudentVo selectStudentInfoByName(LectureApyVo oldlectureApyVo) throws Exception;

    void updateLectureApyOfflineInfo(LectureApyVo lectureApyVo) throws Exception;

    StudentVo selectStudentInfoByDaeri(StudentVo studentVo) throws Exception;

    StudentVo selectStudentInfoByOffLine(StudentVo studentVo) throws Exception;
}
