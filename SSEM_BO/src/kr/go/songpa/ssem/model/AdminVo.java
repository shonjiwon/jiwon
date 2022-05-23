package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class AdminVo implements Serializable {

  private static final long serialVersionUID = 3577137803967351712L;

  private String admin_id;
  private long group_idx;
  private long admin_rule_idx;
  private String name;
  private String mob_no;
  private String tel_no;
  private String email;
  private String pwd;
  private String pwd_c;
  private String cur_pwd;
  private String last_login_dt;
  private String last_login_ip;
  private long login_cnt;
  private long login_fail_cnt;
  private String type;
  private String login_ip;
  private String app_yn;
  private String apy_path;
  private String del_yn;
  private String status;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private long p_idx;
  private String p_name;
  private String grp_name;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public String getAdmin_id() {
    return admin_id;
  }

  public void setAdmin_id(String admin_id) {
    this.admin_id = admin_id;
  }

  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }

  public long getAdmin_rule_idx() {
    return admin_rule_idx;
  }

  public void setAdmin_rule_idx(long admin_rule_idx) {
    this.admin_rule_idx = admin_rule_idx;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getMob_no() {
    return mob_no;
  }

  public void setMob_no(String mob_no) {
    this.mob_no = mob_no;
  }

  public String getTel_no() {
    return tel_no;
  }

  public void setTel_no(String tel_no) {
    this.tel_no = tel_no;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPwd() {
    return pwd;
  }

  public void setPwd(String pwd) {
    this.pwd = pwd;
  }

  public String getPwd_c() {
    return pwd_c;
  }

  public void setPwd_c(String pwd_c) {
    this.pwd_c = pwd_c;
  }

  public String getCur_pwd() {
    return cur_pwd;
  }

  public void setCur_pwd(String cur_pwd) {
    this.cur_pwd = cur_pwd;
  }

  public String getLast_login_dt() {
    return last_login_dt;
  }

  public void setLast_login_dt(String last_login_dt) {
    this.last_login_dt = last_login_dt;
  }

  public String getLast_login_ip() {
    return last_login_ip;
  }

  public void setLast_login_ip(String last_login_ip) {
    this.last_login_ip = last_login_ip;
  }

  public long getLogin_cnt() {
    return login_cnt;
  }

  public void setLogin_cnt(long login_cnt) {
    this.login_cnt = login_cnt;
  }

  public long getLogin_fail_cnt() {
    return login_fail_cnt;
  }

  public void setLogin_fail_cnt(long login_fail_cnt) {
    this.login_fail_cnt = login_fail_cnt;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public String getLogin_ip() {
    return login_ip;
  }

  public void setLogin_ip(String login_ip) {
    this.login_ip = login_ip;
  }

  public String getApp_yn() {
    return app_yn;
  }

  public void setApp_yn(String app_yn) {
    this.app_yn = app_yn;
  }

  public String getApy_path() {
    return apy_path;
  }

  public void setApy_path(String apy_path) {
    this.apy_path = apy_path;
  }

  public String getDel_yn() {
    return del_yn;
  }

  public void setDel_yn(String del_yn) {
    this.del_yn = del_yn;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
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

  public String getGrp_name() {
    return grp_name;
  }

  public void setGrp_name(String grp_name) {
    this.grp_name = grp_name;
  }
}
