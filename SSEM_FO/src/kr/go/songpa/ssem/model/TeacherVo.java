package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class TeacherVo implements Serializable {

  private static final long serialVersionUID = 3719980182223258975L;
  private long teacher_idx;
  private long group_idx;
  private long code_idx;
  private String pic_atch_file_id;
  private String alt_txt;
  private String name;
  private String gender;
  private String mob_no;
  private String birth;
  private String email;
  private String gubun;
  private String status;
  private String start_dt;
  private String end_dt;
  private String prof_field;
  private String career;
  private String cert;
  private String pay;
  private String user_id;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String p_idx;
  private String p_name;
  private String grp_name;
  private List<FileVo> picFileList;
  private String code_name;
  private int score;
  private long lecture_idx;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getTeacher_idx() {
    return teacher_idx;
  }

  public void setTeacher_idx(long teacher_idx) {
    this.teacher_idx = teacher_idx;
  }


  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }


  public long getCode_idx() {
    return code_idx;
  }

  public void setCode_idx(long code_idx) {
    this.code_idx = code_idx;
  }


  public String getPic_atch_file_id() {
    return pic_atch_file_id;
  }

  public void setPic_atch_file_id(String pic_atch_file_id) {
    this.pic_atch_file_id = pic_atch_file_id;
  }


  public String getAlt_txt() {
    return alt_txt;
  }

  public void setAlt_txt(String alt_txt) {
    this.alt_txt = alt_txt;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getGender() {
    return gender;
  }

  public void setGender(String gender) {
    this.gender = gender;
  }


  public String getMob_no() {
    return mob_no;
  }

  public void setMob_no(String mob_no) {
    this.mob_no = mob_no;
  }


  public String getBirth() {
    return birth;
  }

  public void setBirth(String birth) {
    this.birth = birth;
  }


  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }


  public String getGubun() {
    return gubun;
  }

  public void setGubun(String gubun) {
    this.gubun = gubun;
  }


  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }


  public String getStart_dt() {
    return start_dt;
  }

  public void setStart_dt(String start_dt) {
    this.start_dt = start_dt;
  }


  public String getEnd_dt() {
    return end_dt;
  }

  public void setEnd_dt(String end_dt) {
    this.end_dt = end_dt;
  }


  public String getProf_field() {
    return prof_field;
  }

  public void setProf_field(String prof_field) {
    this.prof_field = prof_field;
  }


  public String getCareer() {
    return career;
  }

  public void setCareer(String career) {
    this.career = career;
  }


  public String getCert() {
    return cert;
  }

  public void setCert(String cert) {
    this.cert = cert;
  }


  public String getPay() {
    return pay;
  }

  public void setPay(String pay) {
    this.pay = pay;
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

  public String getP_idx() {
    return p_idx;
  }

  public void setP_idx(String p_idx) {
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

  public List<FileVo> getPicFileList() {
    return picFileList;
  }

  public void setPicFileList(List<FileVo> picFileList) {
    this.picFileList = picFileList;
  }

  public String getCode_name() {
    return code_name;
  }

  public void setCode_name(String code_name) {
    this.code_name = code_name;
  }

  public int getScore() {
    return score;
  }

  public void setScore(int score) {
    this.score = score;
  }

  public long getLecture_idx() {
    return lecture_idx;
  }

  public void setLecture_idx(long lecture_idx) {
    this.lecture_idx = lecture_idx;
  }

  public String getUser_id() {
    return user_id;
  }

  public void setUser_id(String user_id) {
    this.user_id = user_id;
  }
}
