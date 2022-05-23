package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.RequestVo;
import kr.go.songpa.ssem.model.SearchVo;
import kr.go.songpa.ssem.repository.tibero.RequestRepository;
import kr.go.songpa.ssem.service.RequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2021-12-19
 * Description :
 * History :
 * Version :
 */
@Service
public class RequestServiceImpl implements RequestService {

    @Autowired
    private RequestRepository requestRepository;

    @Override
    public void insertRequest(RequestVo requestVo) throws Exception {
        requestRepository.insertRequest(requestVo);
    }

    @Override
    public List<RequestVo> selectRequestList(SearchVo searchVo) throws Exception {
        return requestRepository.selectRequestList(searchVo);
    }

    @Override
    public int selectRequestListTotal(SearchVo searchVo) throws Exception {
        return requestRepository.selectRequestListTotal(searchVo);
    }

    @Override
    public void updateRequestViewCnt(RequestVo requestVo) throws Exception {
        requestRepository.updateRequestViewCnt(requestVo);
    }

    @Override
    public RequestVo selectRequest(RequestVo requestVo) throws Exception {
        return requestRepository.selectRequest(requestVo);
    }

    @Override
    public void updateRequest(RequestVo requestVo) throws Exception {
        requestRepository.updateRequest(requestVo);
    }

    @Override
    public void deleteRequest(RequestVo requestVo) throws Exception {
        requestRepository.deleteRequest(requestVo);
    }
}
