package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class StatUpVo implements Serializable {

  private static final long serialVersionUID = -4071598830715961962L;
  private long stat_up_idx;
  private long group_idx;
  private String admin_id;
  private String name;
  private String cont;
  private String reg_id;
  private String reg_dt;

  private long p_idx;
  private String p_name;
  private String grp_name;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getStat_up_idx() {
    return stat_up_idx;
  }

  public void setStat_up_idx(long stat_up_idx) {
    this.stat_up_idx = stat_up_idx;
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

  public String getCont() {
    return cont;
  }

  public void setCont(String cont) {
    this.cont = cont;
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
}
