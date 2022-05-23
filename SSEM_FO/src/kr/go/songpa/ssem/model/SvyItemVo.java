package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class SvyItemVo implements Serializable {

  private static final long serialVersionUID = 1422237181796163512L;

  private long svy_item_idx;
  private long svy_qst_idx;
  private long svy_idx;
  private long no;
  private String cont;
  private String sa_yn;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private List<SvyRpyVo> replyList = null;
  private int tot_reply_cnt = 0;
  private String reply_percent = "";

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getSvy_item_idx() {
    return svy_item_idx;
  }

  public void setSvy_item_idx(long svy_item_idx) {
    this.svy_item_idx = svy_item_idx;
  }


  public long getSvy_qst_idx() {
    return svy_qst_idx;
  }

  public void setSvy_qst_idx(long svy_qst_idx) {
    this.svy_qst_idx = svy_qst_idx;
  }


  public long getSvy_idx() {
    return svy_idx;
  }

  public void setSvy_idx(long svy_idx) {
    this.svy_idx = svy_idx;
  }


  public long getNo() {
    return no;
  }

  public void setNo(long no) {
    this.no = no;
  }


  public String getCont() {
    return cont;
  }

  public void setCont(String cont) {
    this.cont = cont;
  }


  public String getSa_yn() {
    return sa_yn;
  }

  public void setSa_yn(String sa_yn) {
    this.sa_yn = sa_yn;
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

  public List<SvyRpyVo> getReplyList() {
    return replyList;
  }

  public void setReplyList(List<SvyRpyVo> replyList) {
    this.replyList = replyList;
  }

  public int getTot_reply_cnt() {
    return tot_reply_cnt;
  }

  public void setTot_reply_cnt(int tot_reply_cnt) {
    this.tot_reply_cnt = tot_reply_cnt;
  }

  public String getReply_percent() {
    return reply_percent;
  }

  public void setReply_percent(String reply_percent) {
    this.reply_percent = reply_percent;
  }
}
