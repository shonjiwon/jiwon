package kr.go.songpa.ssem.common;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Program Name : kr.go.songpa.ssem.common
 * Author : shlee
 * Date : 2020-09-14
 * Description :
 * History :
 * Version :
 */
public class RemoveHtmlTag extends TagSupport {
    private static final long serialVersionUID = -558626333979584137L;

    private String pstr;
    private Integer limit;
    private boolean isdot;

    public RemoveHtmlTag() {
        super();
        init();
    }

    private void init() {
        limit = 0;
        isdot = true;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public void setPstr(String pStr) {
        pstr = pStr;
    }

    public int doStartTag() throws JspException {
        try {
            JspWriter out = pageContext.getOut();
            pstr = this.removeHtml(pstr);

            if (limit > 0) {
                this.pstr = this.cutString(this.pstr, limit, isdot);
            }

            out.print(this.removeHtml(pstr));
        } catch (IOException ioe) {
            //throw new JspException("Error: " + ioe.getMessage());
        }
        return SKIP_BODY;
    }

    public void release() {
        init();
    }


    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    public String removeHtml(String content) {

        String result = "";
        Pattern SCRIPTS = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>", Pattern.DOTALL);
        Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>", Pattern.DOTALL);
        Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");
        Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
        Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
        Pattern WHITESPACE = Pattern.compile("\\s\\s+");


        Matcher m;
        if (content == null || content.equals("null")) {
            result = "";
        } else {
            m = SCRIPTS.matcher(content);
            content = m.replaceAll("");

            m = STYLE.matcher(content);
            content = m.replaceAll("");

            m = TAGS.matcher(content);
            content = m.replaceAll("");

            m = nTAGS.matcher(content);
            content = m.replaceAll("");

            m = ENTITY_REFS.matcher(content);
            content = m.replaceAll("");

            m = WHITESPACE.matcher(content);
            content = m.replaceAll("");

            result = content;
        }
        return result;
    }

    public String rplc(String str, String n1, String n2) {
        int itmp = 0;
        String result = "";
        if (str == null) {
            result = "";
        } else {
            String tmp = str;
            StringBuffer sb = new StringBuffer();
            sb.append("");
            while (tmp.indexOf(n1) > -1) {
                itmp = tmp.indexOf(n1);
                sb.append(tmp.substring(0, itmp));
                sb.append(n2);
                tmp = tmp.substring(itmp + n1.length());
            }
            sb.append(tmp);
            result = sb.toString();
        }
        return result;
    }

    public String cutString(String str, int limit, boolean isDot) {
        String result = "";
        if (str != null) {
            str = rplc(str, "&quot;", "\"");
        }
        limit = limit * 2;
        if (str == null || limit < 4) {
            result = str;
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
            result = rplc(str, "\"", "&quot");

        }
        return result;
    }
}
