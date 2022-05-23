package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class TracLecturerVo implements Serializable {

  private static final long serialVersionUID = -6852557173805203092L;
  private long lecturer_seq;
  private long prog_seq;
  private String dong_cd;
  private String div_cd;
  private String field_cd;
  private String lecturer_nm;
  private String sex;
  private String birthday;
  private String agree_sdate;
  private String agree_edate;
  private String career;
  private String right;
  private String post_no;
  private String addr;
  private String addr_detail;
  private String mobile_no;
  private String tel_no;
  private long lecturer_cost;
  private String note;
  private String use_yn;
  private String reg_id;
  private String reg_date;

  private String prog_nm;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getLecturer_seq() {
    return lecturer_seq;
  }

  public void setLecturer_seq(long lecturer_seq) {
    this.lecturer_seq = lecturer_seq;
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


  public String getField_cd() {
    return field_cd;
  }

  public void setField_cd(String field_cd) {
    this.field_cd = field_cd;
  }


  public String getLecturer_nm() {
    return lecturer_nm;
  }

  public void setLecturer_nm(String lecturer_nm) {
    this.lecturer_nm = lecturer_nm;
  }


  public String getSex() {
    return sex;
  }

  public void setSex(String sex) {
    this.sex = sex;
  }


  public String getBirthday() {
    return birthday;
  }

  public void setBirthday(String birthday) {
    this.birthday = birthday;
  }


  public String getAgree_sdate() {
    return agree_sdate;
  }

  public void setAgree_sdate(String agree_sdate) {
    this.agree_sdate = agree_sdate;
  }


  public String getAgree_edate() {
    return agree_edate;
  }

  public void setAgree_edate(String agree_edate) {
    this.agree_edate = agree_edate;
  }


  public String getCareer() {
    return career;
  }

  public void setCareer(String career) {
    this.career = career;
  }


  public String getRight() {
    return right;
  }

  public void setRight(String right) {
    this.right = right;
  }


  public String getPost_no() {
    return post_no;
  }

  public void setPost_no(String post_no) {
    this.post_no = post_no;
  }


  public String getAddr() {
    return addr;
  }

  public void setAddr(String addr) {
    this.addr = addr;
  }


  public String getAddr_detail() {
    return addr_detail;
  }

  public void setAddr_detail(String addr_detail) {
    this.addr_detail = addr_detail;
  }


  public String getMobile_no() {
    return mobile_no;
  }

  public void setMobile_no(String mobile_no) {
    this.mobile_no = mobile_no;
  }


  public String getTel_no() {
    return tel_no;
  }

  public void setTel_no(String tel_no) {
    this.tel_no = tel_no;
  }


  public long getLecturer_cost() {
    return lecturer_cost;
  }

  public void setLecturer_cost(long lecturer_cost) {
    this.lecturer_cost = lecturer_cost;
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

  public String getProg_nm() {
    return prog_nm;
  }

  public void setProg_nm(String prog_nm) {
    this.prog_nm = prog_nm;
  }
}
