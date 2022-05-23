package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class InstrumApyVo implements Serializable {

  private static final long serialVersionUID = -4080616772218235947L;
  private long instrum_apy_idx;
  private long instrum_idx;
  private long group_idx;
  private String status;
  private String gubun;
  private String grp_name;
  private long mem_cnt;
  private String rental_start_dt;
  private String rental_end_dt;
  private long rental_month;
  private String return_due_dt;
  private long late_day;
  private long rental_qty;
  private String purpose;
  private long pay;
  private String pay_status;
  private String pay_dt;
  private String refund_method;
  private long refund;
  private String refund_dt;
  private String return_yn;
  private String return_dt;
  private String atch_file_id;
  private String memo;
  private String apy_id;
  private String apy_nm;
  private String apy_birth;
  private String apy_mob_no;
  private String apy_tel_no;
  private String apy_email;
  private String apy_parent_name;
  private String apy_parent_mob_no;
  private String apy_addr;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;
  private String return_flag;

  private String instrum_gubun;
  private String instrum_name;
  private long instrum_fee;
  private String late_yn;
  private FileVo fileVo;
  private List<FileVo> fileList;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getInstrum_apy_idx() {
    return instrum_apy_idx;
  }

  public void setInstrum_apy_idx(long instrum_apy_idx) {
    this.instrum_apy_idx = instrum_apy_idx;
  }

  public long getInstrum_idx() {
    return instrum_idx;
  }

  public void setInstrum_idx(long instrum_idx) {
    this.instrum_idx = instrum_idx;
  }

  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getGubun() {
    return gubun;
  }

  public void setGubun(String gubun) {
    this.gubun = gubun;
  }

  public String getGrp_name() {
    return grp_name;
  }

  public void setGrp_name(String grp_name) {
    this.grp_name = grp_name;
  }

  public long getMem_cnt() {
    return mem_cnt;
  }

  public void setMem_cnt(long mem_cnt) {
    this.mem_cnt = mem_cnt;
  }

  public String getRental_start_dt() {
    return rental_start_dt;
  }

  public void setRental_start_dt(String rental_start_dt) {
    this.rental_start_dt = rental_start_dt;
  }

  public String getRental_end_dt() {
    return rental_end_dt;
  }

  public void setRental_end_dt(String rental_end_dt) {
    this.rental_end_dt = rental_end_dt;
  }

  public long getRental_month() {
    return rental_month;
  }

  public void setRental_month(long rental_month) {
    this.rental_month = rental_month;
  }

  public String getReturn_due_dt() {
    return return_due_dt;
  }

  public void setReturn_due_dt(String return_due_dt) {
    this.return_due_dt = return_due_dt;
  }

  public long getLate_day() {
    return late_day;
  }

  public void setLate_day(long late_day) {
    this.late_day = late_day;
  }

  public long getRental_qty() {
    return rental_qty;
  }

  public void setRental_qty(long rental_qty) {
    this.rental_qty = rental_qty;
  }

  public String getPurpose() {
    return purpose;
  }

  public void setPurpose(String purpose) {
    this.purpose = purpose;
  }

  public long getPay() {
    return pay;
  }

  public void setPay(long pay) {
    this.pay = pay;
  }

  public String getPay_status() {
    return pay_status;
  }

  public void setPay_status(String pay_status) {
    this.pay_status = pay_status;
  }

  public String getPay_dt() {
    return pay_dt;
  }

  public void setPay_dt(String pay_dt) {
    this.pay_dt = pay_dt;
  }

  public String getRefund_method() {
    return refund_method;
  }

  public void setRefund_method(String refund_method) {
    this.refund_method = refund_method;
  }

  public long getRefund() {
    return refund;
  }

  public void setRefund(long refund) {
    this.refund = refund;
  }

  public String getRefund_dt() {
    return refund_dt;
  }

  public void setRefund_dt(String refund_dt) {
    this.refund_dt = refund_dt;
  }

  public String getReturn_yn() {
    return return_yn;
  }

  public void setReturn_yn(String return_yn) {
    this.return_yn = return_yn;
  }

  public String getReturn_dt() {
    return return_dt;
  }

  public void setReturn_dt(String return_dt) {
    this.return_dt = return_dt;
  }

  public String getAtch_file_id() {
    return atch_file_id;
  }

  public void setAtch_file_id(String atch_file_id) {
    this.atch_file_id = atch_file_id;
  }

  public String getMemo() {
    return memo;
  }

  public void setMemo(String memo) {
    this.memo = memo;
  }

  public String getApy_id() {
    return apy_id;
  }

  public void setApy_id(String apy_id) {
    this.apy_id = apy_id;
  }

  public String getApy_nm() {
    return apy_nm;
  }

  public void setApy_nm(String apy_nm) {
    this.apy_nm = apy_nm;
  }

  public String getApy_birth() {
    return apy_birth;
  }

  public void setApy_birth(String apy_birth) {
    this.apy_birth = apy_birth;
  }

  public String getApy_mob_no() {
    return apy_mob_no;
  }

  public void setApy_mob_no(String apy_mob_no) {
    this.apy_mob_no = apy_mob_no;
  }

  public String getApy_tel_no() {
    return apy_tel_no;
  }

  public void setApy_tel_no(String apy_tel_no) {
    this.apy_tel_no = apy_tel_no;
  }

  public String getApy_email() {
    return apy_email;
  }

  public void setApy_email(String apy_email) {
    this.apy_email = apy_email;
  }

  public String getApy_parent_name() {
    return apy_parent_name;
  }

  public void setApy_parent_name(String apy_parent_name) {
    this.apy_parent_name = apy_parent_name;
  }

  public String getApy_parent_mob_no() {
    return apy_parent_mob_no;
  }

  public void setApy_parent_mob_no(String apy_parent_mob_no) {
    this.apy_parent_mob_no = apy_parent_mob_no;
  }

  public String getApy_addr() {
    return apy_addr;
  }

  public void setApy_addr(String apy_addr) {
    this.apy_addr = apy_addr;
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

  public String getInstrum_gubun() {
    return instrum_gubun;
  }

  public void setInstrum_gubun(String instrum_gubun) {
    this.instrum_gubun = instrum_gubun;
  }

  public String getInstrum_name() {
    return instrum_name;
  }

  public void setInstrum_name(String instrum_name) {
    this.instrum_name = instrum_name;
  }

  public long getInstrum_fee() {
    return instrum_fee;
  }

  public void setInstrum_fee(long instrum_fee) {
    this.instrum_fee = instrum_fee;
  }

  public String getLate_yn() {
    return late_yn;
  }

  public void setLate_yn(String late_yn) {
    this.late_yn = late_yn;
  }

  public FileVo getFileVo() {
    return fileVo;
  }

  public void setFileVo(FileVo fileVo) {
    this.fileVo = fileVo;
  }

  public List<FileVo> getFileList() {
    return fileList;
  }

  public void setFileList(List<FileVo> fileList) {
    this.fileList = fileList;
  }

  public String getReturn_flag() {
    return return_flag;
  }

  public void setReturn_flag(String return_flag) {
    this.return_flag = return_flag;
  }
}
