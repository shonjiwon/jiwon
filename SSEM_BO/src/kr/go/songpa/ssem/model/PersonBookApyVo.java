package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class PersonBookApyVo implements Serializable {

  private static final long serialVersionUID = -4301227629252747132L;
  private long person_book_apy_idx;
  private String gubun;
  private String cate_cd;
  private String title;
  private String person;
  private String apy_name;
  private String apy_mob_no;
  private long apy_cnt;
  private String grp_name;
  private String view_dt;
  private String confirm_dt;
  private String plc;
  private String reason;
  private String memo;
  private long cnt;
  private String status;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;
  private long person_book_idx;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getPerson_book_apy_idx() {
    return person_book_apy_idx;
  }

  public void setPerson_book_apy_idx(long person_book_apy_idx) {
    this.person_book_apy_idx = person_book_apy_idx;
  }


  public String getGubun() {
    return gubun;
  }

  public void setGubun(String gubun) {
    this.gubun = gubun;
  }


  public String getCate_cd() {
    return cate_cd;
  }

  public void setCate_cd(String cate_cd) {
    this.cate_cd = cate_cd;
  }


  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }


  public String getPerson() {
    return person;
  }

  public void setPerson(String person) {
    this.person = person;
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


  public long getApy_cnt() {
    return apy_cnt;
  }

  public void setApy_cnt(long apy_cnt) {
    this.apy_cnt = apy_cnt;
  }


  public String getGrp_name() {
    return grp_name;
  }

  public void setGrp_name(String grp_name) {
    this.grp_name = grp_name;
  }


  public String getView_dt() {
    return view_dt;
  }

  public void setView_dt(String view_dt) {
    this.view_dt = view_dt;
  }


  public String getConfirm_dt() {
    return confirm_dt;
  }

  public void setConfirm_dt(String confirm_dt) {
    this.confirm_dt = confirm_dt;
  }


  public String getPlc() {
    return plc;
  }

  public void setPlc(String plc) {
    this.plc = plc;
  }


  public String getReason() {
    return reason;
  }

  public void setReason(String reason) {
    this.reason = reason;
  }


  public String getMemo() {
    return memo;
  }

  public void setMemo(String memo) {
    this.memo = memo;
  }


  public long getCnt() {
    return cnt;
  }

  public void setCnt(long cnt) {
    this.cnt = cnt;
  }


  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
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

  public long getPerson_book_idx() {
    return person_book_idx;
  }

  public void setPerson_book_idx(long person_book_idx) {
    this.person_book_idx = person_book_idx;
  }
}
