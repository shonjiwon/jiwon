package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class LoveVo implements Serializable {

  private static final long serialVersionUID = -5900434496826555617L;
  private long love_idx;
  private long lecture_idx;
  private String reg_id;
  private String reg_dt;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getLove_idx() {
    return love_idx;
  }

  public void setLove_idx(long love_idx) {
    this.love_idx = love_idx;
  }


  public long getLecture_idx() {
    return lecture_idx;
  }

  public void setLecture_idx(long lecture_idx) {
    this.lecture_idx = lecture_idx;
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
}
