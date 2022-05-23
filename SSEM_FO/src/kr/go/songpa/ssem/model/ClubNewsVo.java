package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class ClubNewsVo implements Serializable {

  private static final long serialVersionUID = -5957831347249465307L;
  private long club_news_idx;
  private long group_idx;
  private String use_yn;
  private String title;
  private String cont;
  private String thumb_atch_file_id;
  private String atch_file_id;
  private long cnt;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;
  private String alt_txt;

  private String p_name;
  private String grp_name;
  private FileVo fileVo;
  private List<FileVo> fileList;
  private List<FileVo> thumbFileList;
  private int prev_idx;
  private int next_idx;
  private ClubNewsVo prev;
  private ClubNewsVo next;
  private String reg_nm;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getClub_news_idx() {
    return club_news_idx;
  }

  public void setClub_news_idx(long club_news_idx) {
    this.club_news_idx = club_news_idx;
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


  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }


  public String getCont() {
    return cont;
  }

  public void setCont(String cont) {
    this.cont = cont;
  }


  public String getThumb_atch_file_id() {
    return thumb_atch_file_id;
  }

  public void setThumb_atch_file_id(String thumb_atch_file_id) {
    this.thumb_atch_file_id = thumb_atch_file_id;
  }


  public String getAtch_file_id() {
    return atch_file_id;
  }

  public void setAtch_file_id(String atch_file_id) {
    this.atch_file_id = atch_file_id;
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

  public ClubNewsVo getPrev() {
    return prev;
  }

  public void setPrev(ClubNewsVo prev) {
    this.prev = prev;
  }

  public ClubNewsVo getNext() {
    return next;
  }

  public void setNext(ClubNewsVo next) {
    this.next = next;
  }

  public String getReg_nm() {
    return reg_nm;
  }

  public void setReg_nm(String reg_nm) {
    this.reg_nm = reg_nm;
  }

  public String getAlt_txt() {
    return alt_txt;
  }

  public void setAlt_txt(String alt_txt) {
    this.alt_txt = alt_txt;
  }
}
