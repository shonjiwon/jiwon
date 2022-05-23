package kr.go.songpa.ssem.common;

import java.util.HashMap;

/**
 * Program Name : kr.go.songpa.ssem.common
 * Author : shlee
 * Date : 2020-09-14
 * Description :
 * History :
 * Version :
 */
public class PageHolder {
    /**
     * 페이지당 라인 수
     *
     * @uml.property name="listSize"
     */
    private int listSize = 0;

    private HashMap<String, String> paramMap = new HashMap<String, String>();


    /**
     * 그룹당 페이지 수
     *
     * @uml.property name="pageSize"
     */
    private int pageSize = 0;

    /**
     * 전체 레코드 수
     *
     * @uml.property name="totalRows"
     */
    private int totalRows;

    /**
     * 현재 페이지 번호
     *
     * @uml.property name="currentPage"
     */
    private int currentPage;

    private String paramStr;

    public String getParamStr() {
        return paramStr;
    }


    public PageHolder(int totalRows, int currentPage) {
        this.totalRows = totalRows;
        this.currentPage = currentPage;
        this.listSize = Constants.DEFAULT_LISTSIZE;
        this.pageSize = Constants.DEFAULT_PAGESIZE_USER;
    }

    public PageHolder(int totalRows, int currentPage, int listSize) {
        this.totalRows = totalRows;
        this.currentPage = currentPage;
        if (listSize == 0) {
            this.listSize = Constants.DEFAULT_LISTSIZE;
        } else {
            this.listSize = listSize;
        }
        //this.listSize = (listSize==0 ? Constants.DEFAULT_LISTSIZE : listSize);

        this.pageSize = Constants.DEFAULT_PAGESIZE_USER;
    }

    public PageHolder(int totalRows, int currentPage, int listSize, int pageSize) {
        this.totalRows = totalRows;
        this.currentPage = currentPage;
        if (listSize == 0) {
            this.listSize = Constants.DEFAULT_LISTSIZE;
        } else {
            this.listSize = listSize;
        }
        //this.listSize = (listSize==0 ? Constants.DEFAULT_LISTSIZE : listSize);
        if (pageSize == 0) {
            this.pageSize = Constants.DEFAULT_PAGESIZE_USER;
        } else {
            this.pageSize = pageSize;
        }
        //this.pageSize = (pageSize==0 ? Constants.DEFAULT_PAGESIZE : pageSize);
    }

    public PageHolder(int totalRows, int currentPage, int listSize, HashMap<String, String> pMap) {
        this.totalRows = totalRows;
        this.currentPage = currentPage;
        if (listSize == 0) {
            this.listSize = Constants.DEFAULT_LISTSIZE;
        } else {
            this.listSize = listSize;
        }
        //this.listSize = (listSize==0 ? Constants.DEFAULT_LISTSIZE : listSize);
        this.pageSize = Constants.DEFAULT_PAGESIZE_USER;
        this.paramMap = pMap;
    }


    /**
     * @return
     * @uml.property name="currentPage"
     */
    public int getCurrentPage() {
        return this.currentPage;
    }

    /**
     * @return
     * @uml.property name="listSize"
     */
    public int getListSize() {
        return this.listSize;
    }

    /**
     * @return
     * @uml.property name="pageSize"
     */
    public int getPageSize() {
        return this.pageSize;
    }

    public HashMap<String, String> getParamMap() {
        return paramMap;
    }


    public int getTotalPages() {
        int result = 0;
        if (totalRows > 0 && currentPage > 0) {
            int totalPages = totalRows / listSize;
            if (totalRows % listSize > 0)
                totalPages++;
            result = totalPages;
        }
        return result;
    }

    /**
     * @return
     * @uml.property name="totalRows"
     */
    public int getTotalRows() {
        return this.totalRows;
    }
}
