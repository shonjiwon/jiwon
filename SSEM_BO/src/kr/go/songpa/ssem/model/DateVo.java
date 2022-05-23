package kr.go.songpa.ssem.model;

import java.io.Serializable;

/**
 * Program Name : kr.go.songpa.ssem.model
 * Author : shlee
 * Date : 2020-12-02
 * Description :
 * History :
 * Version :
 */
public class DateVo implements Serializable {

    private static final long serialVersionUID = -5324445556318687613L;
    private String date;
    private String week_str;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getWeek_str() {
        return week_str;
    }

    public void setWeek_str(String week_str) {
        this.week_str = week_str;
    }
}
