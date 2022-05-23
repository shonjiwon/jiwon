package kr.go.songpa.ssem.service.impl;

import kr.go.songpa.ssem.model.CustomSmsSendVo;
import kr.go.songpa.ssem.repository.oracle.MsgRepository;
import kr.go.songpa.ssem.service.MsgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Program Name : kr.go.songpa.ssem.service.impl
 * Author : shlee
 * Date : 2020-10-13
 * Description :
 * History :
 * Version :
 */
@Service
public class MsgServiceImpl implements MsgService {

    @Autowired
    private MsgRepository msgRepository;

    @Override
    public void sendMsgKakao(String title, String content, String tgt_nm, String phone_num, String template_cd) throws Exception {
        CustomSmsSendVo customSmsSendVo = new CustomSmsSendVo();
        customSmsSendVo.setUser_id("songpassem");
        customSmsSendVo.setSchedule_type("0"); // 즉시 발송
        customSmsSendVo.setTitle(title);
        customSmsSendVo.setMsg_content(content);
        customSmsSendVo.setCalling_num("0211112222");
        customSmsSendVo.setTgt_nm(tgt_nm);
        customSmsSendVo.setPhone_num(phone_num);
        customSmsSendVo.setTemplate_cd(template_cd);

        msgRepository.sendMsgKakao(customSmsSendVo);
    }
}
