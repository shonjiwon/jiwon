package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class SelfCounselVo implements Serializable {

  private static final long serialVersionUID = -4788714118466734173L;
  private long self_counsel_idx;
  private String status;
  private String apy_name;
  private String apy_mob_no;
  private String gubun;
  private String meet_dt;
  private String able_phone_time;
  private String apy_memo;
  private String resv_dt;
  private String mng_memo;
  private long cnt;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;
  private String atch_file_id;

  private String mob_1;
  private String mob_2;
  private String mob_3;
  private String meet_date_str;
  private String meet_day_str;
  private String able_start_time;
  private String able_end_time;
  private List<FileVo> fileList;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getSelf_counsel_idx() {
    return self_counsel_idx;
  }

  public void setSelf_counsel_idx(long self_counsel_idx) {
    this.self_counsel_idx = self_counsel_idx;
  }


  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }


  public String getApy_name() {
    return apy_name;
  }

  public void setApy_name(String apy_name) {
    this.apy_name = apy_name;
  }


  public String getApy_mob_no() {
    return apy_mob_no;
  }

  public void setApy_mob_no(String apy_mob_no) {
    this.apy_mob_no = apy_mob_no;
  }


  public String getGubun() {
    return gubun;
  }

  public void setGubun(String gubun) {
    this.gubun = gubun;
  }


  public String getMeet_dt() {
    return meet_dt;
  }

  public void setMeet_dt(String meet_dt) {
    this.meet_dt = meet_dt;
  }


  public String getAble_phone_time() {
    return able_phone_time;
  }

  public void setAble_phone_time(String able_phone_time) {
    this.able_phone_time = able_phone_time;
  }


  public String getApy_memo() {
    return apy_memo;
  }

  public void setApy_memo(String apy_memo) {
    this.apy_memo = apy_memo;
  }


  public String getResv_dt() {
    return resv_dt;
  }

  public void setResv_dt(String resv_dt) {
    this.resv_dt = resv_dt;
  }


  public String getMng_memo() {
    return mng_memo;
  }

  public void setMng_memo(String mng_memo) {
    this.mng_memo = mng_memo;
  }


  public long getCnt() {
    return cnt;
  }

  public void setCnt(long cnt) {
    this.cnt = cnt;
  }


  public String getReg_id() {
    return reg_id;
  }

  public void setReg_id(String reg_id) {
    this.reg_id = reg_id;
  }


  public String getReg_dt() {
    return reg_dt;
  }

  public void setReg_dt(String reg_dt) {
    this.reg_dt = reg_dt;
  }


  public String getUp_id() {
    return up_id;
  }

  public void setUp_id(String up_id) {
    this.up_id = up_id;
  }


  public String getUp_dt() {
    return up_dt;
  }

  public void setUp_dt(String up_dt) {
    this.up_dt = up_dt;
  }

  public String getMob_1() {
    return mob_1;
  }

  public void setMob_1(String mob_1) {
    this.mob_1 = mob_1;
  }

  public String getMob_2() {
    return mob_2;
  }

  public void setMob_2(String mob_2) {
    this.mob_2 = mob_2;
  }

  public String getMob_3() {
    return mob_3;
  }

  public void setMob_3(String mob_3) {
    this.mob_3 = mob_3;
  }

  public String getMeet_date_str() {
    return meet_date_str;
  }

  public void setMeet_date_str(String meet_date_str) {
    this.meet_date_str = meet_date_str;
  }

  public String getMeet_day_str() {
    return meet_day_str;
  }

  public void setMeet_day_str(String meet_day_str) {
    this.meet_day_str = meet_day_str;
  }

  public String getAble_start_time() {
    return able_start_time;
  }

  public void setAble_start_time(String able_start_time) {
    this.able_start_time = able_start_time;
  }

  public String getAble_end_time() {
    return able_end_time;
  }

  public void setAble_end_time(String able_end_time) {
    this.able_end_time = able_end_time;
  }

  public String getAtch_file_id() {
    return atch_file_id;
  }

  public void setAtch_file_id(String atch_file_id) {
    this.atch_file_id = atch_file_id;
  }

  public List<FileVo> getFileList() {
    return fileList;
  }

  public void setFileList(List<FileVo> fileList) {
    this.fileList = fileList;
  }
}
