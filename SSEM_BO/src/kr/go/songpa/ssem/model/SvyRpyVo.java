package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class SvyRpyVo implements Serializable {

  private static final long serialVersionUID = -5459270127527043743L;
  private long svy_rpy_idx;
  private long svy_item_idx;
  private long svy_qst_idx;
  private long svy_idx;
  private String answer;
  private String rpy_yn;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String rpy_select = "";

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getSvy_rpy_idx() {
    return svy_rpy_idx;
  }

  public void setSvy_rpy_idx(long svy_rpy_idx) {
    this.svy_rpy_idx = svy_rpy_idx;
  }


  public long getSvy_item_idx() {
    return svy_item_idx;
  }

  public void setSvy_item_idx(long svy_item_idx) {
    this.svy_item_idx = svy_item_idx;
  }


  public long getSvy_qst_idx() {
    return svy_qst_idx;
  }

  public void setSvy_qst_idx(long svy_qst_idx) {
    this.svy_qst_idx = svy_qst_idx;
  }


  public long getSvy_idx() {
    return svy_idx;
  }

  public void setSvy_idx(long svy_idx) {
    this.svy_idx = svy_idx;
  }


  public String getAnswer() {
    return answer;
  }

  public void setAnswer(String answer) {
    this.answer = answer;
  }


  public String getRpy_yn() {
    return rpy_yn;
  }

  public void setRpy_yn(String rpy_yn) {
    this.rpy_yn = rpy_yn;
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

  public String getRpy_select() {
    return rpy_select;
  }

  public void setRpy_select(String rpy_select) {
    this.rpy_select = rpy_select;
  }
}
