package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.CoachRoomVo;
import kr.go.songpa.ssem.model.CoachVo;
import kr.go.songpa.ssem.model.SearchVo;
import kr.go.songpa.ssem.repository.tibero.CoachRepository;
import kr.go.songpa.ssem.service.CoachService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2021-06-13
 * Description :
 * History :
 * Version :
 */
@Service
public class CoachServiceImpl implements CoachService {

    @Autowired
    private CoachRepository coachRepository;

    @Override
    public void insertCoachInfo(CoachVo coachVo) throws Exception {
        coachRepository.insertCoachInfo(coachVo);
    }

    @Override
    public List<CoachVo> selectCoachList(SearchVo searchVo) throws Exception {
        return coachRepository.selectCoachList(searchVo);
    }

    @Override
    public int selectCoachListTotal(SearchVo searchVo) throws Exception {
        return coachRepository.selectCoachListTotal(searchVo);
    }

    @Override
    public CoachVo selectCoachInfo(int coach_idx) throws Exception {
        return coachRepository.selectCoachInfo(coach_idx);
    }

    @Override
    public void deleteCoachInfo(CoachVo coachVo) throws Exception {
        coachRepository.deleteCoachInfo(coachVo);
    }

    @Override
    public void updateCoachInfo(CoachVo coachVo) throws Exception {
        coachRepository.updateCoachInfo(coachVo);
    }

    @Override
    public CoachRoomVo selectCoachRoomInfo(int coach_idx) throws Exception {
        return coachRepository.selectCoachRoomInfo(coach_idx);
    }

    @Override
    public void updateCoachRoomInfo(CoachRoomVo coachRoomVo) throws Exception {
        coachRepository.updateCoachRoomInfo(coachRoomVo);
    }
}
