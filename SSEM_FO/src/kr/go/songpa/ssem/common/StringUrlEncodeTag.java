package kr.go.songpa.ssem.common;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * Program Name : kr.go.songpa.ssem.common
 * Author : shlee
 * Date : 2020-09-14
 * Description :
 * History :
 * Version :
 */
public class StringUrlEncodeTag extends TagSupport {
    private static final long serialVersionUID = -3429769629665143084L;

    private String pstr;

    public StringUrlEncodeTag() {
        super();
        init();
    }

    private void init() {
    }

    /**
     *
     */

    public void setPstr(String pstr) {
        this.pstr = pstr;
    }

    public int doStartTag() throws JspException {
        try {
            JspWriter out = pageContext.getOut();
            out.print(URLEncoder.encode(this.pstr));

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
