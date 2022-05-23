package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class TracInoutVo implements Serializable {

  private static final long serialVersionUID = -5653485595310271021L;
  private long inout_seq;
  private String dong_cd;
  private String standard_date;
  private String kind_cd;
  private long amount;
  private String break_down;
  private String inout_yn;
  private String bank_cd;
  private String account_no;
  private String method_cd;
  private String use_yn;
  private String reg_id;
  private String reg_date;
  private long student_seq;
  private long prog_seq;
  private String inout_nm;
  private String sdate;
  private String edate;
  private String comments;
  private String post_no;
  private String addr;
  private String addr_detail;
  private String adj_yn;
  private String refund_yn;
  private String exemption_info;
  private String exemption_gbn;
  private String exemption;

  private String prog_nm;
  private TracStudentVo tracStudentVo;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getInout_seq() {
    return inout_seq;
  }

  public void setInout_seq(long inout_seq) {
    this.inout_seq = inout_seq;
  }


  public String getDong_cd() {
    return dong_cd;
  }

  public void setDong_cd(String dong_cd) {
    this.dong_cd = dong_cd;
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


  public long getAmount() {
    return amount;
  }

  public void setAmount(long amount) {
    this.amount = amount;
  }


  public String getBreak_down() {
    return break_down;
  }

  public void setBreak_down(String break_down) {
    this.break_down = break_down;
  }


  public String getInout_yn() {
    return inout_yn;
  }

  public void setInout_yn(String inout_yn) {
    this.inout_yn = inout_yn;
  }


  public String getBank_cd() {
    return bank_cd;
  }

  public void setBank_cd(String bank_cd) {
    this.bank_cd = bank_cd;
  }


  public String getAccount_no() {
    return account_no;
  }

  public void setAccount_no(String account_no) {
    this.account_no = account_no;
  }


  public String getMethod_cd() {
    return method_cd;
  }

  public void setMethod_cd(String method_cd) {
    this.method_cd = method_cd;
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


  public long getStudent_seq() {
    return student_seq;
  }

  public void setStudent_seq(long student_seq) {
    this.student_seq = student_seq;
  }


  public long getProg_seq() {
    return prog_seq;
  }

  public void setProg_seq(long prog_seq) {
    this.prog_seq = prog_seq;
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


  public String getComments() {
    return comments;
  }

  public void setComments(String comments) {
    this.comments = comments;
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


  public String getExemption_info() {
    return exemption_info;
  }

  public void setExemption_info(String exemption_info) {
    this.exemption_info = exemption_info;
  }


  public String getExemption_gbn() {
    return exemption_gbn;
  }

  public void setExemption_gbn(String exemption_gbn) {
    this.exemption_gbn = exemption_gbn;
  }


  public String getExemption() {
    return exemption;
  }

  public void setExemption(String exemption) {
    this.exemption = exemption;
  }

  public String getProg_nm() {
    return prog_nm;
  }

  public void setProg_nm(String prog_nm) {
    this.prog_nm = prog_nm;
  }

  public TracStudentVo getTracStudentVo() {
    return tracStudentVo;
  }

  public void setTracStudentVo(TracStudentVo tracStudentVo) {
    this.tracStudentVo = tracStudentVo;
  }
}
