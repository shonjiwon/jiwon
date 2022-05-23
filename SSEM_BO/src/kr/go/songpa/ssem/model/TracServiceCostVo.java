package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class TracServiceCostVo implements Serializable {

  private static final long serialVersionUID = -1092720097818558903L;
  private long service_cost_seq;
  private String dong_cd;
  private String standard_yymm;
  private String div_cd;
  private String nm;
  private String resi_no;
  private String work_cnt;
  private long amount;
  private String note;
  private String use_yn;
  private String reg_id;
  private String reg_date;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getService_cost_seq() {
    return service_cost_seq;
  }

  public void setService_cost_seq(long service_cost_seq) {
    this.service_cost_seq = service_cost_seq;
  }


  public String getDong_cd() {
    return dong_cd;
  }

  public void setDong_cd(String dong_cd) {
    this.dong_cd = dong_cd;
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


  public String getWork_cnt() {
    return work_cnt;
  }

  public void setWork_cnt(String work_cnt) {
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


  public String getReg_date() {
    return reg_date;
  }

  public void setReg_date(String reg_date) {
    this.reg_date = reg_date;
  }

}
