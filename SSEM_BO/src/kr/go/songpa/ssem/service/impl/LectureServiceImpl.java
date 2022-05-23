package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.repository.tibero.LectureRepository;
import kr.go.songpa.ssem.service.LectureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-10-15
 * Description :
 * History :
 * Version :
 */
@Service
public class LectureServiceImpl implements LectureService {
    @Autowired
    private LectureRepository lectureRepository;


    @Override
    public List<GroupVo> selectGroupDiscountList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectGroupDiscountList(searchVo);
    }

    @Override
    public int selectGroupDiscountListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectGroupDiscountListTotal(searchVo);
    }

    @Override
    public List<DiscountVo> selectDiscountList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectDiscountList(searchVo);
    }

    @Override
    public int selectDiscountListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectDiscountListTotal(searchVo);
    }

    @Override
    public GroupVo selectGroupInfoByIdx(int group_idx) throws Exception {
        return lectureRepository.selectGroupInfoByIdx(group_idx);
    }

    @Override
    public void insertDiscountInfo(DiscountVo discountVo) throws Exception {
        lectureRepository.insertDiscountInfo(discountVo);
    }

    @Override
    public void updateDiscountInfo(DiscountVo discountVo) throws Exception {
        lectureRepository.updateDiscountInfo(discountVo);
    }

    @Override
    public int selectDiscountUseYn(DiscountVo discountVo) throws Exception {
        return lectureRepository.selectDiscountUseYn(discountVo);
    }

    @Override
    public void deleteDiscountInfo(DiscountVo discountVo) throws Exception {
        lectureRepository.deleteDiscountInfo(discountVo);
    }

    @Override
    public List<GroupVo> selectGroupRoomList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectGroupRoomList(searchVo);
    }

    @Override
    public int selectGroupRoomListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectGroupRoomListTotal(searchVo);
    }

    @Override
    public List<StudyPlaceVo> selectRoomList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectRoomList(searchVo);
    }

    @Override
    public int selectRoomListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectRoomListTotal(searchVo);
    }

    @Override
    public int selectRoomCntByGroupIdx(int group_idx) throws Exception {
        return lectureRepository.selectRoomCntByGroupIdx(group_idx);
    }

    @Override
    public void insertRoomInfo(StudyPlaceVo studyPlaceVo) throws Exception {
        lectureRepository.insertRoomInfo(studyPlaceVo);
    }

    @Override
    public int selectRoomUseYn(StudyPlaceVo studyPlaceVo) throws Exception {
        return lectureRepository.selectRoomUseYn(studyPlaceVo);
    }

    @Override
    public void deleteRoomInfo(StudyPlaceVo studyPlaceVo) throws Exception {
        lectureRepository.deleteRoomInfo(studyPlaceVo);
    }

    @Override
    public void updateRoomInfo(StudyPlaceVo studyPlaceVo) throws Exception {
        lectureRepository.updateRoomInfo(studyPlaceVo);
    }

    @Override
    public List<TeacherVo> selectTeacherList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectTeacherList(searchVo);
    }

    @Override
    public int selectTeacherListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectTeacherListTotal(searchVo);
    }

    @Override
    public List<TeacherVo> selectTeacherListEx(SearchVo searchVo) throws Exception {
        return lectureRepository.selectTeacherListEx(searchVo);
    }

    @Override
    public int selectTeacherListTotalEx(SearchVo searchVo) throws Exception {
        return lectureRepository.selectTeacherListTotalEx(searchVo);
    }

    @Override
    public void insertTeacherInfo(TeacherVo teacherVo) throws Exception {
        lectureRepository.insertTeacherInfo(teacherVo);
    }

    @Override
    public TeacherVo selectTeacherInfo(TeacherVo teacherVo) throws Exception {
        return lectureRepository.selectTeacherInfo(teacherVo);
    }

    @Override
    public void updateTeacherInfo(TeacherVo teacherVo) throws Exception {
        lectureRepository.updateTeacherInfo(teacherVo);
    }

    @Override
    public int selectTeacherUseYn(TeacherVo teacherVo) throws Exception {
        return lectureRepository.selectTeacherUseYn(teacherVo);
    }

    @Override
    public void deleteTeacherInfo(TeacherVo teacherVo) throws Exception {
        lectureRepository.deleteTeacherInfo(teacherVo);
    }

    @Override
    public List<LectureVo> selectLectureList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureList(searchVo);
    }

    @Override
    public int selectLectureListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureListTotal(searchVo);
    }

    @Override
    public void insertLectureInfo(LectureVo lectureVo) throws Exception {
        lectureRepository.insertLectureInfo(lectureVo);
    }

    @Override
    public List<DiscountVo> selectDiscountListEx(SearchVo searchVo) throws Exception {
        return lectureRepository.selectDiscountListEx(searchVo);
    }

    @Override
    public LectureVo selectLectureInfo(LectureVo lectureVo) throws Exception {
        return lectureRepository.selectLectureInfo(lectureVo);
    }

    @Override
    public String selectLectureNameByIdx(long lecture_idx) throws Exception {
        return lectureRepository.selectLectureNameByIdx(lecture_idx);
    }

    @Override
    public int selectLectureApyCountByIdx(long lecture_idx) throws Exception {
        return lectureRepository.selectLectureApyCountByIdx(lecture_idx);
    }

    @Override
    public void deleteLectureInfoByIdx(long lecture_idx) throws Exception {
        lectureRepository.deleteLectureInfoByIdx(lecture_idx);
    }

    @Override
    public String selectTeacherNameByIdx(long teacher_idx) throws Exception {
        return lectureRepository.selectTeacherNameByIdx(teacher_idx);
    }

    @Override
    public String selectStudyPlaceNameByIdx(long study_place_idx) throws Exception {
        return lectureRepository.selectStudyPlaceNameByIdx(study_place_idx);
    }

    @Override
    public void updateLectureInfo(LectureVo lectureVo) throws Exception {
        lectureRepository.updateLectureInfo(lectureVo);
    }

    @Override
    public DiscountVo selectDiscountByIdx(int parseInt) throws Exception {
        return lectureRepository.selectDiscountByIdx(parseInt);
    }

    @Override
    public LectureVo selectLectureByIdx(long lecture_idx) throws Exception {
        return lectureRepository.selectLectureByIdx(lecture_idx);
    }

    @Override
    public int selectLectureApyCancelCnttByIdx(int lecture_idx) throws Exception {
        return lectureRepository.selectLectureApyCancelCnttByIdx(lecture_idx);
    }

    @Override
    public int selectLecturePayWaitCntByIdx(int lecture_idx) throws Exception {
        return lectureRepository.selectLecturePayWaitCntByIdx(lecture_idx);
    }

    @Override
    public int selectLecturePayOkCntByIdx(int lecture_idx) throws Exception {
        return lectureRepository.selectLecturePayOkCntByIdx(lecture_idx);
    }

    @Override
    public int selectLecturePayCancelCntByIdx(int lecture_idx) throws Exception {
        return lectureRepository.selectLecturePayCancelCntByIdx(lecture_idx);
    }

    @Override
    public int selectLectureRefundApyCntByIdx(int lecture_idx) throws Exception {
        return lectureRepository.selectLectureRefundApyCntByIdx(lecture_idx);
    }

    @Override
    public int selectLectureRefundOkCntByIdx(int lecture_idx) throws Exception {
        return lectureRepository.selectLectureRefundOkCntByIdx(lecture_idx);
    }

    @Override
    public int selectLectureAppvOkCntByIdx(int lecture_idx) throws Exception {
        return lectureRepository.selectLectureAppvOkCntByIdx(lecture_idx);
    }

    @Override
    public int selectLectureAppvCancelCntByIdx(int lecture_idx) throws Exception {
        return lectureRepository.selectLectureAppvCancelCntByIdx(lecture_idx);
    }

    @Override
    public int selectLectureAppvNoCntByIdx(int lecture_idx) throws Exception {
        return lectureRepository.selectLectureAppvNoCntByIdx(lecture_idx);
    }

    @Override
    public List<LectureApyVo> selectLectureApyList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureApyList(searchVo);
    }

    @Override
    public int selectLectureApyListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureApyListTotal(searchVo);
    }

    @Override
    public void updateLectureAppvByIdx(int lecture_apy_idx) throws Exception {
        lectureRepository.updateLectureAppvByIdx(lecture_apy_idx);
    }

    @Override
    public void insertLectureApyInfo(LectureApyVo lectureApyVo) throws Exception {
        lectureRepository.insertLectureApyInfo(lectureApyVo);
    }

    @Override
    public LectureApyVo selectLectureApyInfoByIdx(int lecture_apy_idx) throws Exception {
        return lectureRepository.selectLectureApyInfoByIdx(lecture_apy_idx);
    }

    @Override
    public List<LectureApyVo> selectLectureUserHistoryList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureUserHistoryList(searchVo);
    }

    @Override
    public int selectLectureUserHistoryListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureUserHistoryListTotal(searchVo);
    }

    @Override
    public void updateLectureApyInfo(LectureApyVo lectureApyVo) throws Exception {
        lectureRepository.updateLectureApyInfo(lectureApyVo);
    }

    @Override
    public List<LectureVo> selectLectureStudentList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureStudentList(searchVo);
    }

    @Override
    public int selectLectureStudentListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureStudentListTotal(searchVo);
    }

    @Override
    public int selectLectureStudentCntByIdx(long lecture_idx) throws Exception {
        return lectureRepository.selectLectureStudentCntByIdx(lecture_idx);
    }

    @Override
    public void updateLectureCompletedByIdx(int lecture_apy_idx) throws Exception {
        lectureRepository.updateLectureCompletedByIdx(lecture_apy_idx);
    }

    @Override
    public void updateLectureApyCompleteInfo(LectureApyVo lectureApyVo) throws Exception {
        lectureRepository.updateLectureApyCompleteInfo(lectureApyVo);
    }

    @Override
    public void insertStudentInfo(StudentVo studentVo) throws Exception {
        lectureRepository.insertStudentInfo(studentVo);
    }

    @Override
    public void insertStudentLectInfo(StudentLectVo studentLectVo) throws Exception {
        lectureRepository.insertStudentLectInfo(studentLectVo);
    }

    @Override
    public StudentVo selectStudentInfoByID(String apy_id) throws Exception {
        return lectureRepository.selectStudentInfoByID(apy_id);
    }

    @Override
    public StudentVo selectStudentInfo(StudentVo studentVo) throws Exception {
        return lectureRepository.selectStudentInfo(studentVo);
    }

    @Override
    public int selectStudentLectCheckByID(StudentVo studentVo) throws Exception {
        return lectureRepository.selectStudentLectCheckByID(studentVo);
    }

    @Override
    public int selectStudentLectCheck(StudentVo studentVo) throws Exception {
        return lectureRepository.selectStudentLectCheck(studentVo);
    }

    @Override
    public void deleteStudentLectInfoByIdx(long student_idx) throws Exception {
        lectureRepository.deleteStudentLectInfoByIdx(student_idx);
    }

    @Override
    public void deleteStudentInfoByIdx(long student_idx) throws Exception {
        lectureRepository.deleteStudentInfoByIdx(student_idx);
    }

    @Override
    public StudentLectVo selectStudentLectInfo(StudentVo delete_student) throws Exception {
        return lectureRepository.selectStudentLectInfo(delete_student);
    }

    @Override
    public List<StudentVo> selectStudentList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectStudentList(searchVo);
    }

    @Override
    public int selectStudentListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectStudentListTotal(searchVo);
    }

    @Override
    public StudentVo selectStudentInfoByIdx(int student_idx) throws Exception {
        return lectureRepository.selectStudentInfoByIdx(student_idx);
    }

    @Override
    public void updateStudentInfo(StudentVo studentVo) throws Exception {
        lectureRepository.updateStudentInfo(studentVo);
    }

    @Override
    public int selectTeacherScoreTotalCnt(TeacherVo teacherVo) throws Exception {
        return lectureRepository.selectTeacherScoreTotalCnt(teacherVo);
    }

    @Override
    public int selectTeacherScoreTotal(TeacherVo teacherVo) throws Exception {
        return lectureRepository.selectTeacherScoreTotal(teacherVo);
    }

    @Override
    public String selectStudentMemoByIdx(long student_idx) throws Exception {
        return lectureRepository.selectStudentMemoByIdx(student_idx);
    }

    @Override
    public List<LectureVo> selectLectureRoomList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureRoomList(searchVo);
    }

    @Override
    public StudyPlaceVo selectStudyPlaceByIdx(int study_place_idx) throws Exception {
        return lectureRepository.selectStudyPlaceByIdx(study_place_idx);
    }

    @Override
    public void insertRegStudyPlaceInfo(RegStudyPlaceVo regStudyPlaceVo) throws Exception {
        lectureRepository.insertRegStudyPlaceInfo(regStudyPlaceVo);
    }

    @Override
    public List<RegStudyPlaceVo> selectRegStudyPlaceList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectRegStudyPlaceList(searchVo);
    }

    @Override
    public RegStudyPlaceVo selectRegStudyPlaceByIdx(int reg_study_place_idx) throws Exception {
        return lectureRepository.selectRegStudyPlaceByIdx(reg_study_place_idx);
    }

    @Override
    public void updateRegStudyPlaceInfo(RegStudyPlaceVo regStudyPlaceVo) throws Exception {
        lectureRepository.updateRegStudyPlaceInfo(regStudyPlaceVo);
    }

    @Override
    public List<LectureVo> selectLectureForTeacherList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureForTeacherList(searchVo);
    }

    @Override
    public int selectLectureForTeacherListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureForTeacherListTotal(searchVo);
    }

    @Override
    public void updateLectureForTeacher(LectureVo lectureVo) throws Exception {
        lectureRepository.updateLectureForTeacher(lectureVo);
    }

    @Override
    public LectureVo selectLecureInfoByIdx(long lecture_idx) throws Exception {
        return lectureRepository.selectLecureInfoByIdx(lecture_idx);
    }

    @Override
    public List<LectureApyVo> selectLectureApyListAutoCancel() throws Exception {
        return lectureRepository.selectLectureApyListAutoCancel();
    }

    @Override
    public void updateLectureAutoCancel(long lecture_apy_idx) throws Exception {
        lectureRepository.updateLectureAutoCancel(lecture_apy_idx);
    }

    @Override
    public List<LectureVo> selectLectureListEx(GroupVo groupVo) throws Exception {
        return lectureRepository.selectLectureListEx(groupVo);
    }

    @Override
    public List<StudentVo> selectStudentListEx(SearchVo searchVo) throws Exception {
        return lectureRepository.selectStudentListEx(searchVo);
    }

    @Override
    public int selectStudentListTotalEx(SearchVo searchVo) throws Exception {
        return lectureRepository.selectStudentListTotalEx(searchVo);
    }

    @Override
    public List<DiscountVo> selectDiscountListByGroupIdx(int group_idx) throws Exception {
        return lectureRepository.selectDiscountListByGroupIdx(group_idx);
    }

    @Override
    public int checkRegStudyPlace(RegStudyPlaceVo regStudyPlaceVo) throws Exception {
        return lectureRepository.checkRegStudyPlace(regStudyPlaceVo);
    }

    @Override
    public int checkLecturePlace(RegStudyPlaceVo regStudyPlaceVo) throws Exception {
        return lectureRepository.checkLecturePlace(regStudyPlaceVo);
    }

    @Override
    public void updateVisitCanQtyMinusByIdx(long lecture_idx) throws Exception {
        lectureRepository.updateVisitCanQtyMinusByIdx(lecture_idx);
    }

    @Override
    public void updateTelCanQtyMinusByIdx(long lecture_idx) throws Exception {
        lectureRepository.updateTelCanQtyMinusByIdx(lecture_idx);
    }

    @Override
    public void updateOnlineCanQtyPlusByIdx(long lecture_idx) throws Exception {
        lectureRepository.updateOnlineCanQtyPlusByIdx(lecture_idx);
    }

    @Override
    public void updateVisitCanQtyPlusByIdx(long lecture_idx) throws Exception {
        lectureRepository.updateVisitCanQtyPlusByIdx(lecture_idx);
    }

    @Override
    public void updateTelCanQtyPlusByIdx(long lecture_idx) throws Exception {
        lectureRepository.updateTelCanQtyPlusByIdx(lecture_idx);
    }

    @Override
    public void updateOnlineCanQtyMinusByIdx(long lecture_idx) throws Exception {
        lectureRepository.updateOnlineCanQtyMinusByIdx(lecture_idx);
    }

    @Override
    public int selectLectureFreeOkCntByIdx(int lecture_idx) throws Exception {
        return lectureRepository.selectLectureFreeOkCntByIdx(lecture_idx);
    }

    @Override
    public void updateWaitCanQtyPlusByIdx(long lecture_idx) throws Exception {
        lectureRepository.updateWaitCanQtyPlusByIdx(lecture_idx);
    }

    @Override
    public void updateWaitCanQtyMinusByIdx(long lecture_idx) throws Exception {
        lectureRepository.updateWaitCanQtyMinusByIdx(lecture_idx);
    }

    @Override
    public List<StudentVo> selectStudentListExcel(SearchVo searchVo) throws Exception {
        return lectureRepository.selectStudentListExcel(searchVo);
    }

    @Override
    public int selectStudentListExcelTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectStudentListExcelTotal(searchVo);
    }

    @Override
    public List<LectureVo> selectLectureListExcel(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureListExcel(searchVo);
    }

    @Override
    public List<LectureVo> selectLectureStudentListExcel(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureStudentListExcel(searchVo);
    }

    @Override
    public List<LectureApyVo> selectLectureApyListExcel(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureApyListExcel(searchVo);
    }

    @Override
    public int selectLectureApyListTotalExcel(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureApyListTotalExcel(searchVo);
    }

    @Override
    public StudentVo selectStudentInfoByName(LectureApyVo oldlectureApyVo) throws Exception {
        return lectureRepository.selectStudentInfoByName(oldlectureApyVo);
    }

    @Override
    public void updateLectureApyOfflineInfo(LectureApyVo lectureApyVo) throws Exception {
        lectureRepository.updateLectureApyOfflineInfo(lectureApyVo);
    }

    @Override
    public StudentVo selectStudentInfoByDaeri(StudentVo studentVo) throws Exception {
        return lectureRepository.selectStudentInfoByDaeri(studentVo);
    }

    @Override
    public StudentVo selectStudentInfoByOffLine(StudentVo studentVo) throws Exception {
        return lectureRepository.selectStudentInfoByOffLine(studentVo);
    }
}
