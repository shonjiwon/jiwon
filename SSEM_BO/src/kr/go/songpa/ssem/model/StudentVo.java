package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class StudentVo implements Serializable {

  private static final long serialVersionUID = -2942699580531060293L;
  private long student_idx;
  private String user_id;
  private String name;
  private String birth;
  private String gender;
  private String mob_no;
  private String postcode;
  private String addr1;
  private String addr2;
  private String ref_yn;
  private String ref_id;
  private String ref_name;
  private String ref_rel;
  private String ref_mob_no;
  private String like_yn;
  private String memo;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String memo_html;

  private long lecture_apy_idx;
  private long discount_idx;
  private long discount_rate;
  private long pay_sum;
  private DiscountVo discountVo;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getStudent_idx() {
    return student_idx;
  }

  public void setStudent_idx(long student_idx) {
    this.student_idx = student_idx;
  }


  public String getUser_id() {
    return user_id;
  }

  public void setUser_id(String user_id) {
    this.user_id = user_id;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getBirth() {
    return birth;
  }

  public void setBirth(String birth) {
    this.birth = birth;
  }


  public String getGender() {
    return gender;
  }

  public void setGender(String gender) {
    this.gender = gender;
  }


  public String getMob_no() {
    return mob_no;
  }

  public void setMob_no(String mob_no) {
    this.mob_no = mob_no;
  }


  public String getPostcode() {
    return postcode;
  }

  public void setPostcode(String postcode) {
    this.postcode = postcode;
  }


  public String getAddr1() {
    return addr1;
  }

  public void setAddr1(String addr1) {
    this.addr1 = addr1;
  }


  public String getAddr2() {
    return addr2;
  }

  public void setAddr2(String addr2) {
    this.addr2 = addr2;
  }


  public String getRef_yn() {
    return ref_yn;
  }

  public void setRef_yn(String ref_yn) {
    this.ref_yn = ref_yn;
  }


  public String getRef_id() {
    return ref_id;
  }

  public void setRef_id(String ref_id) {
    this.ref_id = ref_id;
  }


  public String getRef_name() {
    return ref_name;
  }

  public void setRef_name(String ref_name) {
    this.ref_name = ref_name;
  }


  public String getRef_rel() {
    return ref_rel;
  }

  public void setRef_rel(String ref_rel) {
    this.ref_rel = ref_rel;
  }


  public String getRef_mob_no() {
    return ref_mob_no;
  }

  public void setRef_mob_no(String ref_mob_no) {
    this.ref_mob_no = ref_mob_no;
  }


  public String getLike_yn() {
    return like_yn;
  }

  public void setLike_yn(String like_yn) {
    this.like_yn = like_yn;
  }


  public String getMemo() {
    return memo;
  }

  public void setMemo(String memo) {
    this.memo = memo;
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

  public long getLecture_apy_idx() {
    return lecture_apy_idx;
  }

  public void setLecture_apy_idx(long lecture_apy_idx) {
    this.lecture_apy_idx = lecture_apy_idx;
  }

  public String getMemo_html() {
    return memo_html;
  }

  public void setMemo_html(String memo_html) {
    this.memo_html = memo_html;
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

  public long getPay_sum() {
    return pay_sum;
  }

  public void setPay_sum(long pay_sum) {
    this.pay_sum = pay_sum;
  }

  public DiscountVo getDiscountVo() {
    return discountVo;
  }

  public void setDiscountVo(DiscountVo discountVo) {
    this.discountVo = discountVo;
  }
}
