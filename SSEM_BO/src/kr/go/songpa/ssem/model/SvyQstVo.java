package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class SvyQstVo implements Serializable {

  private static final long serialVersionUID = 5565477426351822079L;
  private long svy_qst_idx;
  private long svy_idx;
  private long no;
  private String title;
  private String type;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String select_item_idx = "";
  private String answer = "";
  private List<SvyItemVo> itemList = null;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getSvy_qst_idx() {
    return svy_qst_idx;
  }

  public void setSvy_qst_idx(long svy_qst_idx) {
    this.svy_qst_idx = svy_qst_idx;
  }


  public long getSvy_idx() {
    return svy_idx;
  }

  public void setSvy_idx(long svy_idx) {
    this.svy_idx = svy_idx;
  }


  public long getNo() {
    return no;
  }

  public void setNo(long no) {
    this.no = no;
  }


  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }


  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
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

  public String getSelect_item_idx() {
    return select_item_idx;
  }

  public void setSelect_item_idx(String select_item_idx) {
    this.select_item_idx = select_item_idx;
  }

  public String getAnswer() {
    return answer;
  }

  public void setAnswer(String answer) {
    this.answer = answer;
  }

  public List<SvyItemVo> getItemList() {
    return itemList;
  }

  public void setItemList(List<SvyItemVo> itemList) {
    this.itemList = itemList;
  }
}
