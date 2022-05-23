package kr.go.songpa.ssem.common;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Program Name : kr.go.songpa.ssem.common
 * Author : shlee
 * Date : 2020-09-14
 * Description :
 * History :
 * Version :
 */
public class StringTag extends TagSupport {
    private static final long serialVersionUID = 7471740298299864456L;

    private String sdate;
    private String pattern;


    public StringTag() {
        super();
        init();
    }

    private void init() {
        if (pattern == null) {
            pattern = "yyyy-MM-dd";
        }
    }

    /**
     *
     */

    public void setSdate(String pDate) {
        sdate = pDate;
    }


    public void setPattern(String patern) {
        this.pattern = patern;
    }


    public int doStartTag() throws JspException {
        try {
            JspWriter out = pageContext.getOut();
            Date date = new Date();
            Calendar calendar = null;

            String DisYY = "";
            String DisMM = "";
            String DisDD = "";


            if (!sdate.equals("") || sdate == null) {
                sdate = sdate.replaceAll("-", "").replaceAll("\\.", "").replaceAll("/", "");
                DisYY = sdate.substring(0, 4);
                DisMM = sdate.substring(4, 6);
                DisDD = sdate.substring(6, 8);

                calendar = Calendar.getInstance();
                calendar.set(Integer.parseInt(DisYY), Integer
                        .parseInt(DisMM) - 1, Integer
                        .parseInt(DisDD));
                date = calendar.getTime();
                calendar.setTime(date);
            }

            SimpleDateFormat dateFormatter = new SimpleDateFormat(pattern);
            out.print(dateFormatter.format(date));

        } catch (IOException ioe) {
            throw (JspTagException) new JspTagException("Error: " + ioe.getMessage()).initCause(ioe);
        }
        return SKIP_BODY;
    }

    public void release() {
        init();
    }


    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }
}
