package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class TracLecturerCostVo implements Serializable {

  private static final long serialVersionUID = 8107836589412887719L;
  private long lecturer_cost;
  private String dong_cd;
  private String standard_yymm;
  private String classroom_cnt;
  private String course_cnt;
  private String lecturer_cnt;
  private long pay_amount;
  private long apply_amount;
  private String note;
  private String use_yn;
  private String reg_id;
  private String reg_date;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getLecturer_cost() {
    return lecturer_cost;
  }

  public void setLecturer_cost(long lecturer_cost) {
    this.lecturer_cost = lecturer_cost;
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


  public String getClassroom_cnt() {
    return classroom_cnt;
  }

  public void setClassroom_cnt(String classroom_cnt) {
    this.classroom_cnt = classroom_cnt;
  }


  public String getCourse_cnt() {
    return course_cnt;
  }

  public void setCourse_cnt(String course_cnt) {
    this.course_cnt = course_cnt;
  }


  public String getLecturer_cnt() {
    return lecturer_cnt;
  }

  public void setLecturer_cnt(String lecturer_cnt) {
    this.lecturer_cnt = lecturer_cnt;
  }


  public long getPay_amount() {
    return pay_amount;
  }

  public void setPay_amount(long pay_amount) {
    this.pay_amount = pay_amount;
  }


  public long getApply_amount() {
    return apply_amount;
  }

  public void setApply_amount(long apply_amount) {
    this.apply_amount = apply_amount;
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
