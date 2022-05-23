package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class PersonBookVo implements Serializable {

  private static final long serialVersionUID = -2798543863203479117L;
  private long person_book_idx;
  private long group_idx;
  private String use_yn;
  private String cate_cd;
  private String title;
  private String gubun;
  private long year;
  private long month;
  private String summary;
  private String person;
  private String thumb_atch_file_id;
  private String alt_txt;
  private String atch_file_id;
  private String cont;
  private String movie_url;
  private long cnt;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String p_name;
  private String grp_name;
  private FileVo fileVo;
  private List<FileVo> fileList;
  private List<FileVo> thumbFileList;
  private String p_idx;
  private String year_month;
  private int prev_idx;
  private int next_idx;
  private PersonBookVo prev;
  private PersonBookVo next;
  private String reg_nm;
  private String mob_1;
  private String mob_2;
  private String mob_3;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getPerson_book_idx() {
    return person_book_idx;
  }

  public void setPerson_book_idx(long person_book_idx) {
    this.person_book_idx = person_book_idx;
  }

  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }

  public String getUse_yn() {
    return use_yn;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
  }

  public String getCate_cd() {
    return cate_cd;
  }

  public void setCate_cd(String cate_cd) {
    this.cate_cd = cate_cd;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getGubun() {
    return gubun;
  }

  public void setGubun(String gubun) {
    this.gubun = gubun;
  }

  public long getYear() {
    return year;
  }

  public void setYear(long year) {
    this.year = year;
  }

  public long getMonth() {
    return month;
  }

  public void setMonth(long month) {
    this.month = month;
  }

  public String getSummary() {
    return summary;
  }

  public void setSummary(String summary) {
    this.summary = summary;
  }

  public String getPerson() {
    return person;
  }

  public void setPerson(String person) {
    this.person = person;
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

  public String getMovie_url() {
    return movie_url;
  }

  public void setMovie_url(String movie_url) {
    this.movie_url = movie_url;
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

  public List<FileVo> getThumbFileList() {
    return thumbFileList;
  }

  public void setThumbFileList(List<FileVo> thumbFileList) {
    this.thumbFileList = thumbFileList;
  }

  public String getP_idx() {
    return p_idx;
  }

  public void setP_idx(String p_idx) {
    this.p_idx = p_idx;
  }

  public String getYear_month() {
    return year_month;
  }

  public void setYear_month(String year_month) {
    this.year_month = year_month;
  }

  public int getPrev_idx() {
    return prev_idx;
  }

  public void setPrev_idx(int prev_idx) {
    this.prev_idx = prev_idx;
  }

  public int getNext_idx() {
    return next_idx;
  }

  public void setNext_idx(int next_idx) {
    this.next_idx = next_idx;
  }

  public PersonBookVo getPrev() {
    return prev;
  }

  public void setPrev(PersonBookVo prev) {
    this.prev = prev;
  }

  public PersonBookVo getNext() {
    return next;
  }

  public void setNext(PersonBookVo next) {
    this.next = next;
  }

  public String getReg_nm() {
    return reg_nm;
  }

  public void setReg_nm(String reg_nm) {
    this.reg_nm = reg_nm;
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
