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
 * Date : 2020-11-13
 * Description :
 * History :
 * Version :
 */
@Service
public class MagnetServiceImpl implements MagnetService {

    @Autowired
    private MagnetRepository magnetRepository;

    @Override
    public void insertHopeStudyInfo(HopeStudyVo hopeStudyVo) throws Exception {
        magnetRepository.insertHopeStudyInfo(hopeStudyVo);
    }

    @Override
    public List<HopeStudyVo> selectHopeStudyList(SearchVo searchVo) throws Exception {
        return magnetRepository.selectHopeStudyList(searchVo);
    }

    @Override
    public int selectHopeStudyListTotal(SearchVo searchVo) throws Exception {
        return magnetRepository.selectHopeStudyListTotal(searchVo);
    }

    @Override
    public HopeStudyVo selectHopeStudyInfo(HopeStudyVo hopeStudyVo) throws Exception {
        return magnetRepository.selectHopeStudyInfo(hopeStudyVo);
    }

    @Override
    public void updateHopeStudyViewCnt(HopeStudyVo hopeStudyVo) throws Exception {
        magnetRepository.updateHopeStudyViewCnt(hopeStudyVo);
    }

    @Override
    public void insertJoinStudyInfo(JoinStudyVo joinStudyVo) throws Exception {
        magnetRepository.insertJoinStudyInfo(joinStudyVo);
    }

    @Override
    public HopeStudyVo selectHopeStudyByIdx(long hope_study_idx) throws Exception {
        return magnetRepository.selectHopeStudyByIdx(hope_study_idx);
    }

    @Override
    public int selectJoinStudyCount(JoinStudyVo joinStudyVo) throws Exception {
        return magnetRepository.selectJoinStudyCount(joinStudyVo);
    }

    @Override
    public List<JoinStudyVo> selectJoinListByIdx(int hope_study_idx) throws Exception {
        return magnetRepository.selectJoinListByIdx(hope_study_idx);
    }

    @Override
    public void insertTeachStudyInfo(TeachStudyVo teachStudyVo) throws Exception {
        magnetRepository.insertTeachStudyInfo(teachStudyVo);
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
    public ChannelStudyVo selectNextChannelStudy(ChannelStudyVo channelStudyVo) throws Exception {
        return magnetRepository.selectNextChannelStudy(channelStudyVo);
    }

    @Override
    public ChannelStudyVo selectPrevChannelStudy(ChannelStudyVo channelStudyVo) throws Exception {
        return magnetRepository.selectPrevChannelStudy(channelStudyVo);
    }

    @Override
    public int selectJoinStudyCountByIdx(long hope_study_idx) throws Exception {
        return magnetRepository.selectJoinStudyCountByIdx(hope_study_idx);
    }

    @Override
    public void updateHopeStudyInfo(HopeStudyVo hopeStudyVo) throws Exception {
        magnetRepository.updateHopeStudyInfo(hopeStudyVo);
    }

    @Override
    public void updateHopeStudyCancel(HopeStudyVo hopeStudyVo) throws Exception {
        magnetRepository.updateHopeStudyCancel(hopeStudyVo);
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
    public TeachStudyVo selectTeachStudyInfo(TeachStudyVo teachStudyVo) throws Exception {
        return magnetRepository.selectTeachStudyInfo(teachStudyVo);
    }

    @Override
    public void updateTeachStudyInfo(TeachStudyVo teachStudyVo) throws Exception {
        magnetRepository.updateTeachStudyInfo(teachStudyVo);
    }

    @Override
    public void updateTeachStudyCancel(TeachStudyVo teachStudyVo) throws Exception {
        magnetRepository.updateTeachStudyCancel(teachStudyVo);
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
    public JoinStudyVo selectJoinStudyInfo(JoinStudyVo joinStudyVo) throws Exception {
        return magnetRepository.selectJoinStudyInfo(joinStudyVo);
    }

    @Override
    public void updateJoinStudyInfo(JoinStudyVo joinStudyVo) throws Exception {
        magnetRepository.updateJoinStudyInfo(joinStudyVo);
    }

    @Override
    public void deleteJoinStudyInfo(JoinStudyVo joinStudyVo) throws Exception {
        magnetRepository.deleteJoinStudyInfo(joinStudyVo);
    }

    @Override
    public List<LectureVo> selectLectureList(String gubun) throws Exception {
        return magnetRepository.selectLectureList(gubun);
    }

    @Override
    public void insertTeacherApyInfo(TeacherApyVo teacherApyVo) throws Exception {
        magnetRepository.insertTeacherApyInfo(teacherApyVo);
    }
}
