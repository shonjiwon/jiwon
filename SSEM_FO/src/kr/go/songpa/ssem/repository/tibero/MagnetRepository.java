package kr.go.songpa.ssem.repository.tibero;

import kr.go.songpa.ssem.model.*;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.repository.tibero
 * Author : shlee
 * Date : 2020-11-13
 * Description :
 * History :
 * Version :
 */
public interface MagnetRepository {
    void insertHopeStudyInfo(HopeStudyVo hopeStudyVo) throws Exception;

    List<HopeStudyVo> selectHopeStudyList(SearchVo searchVo) throws Exception;

    int selectHopeStudyListTotal(SearchVo searchVo) throws Exception;

    HopeStudyVo selectHopeStudyInfo(HopeStudyVo hopeStudyVo) throws Exception;

    void updateHopeStudyViewCnt(HopeStudyVo hopeStudyVo) throws Exception;

    void insertJoinStudyInfo(JoinStudyVo joinStudyVo) throws Exception;

    HopeStudyVo selectHopeStudyByIdx(long hope_study_idx) throws Exception;

    int selectJoinStudyCount(JoinStudyVo joinStudyVo) throws Exception;

    List<JoinStudyVo> selectJoinListByIdx(int hope_study_idx) throws Exception;

    void insertTeachStudyInfo(TeachStudyVo teachStudyVo) throws Exception;

    List<ChannelStudyVo> selectChannelStudyList(SearchVo searchVo) throws Exception;

    int selectChannelStudyListTotal(SearchVo searchVo) throws Exception;

    void updateChannelStudyViewCnt(ChannelStudyVo channelStudyVo) throws Exception;

    ChannelStudyVo selectChannelStudyInfo(ChannelStudyVo channelStudyVo) throws Exception;

    ChannelStudyVo selectNextChannelStudy(ChannelStudyVo channelStudyVo) throws Exception;

    ChannelStudyVo selectPrevChannelStudy(ChannelStudyVo channelStudyVo) throws Exception;

    int selectJoinStudyCountByIdx(long hope_study_idx) throws Exception;

    void updateHopeStudyInfo(HopeStudyVo hopeStudyVo) throws Exception;

    void updateHopeStudyCancel(HopeStudyVo hopeStudyVo) throws Exception;

    List<TeachStudyVo> selectTeachStudyList(SearchVo searchVo) throws Exception;

    int selectTeachStudyListTotal(SearchVo searchVo) throws Exception;

    TeachStudyVo selectTeachStudyInfo(TeachStudyVo teachStudyVo) throws Exception;

    void updateTeachStudyInfo(TeachStudyVo teachStudyVo) throws Exception;

    void updateTeachStudyCancel(TeachStudyVo teachStudyVo) throws Exception;

    List<JoinStudyVo> selectJoinStudyList(SearchVo searchVo) throws Exception;

    int selectJoinStudyListTotal(SearchVo searchVo) throws Exception;

    JoinStudyVo selectJoinStudyInfo(JoinStudyVo joinStudyVo) throws Exception;

    void updateJoinStudyInfo(JoinStudyVo joinStudyVo) throws Exception;

    void deleteJoinStudyInfo(JoinStudyVo joinStudyVo) throws Exception;

    List<LectureVo> selectLectureList(String gubun) throws Exception;

    void insertTeacherApyInfo(TeacherApyVo teacherApyVo) throws Exception;
}
