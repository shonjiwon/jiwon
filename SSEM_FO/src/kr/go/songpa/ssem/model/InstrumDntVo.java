package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class InstrumDntVo implements Serializable {

  private static final long serialVersionUID = 2509349480615006657L;
  private long instrum_dnt_idx;
  private String status;
  private String dnt_id;
  private String dnt_name;
  private String dnt_mob_no;
  private String instrum_name;
  private String gubun;
  private long pc_year;
  private String atch_file_id;
  private String cont;
  private String memo;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private FileVo fileVo;
  private List<FileVo> fileList;
  private String mob_1;
  private String mob_2;
  private String mob_3;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getInstrum_dnt_idx() {
    return instrum_dnt_idx;
  }

  public void setInstrum_dnt_idx(long instrum_dnt_idx) {
    this.instrum_dnt_idx = instrum_dnt_idx;
  }


  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }


  public String getDnt_id() {
    return dnt_id;
  }

  public void setDnt_id(String dnt_id) {
    this.dnt_id = dnt_id;
  }


  public String getDnt_name() {
    return dnt_name;
  }

  public void setDnt_name(String dnt_name) {
    this.dnt_name = dnt_name;
  }


  public String getDnt_mob_no() {
    return dnt_mob_no;
  }

  public void setDnt_mob_no(String dnt_mob_no) {
    this.dnt_mob_no = dnt_mob_no;
  }


  public String getInstrum_name() {
    return instrum_name;
  }

  public void setInstrum_name(String instrum_name) {
    this.instrum_name = instrum_name;
  }


  public String getGubun() {
    return gubun;
  }

  public void setGubun(String gubun) {
    this.gubun = gubun;
  }


  public long getPc_year() {
    return pc_year;
  }

  public void setPc_year(long pc_year) {
    this.pc_year = pc_year;
  }


  public String getAtch_file_id() {
    return atch_file_id;
  }

  public void setAtch_file_id(String atch_file_id) {
    this.atch_file_id = atch_file_id;
  }


  public String getCont() {
    return cont;
  }

  public void setCont(String cont) {
    this.cont = cont;
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

  public FileVo getFileVo() {
    return fileVo;
  }

  public void setFileVo(FileVo fileVo) {
    this.fileVo = fileVo;
  }

  public List<FileVo> getFileList() {
    return fileList;
  }

  public void setFileList(List<FileVo> fileList) {
    this.fileList = fileList;
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
}
