package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class ClubStatusVo implements Serializable {

  private static final long serialVersionUID = -843917794514345065L;
  private long club_status_idx;
  private long group_idx;
  private long code_idx;
  private String name;
  private String stand_dt;
  private String org_name;
  private long mem_cnt;
  private String meet_dt;
  private String intro;
  private String action;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private String p_name;
  private String grp_name;
  private FileVo fileVo;
  private List<FileVo> fileList;
  private String code_nm;


  public long getClub_status_idx() {
    return club_status_idx;
  }

  public void setClub_status_idx(long club_status_idx) {
    this.club_status_idx = club_status_idx;
  }


  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }


  public long getCode_idx() {
    return code_idx;
  }

  public void setCode_idx(long code_idx) {
    this.code_idx = code_idx;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getStand_dt() {
    return stand_dt;
  }

  public void setStand_dt(String stand_dt) {
    this.stand_dt = stand_dt;
  }


  public String getOrg_name() {
    return org_name;
  }

  public void setOrg_name(String org_name) {
    this.org_name = org_name;
  }


  public long getMem_cnt() {
    return mem_cnt;
  }

  public void setMem_cnt(long mem_cnt) {
    this.mem_cnt = mem_cnt;
  }


  public String getMeet_dt() {
    return meet_dt;
  }

  public void setMeet_dt(String meet_dt) {
    this.meet_dt = meet_dt;
  }


  public String getIntro() {
    return intro;
  }

  public void setIntro(String intro) {
    this.intro = intro;
  }


  public String getAction() {
    return action;
  }

  public void setAction(String action) {
    this.action = action;
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

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public String getP_name() {
    return p_name;
  }

  public void setP_name(String p_name) {
    this.p_name = p_name;
  }

  public String getGrp_name() {
    return grp_name;
  }

  public void setGrp_name(String grp_name) {
    this.grp_name = grp_name;
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

  public String getCode_nm() {
    return code_nm;
  }

  public void setCode_nm(String code_nm) {
    this.code_nm = code_nm;
  }
}
