package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.repository.tibero.MagnetRepository;
import kr.go.songpa.ssem.service.MagnetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-10-10
 * Description :
 * History :
 * Version :
 */
@Service
public class MagnetServiceImpl implements MagnetService {

    @Autowired
    private MagnetRepository magnetRepository;

    @Override
    public void insertChannelStudyInfo(ChannelStudyVo channelStudyVo) throws Exception {
        magnetRepository.insertChannelStudyInfo(channelStudyVo);
    }

    @Override
    public List<ChannelStudyVo> selectChannelStudyList(SearchVo searchVo) throws Exception {
        return magnetRepository.selectChannelStudyList(searchVo);
    }

    @Override
    public int selectChannelStudyListTotal(SearchVo searchVo) throws Exception {
        return magnetRepository.selectChannelStudyListTotal(searchVo);
    }

    @Override
    public void updateChannelStudyViewCnt(ChannelStudyVo channelStudyVo) throws Exception {
        magnetRepository.updateChannelStudyViewCnt(channelStudyVo);
    }

    @Override
    public ChannelStudyVo selectChannelStudyInfo(ChannelStudyVo channelStudyVo) throws Exception {
        return magnetRepository.selectChannelStudyInfo(channelStudyVo);
    }

    @Override
    public void updateChannelStudyInfo(ChannelStudyVo channelStudyVo) throws Exception {
        magnetRepository.updateChannelStudyInfo(channelStudyVo);
    }

    @Override
    public void deleteChannelStudyInfo(ChannelStudyVo channelStudyVo) throws Exception {
        magnetRepository.deleteChannelStudyInfo(channelStudyVo);
    }

    @Override
    public List<TeacherApyVo> selectTeachApplyList(SearchVo searchVo) throws Exception {
        return magnetRepository.selectTeachApplyList(searchVo);
    }

    @Override
    public int selectTeachApplyistTotal(SearchVo searchVo) throws Exception {
        return magnetRepository.selectTeachApplyistTotal(searchVo);
    }

    @Override
    public TeacherApyVo selectTeachApplyInfo(TeacherApyVo teacherApyVo) throws Exception {
        return magnetRepository.selectTeachApplyInfo(teacherApyVo);
    }

    @Override
    public void deleteTeachApplyInfo(TeacherApyVo teacherApyVo) throws Exception {
        magnetRepository.deleteTeachApplyInfo(teacherApyVo);
    }

    @Override
    public void updateTeachApplyInfo(TeacherApyVo teacherApyVo) throws Exception {
        magnetRepository.updateTeachApplyInfo(teacherApyVo);
    }

    @Override
    public List<HopeStudyVo> selectHopeStudyList(SearchVo searchVo) throws Exception {
        return magnetRepository.selectHopeStudyList(searchVo);
    }

    @Override
    public int selectJoinStudyCountByIdx(long hope_study_idx) throws Exception {
        return magnetRepository.selectJoinStudyCountByIdx(hope_study_idx);
    }

    @Override
    public int selectHopeStudyListTotal(SearchVo searchVo) throws Exception {
        return magnetRepository.selectHopeStudyListTotal(searchVo);
    }

    @Override
    public int selectTeachStudyCountByIdx(long hope_study_idx) throws Exception {
        return magnetRepository.selectTeachStudyCountByIdx(hope_study_idx);
    }

    @Override
    public HopeStudyVo selectHopeStudyInfo(HopeStudyVo hopeStudyVo) throws Exception {
        return magnetRepository.selectHopeStudyInfo(hopeStudyVo);
    }

    @Override
    public void updateHopeStudyInfo(HopeStudyVo hopeStudyVo) throws Exception {
        magnetRepository.updateHopeStudyInfo(hopeStudyVo);
    }

    @Override
    public void deleteHopeStudyInfo(HopeStudyVo hopeStudyVo) throws Exception {
        magnetRepository.deleteHopeStudyInfo(hopeStudyVo);
    }

    @Override
    public List<JoinStudyVo> selectJoinStudyList(SearchVo searchVo) throws Exception {
        return magnetRepository.selectJoinStudyList(searchVo);
    }

    @Override
    public int selectJoinStudyListTotal(SearchVo searchVo) throws Exception {
        return magnetRepository.selectJoinStudyListTotal(searchVo);
    }

    @Override
    public List<TeachStudyVo> selectTeachStudyList(SearchVo searchVo) throws Exception {
        return magnetRepository.selectTeachStudyList(searchVo);
    }

    @Override
    public int selectTeachStudyListTotal(SearchVo searchVo) throws Exception {
        return magnetRepository.selectTeachStudyListTotal(searchVo);
    }

    @Override
    public TeachStudyVo selectTeachStudyInfoByIdx(int teach_study_idx) throws Exception {
        return magnetRepository.selectTeachStudyInfoByIdx(teach_study_idx);
    }
}
