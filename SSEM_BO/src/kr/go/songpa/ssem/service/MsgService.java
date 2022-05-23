package kr.go.songpa.ssem.service;

/**
 * Program Name : kr.go.songpa.ssem.service
 * Author : shlee
 * Date : 2020-10-13
 * Description :
 * History :
 * Version :
 */
public interface MsgService {
    void sendMsgKakao(String title, String content, String tgt_nm, String phone_num, String template_cd) throws Exception;
}
