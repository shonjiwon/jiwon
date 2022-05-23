package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class TogetherVo implements Serializable {

  private static final long serialVersionUID = 3702445130501886382L;
  private long idx;
  private String atch_file_id;
  private String atch_file_id_1;
  private String atch_file_id_2;
  private String atch_file_id_3;
  private String atch_file_id_4;
  private String atch_file_id_5;
  private String atch_file_id_6;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private FileVo fileVo;
  private List<FileVo> fileList;
  private List<FileVo> oneFileList;
  private List<FileVo> twoFileList;
  private List<FileVo> threeFileList;
  private List<FileVo> fourFileList;
  private List<FileVo> fiveFileList;
  private List<FileVo> sixFileList;
  private String atch_file_id_one;
  private String atch_file_id_two;
  private String atch_file_id_three;
  private String atch_file_id_four;
  private String atch_file_id_five;
  private String atch_file_id_six;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getIdx() {
    return idx;
  }

  public void setIdx(long idx) {
    this.idx = idx;
  }

  public String getAtch_file_id() {
    return atch_file_id;
  }

  public void setAtch_file_id(String atch_file_id) {
    this.atch_file_id = atch_file_id;
  }

  public String getAtch_file_id_1() {
    return atch_file_id_1;
  }

  public void setAtch_file_id_1(String atch_file_id_1) {
    this.atch_file_id_1 = atch_file_id_1;
  }

  public String getAtch_file_id_2() {
    return atch_file_id_2;
  }

  public void setAtch_file_id_2(String atch_file_id_2) {
    this.atch_file_id_2 = atch_file_id_2;
  }

  public String getAtch_file_id_3() {
    return atch_file_id_3;
  }

  public void setAtch_file_id_3(String atch_file_id_3) {
    this.atch_file_id_3 = atch_file_id_3;
  }

  public String getAtch_file_id_4() {
    return atch_file_id_4;
  }

  public void setAtch_file_id_4(String atch_file_id_4) {
    this.atch_file_id_4 = atch_file_id_4;
  }

  public String getAtch_file_id_5() {
    return atch_file_id_5;
  }

  public void setAtch_file_id_5(String atch_file_id_5) {
    this.atch_file_id_5 = atch_file_id_5;
  }

  public String getAtch_file_id_6() {
    return atch_file_id_6;
  }

  public void setAtch_file_id_6(String atch_file_id_6) {
    this.atch_file_id_6 = atch_file_id_6;
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

  public List<FileVo> getOneFileList() {
    return oneFileList;
  }

  public void setOneFileList(List<FileVo> oneFileList) {
    this.oneFileList = oneFileList;
  }

  public List<FileVo> getTwoFileList() {
    return twoFileList;
  }

  public void setTwoFileList(List<FileVo> twoFileList) {
    this.twoFileList = twoFileList;
  }

  public List<FileVo> getThreeFileList() {
    return threeFileList;
  }

  public void setThreeFileList(List<FileVo> threeFileList) {
    this.threeFileList = threeFileList;
  }

  public List<FileVo> getFourFileList() {
    return fourFileList;
  }

  public void setFourFileList(List<FileVo> fourFileList) {
    this.fourFileList = fourFileList;
  }

  public List<FileVo> getFiveFileList() {
    return fiveFileList;
  }

  public void setFiveFileList(List<FileVo> fiveFileList) {
    this.fiveFileList = fiveFileList;
  }

  public List<FileVo> getSixFileList() {
    return sixFileList;
  }

  public void setSixFileList(List<FileVo> sixFileList) {
    this.sixFileList = sixFileList;
  }

  public String getAtch_file_id_one() {
    return atch_file_id_one;
  }

  public void setAtch_file_id_one(String atch_file_id_one) {
    this.atch_file_id_one = atch_file_id_one;
  }

  public String getAtch_file_id_two() {
    return atch_file_id_two;
  }

  public void setAtch_file_id_two(String atch_file_id_two) {
    this.atch_file_id_two = atch_file_id_two;
  }

  public String getAtch_file_id_three() {
    return atch_file_id_three;
  }

  public void setAtch_file_id_three(String atch_file_id_three) {
    this.atch_file_id_three = atch_file_id_three;
  }

  public String getAtch_file_id_four() {
    return atch_file_id_four;
  }

  public void setAtch_file_id_four(String atch_file_id_four) {
    this.atch_file_id_four = atch_file_id_four;
  }

  public String getAtch_file_id_five() {
    return atch_file_id_five;
  }

  public void setAtch_file_id_five(String atch_file_id_five) {
    this.atch_file_id_five = atch_file_id_five;
  }

  public String getAtch_file_id_six() {
    return atch_file_id_six;
  }

  public void setAtch_file_id_six(String atch_file_id_six) {
    this.atch_file_id_six = atch_file_id_six;
  }
}
