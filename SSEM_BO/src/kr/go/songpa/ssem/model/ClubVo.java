package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class ClubVo implements Serializable {

  private static final long serialVersionUID = -7585337561600309052L;
  private long club_idx;
  private long code_idx;
  private String status;
  private String name;
  private String apy_name;
  private String apy_mob_no;
  private String stand_dt;
  private long mem_cnt;
  private String org_name;
  private String meet_dt;
  private String meet_plc;
  private String intro;
  private String action;
  private String atch_file_id;
  private String memo;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;

  private FileVo fileVo;
  private List<FileVo> fileList;
  private String code_nm;


  public long getClub_idx() {
    return club_idx;
  }

  public void setClub_idx(long club_idx) {
    this.club_idx = club_idx;
  }


  public long getCode_idx() {
    return code_idx;
  }

  public void setCode_idx(long code_idx) {
    this.code_idx = code_idx;
  }


  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
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


  public String getStand_dt() {
    return stand_dt;
  }

  public void setStand_dt(String stand_dt) {
    this.stand_dt = stand_dt;
  }


  public long getMem_cnt() {
    return mem_cnt;
  }

  public void setMem_cnt(long mem_cnt) {
    this.mem_cnt = mem_cnt;
  }


  public String getOrg_name() {
    return org_name;
  }

  public void setOrg_name(String org_name) {
    this.org_name = org_name;
  }


  public String getMeet_dt() {
    return meet_dt;
  }

  public void setMeet_dt(String meet_dt) {
    this.meet_dt = meet_dt;
  }


  public String getMeet_plc() {
    return meet_plc;
  }

  public void setMeet_plc(String meet_plc) {
    this.meet_plc = meet_plc;
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
