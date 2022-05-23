package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class NewTracInoutVo implements Serializable {

  private static final long serialVersionUID = 5945128704021163602L;
  private long inout_seq;
  private long group_idx;
  private String standard_date;
  private String kind_cd;
  private long inout_cd;
  private long inout_cost;
  private String e_note;
  private long bank_cd;
  private String bank_no;
  private String method_cd;
  private long student_idx;
  private long lecture_idx;
  private String inout_nm;
  private String sdate;
  private String edate;
  private String post_no;
  private String addr;
  private String addr_detail;
  private String adj_yn;
  private String refund_yn;
  private String discount_yn;
  private long discount_idx;
  private long discount_rate;
  private String discount_info;
  private String use_yn;
  private String note;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String dong_nm;
  private String lecture_nm;
  private String inout_cd_nm;
  private StudentVo studentVo;
  private DiscountVo discountVo;
  private String lecture_time;
  private String birth;
  private String gender;
  private String mob_no;
  private long refund_cost;
  private String refund_dt;
  private long ref_seq;
  private long old_ref_seq;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getInout_seq() {
    return inout_seq;
  }

  public void setInout_seq(long inout_seq) {
    this.inout_seq = inout_seq;
  }


  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }


  public String getStandard_date() {
    return standard_date;
  }

  public void setStandard_date(String standard_date) {
    this.standard_date = standard_date;
  }


  public String getKind_cd() {
    return kind_cd;
  }

  public void setKind_cd(String kind_cd) {
    this.kind_cd = kind_cd;
  }


  public long getInout_cd() {
    return inout_cd;
  }

  public void setInout_cd(long inout_cd) {
    this.inout_cd = inout_cd;
  }


  public long getInout_cost() {
    return inout_cost;
  }

  public void setInout_cost(long inout_cost) {
    this.inout_cost = inout_cost;
  }


  public String getE_note() {
    return e_note;
  }

  public void setE_note(String e_note) {
    this.e_note = e_note;
  }


  public long getBank_cd() {
    return bank_cd;
  }

  public void setBank_cd(long bank_cd) {
    this.bank_cd = bank_cd;
  }


  public String getBank_no() {
    return bank_no;
  }

  public void setBank_no(String bank_no) {
    this.bank_no = bank_no;
  }


  public String getMethod_cd() {
    return method_cd;
  }

  public void setMethod_cd(String method_cd) {
    this.method_cd = method_cd;
  }


  public long getStudent_idx() {
    return student_idx;
  }

  public void setStudent_idx(long student_idx) {
    this.student_idx = student_idx;
  }


  public long getLecture_idx() {
    return lecture_idx;
  }

  public void setLecture_idx(long lecture_idx) {
    this.lecture_idx = lecture_idx;
  }


  public String getInout_nm() {
    return inout_nm;
  }

  public void setInout_nm(String inout_nm) {
    this.inout_nm = inout_nm;
  }


  public String getSdate() {
    return sdate;
  }

  public void setSdate(String sdate) {
    this.sdate = sdate;
  }


  public String getEdate() {
    return edate;
  }

  public void setEdate(String edate) {
    this.edate = edate;
  }


  public String getPost_no() {
    return post_no;
  }

  public void setPost_no(String post_no) {
    this.post_no = post_no;
  }


  public String getAddr() {
    return addr;
  }

  public void setAddr(String addr) {
    this.addr = addr;
  }


  public String getAddr_detail() {
    return addr_detail;
  }

  public void setAddr_detail(String addr_detail) {
    this.addr_detail = addr_detail;
  }


  public String getAdj_yn() {
    return adj_yn;
  }

  public void setAdj_yn(String adj_yn) {
    this.adj_yn = adj_yn;
  }


  public String getRefund_yn() {
    return refund_yn;
  }

  public void setRefund_yn(String refund_yn) {
    this.refund_yn = refund_yn;
  }


  public String getDiscount_yn() {
    return discount_yn;
  }

  public void setDiscount_yn(String discount_yn) {
    this.discount_yn = discount_yn;
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


  public String getDiscount_info() {
    return discount_info;
  }

  public void setDiscount_info(String discount_info) {
    this.discount_info = discount_info;
  }


  public String getUse_yn() {
    return use_yn;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
  }


  public String getNote() {
    return note;
  }

  public void setNote(String note) {
    this.note = note;
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

  public String getInout_cd_nm() {
    return inout_cd_nm;
  }

  public void setInout_cd_nm(String inout_cd_nm) {
    this.inout_cd_nm = inout_cd_nm;
  }

  public StudentVo getStudentVo() {
    return studentVo;
  }

  public void setStudentVo(StudentVo studentVo) {
    this.studentVo = studentVo;
  }

  public DiscountVo getDiscountVo() {
    return discountVo;
  }

  public void setDiscountVo(DiscountVo discountVo) {
    this.discountVo = discountVo;
  }

  public String getLecture_time() {
    return lecture_time;
  }

  public void setLecture_time(String lecture_time) {
    this.lecture_time = lecture_time;
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

  public long getRefund_cost() {
    return refund_cost;
  }

  public void setRefund_cost(long refund_cost) {
    this.refund_cost = refund_cost;
  }

  public String getRefund_dt() {
    return refund_dt;
  }

  public void setRefund_dt(String refund_dt) {
    this.refund_dt = refund_dt;
  }

  public long getRef_seq() {
    return ref_seq;
  }

  public void setRef_seq(long ref_seq) {
    this.ref_seq = ref_seq;
  }

  public long getOld_ref_seq() {
    return old_ref_seq;
  }

  public void setOld_ref_seq(long old_ref_seq) {
    this.old_ref_seq = old_ref_seq;
  }
}
