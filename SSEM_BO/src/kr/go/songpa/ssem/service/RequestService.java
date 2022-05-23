package kr.go.songpa.ssem.service;

import kr.go.songpa.ssem.model.RequestVo;
import kr.go.songpa.ssem.model.SearchVo;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service
 * Author : shlee
 * Date : 2021-12-19
 * Description :
 * History :
 * Version :
 */
public interface RequestService {
    void insertRequest(RequestVo requestVo) throws Exception;

    List<RequestVo> selectRequestList(SearchVo searchVo) throws Exception;

    int selectRequestListTotal(SearchVo searchVo) throws Exception;

    void updateRequestViewCnt(RequestVo requestVo) throws Exception;

    RequestVo selectRequest(RequestVo requestVo) throws Exception;

    void updateRequest(RequestVo requestVo) throws Exception;

    void deleteRequest(RequestVo requestVo) throws Exception;
}
