package kr.go.songpa.ssem.model;

import java.io.Serializable;

/**
 * Program Name : kr.go.songpa.ssem.model
 * Author : shlee
 * Date : 2020-09-20
 * Description :
 * History :
 * Version :
 */
public class OrdVo implements Serializable {
    private static final long serialVersionUID = 7535031238508072689L;

    private String idx;
    private String val;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getIdx() {
        return idx;
    }

    public void setIdx(String idx) {
        this.idx = idx;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }
}
