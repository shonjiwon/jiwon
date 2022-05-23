package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class SvyMstVo implements Serializable {

  private static final long serialVersionUID = 676067028358892311L;
  private long svy_idx;
  private String title;
  private String start_dt;
  private String end_dt;
  private long reply_cnt;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;
  private String use_yn;

  private List<SvyQstVo> questList = null;
  private String srv_yn = ""; // 진행여부
  private int idx = 0;				// ADD
  private String reg_name = "";    	// 등록자
  private String up_name = "";    	// 수정자

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getSvy_idx() {
    return svy_idx;
  }

  public void setSvy_idx(long svy_idx) {
    this.svy_idx = svy_idx;
  }


  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }


  public String getStart_dt() {
    return start_dt;
  }

  public void setStart_dt(String start_dt) {
    this.start_dt = start_dt;
  }


  public String getEnd_dt() {
    return end_dt;
  }

  public void setEnd_dt(String end_dt) {
    this.end_dt = end_dt;
  }


  public long getReply_cnt() {
    return reply_cnt;
  }

  public void setReply_cnt(long reply_cnt) {
    this.reply_cnt = reply_cnt;
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

  public List<SvyQstVo> getQuestList() {
    return questList;
  }

  public void setQuestList(List<SvyQstVo> questList) {
    this.questList = questList;
  }

  public String getSrv_yn() {
    return srv_yn;
  }

  public void setSrv_yn(String srv_yn) {
    this.srv_yn = srv_yn;
  }

  public int getIdx() {
    return idx;
  }

  public void setIdx(int idx) {
    this.idx = idx;
  }

  public String getReg_name() {
    return reg_name;
  }

  public void setReg_name(String reg_name) {
    this.reg_name = reg_name;
  }

  public String getUp_name() {
    return up_name;
  }

  public void setUp_name(String up_name) {
    this.up_name = up_name;
  }

  public String getUse_yn() {
    return use_yn;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
  }
}
