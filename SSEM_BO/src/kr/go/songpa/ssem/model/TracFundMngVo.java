package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class TracFundMngVo implements Serializable {

  private static final long serialVersionUID = -7209347286724242706L;
  private long fund_mng_seq;
  private String dong_cd;
  private String standard_yymm;
  private String div_cd;
  private long amount;
  private String note;
  private String use_yn;
  private String reg_id;
  private String reg_date;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getFund_mng_seq() {
    return fund_mng_seq;
  }

  public void setFund_mng_seq(long fund_mng_seq) {
    this.fund_mng_seq = fund_mng_seq;
  }


  public String getDong_cd() {
    return dong_cd;
  }

  public void setDong_cd(String dong_cd) {
    this.dong_cd = dong_cd;
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


  public String getReg_date() {
    return reg_date;
  }

  public void setReg_date(String reg_date) {
    this.reg_date = reg_date;
  }

}
