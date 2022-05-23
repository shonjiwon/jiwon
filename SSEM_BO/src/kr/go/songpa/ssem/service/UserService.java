package kr.go.songpa.ssem.service;

import kr.go.songpa.ssem.model.SearchVo;
import kr.go.songpa.ssem.model.TnUserInfoVo;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service
 * Author : shlee
 * Date : 2020-11-25
 * Description :
 * History :
 * Version :
 */
public interface UserService {
    List<TnUserInfoVo> selectUserList(SearchVo searchVo) throws Exception;

    int selectUserListTotal(SearchVo searchVo) throws Exception;
}
