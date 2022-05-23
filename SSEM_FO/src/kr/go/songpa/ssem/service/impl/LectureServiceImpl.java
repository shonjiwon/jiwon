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
    public StudyPlaceVo selectStudyPlaceByIdx(long study_place_idx) throws Exception {
        return lectureRepository.selectStudyPlaceByIdx(study_place_idx);
    }

    @Override
    public DiscountVo selectDiscountByIdx(int discount_idx) throws Exception {
        return lectureRepository.selectDiscountByIdx(discount_idx);
    }

    @Override
    public TeacherVo selectTeacherInfoByIdx(long teacher_idx) throws Exception {
        return lectureRepository.selectTeacherInfoByIdx(teacher_idx);
    }

    @Override
    public int selectLoveCount(long lecture_idx) throws Exception {
        return lectureRepository.selectLoveCount(lecture_idx);
    }

    @Override
    public int checkLoveDupByUserId(LoveVo loveVo) throws Exception {
        return lectureRepository.checkLoveDupByUserId(loveVo);
    }

    @Override
    public void insertLoveInfo(LoveVo loveVo) throws Exception {
        lectureRepository.insertLoveInfo(loveVo);
    }

    @Override
    public int selectTeacherScoreTotalCnt(TeacherVo teacher) throws Exception {
        return lectureRepository.selectTeacherScoreTotalCnt(teacher);
    }

    @Override
    public int selectTeacherScoreTotal(TeacherVo teacher) throws Exception {
        return lectureRepository.selectTeacherScoreTotal(teacher);
    }

    @Override
    public void insertLectureApyInfo(LectureApyVo lectureApyVo) throws Exception {
        lectureRepository.insertLectureApyInfo(lectureApyVo);
    }

    @Override
    public int checkOnlineCanQtyByIdx(long lecture_apy_idx) throws Exception {
        return lectureRepository.checkOnlineCanQtyByIdx(lecture_apy_idx);
    }

    @Override
    public int checkWaitCanQtyByIdx(long lecture_apy_idx) throws Exception {
        return lectureRepository.checkWaitCanQtyByIdx(lecture_apy_idx);
    }

    @Override
    public void updateOnlineCanQtyMinusByIdx(long lecture_apy_idx) throws Exception {
        lectureRepository.updateOnlineCanQtyMinusByIdx(lecture_apy_idx);
    }

    @Override
    public void updateWaitCanQtyMinusByIdx(long lecture_apy_idx) throws Exception {
        lectureRepository.updateWaitCanQtyMinusByIdx(lecture_apy_idx);
    }

    @Override
    public LectureApyVo selectLectureApyInfoByIdx(LectureApyVo lectureApyVo) throws Exception {
        return lectureRepository.selectLectureApyInfoByIdx(lectureApyVo);
    }

    @Override
    public int checkLectureApySame(LectureApyVo lectureApyVo) throws Exception {
        return lectureRepository.checkLectureApySame(lectureApyVo);
    }

    @Override
    public int updateLectureApyPayResult(LectureApyVo lectureApyVo) throws Exception {
        return lectureRepository.updateLectureApyPayResult(lectureApyVo);
    }

    @Override
    public void updateLectureApyDiscountInfo(LectureApyVo lectureApyVo) throws Exception {
        lectureRepository.updateLectureApyDiscountInfo(lectureApyVo);
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
    public LectureApyVo selectLectureApyInfoByIdxEx(int lecture_apy_idx) throws Exception {
        return lectureRepository.selectLectureApyInfoByIdxEx(lecture_apy_idx);
    }

    @Override
    public int updateLectureApyPayCancel(LectureApyVo lectureApyVo) throws Exception {
        return lectureRepository.updateLectureApyPayCancel(lectureApyVo);
    }

    @Override
    public void updateOnlineCanQtyPlusByIdx(long lecture_idx) throws Exception {
        lectureRepository.updateOnlineCanQtyPlusByIdx(lecture_idx);
    }

    @Override
    public int updateLectureApyCancelByIdx(long lecture_apy_idx) throws Exception {
        return lectureRepository.updateLectureApyCancelByIdx(lecture_apy_idx);
    }

    @Override
    public void updateLectureApyRefund(LectureApyVo lectureApyVo) throws Exception {
        lectureRepository.updateLectureApyRefund(lectureApyVo);
    }

    @Override
    public List<LectureApyVo> selectLectureHistoryList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureHistoryList(searchVo);
    }

    @Override
    public int selectLectureHistoryListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureHistoryListTotal(searchVo);
    }

    @Override
    public void insertTeacherLoveInfo(LectureVo lectureVo) throws Exception {
        lectureRepository.insertTeacherLoveInfo(lectureVo);
    }

    @Override
    public void updateLectureApyTeacherLoveByIdx(int lecture_apy_idx) throws Exception {
        lectureRepository.updateLectureApyTeacherLoveByIdx(lecture_apy_idx);
    }

    @Override
    public TeacherSatisfactionVo selectTeacherLove(TeacherSatisfactionVo teacherSatisfactionVo) throws Exception {
        return lectureRepository.selectTeacherLove(teacherSatisfactionVo);
    }

    @Override
    public List<LectureVo> selectLectureTeachHistoryList(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureTeachHistoryList(searchVo);
    }

    @Override
    public int selectLectureTeachHistoryListTotal(SearchVo searchVo) throws Exception {
        return lectureRepository.selectLectureTeachHistoryListTotal(searchVo);
    }

    @Override
    public LectureVo selectLecureInfoByIdx(long lecture_idx) throws Exception {
        return lectureRepository.selectLecureInfoByIdx(lecture_idx);
    }

    @Override
    public int selectLoveCountBySelf(LoveVo love) throws Exception {
        return lectureRepository.selectLoveCountBySelf(love);
    }

    @Override
    public void deleteLoveInfo(LoveVo loveVo) throws Exception {
        lectureRepository.deleteLoveInfo(loveVo);
    }

    @Override
    public void updateLectureAppvCdByIdx(long lecture_apy_idx) throws Exception {
        lectureRepository.updateLectureAppvCdByIdx(lecture_apy_idx);
    }

    @Override
    public StudentVo selectStudentInfoByID(String apy_id) throws Exception {
        return lectureRepository.selectStudentInfoByID(apy_id);
    }

    @Override
    public void insertStudentLectInfo(StudentLectVo studentLectVo) throws Exception {
        lectureRepository.insertStudentLectInfo(studentLectVo);
    }

    @Override
    public void insertStudentInfo(StudentVo studentVo) throws Exception {
        lectureRepository.insertStudentInfo(studentVo);
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
    public StudentLectVo selectStudentLectInfo(StudentVo delete_student) throws Exception {
        return lectureRepository.selectStudentLectInfo(delete_student);
    }

    @Override
    public void deleteStudentLectInfoByIdx(long student_lect_idx) throws Exception {
        lectureRepository.deleteStudentLectInfoByIdx(student_lect_idx);
    }

    @Override
    public void deleteStudentInfoByIdx(long student_idx) throws Exception {
        lectureRepository.deleteStudentInfoByIdx(student_idx);
    }

    @Override
    public int selectStudentLectCheck(StudentVo studentVo) throws Exception {
        return lectureRepository.selectStudentLectCheck(studentVo);
    }
}
