package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class TracProgResultVo implements Serializable {

  private static final long serialVersionUID = 741986314527213348L;
  private long prog_result_seq;
  private String standard_yymm;
  private String dong_cd;
  private String div_cd;
  private String man_cnt;
  private String woman_cnt;
  private String adult_woman_cnt;
  private String youth_cnt;
  private String adult_man_cnt;
  private String oldman_cnt;
  private String operate_cnt;
  private long collect_amount;
  private long lecturer_pay_amount;
  private long support_amount;
  private String use_yn;
  private String reg_id;
  private String reg_date;
  private long prog_seq;
  private long tuition_monthly_fee;
  private long lecturer_hourly_fee;
  private long lecture_hour;
  private long lecturer_cnt;
  private long reduce_cnt;
  private long reduce100_cnt;
  private String tax_exemption;

  private String prog_nm;
  private TracProgramVo tracProgramVo;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getProg_result_seq() {
    return prog_result_seq;
  }

  public void setProg_result_seq(long prog_result_seq) {
    this.prog_result_seq = prog_result_seq;
  }


  public String getStandard_yymm() {
    return standard_yymm;
  }

  public void setStandard_yymm(String standard_yymm) {
    this.standard_yymm = standard_yymm;
  }


  public String getDong_cd() {
    return dong_cd;
  }

  public void setDong_cd(String dong_cd) {
    this.dong_cd = dong_cd;
  }


  public String getDiv_cd() {
    return div_cd;
  }

  public void setDiv_cd(String div_cd) {
    this.div_cd = div_cd;
  }


  public String getMan_cnt() {
    return man_cnt;
  }

  public void setMan_cnt(String man_cnt) {
    this.man_cnt = man_cnt;
  }


  public String getWoman_cnt() {
    return woman_cnt;
  }

  public void setWoman_cnt(String woman_cnt) {
    this.woman_cnt = woman_cnt;
  }


  public String getAdult_woman_cnt() {
    return adult_woman_cnt;
  }

  public void setAdult_woman_cnt(String adult_woman_cnt) {
    this.adult_woman_cnt = adult_woman_cnt;
  }


  public String getYouth_cnt() {
    return youth_cnt;
  }

  public void setYouth_cnt(String youth_cnt) {
    this.youth_cnt = youth_cnt;
  }


  public String getAdult_man_cnt() {
    return adult_man_cnt;
  }

  public void setAdult_man_cnt(String adult_man_cnt) {
    this.adult_man_cnt = adult_man_cnt;
  }


  public String getOldman_cnt() {
    return oldman_cnt;
  }

  public void setOldman_cnt(String oldman_cnt) {
    this.oldman_cnt = oldman_cnt;
  }


  public String getOperate_cnt() {
    return operate_cnt;
  }

  public void setOperate_cnt(String operate_cnt) {
    this.operate_cnt = operate_cnt;
  }


  public long getCollect_amount() {
    return collect_amount;
  }

  public void setCollect_amount(long collect_amount) {
    this.collect_amount = collect_amount;
  }


  public long getLecturer_pay_amount() {
    return lecturer_pay_amount;
  }

  public void setLecturer_pay_amount(long lecturer_pay_amount) {
    this.lecturer_pay_amount = lecturer_pay_amount;
  }


  public long getSupport_amount() {
    return support_amount;
  }

  public void setSupport_amount(long support_amount) {
    this.support_amount = support_amount;
  }


  public String getUse_yn() {
    return use_yn;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
  }


  public String getReg_id() {
    return reg_id;
  }

  public void setReg_id(String reg_id) {
    this.reg_id = reg_id;
  }


  public String getReg_date() {
    return reg_date;
  }

  public void setReg_date(String reg_date) {
    this.reg_date = reg_date;
  }


  public long getProg_seq() {
    return prog_seq;
  }

  public void setProg_seq(long prog_seq) {
    this.prog_seq = prog_seq;
  }


  public long getTuition_monthly_fee() {
    return tuition_monthly_fee;
  }

  public void setTuition_monthly_fee(long tuition_monthly_fee) {
    this.tuition_monthly_fee = tuition_monthly_fee;
  }


  public long getLecturer_hourly_fee() {
    return lecturer_hourly_fee;
  }

  public void setLecturer_hourly_fee(long lecturer_hourly_fee) {
    this.lecturer_hourly_fee = lecturer_hourly_fee;
  }


  public long getLecture_hour() {
    return lecture_hour;
  }

  public void setLecture_hour(long lecture_hour) {
    this.lecture_hour = lecture_hour;
  }


  public long getLecturer_cnt() {
    return lecturer_cnt;
  }

  public void setLecturer_cnt(long lecturer_cnt) {
    this.lecturer_cnt = lecturer_cnt;
  }


  public long getReduce_cnt() {
    return reduce_cnt;
  }

  public void setReduce_cnt(long reduce_cnt) {
    this.reduce_cnt = reduce_cnt;
  }


  public long getReduce100_cnt() {
    return reduce100_cnt;
  }

  public void setReduce100_cnt(long reduce100_cnt) {
    this.reduce100_cnt = reduce100_cnt;
  }


  public String getTax_exemption() {
    return tax_exemption;
  }

  public void setTax_exemption(String tax_exemption) {
    this.tax_exemption = tax_exemption;
  }

  public String getProg_nm() {
    return prog_nm;
  }

  public void setProg_nm(String prog_nm) {
    this.prog_nm = prog_nm;
  }

  public TracProgramVo getTracProgramVo() {
    return tracProgramVo;
  }

  public void setTracProgramVo(TracProgramVo tracProgramVo) {
    this.tracProgramVo = tracProgramVo;
  }
}
