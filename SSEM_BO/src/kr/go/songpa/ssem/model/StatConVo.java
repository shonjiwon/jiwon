package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class StatConVo implements Serializable {

  private long stat_con_idx;
  private long group_idx;
  private String admin_id;
  private String name;
  private String ip;
  private String os;
  private String browser;
  private String login_dt;
  private String type;

  private long p_idx;
  private String p_name;
  private String grp_name;

  public long getStat_con_idx() {
    return stat_con_idx;
  }

  public void setStat_con_idx(long stat_con_idx) {
    this.stat_con_idx = stat_con_idx;
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


  public String getIp() {
    return ip;
  }

  public void setIp(String ip) {
    this.ip = ip;
  }


  public String getOs() {
    return os;
  }

  public void setOs(String os) {
    this.os = os;
  }


  public String getBrowser() {
    return browser;
  }

  public void setBrowser(String browser) {
    this.browser = browser;
  }


  public String getLogin_dt() {
    return login_dt;
  }

  public void setLogin_dt(String login_dt) {
    this.login_dt = login_dt;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
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
