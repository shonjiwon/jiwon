package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class StudentLectVo implements Serializable {

  private static final long serialVersionUID = -7252324687201098534L;
  private long student_lect_idx;
  private long student_idx;
  private long lecture_apy_idx;
  private long group_idx;
  private long p_idx;
  private long lecture_idx;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getStudent_lect_idx() {
    return student_lect_idx;
  }

  public void setStudent_lect_idx(long student_lect_idx) {
    this.student_lect_idx = student_lect_idx;
  }


  public long getStudent_idx() {
    return student_idx;
  }

  public void setStudent_idx(long student_idx) {
    this.student_idx = student_idx;
  }


  public long getLecture_apy_idx() {
    return lecture_apy_idx;
  }

  public void setLecture_apy_idx(long lecture_apy_idx) {
    this.lecture_apy_idx = lecture_apy_idx;
  }


  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }


  public long getP_idx() {
    return p_idx;
  }

  public void setP_idx(long p_idx) {
    this.p_idx = p_idx;
  }

  public long getLecture_idx() {
    return lecture_idx;
  }

  public void setLecture_idx(long lecture_idx) {
    this.lecture_idx = lecture_idx;
  }
}
