package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class JoinStudyVo implements Serializable {

  private static final long serialVersionUID = -8433867055803670422L;
  private long join_study_idx;
  private long hope_study_idx;
  private String apy_name;
  private String apy_id;
  private String apy_mob_no;
  private String apy_addr1;
  private String apy_addr2;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;
  private String postcode;

  private HopeStudyVo hopeStudyVo;
  private String mob_1;
  private String mob_2;
  private String mob_3;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getJoin_study_idx() {
    return join_study_idx;
  }

  public void setJoin_study_idx(long join_study_idx) {
    this.join_study_idx = join_study_idx;
  }


  public long getHope_study_idx() {
    return hope_study_idx;
  }

  public void setHope_study_idx(long hope_study_idx) {
    this.hope_study_idx = hope_study_idx;
  }


  public String getApy_name() {
    return apy_name;
  }

  public void setApy_name(String apy_name) {
    this.apy_name = apy_name;
  }


  public String getApy_id() {
    return apy_id;
  }

  public void setApy_id(String apy_id) {
    this.apy_id = apy_id;
  }


  public String getApy_mob_no() {
    return apy_mob_no;
  }

  public void setApy_mob_no(String apy_mob_no) {
    this.apy_mob_no = apy_mob_no;
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


  public String getPostcode() {
    return postcode;
  }

  public void setPostcode(String postcode) {
    this.postcode = postcode;
  }

  public HopeStudyVo getHopeStudyVo() {
    return hopeStudyVo;
  }

  public void setHopeStudyVo(HopeStudyVo hopeStudyVo) {
    this.hopeStudyVo = hopeStudyVo;
  }

  public String getMob_1() {
    return mob_1;
  }

  public void setMob_1(String mob_1) {
    this.mob_1 = mob_1;
  }

  public String getMob_2() {
    return mob_2;
  }

  public void setMob_2(String mob_2) {
    this.mob_2 = mob_2;
  }

  public String getMob_3() {
    return mob_3;
  }

  public void setMob_3(String mob_3) {
    this.mob_3 = mob_3;
  }
}
