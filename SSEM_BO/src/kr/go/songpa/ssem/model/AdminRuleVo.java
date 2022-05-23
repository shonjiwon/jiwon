package kr.go.songpa.ssem.model;
import java.io.Serializable;


public class AdminRuleVo implements Serializable {

  private static final long serialVersionUID = 4079135955001986008L;

  private long admin_rule_idx;
  private String type;
  private String name;
  private String explain;
  private String menu_info;
  private String use_yn;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String[] menu_array;
  private MenuIndexVo menuIndexVo;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getAdmin_rule_idx() {
    return admin_rule_idx;
  }

  public void setAdmin_rule_idx(long admin_rule_idx) {
    this.admin_rule_idx = admin_rule_idx;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getExplain() {
    return explain;
  }

  public void setExplain(String explain) {
    this.explain = explain;
  }


  public String getMenu_info() {
    return menu_info;
  }

  public void setMenu_info(String menu_info) {
    this.menu_info = menu_info;
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

  public String[] getMenu_array() {
    return menu_array;
  }

  public void setMenu_array(String[] menu_array) {
    this.menu_array = menu_array;
  }

  public MenuIndexVo getMenuIndexVo() {
    return menuIndexVo;
  }

  public void setMenuIndexVo(MenuIndexVo menuIndexVo) {
    this.menuIndexVo = menuIndexVo;
  }
}
