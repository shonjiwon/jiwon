package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class LawtaxCounselVo implements Serializable {

  private static final long serialVersionUID = -8433867055803670772L;

  private long lawtax_idx;
  private String gbn;
  private String title;
  private String cont;
  private String status;
  private String rpy_cont;
  private String apy_id;
  private String apy_nm;
  private String apy_mob_no;
  private String apy_email;
  private String apy_addr;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String my_item;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getLawtax_idx() {
    return lawtax_idx;
  }

  public void setLawtax_idx(long lawtax_idx) {
    this.lawtax_idx = lawtax_idx;
  }


  public String getGbn() {
    return gbn;
  }

  public void setGbn(String gbn) {
    this.gbn = gbn;
  }


  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }


  public String getCont() {
    return cont;
  }

  public void setCont(String cont) {
    this.cont = cont;
  }


  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }


  public String getRpy_cont() {
    return rpy_cont;
  }

  public void setRpy_cont(String rpy_cont) {
    this.rpy_cont = rpy_cont;
  }


  public String getApy_id() {
    return apy_id;
  }

  public void setApy_id(String apy_id) {
    this.apy_id = apy_id;
  }


  public String getApy_nm() {
    return apy_nm;
  }

  public void setApy_nm(String apy_nm) {
    this.apy_nm = apy_nm;
  }


  public String getApy_mob_no() {
    return apy_mob_no;
  }

  public void setApy_mob_no(String apy_mob_no) {
    this.apy_mob_no = apy_mob_no;
  }


  public String getApy_email() {
    return apy_email;
  }

  public void setApy_email(String apy_email) {
    this.apy_email = apy_email;
  }


  public String getApy_addr() {
    return apy_addr;
  }

  public void setApy_addr(String apy_addr) {
    this.apy_addr = apy_addr;
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

  public String getMy_item() {
    return my_item;
  }

  public void setMy_item(String my_item) {
    this.my_item = my_item;
  }
}
