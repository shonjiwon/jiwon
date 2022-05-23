package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class NewTracServiceCostVo implements Serializable {

  private static final long serialVersionUID = -26666219081261762L;
  private long service_cost_seq;
  private long group_idx;
  private String standard_yymm;
  private String div_cd;
  private long div_cd_cost;
  private String nm;
  private String resi_no;
  private long work_cnt;
  private long amount;
  private String note;
  private String use_yn;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String dong_nm;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getService_cost_seq() {
    return service_cost_seq;
  }

  public void setService_cost_seq(long service_cost_seq) {
    this.service_cost_seq = service_cost_seq;
  }

  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
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

  public long getDiv_cd_cost() {
    return div_cd_cost;
  }

  public void setDiv_cd_cost(long div_cd_cost) {
    this.div_cd_cost = div_cd_cost;
  }

  public String getNm() {
    return nm;
  }

  public void setNm(String nm) {
    this.nm = nm;
  }

  public String getResi_no() {
    return resi_no;
  }

  public void setResi_no(String resi_no) {
    this.resi_no = resi_no;
  }

  public long getWork_cnt() {
    return work_cnt;
  }

  public void setWork_cnt(long work_cnt) {
    this.work_cnt = work_cnt;
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

  public String getDong_nm() {
    return dong_nm;
  }

  public void setDong_nm(String dong_nm) {
    this.dong_nm = dong_nm;
  }
}
