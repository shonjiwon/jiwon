package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.List;


public class LectureVo implements Serializable {

  private static final long serialVersionUID = -6506873630027274353L;
  private long lecture_idx;
  private long group_idx;
  private String gubun;
  private String use_yn;
  private String name;
  private String thumb_atch_file_id;
  private String alt_txt;
  private String ict_yn;
  private long part_code_idx;
  private String tgt_code;
  private String tgt_detail;
  private String start_dt;
  private String end_dt;
  private String dt_txt;
  private String dt_type;
  private String dt_week;
  private String start_time;
  private String end_time;
  private String time_type;
  private String reg_start_st;
  private String reg_end_dt;
  private String reg_type;
  private String reg_method;
  private String reg_method_url;
  private long student_qty;
  private long online_qty;
  private long wait_qty;
  private long tel_qty;
  private String qty_open_yn;
  private String age_type;
  private String fee_type;
  private long fee;
  private String fee_detail;
  private String pay_type;
  private String discount_yn;
  private String discount_str;
  private String refund_txt;
  private String refund_start_dt;
  private String refund_end_dt;
  private String desc_txt;
  private String cont;
  private long teacher_idx;
  private String teacher_yn;
  private long study_place_idx;
  private String reg_id;
  private String reg_dt;
  private String up_id;
  private String up_dt;
  private String teacher_nm;
  private long visit_qty;
  private long online_can_qty;
  private long wait_can_qty;
  private long visit_can_qty;
  private long tel_can_qty;

  private String p_idx;
  private String p_name;
  private String grp_name;
  private List<FileVo> thumbFileList;
  private String part_name;
  private List<String> weekList;
  private String closing_yn;
  private List<String> array_tgt;
  private String dt_str;
  private String reg_method_str;
  private StudyPlaceVo place;
  private GroupVo group;
  private List<DiscountVo> array_discount;
  private TeacherVo teacher;
  private int love_cnt;
  private int status_code;
  private String status_code_str;
  private String start_hour;
  private String start_min;
  private String end_hour;
  private String end_min;
  private String teacher_name;
  private String study_place_name;
  private int apy_cancel_cnt;
  private int pay_wait_cnt;
  private int pay_ok_cnt;
  private int pay_cancel_cnt;
  private int refund_apy_cnt;
  private int refund_ok_cnt;
  private int appv_ok_cnt;
  private int appv_cancel_cnt;
  private int appv_no_cnt;
  private int student_cnt;
  private String week_list_str;
  private String excel_qty;
  private int free_ok_cnt;

  private String atch_file_id;
  private FileVo fileVo;
  private List<FileVo> fileList;

  public static long getSerialVersionUID() {
    return serialVersionUID;
  }

  public long getLecture_idx() {
    return lecture_idx;
  }

  public void setLecture_idx(long lecture_idx) {
    this.lecture_idx = lecture_idx;
  }


  public long getGroup_idx() {
    return group_idx;
  }

  public void setGroup_idx(long group_idx) {
    this.group_idx = group_idx;
  }


  public String getGubun() {
    return gubun;
  }

  public void setGubun(String gubun) {
    this.gubun = gubun;
  }


