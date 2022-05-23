package kr.go.songpa.ssem.common;

import kr.go.songpa.ssem.util.Util;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;

/**
 * Program Name : kr.go.songpa.ssem.common
 * Author : shlee
 * Date : 2020-09-14
 * Description :
 * History :
 * Version :
 */
public class PageLinkAdminTag extends TagSupport {
    private static final long serialVersionUID = -2561704188955203611L;

    private String pageParam = "page";
    /**
     * 페이지 홀더명
     *
     * @uml.property name="name"
     */
    private String name;


    /**
     * 페이지홀더 인스턴스
     *
     * @uml.property name="pageHolder"
     * @uml.associationEnd
     */
    private PageHolder pageHolder;

    public int doStartTag() throws JspTagException {
        return SKIP_BODY;
    }

    public int doEndTag() throws JspTagException {
        StringBuffer sb = new StringBuffer();
        JspWriter out = null;
        try {
            this.pageHolder = (PageHolder) lookup(pageContext, name, "request");
            if (pageHolder == null || pageHolder.getTotalRows() < 1) {
                return SKIP_BODY;
            }
            int page = this.pageHolder.getCurrentPage();        // 현재 페이지
            int pageBlockSize = this.pageHolder.getPageSize();    // 페이지 블록 사이즈
            int totalPage = this.pageHolder.getTotalPages();    // 총페이지 수
            String paramString = this.mapToString(this.pageHolder.getParamMap());
            //String paramString = this.mapToString(this.pageHolder.getParamMap());

            //String paramString = makeParamString(pageContext.getRequest());  // 파라메타 연결
            //int pageBlockNo = ((page - 1) / pageBlockSize) * pageBlockSize + 1;
            int pageBlockNo = ((page - 1) / pageBlockSize) * pageBlockSize + 1;
            int pageBlockGroupNo = ((page - 1) / pageBlockSize) * 1 + 1;

            sb.append("<div class=\"paginArea\">");
            sb.append("<ul class=\"pagination\">");
            if (page == 1) {
                sb.append("<li class=\"first\"><a href=\"#none\" alt=\"처음으로\"><span class=\"material-icons\">keyboard_arrow_left</span><span class=\"material-icons\">keyboard_arrow_left</span></a></li>");
            } else {
                //sb.append("<li class=\"first\"><a href=\"?" + paramString + "&amp;page=1\" title=\"처음으로\" alt=\"처음으로\"><span class=\"material-icons\">keyboard_arrow_left</span><span class=\"material-icons\">keyboard_arrow_left</span></a></li>");
                sb.append("<li class=\"first\"><a href=\"#none\" title=\"처음으로\" alt=\"처음으로\" onclick=\"goPageNavigation(1); return false;\"><span class=\"material-icons\">keyboard_arrow_left</span><span class=\"material-icons\">keyboard_arrow_left</span></a></li>");
            }
            //----------- 이전 xx개 -----------
            if (page != 1) {
                //sb.append("<li class=\"prev\"><a href=\"?page=" + (page - 1) + paramString + "\" title=\"이전\"  alt=\"이전\"><span class=\"material-icons\">keyboard_arrow_left</span></a></li>");
                sb.append("<li class=\"prev\"><a href=\"#none\" title=\"이전\" onclick=\"goPageNavigation(" + (page - 1) + "); return false;\" alt=\"이전\"><span class=\"material-icons\">keyboard_arrow_left</span></a></li>");
            } else {
                sb.append("<li class=\"prev\"><a href=\"#none\" alt=\"이전\"><span class=\"material-icons\">keyboard_arrow_left</span></a></li>");
            }
            //--------------페이지 번호--------------
            for (int i = pageBlockNo; i < pageBlockNo + pageBlockSize; i++) {
                if (i == totalPage + 1) break;
                if (page == i) {
                    sb.append("<li class=\"on\"><a href=\"#none\">" + i + "</a></li>");
                } else {
                    sb.append("<li><a href=\"#none\" onclick=\"goPageNavigation(" + i + "); return false;\" title=\"" + i + "page\" alt=\"" + i + "page\">" + i + "</a></li>");
                }
            }
            //---------------- 다음 xx개-----------
            //if (pageBlockGroupNo != ((totalPage - 1) / pageBlockSize) * 1 + 1) {
            if (totalPage != page) {
                sb.append("<li class=\"next\"><a href=\"none\" title=\"다음\" alt=\"다음\" onclick=\"goPageNavigation(" + (page+1) + "); return false;\"><span class=\"material-icons\">keyboard_arrow_right</span></a></li>");
            } else {
                sb.append("<li class=\"next\"><a href=\"#none\" alt=\"다음\"><span class=\"material-icons\">keyboard_arrow_right</span></a></li>");
            }
            if (page == totalPage) {
                sb.append("<li class=\"last\"><a href=\"#none\" alt=\"끝으로\"><span class=\"material-icons\">keyboard_arrow_right</span><span class=\"material-icons\">keyboard_arrow_right</span></a></li>");
            } else {
                sb.append("<li class=\"last\"><a href=\"#none\" onclick=\"goPageNavigation(" + totalPage + "); return false;\" title=\"끝으로\" alt=\"끝으로\"><span class=\"material-icons\">keyboard_arrow_right</span><span class=\"material-icons\">keyboard_arrow_right</span></a></li>");
            }
            sb.append("</ul>");
            sb.append("</div>");
            out = pageContext.getOut();
            out.println(sb.toString());
        } catch (Exception e) {
            throw new JspTagException(e.toString());
        }
        // out은 닫으면 안됨..

        return EVAL_PAGE;
    }

