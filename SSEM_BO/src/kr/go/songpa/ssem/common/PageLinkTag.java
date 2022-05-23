package kr.go.songpa.ssem.common;

import kr.go.songpa.ssem.util.Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
public class PageLinkTag extends TagSupport {
    private static final long serialVersionUID = -9062540178576775104L;

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

    public PageLinkTag() {
        this.name = "";
    }

    public int doStartTag() throws JspTagException {
        return SKIP_BODY;
    }

    public int doEndTag() throws JspTagException {
        StringBuffer sb = new StringBuffer();
        JspWriter out = null;
        try {

            this.pageHolder = (PageHolder) lookup(pageContext, name, "request");
            if (pageHolder == null || pageHolder.getTotalRows() < 1) {
            	/*sb.append("<div class=\"pagination forWeb marT40\">");
            	sb.append("		<a href=\"#\" title=\"1페이지\" class=\"select\">1</a>");
            	sb.append("</div>");*/
                out = pageContext.getOut();
                out.println(sb.toString());
            } else {
                int page = this.pageHolder.getCurrentPage();        // 현재 페이지
                int pageBlockSize = this.pageHolder.getPageSize();    // 페이지 블록 사이즈
                int totalPage = this.pageHolder.getTotalPages();    // 총페이지 수
                String paramString = this.mapToString(this.pageHolder.getParamMap());

                int pageBlockNo = ((page - 1) / pageBlockSize) * pageBlockSize + 1;
                int pageBlockGroupNo = ((page - 1) / pageBlockSize) + 1;

                sb.append("<div class=\"paging_wrap\">");
                //sb.append("<div class=\"bttn-area\">");
                if (page == 1) {
                    sb.append("	<button type=\"button\" class=\"first\" alt=\"처음\"><span class=\"isico isi_paging\">First</span></button>");
                } else {
                    /*sb.append("	<a href=\"?" + paramString + "&amp;page=1\" class=\"first\" alt=\"First\"><span class=\"isico isi_paging\">First</span></a>");*/
                    sb.append("	<button type=\"button\" class=\"first\" alt=\"First\" onclick=\"goPageNavigation('?" + paramString + "&amp;page=1'); return false;\"><span class=\"isico isi_paging\">First</span></button>");
                }
                //----------- 이전 xx개 -----------
                if (pageBlockGroupNo != 1) {
                    /*sb.append("	<a href=\"?page=" + (pageBlockNo - pageBlockSize) + paramString + "\" class=\"prev\" alt=\"Prev\"><span class=\"isico isi_paging\">Prev</span></a>");*/
                    sb.append("	<button type=\"button\" class=\"prev\" alt=\"Prev\" onclick=\"goPageNavigation('?page=" + (pageBlockNo - pageBlockSize) + paramString + "'); return false;\"><span class=\"isico isi_paging\">Prev</span></button>");
                } else {
                    sb.append("	<button type=\"button\" class=\"prev\"><span class=\"isico isi_paging\" alt=\"Prev\">Prev</span></button>");
                }
                //sb.append("</div>");
                //sb.append("<ul class=\"center-area\">");
                //--------------페이지 번호--------------
                for (int i = pageBlockNo; i < pageBlockNo + pageBlockSize; i++) {
                    if (i == totalPage + 1) break;
                    if (page == i) {
                        sb.append("<a href=\"#none\" class=\"active\" title=\"selected\" alt=\"" + i + "page\"><span>" + i + "</span></a>");
                    } else {
                        sb.append("<a href=\"?page=" + (i) + paramString + "\" title=\"" + i + "page\" alt=\"" + i + "page\"><span>" + i + "</span></a>");
                    }
                }
                //sb.append("</ul>");
                //sb.append("<div class=\"bttn-area\">");
                //---------------- 다음 xx개-----------
                if (pageBlockGroupNo != ((totalPage - 1) / pageBlockSize) * 1 + 1) {
                    /*sb.append("	<a href=\"?page=" + (pageBlockNo + pageBlockSize) + paramString + "\" title=\"Next\" alt=\"Next\" class=\"next\"><span class=\"isico isi_paging\">Next</span></a>");*/
                    sb.append("	<button type=\"button\" title=\"Next\" alt=\"Next\" class=\"next\" onclick=\"goPageNavigation('?page=" + (pageBlockNo + pageBlockSize) + paramString + "'); return false;\"><span class=\"isico isi_paging\">Next</span></button>");
                } else {
                    sb.append("	<button type=\"button\" class=\"next\"><span class=\"isico isi_paging\">Next</span></button>");
                }
                if (page == totalPage) {
                    sb.append("	<button type=\"button\" class=\"end\" title=\"Last\" alt=\"Last\"><span class=\"isico isi_paging\">Last</span></button>");
                } else {
                    /*sb.append("	<a href=\"?page=" + totalPage + paramString + "\" title=\"Last\" alt=\"Last\" class=\"end\"><span class=\"isico isi_paging\">Last</span></a>");*/
                    sb.append("	<button type=\"button\" title=\"Last\" alt=\"Last\" class=\"end\" onclick=\"goPageNavigation('?page=" + totalPage + paramString + "'); return false;\"><span class=\"isico isi_paging\">Last</span></button>");
                }
                //sb.append("</div>");
                sb.append("</div>");
                out = pageContext.getOut();
                out.println(sb.toString());
            }
        } catch (Exception e) {
            throw (JspTagException) new JspTagException(e.toString()).initCause(e);
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
        return bean;
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

        String retVal = "";
        if (!Util.isEmpty(parameters)) {
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
            retVal = queryString.toString();
        }
        return retVal;
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
        for (Map.Entry<String, String> me : param) {
            parameters = parameters + startGubun + me.getKey();
            startGubun = ",";
            arryListVal.add(me.getValue());
            arryList.add(me.getKey());
        }

        String retVal = "";

        if (!Util.isEmpty(parameters)) {
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
            retVal = queryString.toString();
        }
        return retVal;
    }

    /**
     * @param string
     * @uml.property name="name"
     */
    public void setName(String string) {
        this.name = string;
    }
}
