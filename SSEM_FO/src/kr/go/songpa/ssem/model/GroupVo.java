package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class GroupVo implements Serializable {

  private static final long serialVersionUID = 5407866366986239469L;

  private long group_idx;
  private long lvl_cd;
  private long p_idx;
  private String p_name;
  private String name;
  private String use_yn;
  private String addr1;
  private String addr2;
  private String tel_no;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;
  private String pay_shop_id;

  private String tel_1;
  private String tel_2;
  private String tel_3;

  private List<GroupVo> subGroupList;
  private int subGroupCnt;
  private int discount_cnt;
  private int room_cnt;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }

  public long getLvl_cd() {
    return lvl_cd;
  }

  public void setLvl_cd(long lvl_cd) {
    this.lvl_cd = lvl_cd;
  }

  public long getP_idx() {
    return p_idx;
  }

  public void setP_idx(long p_idx) {
    this.p_idx = p_idx;
  }

  public String getP_name() {
    return p_name;
  }

  public void setP_name(String p_name) {
    this.p_name = p_name;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getUse_yn() {
    return use_yn;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
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

  public String getTel_no() {
    return tel_no;
  }

  public void setTel_no(String tel_no) {
    this.tel_no = tel_no;
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

  public List<GroupVo> getSubGroupList() {
    return subGroupList;
  }

  public void setSubGroupList(List<GroupVo> subGroupList) {
    this.subGroupList = subGroupList;
  }

  public int getSubGroupCnt() {
    return subGroupCnt;
  }

  public void setSubGroupCnt(int subGroupCnt) {
    this.subGroupCnt = subGroupCnt;
  }

  public String getTel_1() {
    return tel_1;
  }

  public void setTel_1(String tel_1) {
    this.tel_1 = tel_1;
  }

  public String getTel_2() {
    return tel_2;
  }

  public void setTel_2(String tel_2) {
    this.tel_2 = tel_2;
  }

  public String getTel_3() {
    return tel_3;
  }

  public void setTel_3(String tel_3) {
    this.tel_3 = tel_3;
  }

  public int getDiscount_cnt() {
    return discount_cnt;
  }

  public void setDiscount_cnt(int discount_cnt) {
    this.discount_cnt = discount_cnt;
  }

  public int getRoom_cnt() {
    return room_cnt;
  }

  public void setRoom_cnt(int room_cnt) {
    this.room_cnt = room_cnt;
  }

  public String getPay_shop_id() {
    return pay_shop_id;
  }

  public void setPay_shop_id(String pay_shop_id) {
    this.pay_shop_id = pay_shop_id;
  }
}
