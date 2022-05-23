package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class CodeVo implements Serializable {

  private static final long serialVersionUID = -1844289997868571017L;
  private long code_idx;
  private String gubun;
  private String cd_val;
  private long ord;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getCode_idx() {
    return code_idx;
  }

  public void setCode_idx(long code_idx) {
    this.code_idx = code_idx;
  }


  public String getGubun() {
    return gubun;
  }

  public void setGubun(String gubun) {
    this.gubun = gubun;
  }


  public String getCd_val() {
    return cd_val;
  }

  public void setCd_val(String cd_val) {
    this.cd_val = cd_val;
  }


  public long getOrd() {
    return ord;
  }

  public void setOrd(long ord) {
    this.ord = ord;
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

}
