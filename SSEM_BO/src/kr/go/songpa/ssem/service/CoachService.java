package kr.go.songpa.ssem.service;

import kr.go.songpa.ssem.model.CoachRoomVo;
import kr.go.songpa.ssem.model.CoachVo;
import kr.go.songpa.ssem.model.SearchVo;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service
 * Author : shlee
 * Date : 2021-06-13
 * Description :
 * History :
 * Version :
 */
public interface CoachService {
    void insertCoachInfo(CoachVo coachVo) throws Exception;

    List<CoachVo> selectCoachList(SearchVo searchVo) throws Exception;

    int selectCoachListTotal(SearchVo searchVo) throws Exception;

    CoachVo selectCoachInfo(int coach_idx) throws Exception;

    void deleteCoachInfo(CoachVo coachVo) throws Exception;

    void updateCoachInfo(CoachVo coachVo) throws Exception;

    CoachRoomVo selectCoachRoomInfo(int coach_idx) throws Exception;

    void updateCoachRoomInfo(CoachRoomVo coachRoomVo) throws Exception;
}
