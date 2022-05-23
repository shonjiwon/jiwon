package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class DiscountVo implements Serializable {

  private static final long serialVersionUID = 3525872678764211426L;
  private long discount_idx;
  private long group_idx;
  private String tgt_name;
  private String dtl_txt;
  private long rate;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private long p_idx;
  private String p_name;
  private String name;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getDiscount_idx() {
    return discount_idx;
  }

  public void setDiscount_idx(long discount_idx) {
    this.discount_idx = discount_idx;
  }


  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }


  public String getTgt_name() {
    return tgt_name;
  }

  public void setTgt_name(String tgt_name) {
    this.tgt_name = tgt_name;
  }


  public String getDtl_txt() {
    return dtl_txt;
  }

  public void setDtl_txt(String dtl_txt) {
    this.dtl_txt = dtl_txt;
  }


  public long getRate() {
    return rate;
  }

  public void setRate(long rate) {
    this.rate = rate;
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

  public long getP_idx() {
    return p_idx;
  }

  public void setP_idx(long p_idx) {
    this.p_idx = p_idx;
  }

  public String getP_name() {
    return p_name;
  }

  public void setP_name(String p_name) {
    this.p_name = p_name;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }
}
