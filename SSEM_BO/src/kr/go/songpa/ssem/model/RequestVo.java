package kr.go.songpa.ssem.model;

import java.io.Serializable;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.model
 * Author : shlee
 * Date : 2021-12-19
 * Description :
 * History :
 * Version :
 */
public class RequestVo implements Serializable {

    private static final long serialVersionUID = 7871972312170118188L;
    private long req_idx;
    private long group_idx;
    private String gbn_cd;
    private String work_type;
    private String reg_nm;
    private String tel_no;
    private String url;
    private String title;
    private String cont;
    private String atch_file_id;
    private String reg_id;
    private String reg_dt;
    private String up_id;
    private String up_dt;
    private long cnt;

    private String p_name;
    private String grp_name;
    private FileVo fileVo;
    private List<FileVo> fileList;

    public long getReq_idx() {
        return req_idx;
    }

    public void setReq_idx(long req_idx) {
        this.req_idx = req_idx;
    }

    public long getGroup_idx() {
        return group_idx;
    }

    public void setGroup_idx(long group_idx) {
        this.group_idx = group_idx;
    }

    public String getGbn_cd() {
        return gbn_cd;
    }

    public void setGbn_cd(String gbn_cd) {
        this.gbn_cd = gbn_cd;
    }

    public String getWork_type() {
        return work_type;
    }

    public void setWork_type(String work_type) {
        this.work_type = work_type;
    }

    public String getReg_nm() {
        return reg_nm;
    }

    public void setReg_nm(String reg_nm) {
        this.reg_nm = reg_nm;
    }

    public String getTel_no() {
        return tel_no;
    }

    public void setTel_no(String tel_no) {
        this.tel_no = tel_no;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCont() {
        return cont;
    }

    public void setCont(String cont) {
        this.cont = cont;
    }

    public String getAtch_file_id() {
        return atch_file_id;
    }

    public void setAtch_file_id(String atch_file_id) {
        this.atch_file_id = atch_file_id;
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

    public long getCnt() {
        return cnt;
    }

    public void setCnt(long cnt) {
        this.cnt = cnt;
    }
}
