package kr.go.songpa.ssem.model;

import java.io.Serializable;

/**
 * Program Name : kr.go.songpa.ssem.model
 * Author : shlee
 * Date : 2020-10-13
 * Description :
 * History :
 * Version :
 */
public class CustomSmsSendVo implements Serializable {
    private static final long serialVersionUID = 6463616274702611086L;

    private long id;
    private String user_id;
    private String schedule_type;
    private String title;
    private String msg_content;
    private String calling_num;
    private String tgt_nm;
    private String phone_num;
    private String state_cd;
    private String result_msg;
    private String template_cd;
    private String push_send_yn;
    private String push_id;
    private String push_resend_tp_cd;
    private String reserv_dttm;
    private String reg_dttm;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getSchedule_type() {
        return schedule_type;
    }

    public void setSchedule_type(String schedule_type) {
        this.schedule_type = schedule_type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMsg_content() {
        return msg_content;
    }

    public void setMsg_content(String msg_content) {
        this.msg_content = msg_content;
    }

    public String getCalling_num() {
        return calling_num;
    }

    public void setCalling_num(String calling_num) {
        this.calling_num = calling_num;
    }

    public String getTgt_nm() {
        return tgt_nm;
    }

    public void setTgt_nm(String tgt_nm) {
        this.tgt_nm = tgt_nm;
    }

    public String getPhone_num() {
        return phone_num;
    }

    public void setPhone_num(String phone_num) {
        this.phone_num = phone_num;
    }

    public String getState_cd() {
        return state_cd;
    }

    public void setState_cd(String state_cd) {
        this.state_cd = state_cd;
    }

    public String getResult_msg() {
        return result_msg;
    }

    public void setResult_msg(String result_msg) {
        this.result_msg = result_msg;
    }

    public String getTemplate_cd() {
        return template_cd;
    }

    public void setTemplate_cd(String template_cd) {
        this.template_cd = template_cd;
    }

    public String getPush_send_yn() {
        return push_send_yn;
    }

    public void setPush_send_yn(String push_send_yn) {
        this.push_send_yn = push_send_yn;
    }

    public String getPush_id() {
        return push_id;
    }

    public void setPush_id(String push_id) {
        this.push_id = push_id;
    }

    public String getPush_resend_tp_cd() {
        return push_resend_tp_cd;
    }

    public void setPush_resend_tp_cd(String push_resend_tp_cd) {
        this.push_resend_tp_cd = push_resend_tp_cd;
    }

    public String getReserv_dttm() {
        return reserv_dttm;
    }

    public void setReserv_dttm(String reserv_dttm) {
        this.reserv_dttm = reserv_dttm;
    }

    public String getReg_dttm() {
        return reg_dttm;
    }

    public void setReg_dttm(String reg_dttm) {
        this.reg_dttm = reg_dttm;
    }
}
