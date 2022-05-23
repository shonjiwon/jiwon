package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class StatPrivateVo implements Serializable {

  private static final long serialVersionUID = -5230992931006721585L;
  private long stat_private_idx;
  private long group_idx;
  private String admin_id;
  private String name;
  private String level1;
  private String level2;
  private String level3;
  private String cont;
  private String reg_dt;

  private long p_idx;
  private String p_name;
  private String grp_name;
  private String excel_pwd;
  private String reason;
  private String reason_txt;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getStat_private_idx() {
    return stat_private_idx;
  }

  public void setStat_private_idx(long stat_private_idx) {
    this.stat_private_idx = stat_private_idx;
  }

  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }

  public String getAdmin_id() {
    return admin_id;
  }

  public void setAdmin_id(String admin_id) {
    this.admin_id = admin_id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getLevel1() {
    return level1;
  }

  public void setLevel1(String level1) {
    this.level1 = level1;
  }

  public String getLevel2() {
    return level2;
  }

  public void setLevel2(String level2) {
    this.level2 = level2;
  }

  public String getLevel3() {
    return level3;
  }

  public void setLevel3(String level3) {
    this.level3 = level3;
  }

  public String getCont() {
    return cont;
  }

  public void setCont(String cont) {
    this.cont = cont;
  }

  public String getReg_dt() {
    return reg_dt;
  }

  public void setReg_dt(String reg_dt) {
    this.reg_dt = reg_dt;
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

  public String getGrp_name() {
    return grp_name;
  }

  public void setGrp_name(String grp_name) {
    this.grp_name = grp_name;
  }

  public String getExcel_pwd() {
    return excel_pwd;
  }

  public void setExcel_pwd(String excel_pwd) {
    this.excel_pwd = excel_pwd;
  }

  public String getReason() {
    return reason;
  }

  public void setReason(String reason) {
    this.reason = reason;
  }

  public String getReason_txt() {
    return reason_txt;
  }

  public void setReason_txt(String reason_txt) {
    this.reason_txt = reason_txt;
  }
}
