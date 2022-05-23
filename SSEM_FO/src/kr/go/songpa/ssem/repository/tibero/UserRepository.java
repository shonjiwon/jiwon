package kr.go.songpa.ssem.repository.tibero;

import kr.go.songpa.ssem.model.TnUserInfoVo;

/**
 * Program Name : kr.go.songpa.ssem.repository.tibero
 * Author : shlee
 * Date : 2020-10-25
 * Description :
 * History :
 * Version :
 */
public interface UserRepository {
    TnUserInfoVo selectUserInfo(TnUserInfoVo tnUserInfoVo) throws Exception;

    int selectIsTeacherByID(String user_id) throws Exception;

    TnUserInfoVo selectUserInfoById(String user_id) throws Exception;
}
