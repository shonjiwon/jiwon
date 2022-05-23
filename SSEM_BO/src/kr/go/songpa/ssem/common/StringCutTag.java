package kr.go.songpa.ssem.common;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

/**
 * Program Name : kr.go.songpa.ssem.common
 * Author : shlee
 * Date : 2020-09-14
 * Description :
 * History :
 * Version :
 */
public class StringCutTag extends TagSupport {
    private static final long serialVersionUID = -2099211130155217652L;

    private String pstr;
    private Integer limit;
    private boolean isdot;

    public StringCutTag() {
        super();
        init();
    }

    private void init() {
        isdot = true;
    }

    /**
     *
     */


    public void setPstr(String pstr) {
        this.pstr = pstr;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public void setIsdot(boolean isdot) {
        this.isdot = isdot;
    }

    public int doStartTag() throws JspException {
        try {
            JspWriter out = pageContext.getOut();
            out.print(this.cutString(this.pstr, limit, isdot));

        } catch (IOException ioe) {
            // throw new JspException("StringCutTag Error: " + ioe.getMessage());
        }
        return SKIP_BODY;
    }

    public void release() {
        init();
    }


    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    public String rplc(String str, String n1, String n2) {
        String retVal = "";
        int itmp = 0;
        if (str != null) {
            String tmp = str;
            StringBuffer sb = new StringBuffer();
            sb.append("");
            while (tmp.indexOf(n1) > -1) {
                itmp = tmp.indexOf(n1);
                sb.append(tmp.substring(0, itmp));
                sb.append(n2);
                tmp = tmp.substring(itmp + n1.length());
            }
            retVal = sb.append(tmp).toString();
        }
        return retVal;
    }

    public String cutString(String str, int limit, boolean isDot) {
        String retVal = "";
        if (str != null) {
            str = rplc(str, "&quot;", "\"");
        }
        limit = limit * 2;
        if (str == null || limit < 4) {
            retVal = str;
        } else {
            int len = str.length();
            int cnt = 0, index = 0;

            while (index < len && cnt < limit) {
                if (str.charAt(index++) < 256) // 1바이트 문자라면...
                    cnt++;     // 길이 1 증가
                else {  // 2바이트 문자라면...
                    if (cnt < limit - 1) {
                        cnt += 2;  // 길이 2 증가
                    } else {
                        index--;
                        break;
                    }  // 여기까지 해당 바이트 초과시 버림.
                }
            }
            if (index < len) {
                if (isDot) {
                    str = str.substring(0, index) + " ...";
                } else {
                    str = str.substring(0, index);
                }
            }
            retVal = rplc(str, "\"", "&quot");
        }
        return retVal;
    }
}
