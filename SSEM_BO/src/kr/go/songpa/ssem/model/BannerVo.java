package kr.go.songpa.ssem.model;
import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;


public class BannerVo implements Serializable {

    private static final long serialVersionUID = 2383761106806063732L;
    private long banner_idx;
    private long group_idx;
    private String gubun;
    private String name;
    private String use_yn;
    private long ord;
    private String atch_file_id;
    private String alt_txt;
    private String link;
    private String link_tgt;
    private String reg_id;
    private String reg_dt;
    private String up_id;
    private String up_dt;

    private String p_name;
    private String grp_name;
    private FileVo fileVo;
    private List<FileVo> fileList;
    private List<OrdVo> ordList;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public long getBanner_idx() {
        return banner_idx;
    }

    public void setBanner_idx(long banner_idx) {
        this.banner_idx = banner_idx;
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

    public long getOrd() {
        return ord;
    }

    public void setOrd(long ord) {
        this.ord = ord;
    }

    public String getAtch_file_id() {
        return atch_file_id;
    }

    public void setAtch_file_id(String atch_file_id) {
        this.atch_file_id = atch_file_id;
    }

    public String getAlt_txt() {
        return alt_txt;
    }

    public void setAlt_txt(String alt_txt) {
        this.alt_txt = alt_txt;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getLink_tgt() {
        return link_tgt;
    }

    public void setLink_tgt(String link_tgt) {
        this.link_tgt = link_tgt;
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

    public List<OrdVo> getOrdList() {
        return ordList;
    }

    public void setOrdList(List<OrdVo> ordList) {
        this.ordList = ordList;
    }
}
