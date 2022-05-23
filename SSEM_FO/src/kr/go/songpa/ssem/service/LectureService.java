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

    StudyPlaceVo selectStudyPlaceByIdx(long study_place_idx) throws Exception;

    DiscountVo selectDiscountByIdx(int discount_idx) throws Exception;

    TeacherVo selectTeacherInfoByIdx(long teacher_idx) throws Exception;

    int selectLoveCount(long lecture_idx) throws Exception;

    int checkLoveDupByUserId(LoveVo loveVo) throws Exception;

    void insertLoveInfo(LoveVo loveVo) throws Exception;

    int selectTeacherScoreTotalCnt(TeacherVo teacher) throws Exception;

    int selectTeacherScoreTotal(TeacherVo teacher) throws Exception;

    void insertLectureApyInfo(LectureApyVo lectureApyVo) throws Exception;

    int checkOnlineCanQtyByIdx(long lecture_apy_idx) throws Exception;

    int checkWaitCanQtyByIdx(long lecture_apy_idx) throws Exception;

    void updateOnlineCanQtyMinusByIdx(long lecture_apy_idx) throws Exception;

    void updateWaitCanQtyMinusByIdx(long lecture_apy_idx) throws Exception;

    LectureApyVo selectLectureApyInfoByIdx(LectureApyVo lectureApyVo) throws Exception;

    int checkLectureApySame(LectureApyVo lectureApyVo) throws Exception;

    int updateLectureApyPayResult(LectureApyVo lectureApyVo) throws Exception;

    void updateLectureApyDiscountInfo(LectureApyVo lectureApyVo) throws Exception;

    List<LectureApyVo> selectLectureApyList(SearchVo searchVo) throws Exception;

    int selectLectureApyListTotal(SearchVo searchVo) throws Exception;

    LectureApyVo selectLectureApyInfoByIdxEx(int lecture_apy_idx) throws Exception;

    int updateLectureApyPayCancel(LectureApyVo lectureApyVo) throws Exception;

    void updateOnlineCanQtyPlusByIdx(long lecture_idx) throws Exception;

    int updateLectureApyCancelByIdx(long lecture_apy_idx) throws Exception;

    void updateLectureApyRefund(LectureApyVo lectureApyVo) throws Exception;

    List<LectureApyVo> selectLectureHistoryList(SearchVo searchVo) throws Exception;

    int selectLectureHistoryListTotal(SearchVo searchVo) throws Exception;

    void insertTeacherLoveInfo(LectureVo lectureVo) throws Exception;

    void updateLectureApyTeacherLoveByIdx(int lecture_apy_idx) throws Exception;

    TeacherSatisfactionVo selectTeacherLove(TeacherSatisfactionVo teacherSatisfactionVo) throws Exception;

    List<LectureVo> selectLectureTeachHistoryList(SearchVo searchVo) throws Exception;

    int selectLectureTeachHistoryListTotal(SearchVo searchVo) throws Exception;

    LectureVo selectLecureInfoByIdx(long lecture_idx) throws Exception;

    int selectLoveCountBySelf(LoveVo love) throws Exception;

    void deleteLoveInfo(LoveVo loveVo) throws Exception;

    void updateLectureAppvCdByIdx(long lecture_apy_idx) throws Exception;

    StudentVo selectStudentInfoByID(String apy_id) throws Exception;

    void insertStudentLectInfo(StudentLectVo studentLectVo) throws Exception;

    void insertStudentInfo(StudentVo studentVo) throws Exception;

    StudentVo selectStudentInfo(StudentVo studentVo) throws Exception;

    int selectStudentLectCheckByID(StudentVo studentVo) throws Exception;

    StudentLectVo selectStudentLectInfo(StudentVo delete_student) throws Exception;

    void deleteStudentLectInfoByIdx(long student_lect_idx) throws Exception;

    void deleteStudentInfoByIdx(long student_idx) throws Exception;

    int selectStudentLectCheck(StudentVo studentVo) throws Exception;
}
