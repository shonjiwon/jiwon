package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class NewTracLecturerCostVo implements Serializable {

  private static final long serialVersionUID = 8880820532856032782L;
  private long lecturer_cost;
  private long group_idx;
  private String standard_yymm;
  private long classroom_cnt;
  private long lecture_cnt;
  private long teacher_cnt;
  private long pay_amount;
  private long apply_amount;
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

  public long getLecturer_cost() {
    return lecturer_cost;
  }

  public void setLecturer_cost(long lecturer_cost) {
    this.lecturer_cost = lecturer_cost;
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


  public long getClassroom_cnt() {
    return classroom_cnt;
  }

  public void setClassroom_cnt(long classroom_cnt) {
    this.classroom_cnt = classroom_cnt;
  }


  public long getLecture_cnt() {
    return lecture_cnt;
  }

  public void setLecture_cnt(long lecture_cnt) {
    this.lecture_cnt = lecture_cnt;
  }


  public long getTeacher_cnt() {
    return teacher_cnt;
  }

  public void setTeacher_cnt(long teacher_cnt) {
    this.teacher_cnt = teacher_cnt;
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
