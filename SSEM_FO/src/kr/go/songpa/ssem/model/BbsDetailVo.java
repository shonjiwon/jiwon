package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class BbsDetailVo implements Serializable {

  private static final long serialVersionUID = 7577628385110489741L;

  private long bbs_detail_idx;
  private long group_idx;
  private String gubun;
  private String type_cd;
  private String p_top_yn;
  private String top_yn;
  private long ord;
  private long pt_ord;
  private String title;
  private String cont;
  private String use_yn;
  private String atch_file_id;
  private long cnt;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;
  private String thumb_atch_file_id;
  private String alt_txt;
  private String movie_url;
  private String main_use_yn;

  private String p_name;
  private String grp_name;
  private FileVo fileVo;
  private List<FileVo> fileList;
  private List<FileVo> thumbFileList;
  private String p_idx;
  private List<OrdVo> ordList;
  private String reg_nm;
  private int prev_idx;
  private int next_idx;
  private BbsDetailVo prev;
  private BbsDetailVo next;
  private List<String> array_group_idx;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getBbs_detail_idx() {
    return bbs_detail_idx;
  }

  public void setBbs_detail_idx(long bbs_detail_idx) {
    this.bbs_detail_idx = bbs_detail_idx;
  }

  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }

  public String getGubun() {
    return gubun;
  }

  public void setGubun(String gubun) {
    this.gubun = gubun;
  }

  public String getType_cd() {
    return type_cd;
  }

  public void setType_cd(String type_cd) {
    this.type_cd = type_cd;
  }

  public String getP_top_yn() {
    return p_top_yn;
  }

  public void setP_top_yn(String p_top_yn) {
    this.p_top_yn = p_top_yn;
  }

  public String getTop_yn() {
    return top_yn;
  }

  public void setTop_yn(String top_yn) {
    this.top_yn = top_yn;
  }

  public long getOrd() {
    return ord;
  }

  public void setOrd(long ord) {
    this.ord = ord;
  }

  public long getPt_ord() {
    return pt_ord;
  }

  public void setPt_ord(long pt_ord) {
    this.pt_ord = pt_ord;
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

  public String getUse_yn() {
    return use_yn;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
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

  public String getMovie_url() {
    return movie_url;
  }

  public void setMovie_url(String movie_url) {
    this.movie_url = movie_url;
  }

  public String getMain_use_yn() {
    return main_use_yn;
  }

  public void setMain_use_yn(String main_use_yn) {
    this.main_use_yn = main_use_yn;
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

  public List<OrdVo> getOrdList() {
    return ordList;
  }

  public void setOrdList(List<OrdVo> ordList) {
    this.ordList = ordList;
  }

  public String getReg_nm() {
    return reg_nm;
  }

  public void setReg_nm(String reg_nm) {
    this.reg_nm = reg_nm;
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

  public BbsDetailVo getPrev() {
    return prev;
  }

  public void setPrev(BbsDetailVo prev) {
    this.prev = prev;
  }

  public BbsDetailVo getNext() {
    return next;
  }

  public void setNext(BbsDetailVo next) {
    this.next = next;
  }

  public List<String> getArray_group_idx() {
    return array_group_idx;
  }

  public void setArray_group_idx(List<String> array_group_idx) {
    this.array_group_idx = array_group_idx;
  }
}
