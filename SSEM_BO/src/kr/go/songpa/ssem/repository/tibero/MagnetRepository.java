package kr.go.songpa.ssem.repository.tibero;

import kr.go.songpa.ssem.model.*;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.repository.tibero
 * Author : shlee
 * Date : 2020-10-10
 * Description :
 * History :
 * Version :
 */
public interface MagnetRepository {
    void insertChannelStudyInfo(ChannelStudyVo channelStudyVo) throws Exception;

    List<ChannelStudyVo> selectChannelStudyList(SearchVo searchVo) throws Exception;

    int selectChannelStudyListTotal(SearchVo searchVo) throws Exception;

    void updateChannelStudyViewCnt(ChannelStudyVo channelStudyVo) throws Exception;

    ChannelStudyVo selectChannelStudyInfo(ChannelStudyVo channelStudyVo) throws Exception;

    void updateChannelStudyInfo(ChannelStudyVo channelStudyVo) throws Exception;

    void deleteChannelStudyInfo(ChannelStudyVo channelStudyVo) throws Exception;

    List<TeacherApyVo> selectTeachApplyList(SearchVo searchVo) throws Exception;

    int selectTeachApplyistTotal(SearchVo searchVo) throws Exception;

    TeacherApyVo selectTeachApplyInfo(TeacherApyVo teacherApyVo) throws Exception;

    void deleteTeachApplyInfo(TeacherApyVo teacherApyVo) throws Exception;

    void updateTeachApplyInfo(TeacherApyVo teacherApyVo) throws Exception;

    List<HopeStudyVo> selectHopeStudyList(SearchVo searchVo) throws Exception;

    int selectJoinStudyCountByIdx(long hope_study_idx) throws Exception;

    int selectHopeStudyListTotal(SearchVo searchVo) throws Exception;

    int selectTeachStudyCountByIdx(long hope_study_idx) throws Exception;

    HopeStudyVo selectHopeStudyInfo(HopeStudyVo hopeStudyVo) throws Exception;

    void updateHopeStudyInfo(HopeStudyVo hopeStudyVo) throws Exception;

    void deleteHopeStudyInfo(HopeStudyVo hopeStudyVo) throws Exception;

    List<JoinStudyVo> selectJoinStudyList(SearchVo searchVo) throws Exception;

    int selectJoinStudyListTotal(SearchVo searchVo) throws Exception;

    List<TeachStudyVo> selectTeachStudyList(SearchVo searchVo) throws Exception;

    int selectTeachStudyListTotal(SearchVo searchVo) throws Exception;

    TeachStudyVo selectTeachStudyInfoByIdx(int teach_study_idx) throws Exception;
}
