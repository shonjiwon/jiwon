package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class TeacherApyVo implements Serializable {

  private static final long serialVersionUID = 2447679437847872005L;
  private long teacher_apy_idx;
  private long code_idx;
  private String status;
  private String apy_name;
  private String apy_id;
  private String apy_gender;
  private String apy_mob_no;
  private String apy_birth;
  private String apy_email;
  private String pic_atch_file_id;
  private String prof_field;
  private String career;
  private String cert;
  private String career_atch_file_id;
  private String memo;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private List<FileVo> picFileList;
  private List<FileVo> careerFileList;
  private String code_name;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getTeacher_apy_idx() {
    return teacher_apy_idx;
  }

  public void setTeacher_apy_idx(long teacher_apy_idx) {
    this.teacher_apy_idx = teacher_apy_idx;
  }


  public long getCode_idx() {
    return code_idx;
  }

  public void setCode_idx(long code_idx) {
    this.code_idx = code_idx;
  }


  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }


  public String getApy_name() {
    return apy_name;
  }

  public void setApy_name(String apy_name) {
    this.apy_name = apy_name;
  }


  public String getApy_id() {
    return apy_id;
  }

  public void setApy_id(String apy_id) {
    this.apy_id = apy_id;
  }


  public String getApy_gender() {
    return apy_gender;
  }

  public void setApy_gender(String apy_gender) {
    this.apy_gender = apy_gender;
  }


  public String getApy_mob_no() {
    return apy_mob_no;
  }

  public void setApy_mob_no(String apy_mob_no) {
    this.apy_mob_no = apy_mob_no;
  }


  public String getApy_birth() {
    return apy_birth;
  }

  public void setApy_birth(String apy_birth) {
    this.apy_birth = apy_birth;
  }


  public String getApy_email() {
    return apy_email;
  }

  public void setApy_email(String apy_email) {
    this.apy_email = apy_email;
  }


  public String getPic_atch_file_id() {
    return pic_atch_file_id;
  }

  public void setPic_atch_file_id(String pic_atch_file_id) {
    this.pic_atch_file_id = pic_atch_file_id;
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


  public String getCareer_atch_file_id() {
    return career_atch_file_id;
  }

  public void setCareer_atch_file_id(String career_atch_file_id) {
    this.career_atch_file_id = career_atch_file_id;
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

  public List<FileVo> getPicFileList() {
    return picFileList;
  }

  public void setPicFileList(List<FileVo> picFileList) {
    this.picFileList = picFileList;
  }

  public List<FileVo> getCareerFileList() {
    return careerFileList;
  }

  public void setCareerFileList(List<FileVo> careerFileList) {
    this.careerFileList = careerFileList;
  }

  public String getCode_name() {
    return code_name;
  }

  public void setCode_name(String code_name) {
    this.code_name = code_name;
  }

  public String getMemo() {
    return memo;
  }

  public void setMemo(String memo) {
    this.memo = memo;
  }
}
