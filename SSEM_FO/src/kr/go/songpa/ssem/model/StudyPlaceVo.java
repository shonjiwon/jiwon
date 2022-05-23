package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class StudyPlaceVo implements Serializable {

  private static final long serialVersionUID = -8302265960433150423L;
  private long study_place_idx;
  private long group_idx;
  private String addr;
  private String addr2;
  private String name;
  private String cont;
  private long max_qty;
  private long gd_qty;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;
  private String tel_no;

  private String p_name;
  private String grp_name;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getStudy_place_idx() {
    return study_place_idx;
  }

  public void setStudy_place_idx(long study_place_idx) {
    this.study_place_idx = study_place_idx;
  }


  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }


  public String getAddr() {
    return addr;
  }

  public void setAddr(String addr) {
    this.addr = addr;
  }


  public String getAddr2() {
    return addr2;
  }

  public void setAddr2(String addr2) {
    this.addr2 = addr2;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getCont() {
    return cont;
  }

  public void setCont(String cont) {
    this.cont = cont;
  }


  public long getMax_qty() {
    return max_qty;
  }

  public void setMax_qty(long max_qty) {
    this.max_qty = max_qty;
  }


  public long getGd_qty() {
    return gd_qty;
  }

  public void setGd_qty(long gd_qty) {
    this.gd_qty = gd_qty;
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

  public String getTel_no() {
    return tel_no;
  }

  public void setTel_no(String tel_no) {
    this.tel_no = tel_no;
  }

  public String getP_name() {
    return p_name;
  }

  public void setP_name(String p_name) {
    this.p_name = p_name;
  }

  public String getGrp_name() {
    return grp_name;
  }

  public void setGrp_name(String grp_name) {
    this.grp_name = grp_name;
  }
}
