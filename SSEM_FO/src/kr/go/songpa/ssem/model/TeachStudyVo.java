package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class TeachStudyVo implements Serializable {

  private static final long serialVersionUID = 3840117979879849404L;
  private long teach_study_idx;
  private long hope_study_idx;
  private long code_idx;
  private String apy_name;
  private String apy_id;
  private String apy_mob_no;
  private String name;
  private String cont;
  private String teach_atch_file_id;
  private String career_atch_file_id;
  private String use_yn;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String mob_1;
  private String mob_2;
  private String mob_3;
  private String study_name;
  private String close_yn;
  private String select_yn;
  private String study_start_dt;
  private String study_end_dt;
  private List<FileVo> planFileList;
  private List<FileVo> careerFileList;


  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getTeach_study_idx() {
    return teach_study_idx;
  }

  public void setTeach_study_idx(long teach_study_idx) {
    this.teach_study_idx = teach_study_idx;
  }


  public long getHope_study_idx() {
    return hope_study_idx;
  }

  public void setHope_study_idx(long hope_study_idx) {
    this.hope_study_idx = hope_study_idx;
  }


  public long getCode_idx() {
    return code_idx;
  }

  public void setCode_idx(long code_idx) {
    this.code_idx = code_idx;
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


  public String getApy_mob_no() {
    return apy_mob_no;
  }

  public void setApy_mob_no(String apy_mob_no) {
    this.apy_mob_no = apy_mob_no;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getTeach_atch_file_id() {
    return teach_atch_file_id;
  }

  public void setTeach_atch_file_id(String teach_atch_file_id) {
    this.teach_atch_file_id = teach_atch_file_id;
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

  public String getMob_1() {
    return mob_1;
  }

  public void setMob_1(String mob_1) {
    this.mob_1 = mob_1;
  }

  public String getMob_2() {
    return mob_2;
  }

  public void setMob_2(String mob_2) {
    this.mob_2 = mob_2;
  }

  public String getMob_3() {
    return mob_3;
  }

  public void setMob_3(String mob_3) {
    this.mob_3 = mob_3;
  }

  public String getCont() {
    return cont;
  }

  public void setCont(String cont) {
    this.cont = cont;
  }

  public String getStudy_name() {
    return study_name;
  }

  public void setStudy_name(String study_name) {
    this.study_name = study_name;
  }

  public String getClose_yn() {
    return close_yn;
  }

  public void setClose_yn(String close_yn) {
    this.close_yn = close_yn;
  }

  public String getSelect_yn() {
    return select_yn;
  }

  public void setSelect_yn(String select_yn) {
    this.select_yn = select_yn;
  }

  public String getStudy_start_dt() {
    return study_start_dt;
  }

  public void setStudy_start_dt(String study_start_dt) {
    this.study_start_dt = study_start_dt;
  }

  public String getStudy_end_dt() {
    return study_end_dt;
  }

  public void setStudy_end_dt(String study_end_dt) {
    this.study_end_dt = study_end_dt;
  }

  public String getUse_yn() {
    return use_yn;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
  }

  public List<FileVo> getPlanFileList() {
    return planFileList;
  }

  public void setPlanFileList(List<FileVo> planFileList) {
    this.planFileList = planFileList;
  }

  public List<FileVo> getCareerFileList() {
    return careerFileList;
  }

  public void setCareerFileList(List<FileVo> careerFileList) {
    this.careerFileList = careerFileList;
  }
}
