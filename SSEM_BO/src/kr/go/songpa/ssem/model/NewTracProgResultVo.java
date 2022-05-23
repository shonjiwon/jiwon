package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class NewTracProgResultVo implements Serializable {

  private static final long serialVersionUID = 8310228139653652494L;
  private long prog_result_seq;
  private String standard_yymm;
  private long group_idx;
  private String div_cd;
  private long lecture_idx;
  private String man_cnt;
  private String woman_cnt;
  private String adult_woman_cnt;
  private String youth_cnt;
  private String adult_man_cnt;
  private String oldman_cnt;
  private String tax_exemption;
  private long tuition_monthly_fee;
  private long lecturer_hourly_fee;
  private float lecture_hour;
  private String operate_cnt;
  private long collect_amount;
  private long reduce5_cnt;
  private long reduce5_cost;
  private long reduce10_cnt;
  private long reduce10_cost;
  private long reduce15_cnt;
  private long reduce15_cost;
  private long reduce20_cnt;
  private long reduce20_cost;
  private long reduce25_cnt;
  private long reduce25_cost;
  private long reduce30_cnt;
  private long reduce30_cost;
  private long reduce50_cnt;
  private long reduce50_cost;
  private long reduce100_cnt;
  private long reduce100_cost;
  private long lecturer_fund_cost;
  private long lecturer_exist_cost;
  private String use_yn;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String dong_nm;
  private String lecture_nm;

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

  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }

  public String getDiv_cd() {
    return div_cd;
  }

  public void setDiv_cd(String div_cd) {
    this.div_cd = div_cd;
  }

  public long getLecture_idx() {
    return lecture_idx;
  }

  public void setLecture_idx(long lecture_idx) {
    this.lecture_idx = lecture_idx;
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

  public String getTax_exemption() {
    return tax_exemption;
  }

  public void setTax_exemption(String tax_exemption) {
    this.tax_exemption = tax_exemption;
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

  public float getLecture_hour() {
    return lecture_hour;
  }

  public void setLecture_hour(float lecture_hour) {
    this.lecture_hour = lecture_hour;
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

  public long getReduce5_cnt() {
    return reduce5_cnt;
  }

  public void setReduce5_cnt(long reduce5_cnt) {
    this.reduce5_cnt = reduce5_cnt;
  }

  public long getReduce5_cost() {
    return reduce5_cost;
  }

  public void setReduce5_cost(long reduce5_cost) {
    this.reduce5_cost = reduce5_cost;
  }

  public long getReduce10_cnt() {
    return reduce10_cnt;
  }

  public void setReduce10_cnt(long reduce10_cnt) {
    this.reduce10_cnt = reduce10_cnt;
  }

  public long getReduce10_cost() {
    return reduce10_cost;
  }

  public void setReduce10_cost(long reduce10_cost) {
    this.reduce10_cost = reduce10_cost;
  }

  public long getReduce15_cnt() {
    return reduce15_cnt;
  }

  public void setReduce15_cnt(long reduce15_cnt) {
    this.reduce15_cnt = reduce15_cnt;
  }

  public long getReduce15_cost() {
    return reduce15_cost;
  }

  public void setReduce15_cost(long reduce15_cost) {
    this.reduce15_cost = reduce15_cost;
  }

  public long getReduce20_cnt() {
    return reduce20_cnt;
  }

  public void setReduce20_cnt(long reduce20_cnt) {
    this.reduce20_cnt = reduce20_cnt;
  }

  public long getReduce20_cost() {
    return reduce20_cost;
  }

  public void setReduce20_cost(long reduce20_cost) {
    this.reduce20_cost = reduce20_cost;
  }

  public long getReduce25_cnt() {
    return reduce25_cnt;
  }

  public void setReduce25_cnt(long reduce25_cnt) {
    this.reduce25_cnt = reduce25_cnt;
  }

  public long getReduce25_cost() {
    return reduce25_cost;
  }

  public void setReduce25_cost(long reduce25_cost) {
    this.reduce25_cost = reduce25_cost;
  }

  public long getReduce30_cnt() {
    return reduce30_cnt;
  }

  public void setReduce30_cnt(long reduce30_cnt) {
    this.reduce30_cnt = reduce30_cnt;
  }

  public long getReduce30_cost() {
    return reduce30_cost;
  }

  public void setReduce30_cost(long reduce30_cost) {
    this.reduce30_cost = reduce30_cost;
  }

  public long getReduce50_cnt() {
    return reduce50_cnt;
  }

  public void setReduce50_cnt(long reduce50_cnt) {
    this.reduce50_cnt = reduce50_cnt;
  }

  public long getReduce50_cost() {
    return reduce50_cost;
  }

  public void setReduce50_cost(long reduce50_cost) {
    this.reduce50_cost = reduce50_cost;
  }

  public long getReduce100_cnt() {
    return reduce100_cnt;
  }

  public void setReduce100_cnt(long reduce100_cnt) {
    this.reduce100_cnt = reduce100_cnt;
  }

  public long getReduce100_cost() {
    return reduce100_cost;
  }

  public void setReduce100_cost(long reduce100_cost) {
    this.reduce100_cost = reduce100_cost;
  }

  public long getLecturer_fund_cost() {
    return lecturer_fund_cost;
  }

  public void setLecturer_fund_cost(long lecturer_fund_cost) {
    this.lecturer_fund_cost = lecturer_fund_cost;
  }

  public long getLecturer_exist_cost() {
    return lecturer_exist_cost;
  }

  public void setLecturer_exist_cost(long lecturer_exist_cost) {
    this.lecturer_exist_cost = lecturer_exist_cost;
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

  public String getDong_nm() {
    return dong_nm;
  }

  public void setDong_nm(String dong_nm) {
    this.dong_nm = dong_nm;
  }

  public String getLecture_nm() {
    return lecture_nm;
  }

  public void setLecture_nm(String lecture_nm) {
    this.lecture_nm = lecture_nm;
  }
}
