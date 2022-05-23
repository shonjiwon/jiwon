package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class TeacherSatisfactionVo implements Serializable {

  private static final long serialVersionUID = 4212065863192434057L;
  private long idx;
  private long lecture_idx;
  private long teacher_idx;
  private long score = 0;
  private String reg_id;
  private String reg_dt;
  private int avg_score;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getIdx() {
    return idx;
  }

  public void setIdx(long idx) {
    this.idx = idx;
  }

  public long getLecture_idx() {
    return lecture_idx;
  }

  public void setLecture_idx(long lecture_idx) {
    this.lecture_idx = lecture_idx;
  }


  public long getTeacher_idx() {
    return teacher_idx;
  }

  public void setTeacher_idx(long teacher_idx) {
    this.teacher_idx = teacher_idx;
  }


  public long getScore() {
    return score;
  }

  public void setScore(long score) {
    this.score = score;
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

  public int getAvg_score() {
    return avg_score;
  }

  public void setAvg_score(int avg_score) {
    this.avg_score = avg_score;
  }
}
