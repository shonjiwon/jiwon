package kr.go.songpa.ssem.model;

import java.io.Serializable;

/**
 * Program Name : kr.go.songpa.ssem.model
 * Author : shlee
 * Date : 2020-09-16
 * Description :
 * History :
 * Version :
 */
public class FileVo implements Serializable {

    private static final long serialVersionUID = 4610243940826091796L;

    private String atch_file_id;        // 파일 아이디
    private String reg_dt;                // 파일 생성 일시
    private String use_yn;                // 사용 여부 'Y': 사용 , 'N': 미사용

    private String file_num;            // 파일순번
    private String file_store_path;        // 파일경로
    private String file_nm;                // 저장파일이름
    private String file_ori_nm;            // 원본파일이름
    private String file_ext;            // 파일확장자
    private String file_con;            // 파일내용
    private Double file_size;            // 파일크기
    private String file_exp;            // 사진설명
    private String file_plc;            // 파일출처

    private String file_src;            // 파일 웹 경로

    public FileVo() {
        atch_file_id = "";                // 파일 아이디
        reg_dt = "";                        // 파일 생성 일시
        use_yn = "";                        // 사용 여부 'Y': 사용 , 'N': 미사용
        file_num = "";                    // 파일순번
        file_store_path = "";                // 파일경로
        file_nm = "";                        // 저장파일이름
        file_ori_nm = "";                    // 원본파일이름
        file_ext = "";                    // 파일확장자
        file_con = "";                    // 파일내용
        file_size = 0.0;                    // 파일크기
        file_src = "";                    // 파일 웹 경로
        file_exp = "";                    // 사진설명
        file_plc = "";                    // 파일출처
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getAtch_file_id() {
        return atch_file_id;
    }

    public void setAtch_file_id(String atch_file_id) {
        this.atch_file_id = atch_file_id;
    }

    public String getReg_dt() {
        return reg_dt;
    }

    public void setReg_dt(String reg_dt) {
        this.reg_dt = reg_dt;
    }

    public String getUse_yn() {
        return use_yn;
    }

    public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
    }

    public String getFile_num() {
        return file_num;
    }

    public void setFile_num(String file_num) {
        this.file_num = file_num;
    }

    public String getFile_store_path() {
        return file_store_path;
    }

    public void setFile_store_path(String file_store_path) {
        this.file_store_path = file_store_path;
    }

    public String getFile_nm() {
        return file_nm;
    }

    public void setFile_nm(String file_nm) {
        this.file_nm = file_nm;
    }

    public String getFile_ori_nm() {
        return file_ori_nm;
    }

    public void setFile_ori_nm(String file_ori_nm) {
        this.file_ori_nm = file_ori_nm;
    }

    public String getFile_ext() {
        return file_ext;
    }

    public void setFile_ext(String file_ext) {
        this.file_ext = file_ext;
    }

    public String getFile_con() {
        return file_con;
    }

    public void setFile_con(String file_con) {
        this.file_con = file_con;
    }

    public Double getFile_size() {
        return file_size;
    }

    public void setFile_size(Double file_size) {
        this.file_size = file_size;
    }

    public String getFile_exp() {
        return file_exp;
    }

    public void setFile_exp(String file_exp) {
        this.file_exp = file_exp;
    }

    public String getFile_plc() {
        return file_plc;
    }

    public void setFile_plc(String file_plc) {
        this.file_plc = file_plc;
    }

    public String getFile_src() {
        return file_src;
    }

    public void setFile_src(String file_src) {
        this.file_src = file_src;
    }
}