    protected Object lookup(PageContext pageContext, String name, String scope) throws JspTagException {
        Object bean = null;
        if (scope == null)
            bean = pageContext.findAttribute(name);
        else if (scope.equalsIgnoreCase("page"))
            bean = pageContext.getAttribute(name, PageContext.PAGE_SCOPE);
        else if (scope.equalsIgnoreCase("request"))
            bean = pageContext.getAttribute(name, PageContext.REQUEST_SCOPE);
        else if (scope.equalsIgnoreCase("session"))
            bean = pageContext.getAttribute(name, PageContext.SESSION_SCOPE);
        else if (scope.equalsIgnoreCase("application"))
            bean = pageContext.getAttribute(name, PageContext.APPLICATION_SCOPE);
        else {
            JspTagException e = new JspTagException("Invalid scope " + scope);
            throw e;
        }
        return (bean);
    }

    private String makeParamString(ServletRequest request) {
        StringBuffer queryString = new StringBuffer();
        String parameters = "";
        String startGubun = "";
        Enumeration enuma = request.getParameterNames();
        while (enuma.hasMoreElements()) {
            parameters = parameters + startGubun + enuma.nextElement().toString();
            startGubun = ",";
        }


        if (Util.isEmpty(parameters)) {
            return "";
        }

        StringTokenizer tokenizer = new StringTokenizer(parameters, ",");
        while (tokenizer.hasMoreTokens()) {
            String parameterName = tokenizer.nextToken();
            String[] value = request.getParameterValues(parameterName);
            for (int i = 0; value != null && i < value.length; i++) {
                if (parameterName.equals(this.pageParam)) {
                    continue;
                }
                if (value[i] != null) {
                    try {
                        queryString.append("&" + parameterName + "=" + URLEncoder.encode(value[i], "UTF-8"));
                    } catch (UnsupportedEncodingException e) {
                        queryString.append("&" + parameterName + "=");
                    }
                } else {
                    queryString.append("&" + parameterName + "=");
                }
            }
        }

        return queryString.toString();
    }

    @SuppressWarnings("unchecked")
    public String mapToString(HashMap<String, String> map) {
        StringBuffer queryString = new StringBuffer();
        String parameters = "";
        String startGubun = "";
        String[] value = new String[100];
        Set<Map.Entry<String, String>> param = map.entrySet();

        @SuppressWarnings("rawtypes")
        ArrayList arryList = new ArrayList();
        ArrayList arryListVal = new ArrayList();
        int j = 0;
        for (Map.Entry<String, String> me : param) {
            parameters = parameters + startGubun + me.getKey();
            startGubun = ",";
            arryListVal.add(me.getValue());
            arryList.add(me.getKey());
            j++;
        }


        if (Util.isEmpty(parameters)) {
            return "";
        }
        for (int jj = 0; jj < arryList.size(); jj++) {
            String parameterName = (String) arryList.get(jj);

            if (parameterName.equals(this.pageParam)) {
                continue;
            }
            if (arryListVal.get(jj) != null) {
                try {
                    queryString.append("&amp;" + parameterName + "=" + URLEncoder.encode((String) arryListVal.get(jj), "UTF-8"));
                } catch (UnsupportedEncodingException e) {
                    queryString.append("&amp;" + parameterName + "=");
                }
            } else {
                queryString.append("&amp;" + parameterName + "=");
            }

        }

        return queryString.toString();
    }

    /**
     * @param string
     * @uml.property name="name"
     */
    public void setName(String string) {
        this.name = string;
    }
}
