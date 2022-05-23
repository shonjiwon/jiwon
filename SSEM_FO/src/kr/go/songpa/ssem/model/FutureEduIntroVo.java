package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class FutureEduIntroVo implements Serializable {

  private static final long serialVersionUID = -5591504890157731682L;
  private long future_edu_intro_idx;
  private long group_idx;
  private String name;
  private String cont;
  private String tgt;
  private String term_time;
  private String capacity;
  private String fee;
  private String quest;
  private String location;
  private String explain;
  private String thumb_atch_file_id;
  private String thumb_sub_file_id1;
  private String thumb_sub_file_id2;
  private String alt_txt;
  private String alt_txt1;
  private String alt_txt2;
  private String main_yn;
  private long cnt;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String p_idx;
  private String p_name;
  private String grp_name;
  private List<FileVo> thumbFileList;
  private List<FileVo> thumbSubFileList1;
  private List<FileVo> thumbSubFileList2;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getFuture_edu_intro_idx() {
    return future_edu_intro_idx;
  }

  public void setFuture_edu_intro_idx(long future_edu_intro_idx) {
    this.future_edu_intro_idx = future_edu_intro_idx;
  }

  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getCont() {
    return cont;
  }

  public void setCont(String cont) {
    this.cont = cont;
  }

  public String getTgt() {
    return tgt;
  }

  public void setTgt(String tgt) {
    this.tgt = tgt;
  }

  public String getTerm_time() {
    return term_time;
  }

  public void setTerm_time(String term_time) {
    this.term_time = term_time;
  }

  public String getCapacity() {
    return capacity;
  }

  public void setCapacity(String capacity) {
    this.capacity = capacity;
  }

  public String getFee() {
    return fee;
  }

  public void setFee(String fee) {
    this.fee = fee;
  }

  public String getQuest() {
    return quest;
  }

  public void setQuest(String quest) {
    this.quest = quest;
  }

  public String getLocation() {
    return location;
  }

  public void setLocation(String location) {
    this.location = location;
  }

  public String getExplain() {
    return explain;
  }

  public void setExplain(String explain) {
    this.explain = explain;
  }

  public String getThumb_atch_file_id() {
    return thumb_atch_file_id;
  }

  public void setThumb_atch_file_id(String thumb_atch_file_id) {
    this.thumb_atch_file_id = thumb_atch_file_id;
  }

  public String getThumb_sub_file_id1() {
    return thumb_sub_file_id1;
  }

  public void setThumb_sub_file_id1(String thumb_sub_file_id1) {
    this.thumb_sub_file_id1 = thumb_sub_file_id1;
  }

  public String getThumb_sub_file_id2() {
    return thumb_sub_file_id2;
  }

  public void setThumb_sub_file_id2(String thumb_sub_file_id2) {
    this.thumb_sub_file_id2 = thumb_sub_file_id2;
  }

  public String getAlt_txt() {
    return alt_txt;
  }

  public void setAlt_txt(String alt_txt) {
    this.alt_txt = alt_txt;
  }

  public String getAlt_txt1() {
    return alt_txt1;
  }

  public void setAlt_txt1(String alt_txt1) {
    this.alt_txt1 = alt_txt1;
  }

  public String getAlt_txt2() {
    return alt_txt2;
  }

  public void setAlt_txt2(String alt_txt2) {
    this.alt_txt2 = alt_txt2;
  }

  public String getMain_yn() {
    return main_yn;
  }

  public void setMain_yn(String main_yn) {
    this.main_yn = main_yn;
  }

  public long getCnt() {
    return cnt;
  }

  public void setCnt(long cnt) {
    this.cnt = cnt;
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

  public List<FileVo> getThumbFileList() {
    return thumbFileList;
  }

  public void setThumbFileList(List<FileVo> thumbFileList) {
    this.thumbFileList = thumbFileList;
  }

  public List<FileVo> getThumbSubFileList1() {
    return thumbSubFileList1;
  }

  public void setThumbSubFileList1(List<FileVo> thumbSubFileList1) {
    this.thumbSubFileList1 = thumbSubFileList1;
  }

  public List<FileVo> getThumbSubFileList2() {
    return thumbSubFileList2;
  }

  public void setThumbSubFileList2(List<FileVo> thumbSubFileList2) {
    this.thumbSubFileList2 = thumbSubFileList2;
  }
}
