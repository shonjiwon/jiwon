package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class RentalFtyVo implements Serializable {

  private static final long serialVersionUID = 6259797193084178755L;
  private long rental_fty_idx;
  private long group_idx;
  private String name;
  private String use_yn;
  private String thumb_atch_file_id;
  private String alt_txt;
  private String capacity;
  private String use_time;
  private String intro;
  private String cont;
  private long fee;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String p_idx;
  private String p_name;
  private String grp_name;
  private List<FileVo> thumbFileList;
  private List<RentalFtySdVo> dateList;
  private String date;
  private String start_date;
  private String end_date;
  private String mob_1;
  private String mob_2;
  private String mob_3;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getRental_fty_idx() {
    return rental_fty_idx;
  }

  public void setRental_fty_idx(long rental_fty_idx) {
    this.rental_fty_idx = rental_fty_idx;
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

  public String getUse_yn() {
    return use_yn;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
  }

  public String getThumb_atch_file_id() {
    return thumb_atch_file_id;
  }

  public void setThumb_atch_file_id(String thumb_atch_file_id) {
    this.thumb_atch_file_id = thumb_atch_file_id;
  }

  public String getAlt_txt() {
    return alt_txt;
  }

  public void setAlt_txt(String alt_txt) {
    this.alt_txt = alt_txt;
  }

  public String getCapacity() {
    return capacity;
  }

  public void setCapacity(String capacity) {
    this.capacity = capacity;
  }

  public String getUse_time() {
    return use_time;
  }

  public void setUse_time(String use_time) {
    this.use_time = use_time;
  }

  public String getIntro() {
    return intro;
  }

  public void setIntro(String intro) {
    this.intro = intro;
  }

  public String getCont() {
    return cont;
  }

  public void setCont(String cont) {
    this.cont = cont;
  }

  public long getFee() {
    return fee;
  }

  public void setFee(long fee) {
    this.fee = fee;
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

  public List<RentalFtySdVo> getDateList() {
    return dateList;
  }

  public void setDateList(List<RentalFtySdVo> dateList) {
    this.dateList = dateList;
  }

  public String getDate() {
    return date;
  }

  public void setDate(String date) {
    this.date = date;
  }

  public String getStart_date() {
    return start_date;
  }

  public void setStart_date(String start_date) {
    this.start_date = start_date;
  }

  public String getEnd_date() {
    return end_date;
  }

  public void setEnd_date(String end_date) {
    this.end_date = end_date;
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
