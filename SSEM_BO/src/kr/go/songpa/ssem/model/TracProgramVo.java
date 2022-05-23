package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class TracProgramVo implements Serializable {

  private static final long serialVersionUID = -3022588660918279536L;
  private long prog_seq;
  private String dong_cd;
  private String div_cd;
  private String prog_nm;
  private String course_sdate;
  private String course_edate;
  private String note;
  private String use_yn;
  private String reg_id;
  private String reg_date;
  private String operate_date;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getProg_seq() {
    return prog_seq;
  }

  public void setProg_seq(long prog_seq) {
    this.prog_seq = prog_seq;
  }


  public String getDong_cd() {
    return dong_cd;
  }

  public void setDong_cd(String dong_cd) {
    this.dong_cd = dong_cd;
  }


  public String getDiv_cd() {
    return div_cd;
  }

  public void setDiv_cd(String div_cd) {
    this.div_cd = div_cd;
  }


  public String getProg_nm() {
    return prog_nm;
  }

  public void setProg_nm(String prog_nm) {
    this.prog_nm = prog_nm;
  }


  public String getCourse_sdate() {
    return course_sdate;
  }

  public void setCourse_sdate(String course_sdate) {
    this.course_sdate = course_sdate;
  }


  public String getCourse_edate() {
    return course_edate;
  }

  public void setCourse_edate(String course_edate) {
    this.course_edate = course_edate;
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


  public String getOperate_date() {
    return operate_date;
  }

  public void setOperate_date(String operate_date) {
    this.operate_date = operate_date;
  }

}
