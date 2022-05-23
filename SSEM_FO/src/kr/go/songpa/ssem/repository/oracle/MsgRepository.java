package kr.go.songpa.ssem.repository.oracle;

import kr.go.songpa.ssem.model.CustomSmsSendVo;

/**
 * Program Name : kr.go.songpa.ssem.repository.oracle
 * Author : shlee
 * Date : 2020-10-13
 * Description :
 * History :
 * Version :
 */
public interface MsgRepository {
    // 카카오톡 메세지 발송
    void sendMsgKakao(CustomSmsSendVo customSmsSendVo) throws Exception;
}
