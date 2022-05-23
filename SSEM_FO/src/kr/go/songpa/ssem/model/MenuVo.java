package kr.go.songpa.ssem.model;

import java.io.Serializable;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.model
 * Author : shlee
 * Date : 2020-09-13
 * Description :
 * History :
 * Version :
 */
public class MenuVo implements Serializable {

    private static final long serialVersionUID = 1832968755264269716L;

    private int menu_idx = 0;
    private int bbs_mst_idx = 0;
    private int p_menu_idx = 0;
    private String type = "";
    private String kind = "";
    private String name = "";
    private String url = "";
    private String param = "";
    private String ord = "";
    private String yn_use = "";
    private String reg_dt = "";
    private String reg_id = "";
    private String up_dt = "";
    private String up_id = "";
    private int level = 0;
    private String lang = "";
    private List<MenuVo> sublist = null;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public int getMenu_idx() {
        return menu_idx;
    }

    public void setMenu_idx(int menu_idx) {
        this.menu_idx = menu_idx;
    }

    public int getBbs_mst_idx() {
        return bbs_mst_idx;
    }

    public void setBbs_mst_idx(int bbs_mst_idx) {
        this.bbs_mst_idx = bbs_mst_idx;
    }

    public int getP_menu_idx() {
        return p_menu_idx;
    }

    public void setP_menu_idx(int p_menu_idx) {
        this.p_menu_idx = p_menu_idx;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    public String getOrd() {
        return ord;
    }

    public void setOrd(String ord) {
        this.ord = ord;
    }

    public String getYn_use() {
        return yn_use;
    }

    public void setYn_use(String yn_use) {
        this.yn_use = yn_use;
    }

    public String getReg_dt() {
        return reg_dt;
    }

    public void setReg_dt(String reg_dt) {
        this.reg_dt = reg_dt;
    }

    public String getReg_id() {
        return reg_id;
    }

    public void setReg_id(String reg_id) {
        this.reg_id = reg_id;
    }

    public String getUp_dt() {
        return up_dt;
    }

    public void setUp_dt(String up_dt) {
        this.up_dt = up_dt;
    }

    public String getUp_id() {
        return up_id;
    }

    public void setUp_id(String up_id) {
        this.up_id = up_id;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getLang() {
        return lang;
    }

    public void setLang(String lang) {
        this.lang = lang;
    }

    public List<MenuVo> getSublist() {
        return sublist;
    }

    public void setSublist(List<MenuVo> sublist) {
        this.sublist = sublist;
    }
}
