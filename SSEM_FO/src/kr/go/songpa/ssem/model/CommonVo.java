package kr.go.songpa.ssem.model;

import org.springframework.web.multipart.MultipartFile;

import java.io.Serializable;
import java.util.LinkedHashMap;

/**
 * Program Name : kr.go.songpa.ssem.model
 * Author : shlee
 * Date : 2020-09-16
 * Description :
 * History :
 * Version :
 */
public class CommonVo implements Serializable {

    private static final long serialVersionUID = 1676763678241064474L;

    /* 첨부파일 관련 */
    private boolean ftype_flag = true;
    private int chkcnt = 0;
    //private Map<String, MultipartFile> tmpfiles = null;
    private LinkedHashMap<String, MultipartFile> tmpfiles = null;

    public boolean isFtype_flag() {
        return ftype_flag;
    }
    public void setFtype_flag(boolean ftype_flag) {
        this.ftype_flag = ftype_flag;
    }
    public int getChkcnt() {
        return chkcnt;
    }
    public void setChkcnt(int chkcnt) {
        this.chkcnt = chkcnt;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
    public LinkedHashMap<String, MultipartFile> getTmpfiles() {
        return tmpfiles;
    }
    public void setTmpfiles(LinkedHashMap<String, MultipartFile> tmpfiles) {
        this.tmpfiles = tmpfiles;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }
}