  public String getUse_yn() {
    return use_yn;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getThumb_atch_file_id() {
    return thumb_atch_file_id;
  }

  public void setThumb_atch_file_id(String thumb_atch_file_id) {
    this.thumb_atch_file_id = thumb_atch_file_id;
  }


  public String getAlt_txt() {
    return alt_txt;
  }

  public void setAlt_txt(String alt_txt) {
    this.alt_txt = alt_txt;
  }


  public String getIct_yn() {
    return ict_yn;
  }

  public void setIct_yn(String ict_yn) {
    this.ict_yn = ict_yn;
  }


  public long getPart_code_idx() {
    return part_code_idx;
  }

  public void setPart_code_idx(long part_code_idx) {
    this.part_code_idx = part_code_idx;
  }

  public String getTgt_code() {
    return tgt_code;
  }

  public void setTgt_code(String tgt_code) {
    this.tgt_code = tgt_code;
  }

  public String getTgt_detail() {
    return tgt_detail;
  }

  public void setTgt_detail(String tgt_detail) {
    this.tgt_detail = tgt_detail;
  }


  public String getStart_dt() {
    return start_dt;
  }

  public void setStart_dt(String start_dt) {
    this.start_dt = start_dt;
  }


  public String getEnd_dt() {
    return end_dt;
  }

  public void setEnd_dt(String end_dt) {
    this.end_dt = end_dt;
  }


  public String getDt_txt() {
    return dt_txt;
  }

  public void setDt_txt(String dt_txt) {
    this.dt_txt = dt_txt;
  }


  public String getDt_type() {
    return dt_type;
  }

  public void setDt_type(String dt_type) {
    this.dt_type = dt_type;
  }


  public String getDt_week() {
    return dt_week;
  }

  public void setDt_week(String dt_week) {
    this.dt_week = dt_week;
  }


  public String getStart_time() {
    return start_time;
  }

  public void setStart_time(String start_time) {
    this.start_time = start_time;
  }


  public String getEnd_time() {
    return end_time;
  }

  public void setEnd_time(String end_time) {
    this.end_time = end_time;
  }


  public String getTime_type() {
    return time_type;
  }

  public void setTime_type(String time_type) {
    this.time_type = time_type;
  }


  public String getReg_start_st() {
    return reg_start_st;
  }

  public void setReg_start_st(String reg_start_st) {
    this.reg_start_st = reg_start_st;
  }


  public String getReg_end_dt() {
    return reg_end_dt;
  }

  public void setReg_end_dt(String reg_end_dt) {
    this.reg_end_dt = reg_end_dt;
  }


  public String getReg_type() {
    return reg_type;
  }

  public void setReg_type(String reg_type) {
    this.reg_type = reg_type;
  }


  public String getReg_method() {
    return reg_method;
  }

  public void setReg_method(String reg_method) {
    this.reg_method = reg_method;
  }


  public String getReg_method_url() {
    return reg_method_url;
  }

  public void setReg_method_url(String reg_method_url) {
    this.reg_method_url = reg_method_url;
  }


  public long getStudent_qty() {
    return student_qty;
  }

  public void setStudent_qty(long student_qty) {
    this.student_qty = student_qty;
  }


  public long getOnline_qty() {
    return online_qty;
  }

  public void setOnline_qty(long online_qty) {
    this.online_qty = online_qty;
  }


  public long getWait_qty() {
    return wait_qty;
  }

  public void setWait_qty(long wait_qty) {
    this.wait_qty = wait_qty;
  }


  public long getTel_qty() {
    return tel_qty;
  }

  public void setTel_qty(long tel_qty) {
    this.tel_qty = tel_qty;
  }


  public String getQty_open_yn() {
    return qty_open_yn;
  }

  public void setQty_open_yn(String qty_open_yn) {
    this.qty_open_yn = qty_open_yn;
  }


  public String getAge_type() {
    return age_type;
  }

  public void setAge_type(String age_type) {
    this.age_type = age_type;
  }


  public String getFee_type() {
    return fee_type;
  }

  public void setFee_type(String fee_type) {
    this.fee_type = fee_type;
  }


  public long getFee() {
    return fee;
  }

  public void setFee(long fee) {
    this.fee = fee;
  }


  public String getFee_detail() {
    return fee_detail;
  }

  public void setFee_detail(String fee_detail) {
    this.fee_detail = fee_detail;
  }


  public String getPay_type() {
    return pay_type;
  }

  public void setPay_type(String pay_type) {
    this.pay_type = pay_type;
  }


  public String getDiscount_yn() {
    return discount_yn;
  }

  public void setDiscount_yn(String discount_yn) {
    this.discount_yn = discount_yn;
  }

  public String getDiscount_str() {
    return discount_str;
  }

  public void setDiscount_str(String discount_str) {
    this.discount_str = discount_str;
  }

  public String getRefund_txt() {
    return refund_txt;
  }

  public void setRefund_txt(String refund_txt) {
    this.refund_txt = refund_txt;
  }


  public String getRefund_start_dt() {
    return refund_start_dt;
  }

  public void setRefund_start_dt(String refund_start_dt) {
    this.refund_start_dt = refund_start_dt;
  }


  public String getRefund_end_dt() {
    return refund_end_dt;
  }

  public void setRefund_end_dt(String refund_end_dt) {
    this.refund_end_dt = refund_end_dt;
  }


  public String getDesc_txt() {
    return desc_txt;
  }

  public void setDesc_txt(String desc_txt) {
    this.desc_txt = desc_txt;
  }


  public String getCont() {
    return cont;
  }

  public void setCont(String cont) {
    this.cont = cont;
  }


  public long getTeacher_idx() {
    return teacher_idx;
  }

  public void setTeacher_idx(long teacher_idx) {
    this.teacher_idx = teacher_idx;
  }


  public String getTeacher_yn() {
    return teacher_yn;
  }

  public void setTeacher_yn(String teacher_yn) {
    this.teacher_yn = teacher_yn;
  }


  public long getStudy_place_idx() {
    return study_place_idx;
  }

  public void setStudy_place_idx(long study_place_idx) {
    this.study_place_idx = study_place_idx;
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

  public String getP_idx() {
    return p_idx;
  }

  public void setP_idx(String p_idx) {
    this.p_idx = p_idx;
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

  public List<FileVo> getThumbFileList() {
    return thumbFileList;
  }

  public void setThumbFileList(List<FileVo> thumbFileList) {
    this.thumbFileList = thumbFileList;
  }

  public String getPart_name() {
    return part_name;
  }

  public void setPart_name(String part_name) {
    this.part_name = part_name;
  }

  public List<String> getWeekList() {
    return weekList;
  }

  public void setWeekList(List<String> weekList) {
    this.weekList = weekList;
  }

  public String getTeacher_nm() {
    return teacher_nm;
  }

  public void setTeacher_nm(String teacher_nm) {
    this.teacher_nm = teacher_nm;
  }

  public long getVisit_qty() {
    return visit_qty;
  }

  public void setVisit_qty(long visit_qty) {
    this.visit_qty = visit_qty;
  }

  public long getOnline_can_qty() {
    return online_can_qty;
  }

  public void setOnline_can_qty(long online_can_qty) {
    this.online_can_qty = online_can_qty;
  }

  public long getWait_can_qty() {
    return wait_can_qty;
  }

  public void setWait_can_qty(long wait_can_qty) {
    this.wait_can_qty = wait_can_qty;
  }

  public String getClosing_yn() {
    return closing_yn;
  }

  public void setClosing_yn(String closing_yn) {
    this.closing_yn = closing_yn;
  }

  public List<String> getArray_tgt() {
    return array_tgt;
  }

  public void setArray_tgt(List<String> array_tgt) {
    this.array_tgt = array_tgt;
  }

  public String getDt_str() {
    return dt_str;
  }

  public void setDt_str(String dt_str) {
    this.dt_str = dt_str;
  }

  public String getReg_method_str() {
    return reg_method_str;
  }

  public void setReg_method_str(String reg_method_str) {
    this.reg_method_str = reg_method_str;
  }

  public StudyPlaceVo getPlace() {
    return place;
  }

  public void setPlace(StudyPlaceVo place) {
    this.place = place;
  }

  public GroupVo getGroup() {
    return group;
  }

  public void setGroup(GroupVo group) {
    this.group = group;
  }

  public List<DiscountVo> getArray_discount() {
    return array_discount;
  }

  public void setArray_discount(List<DiscountVo> array_discount) {
    this.array_discount = array_discount;
  }

  public TeacherVo getTeacher() {
    return teacher;
  }

  public void setTeacher(TeacherVo teacher) {
    this.teacher = teacher;
  }

  public int getLove_cnt() {
    return love_cnt;
  }

  public void setLove_cnt(int love_cnt) {
    this.love_cnt = love_cnt;
  }

  public int getStatus_code() {
    return status_code;
  }

  public void setStatus_code(int status_code) {
    this.status_code = status_code;
  }

  public String getStart_hour() {
    return start_hour;
  }

  public void setStart_hour(String start_hour) {
    this.start_hour = start_hour;
  }

  public String getStart_min() {
    return start_min;
  }

  public void setStart_min(String start_min) {
    this.start_min = start_min;
  }

  public String getEnd_hour() {
    return end_hour;
  }

  public void setEnd_hour(String end_hour) {
    this.end_hour = end_hour;
  }

  public String getEnd_min() {
    return end_min;
  }

  public void setEnd_min(String end_min) {
    this.end_min = end_min;
  }

  public String getTeacher_name() {
    return teacher_name;
  }

  public void setTeacher_name(String teacher_name) {
    this.teacher_name = teacher_name;
  }

  public String getStudy_place_name() {
    return study_place_name;
  }

  public void setStudy_place_name(String study_place_name) {
    this.study_place_name = study_place_name;
  }

  public int getApy_cancel_cnt() {
    return apy_cancel_cnt;
  }

  public void setApy_cancel_cnt(int apy_cancel_cnt) {
    this.apy_cancel_cnt = apy_cancel_cnt;
  }

  public int getPay_wait_cnt() {
    return pay_wait_cnt;
  }

  public void setPay_wait_cnt(int pay_wait_cnt) {
    this.pay_wait_cnt = pay_wait_cnt;
  }

  public int getPay_ok_cnt() {
    return pay_ok_cnt;
  }

  public void setPay_ok_cnt(int pay_ok_cnt) {
    this.pay_ok_cnt = pay_ok_cnt;
  }

  public int getPay_cancel_cnt() {
    return pay_cancel_cnt;
  }

  public void setPay_cancel_cnt(int pay_cancel_cnt) {
    this.pay_cancel_cnt = pay_cancel_cnt;
  }

  public int getRefund_apy_cnt() {
    return refund_apy_cnt;
  }

  public void setRefund_apy_cnt(int refund_apy_cnt) {
    this.refund_apy_cnt = refund_apy_cnt;
  }

  public int getRefund_ok_cnt() {
    return refund_ok_cnt;
  }

  public void setRefund_ok_cnt(int refund_ok_cnt) {
    this.refund_ok_cnt = refund_ok_cnt;
  }

  public int getAppv_ok_cnt() {
    return appv_ok_cnt;
  }

  public void setAppv_ok_cnt(int appv_ok_cnt) {
    this.appv_ok_cnt = appv_ok_cnt;
  }

  public int getAppv_cancel_cnt() {
    return appv_cancel_cnt;
  }

  public void setAppv_cancel_cnt(int appv_cancel_cnt) {
    this.appv_cancel_cnt = appv_cancel_cnt;
  }

  public int getAppv_no_cnt() {
    return appv_no_cnt;
  }

  public void setAppv_no_cnt(int appv_no_cnt) {
    this.appv_no_cnt = appv_no_cnt;
  }

  public long getVisit_can_qty() {
    return visit_can_qty;
  }

  public void setVisit_can_qty(long visit_can_qty) {
    this.visit_can_qty = visit_can_qty;
  }

  public long getTel_can_qty() {
    return tel_can_qty;
  }

  public void setTel_can_qty(long tel_can_qty) {
    this.tel_can_qty = tel_can_qty;
  }

  public int getStudent_cnt() {
    return student_cnt;
  }

  public void setStudent_cnt(int student_cnt) {
    this.student_cnt = student_cnt;
  }

  public String getStatus_code_str() {
    return status_code_str;
  }

  public void setStatus_code_str(String status_code_str) {
    this.status_code_str = status_code_str;
  }

  public String getWeek_list_str() {
    return week_list_str;
  }

  public void setWeek_list_str(String week_list_str) {
    this.week_list_str = week_list_str;
  }

  public String getExcel_qty() {
    return excel_qty;
  }

  public void setExcel_qty(String excel_qty) {
    this.excel_qty = excel_qty;
  }

  public int getFree_ok_cnt() {
    return free_ok_cnt;
  }

  public void setFree_ok_cnt(int free_ok_cnt) {
    this.free_ok_cnt = free_ok_cnt;
  }

  public String getAtch_file_id() {
    return atch_file_id;
  }

  public void setAtch_file_id(String atch_file_id) {
    this.atch_file_id = atch_file_id;
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
}
