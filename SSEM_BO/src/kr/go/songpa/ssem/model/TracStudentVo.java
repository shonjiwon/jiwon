package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class TracStudentVo implements Serializable {

  private static final long serialVersionUID = 4689649405970088862L;
  private long student_seq;
  private String student_nm;
  private String student_resino;
  private String reg_id;
  private String reg_date;
  private String tel_no;
  private String post_no;
  private String addr;
  private String addr_detail;
  private String email;
  private String dong_cd;
  private String use_yn;
  private String sex;
  private String mobile_no;
  private String exemption;
  private String note;
  private String exemption_info;
  private String exemption_gbn;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getStudent_seq() {
    return student_seq;
  }

  public void setStudent_seq(long student_seq) {
    this.student_seq = student_seq;
  }


  public String getStudent_nm() {
    return student_nm;
  }

  public void setStudent_nm(String student_nm) {
    this.student_nm = student_nm;
  }

  public String getStudent_resino() {
    return student_resino;
  }

  public void setStudent_resino(String student_resino) {
    this.student_resino = student_resino;
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


  public String getTel_no() {
    return tel_no;
  }

  public void setTel_no(String tel_no) {
    this.tel_no = tel_no;
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


  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }


  public String getDong_cd() {
    return dong_cd;
  }

  public void setDong_cd(String dong_cd) {
    this.dong_cd = dong_cd;
  }


  public String getUse_yn() {
    return use_yn;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
  }


  public String getSex() {
    return sex;
  }

  public void setSex(String sex) {
    this.sex = sex;
  }


  public String getMobile_no() {
    return mobile_no;
  }

  public void setMobile_no(String mobile_no) {
    this.mobile_no = mobile_no;
  }


  public String getExemption() {
    return exemption;
  }

  public void setExemption(String exemption) {
    this.exemption = exemption;
  }


  public String getNote() {
    return note;
  }

  public void setNote(String note) {
    this.note = note;
  }


  public String getExemption_info() {
    return exemption_info;
  }

  public void setExemption_info(String exemption_info) {
    this.exemption_info = exemption_info;
  }


  public String getExemption_gbn() {
    return exemption_gbn;
  }

  public void setExemption_gbn(String exemption_gbn) {
    this.exemption_gbn = exemption_gbn;
  }

}
