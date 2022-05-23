package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class CoachRoomVo implements Serializable {

  private static final long serialVersionUID = 4025769526572751788L;
  private long coach_room_idx;
  private String url;
  private String start_time;
  private String end_time;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String start_hour;
  private String start_min;
  private String end_hour;
  private String end_min;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getCoach_room_idx() {
    return coach_room_idx;
  }

  public void setCoach_room_idx(long coach_room_idx) {
    this.coach_room_idx = coach_room_idx;
  }

  public String getUrl() {
    return url;
  }

  public void setUrl(String url) {
    this.url = url;
  }

  public String getStart_time() {
    return start_time;
  }

  public void setStart_time(String start_time) {
    this.start_time = start_time;
  }

  public String getEnd_time() {
    return end_time;
  }

  public void setEnd_time(String end_time) {
    this.end_time = end_time;
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

  public String getStart_hour() {
    return start_hour;
  }

  public void setStart_hour(String start_hour) {
    this.start_hour = start_hour;
  }

  public String getStart_min() {
    return start_min;
  }

  public void setStart_min(String start_min) {
    this.start_min = start_min;
  }

  public String getEnd_hour() {
    return end_hour;
  }

  public void setEnd_hour(String end_hour) {
    this.end_hour = end_hour;
  }

  public String getEnd_min() {
    return end_min;
  }

  public void setEnd_min(String end_min) {
    this.end_min = end_min;
  }
}
