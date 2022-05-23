package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.TnUserInfoVo;
import kr.go.songpa.ssem.repository.tibero.UserRepository;
import kr.go.songpa.ssem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-10-25
 * Description :
 * History :
 * Version :
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserRepository userRepository;


    @Override
    public TnUserInfoVo selectUserInfo(TnUserInfoVo tnUserInfoVo) throws Exception {
        return userRepository.selectUserInfo(tnUserInfoVo);
    }

    @Override
    public int selectIsTeacherByID(String user_id) throws Exception {
        return userRepository.selectIsTeacherByID(user_id);
    }

    @Override
    public TnUserInfoVo selectUserInfoById(String user_id) throws Exception {
        return userRepository.selectUserInfoById(user_id);
    }
}
