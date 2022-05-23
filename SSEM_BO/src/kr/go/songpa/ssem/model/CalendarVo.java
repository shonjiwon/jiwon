package kr.go.songpa.ssem.model;

import java.io.Serializable;

/**
 * Program Name : kr.go.songpa.ssem.model
 * Author : shlee
 * Date : 2020-11-29
 * Description :
 * History :
 * Version :
 */
public class CalendarVo implements Serializable {
    private static final long serialVersionUID = -8935531968087964498L;
    private String title;
    private String start;
    private String end;
    private String groupId;
    private String url;
    private Boolean allday;
    private String display; /* block, list-item, background, inverse-background */
    private String color;
    private String textColor;  /* #f00, #ff0000, rgb(255,0,0), or red. */
    private String popup_yn;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Boolean getAllday() {
        return allday;
    }

    public void setAllday(Boolean allday) {
        this.allday = allday;
    }

    public String getDisplay() {
        return display;
    }

    public void setDisplay(String display) {
        this.display = display;
    }

    public String getTextColor() {
        return textColor;
    }

    public void setTextColor(String textColor) {
        this.textColor = textColor;
    }

    public String getPopup_yn() {
        return popup_yn;
    }

    public void setPopup_yn(String popup_yn) {
        this.popup_yn = popup_yn;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }
}
