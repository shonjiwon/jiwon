package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class NewTracFundMngVo implements Serializable {

  private static final long serialVersionUID = -527095668524516678L;
  private long fund_mng_seq;
  private long group_idx;
  private String standard_yymm;
  private String div_cd;
  private long amount;
  private String note;
  private String use_yn;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String dong_nm;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getFund_mng_seq() {
    return fund_mng_seq;
  }

  public void setFund_mng_seq(long fund_mng_seq) {
    this.fund_mng_seq = fund_mng_seq;
  }


  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }


  public String getStandard_yymm() {
    return standard_yymm;
  }

  public void setStandard_yymm(String standard_yymm) {
    this.standard_yymm = standard_yymm;
  }


  public String getDiv_cd() {
    return div_cd;
  }

  public void setDiv_cd(String div_cd) {
    this.div_cd = div_cd;
  }


  public long getAmount() {
    return amount;
  }

  public void setAmount(long amount) {
    this.amount = amount;
  }


  public String getNote() {
    return note;
  }

  public void setNote(String note) {
    this.note = note;
  }


  public String getUse_yn() {
    return use_yn;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
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

  public String getDong_nm() {
    return dong_nm;
  }

  public void setDong_nm(String dong_nm) {
    this.dong_nm = dong_nm;
  }
}
