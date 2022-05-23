package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.SearchVo;
import kr.go.songpa.ssem.model.TnUserInfoVo;
import kr.go.songpa.ssem.repository.tibero.UserRepository;
import kr.go.songpa.ssem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-11-25
 * Description :
 * History :
 * Version :
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public List<TnUserInfoVo> selectUserList(SearchVo searchVo) throws Exception {
        return userRepository.selectUserList(searchVo);
    }

    @Override
    public int selectUserListTotal(SearchVo searchVo) throws Exception {
        return userRepository.selectUserListTotal(searchVo);
    }
}
