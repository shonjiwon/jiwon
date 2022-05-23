package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class PersonBookRegVo implements Serializable {

  private static final long serialVersionUID = -3625823762142667803L;
  private long person_book_reg_idx;
  private String cate_cd;
  private String reg_name;
  private String reg_mob_no;
  private String reg_birth;
  private String reg_gender;
  private String reg_age;
  private String reg_addr;
  private String reg_tel_no;
  private String reg_email;
  private String atch_file_id;
  private String career;
  private String intro;
  private String memo;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;
  private String status;

  private List<FileVo> fileList;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getPerson_book_reg_idx() {
    return person_book_reg_idx;
  }

  public void setPerson_book_reg_idx(long person_book_reg_idx) {
    this.person_book_reg_idx = person_book_reg_idx;
  }


  public String getCate_cd() {
    return cate_cd;
  }

  public void setCate_cd(String cate_cd) {
    this.cate_cd = cate_cd;
  }


  public String getReg_name() {
    return reg_name;
  }

  public void setReg_name(String reg_name) {
    this.reg_name = reg_name;
  }


  public String getReg_mob_no() {
    return reg_mob_no;
  }

  public void setReg_mob_no(String reg_mob_no) {
    this.reg_mob_no = reg_mob_no;
  }


  public String getReg_birth() {
    return reg_birth;
  }

  public void setReg_birth(String reg_birth) {
    this.reg_birth = reg_birth;
  }


  public String getReg_gender() {
    return reg_gender;
  }

  public void setReg_gender(String reg_gender) {
    this.reg_gender = reg_gender;
  }


  public String getReg_age() {
    return reg_age;
  }

  public void setReg_age(String reg_age) {
    this.reg_age = reg_age;
  }


  public String getReg_addr() {
    return reg_addr;
  }

  public void setReg_addr(String reg_addr) {
    this.reg_addr = reg_addr;
  }


  public String getReg_tel_no() {
    return reg_tel_no;
  }

  public void setReg_tel_no(String reg_tel_no) {
    this.reg_tel_no = reg_tel_no;
  }


  public String getReg_email() {
    return reg_email;
  }

  public void setReg_email(String reg_email) {
    this.reg_email = reg_email;
  }


  public String getAtch_file_id() {
    return atch_file_id;
  }

  public void setAtch_file_id(String atch_file_id) {
    this.atch_file_id = atch_file_id;
  }


  public String getCareer() {
    return career;
  }

  public void setCareer(String career) {
    this.career = career;
  }


  public String getIntro() {
    return intro;
  }

  public void setIntro(String intro) {
    this.intro = intro;
  }


  public String getMemo() {
    return memo;
  }

  public void setMemo(String memo) {
    this.memo = memo;
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

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public List<FileVo> getFileList() {
    return fileList;
  }

  public void setFileList(List<FileVo> fileList) {
    this.fileList = fileList;
  }
}
