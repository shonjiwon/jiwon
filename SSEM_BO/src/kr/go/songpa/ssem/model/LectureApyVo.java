package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class LectureApyVo implements Serializable {

  private static final long serialVersionUID = -5739112826675227695L;
  private long lecture_apy_idx;
  private long lecture_idx;
  private String apy_type;
  private String apy_id;
  private String apy_name;
  private String apy_mob_no;
  private String postcode;
  private String apy_addr1;
  private String apy_addr2;
  private String apy_ref;
  private String apy_real_name;
  private String apy_ref_mob_no;
  private long discount_idx;
  private long discount_rate;
  private String pay_sucs_yn;
  private long pay_sum;
  private String pay_dt;
  private String pay_code;
  private String trade_code;
  private String apy_status;
  private String pay_status;
  private String pay_cancel_dt;
  private String refund_dt;
  private String refund_ok_dt;
  private String appv_cd;
  private String appv_up_dt;
  private String refund_apy_yn;
  private String refund_mob_no;
  private String refund_cont;
  private String apy_gender;
  private String apy_birth;
  private String apy_method;
  private String cpl_dt;
  private String cpl_yn;
  private long group_idx;
  private String teacher_love_yn;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private LectureVo lectureVo;
  private String apy_no;
  private String alt_apy_yn;
  private String grp_name;
  private DiscountVo discountVo;
  private String vaccine_yn;
  private String vaccine_dt;
  private String student_type;
  private String student_grade;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getLecture_apy_idx() {
    return lecture_apy_idx;
  }

  public void setLecture_apy_idx(long lecture_apy_idx) {
    this.lecture_apy_idx = lecture_apy_idx;
  }


  public long getLecture_idx() {
    return lecture_idx;
  }

  public void setLecture_idx(long lecture_idx) {
    this.lecture_idx = lecture_idx;
  }


  public String getApy_id() {
    return apy_id;
  }

  public void setApy_id(String apy_id) {
    this.apy_id = apy_id;
  }


  public String getApy_name() {
    return apy_name;
  }

  public void setApy_name(String apy_name) {
    this.apy_name = apy_name;
  }


  public String getApy_mob_no() {
    return apy_mob_no;
  }

  public void setApy_mob_no(String apy_mob_no) {
    this.apy_mob_no = apy_mob_no;
  }


  public String getPostcode() {
    return postcode;
  }

  public void setPostcode(String postcode) {
    this.postcode = postcode;
  }


  public String getApy_addr1() {
    return apy_addr1;
  }

  public void setApy_addr1(String apy_addr1) {
    this.apy_addr1 = apy_addr1;
  }


  public String getApy_addr2() {
    return apy_addr2;
  }

  public void setApy_addr2(String apy_addr2) {
    this.apy_addr2 = apy_addr2;
  }


  public String getApy_ref() {
    return apy_ref;
  }

  public void setApy_ref(String apy_ref) {
    this.apy_ref = apy_ref;
  }


  public String getApy_real_name() {
    return apy_real_name;
  }

  public void setApy_real_name(String apy_real_name) {
    this.apy_real_name = apy_real_name;
  }


  public String getApy_ref_mob_no() {
    return apy_ref_mob_no;
  }

  public void setApy_ref_mob_no(String apy_ref_mob_no) {
    this.apy_ref_mob_no = apy_ref_mob_no;
  }


  public long getDiscount_idx() {
    return discount_idx;
  }

  public void setDiscount_idx(long discount_idx) {
    this.discount_idx = discount_idx;
  }


  public long getDiscount_rate() {
    return discount_rate;
  }

  public void setDiscount_rate(long discount_rate) {
    this.discount_rate = discount_rate;
  }


  public String getPay_sucs_yn() {
    return pay_sucs_yn;
  }

  public void setPay_sucs_yn(String pay_sucs_yn) {
    this.pay_sucs_yn = pay_sucs_yn;
  }


  public long getPay_sum() {
    return pay_sum;
  }

  public void setPay_sum(long pay_sum) {
    this.pay_sum = pay_sum;
  }


  public String getPay_dt() {
    return pay_dt;
  }

  public void setPay_dt(String pay_dt) {
    this.pay_dt = pay_dt;
  }


  public String getPay_code() {
    return pay_code;
  }

  public void setPay_code(String pay_code) {
    this.pay_code = pay_code;
  }


  public String getTrade_code() {
    return trade_code;
  }

  public void setTrade_code(String trade_code) {
    this.trade_code = trade_code;
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

  public String getApy_type() {
    return apy_type;
  }

  public void setApy_type(String apy_type) {
    this.apy_type = apy_type;
  }

  public String getApy_status() {
    return apy_status;
  }

  public void setApy_status(String apy_status) {
    this.apy_status = apy_status;
  }

  public String getPay_status() {
    return pay_status;
  }

  public void setPay_status(String pay_status) {
    this.pay_status = pay_status;
  }

  public LectureVo getLectureVo() {
    return lectureVo;
  }

  public void setLectureVo(LectureVo lectureVo) {
    this.lectureVo = lectureVo;
  }

  public String getPay_cancel_dt() {
    return pay_cancel_dt;
  }

  public void setPay_cancel_dt(String pay_cancel_dt) {
    this.pay_cancel_dt = pay_cancel_dt;
  }

  public String getRefund_dt() {
    return refund_dt;
  }

  public void setRefund_dt(String refund_dt) {
    this.refund_dt = refund_dt;
  }

  public String getRefund_ok_dt() {
    return refund_ok_dt;
  }

  public void setRefund_ok_dt(String refund_ok_dt) {
    this.refund_ok_dt = refund_ok_dt;
  }

  public String getAppv_cd() {
    return appv_cd;
  }

  public void setAppv_cd(String appv_cd) {
    this.appv_cd = appv_cd;
  }

  public String getAppv_up_dt() {
    return appv_up_dt;
  }

  public void setAppv_up_dt(String appv_up_dt) {
    this.appv_up_dt = appv_up_dt;
  }

  public String getRefund_apy_yn() {
    return refund_apy_yn;
  }

  public void setRefund_apy_yn(String refund_apy_yn) {
    this.refund_apy_yn = refund_apy_yn;
  }

  public String getRefund_mob_no() {
    return refund_mob_no;
  }

  public void setRefund_mob_no(String refund_mob_no) {
    this.refund_mob_no = refund_mob_no;
  }

  public String getRefund_cont() {
    return refund_cont;
  }

  public void setRefund_cont(String refund_cont) {
    this.refund_cont = refund_cont;
  }

  public String getCpl_dt() {
    return cpl_dt;
  }

  public void setCpl_dt(String cpl_dt) {
    this.cpl_dt = cpl_dt;
  }

  public String getCpl_yn() {
    return cpl_yn;
  }

  public void setCpl_yn(String cpl_yn) {
    this.cpl_yn = cpl_yn;
  }

  public String getApy_gender() {
    return apy_gender;
  }

  public void setApy_gender(String apy_gender) {
    this.apy_gender = apy_gender;
  }

  public String getApy_birth() {
    return apy_birth;
  }

  public void setApy_birth(String apy_birth) {
    this.apy_birth = apy_birth;
  }

  public String getApy_method() {
    return apy_method;
  }

  public void setApy_method(String apy_method) {
    this.apy_method = apy_method;
  }

  public String getApy_no() {
    return apy_no;
  }

  public void setApy_no(String apy_no) {
    this.apy_no = apy_no;
  }

  public String getAlt_apy_yn() {
    return alt_apy_yn;
  }

  public void setAlt_apy_yn(String alt_apy_yn) {
    this.alt_apy_yn = alt_apy_yn;
  }

  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }

  public String getGrp_name() {
    return grp_name;
  }

  public void setGrp_name(String grp_name) {
    this.grp_name = grp_name;
  }

  public DiscountVo getDiscountVo() {
    return discountVo;
  }

  public void setDiscountVo(DiscountVo discountVo) {
    this.discountVo = discountVo;
  }

  public String getTeacher_love_yn() {
    return teacher_love_yn;
  }

  public void setTeacher_love_yn(String teacher_love_yn) {
    this.teacher_love_yn = teacher_love_yn;
  }

  public String getVaccine_yn() {
    return vaccine_yn;
  }

  public void setVaccine_yn(String vaccine_yn) {
    this.vaccine_yn = vaccine_yn;
  }

  public String getVaccine_dt() {
    return vaccine_dt;
  }

  public void setVaccine_dt(String vaccine_dt) {
    this.vaccine_dt = vaccine_dt;
  }

  public String getStudent_type() {
    return student_type;
  }

  public void setStudent_type(String student_type) {
    this.student_type = student_type;
  }

  public String getStudent_grade() {
    return student_grade;
  }

  public void setStudent_grade(String student_grade) {
    this.student_grade = student_grade;
  }
}
