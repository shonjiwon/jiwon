package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class RegStudyPlaceVo implements Serializable {

  private static final long serialVersionUID = -7780025778039321402L;
  private long reg_study_place_idx;
  private long study_place_idx;
  private long group_idx;
  private String name;
  private String start_dt;
  private String end_dt;
  private String allday_yn;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;
  private String start_time;
  private String end_time;
  private String dt_week;

  private String dt_type;
  private String start_hour;
  private String start_min;
  private String end_hour;
  private String end_min;
  private String p_name;
  private String grp_name;
  private String study_place_name;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getReg_study_place_idx() {
    return reg_study_place_idx;
  }

  public void setReg_study_place_idx(long reg_study_place_idx) {
    this.reg_study_place_idx = reg_study_place_idx;
  }


  public long getStudy_place_idx() {
    return study_place_idx;
  }

  public void setStudy_place_idx(long study_place_idx) {
    this.study_place_idx = study_place_idx;
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


  public String getAllday_yn() {
    return allday_yn;
  }

  public void setAllday_yn(String allday_yn) {
    this.allday_yn = allday_yn;
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


  public String getDt_week() {
    return dt_week;
  }

  public void setDt_week(String dt_week) {
    this.dt_week = dt_week;
  }

  public String getDt_type() {
    return dt_type;
  }

  public void setDt_type(String dt_type) {
    this.dt_type = dt_type;
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

  public String getStudy_place_name() {
    return study_place_name;
  }

  public void setStudy_place_name(String study_place_name) {
    this.study_place_name = study_place_name;
  }
}
