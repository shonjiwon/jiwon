package kr.go.songpa.ssem.model;

import java.io.Serializable;

/**
 * Program Name : kr.go.songpa.ssem.model
 * Author : shlee
 * Date : 2020-11-17
 * Description :
 * History :
 * Version :
 */
public class PayVo implements Serializable {

    private static final long serialVersionUID = 8600390867681709062L;
    private String LGD_OID = "";
    private String LGD_TIMESTAMP = "";
    private String LGD_HASHDATA = "";
    private String CST_PLATFORM = "";
    private String CST_MID = "";
    private String LGD_PAYKEY = "";
    private String LGD_TID = "";

    private long lecture_apy_idx = 0;
    private long lecture_idx = 0;
    private long discount_idx = 0;
    private long discount_rate = 0;
    private long rental_fty_apy_idx = 0;
    private long rental_fty_idx = 0;
    private String pay_method = "";


    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getLGD_OID() {
        return LGD_OID;
    }

    public void setLGD_OID(String LGD_OID) {
        this.LGD_OID = LGD_OID;
    }

    public String getLGD_TIMESTAMP() {
        return LGD_TIMESTAMP;
    }

    public void setLGD_TIMESTAMP(String LGD_TIMESTAMP) {
        this.LGD_TIMESTAMP = LGD_TIMESTAMP;
    }

    public String getLGD_HASHDATA() {
        return LGD_HASHDATA;
    }

    public void setLGD_HASHDATA(String LGD_HASHDATA) {
        this.LGD_HASHDATA = LGD_HASHDATA;
    }

    public String getCST_PLATFORM() {
        return CST_PLATFORM;
    }

    public void setCST_PLATFORM(String CST_PLATFORM) {
        this.CST_PLATFORM = CST_PLATFORM;
    }

    public String getCST_MID() {
        return CST_MID;
    }

    public void setCST_MID(String CST_MID) {
        this.CST_MID = CST_MID;
    }

    public String getLGD_PAYKEY() {
        return LGD_PAYKEY;
    }

    public void setLGD_PAYKEY(String LGD_PAYKEY) {
        this.LGD_PAYKEY = LGD_PAYKEY;
    }

    public String getLGD_TID() {
        return LGD_TID;
    }

    public void setLGD_TID(String LGD_TID) {
        this.LGD_TID = LGD_TID;
    }

    public long getLecture_apy_idx() {
        return lecture_apy_idx;
    }

    public void setLecture_apy_idx(long lecture_apy_idx) {
        this.lecture_apy_idx = lecture_apy_idx;
    }

    public long getLecture_idx() {
        return lecture_idx;
    }

    public void setLecture_idx(long lecture_idx) {
        this.lecture_idx = lecture_idx;
    }

    public long getDiscount_idx() {
        return discount_idx;
    }

    public void setDiscount_idx(long discount_idx) {
        this.discount_idx = discount_idx;
    }

    public long getDiscount_rate() {
        return discount_rate;
    }

    public void setDiscount_rate(long discount_rate) {
        this.discount_rate = discount_rate;
    }

    public long getRental_fty_apy_idx() {
        return rental_fty_apy_idx;
    }

    public void setRental_fty_apy_idx(long rental_fty_apy_idx) {
        this.rental_fty_apy_idx = rental_fty_apy_idx;
    }

    public long getRental_fty_idx() {
        return rental_fty_idx;
    }

    public void setRental_fty_idx(long rental_fty_idx) {
        this.rental_fty_idx = rental_fty_idx;
    }

    public String getPay_method() {
        return pay_method;
    }

    public void setPay_method(String pay_method) {
        this.pay_method = pay_method;
    }
}
