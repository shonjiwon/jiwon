package kr.go.songpa.ssem.model;

import java.io.Serializable;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.model
 * Author : shlee
 * Date : 2020-09-13
 * Description :
 * History :
 * Version :
 */
public class SearchVo implements Serializable {

    private static final long serialVersionUID = -3859755573882419776L;

    /**
     * 현재페이지
     */
    private int pageIndex = 1;

    /**
     * 페이지갯수
     */
    private int pageUnit = 10;

    /**
     * 페이지사이즈
     */
    private int pageSize = 5;

    /**
     * firstIndex
     */
    private int firstIndex = 1;

    /**
     * lastIndex
     */
    private int lastIndex = 1;

    private String param = "";             // 페이징 파라미터 저장

    private String searchVal;                // 검색 값1
    private String searchVal2;                // 검색 값2
    private String searchVal3;                // 검색 값3
    private String searchVal4;                // 검색 값4
    private String searchVal5;                // 검색 값5
    private String searchVal6;                // 검색 값6
    private String searchVal7;                // 검색 값7
    private String searchVal8;                // 검색 값8
    private String searchVal9;                // 검색 값9
    private String searchVal10;                // 검색 값10

    private String searchSDate;                // 검색 시작 일자1
    private String searchEDate;                // 검색 완료 일자1

    private String searchKind;                // 검색 구분1
    private String searchKind2;                // 검색 구분2
    private String searchKind3;                // 검색 구분3
    private String searchKind4;                // 검색 구분3

    private String searchLang;                // 검색 언어
    private String lang;                    // 접근 언어
    private String type;
    private String bbs_idx;
    private List<String> searchArrayVal;    // 배열 검색
    private List<String> searchArrayVal2;    // 배열 검색
    private List<String> searchArrayVal3;    // 배열 검색

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getPageUnit() {
        return pageUnit;
    }

    public void setPageUnit(int pageUnit) {
        this.pageUnit = pageUnit;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getFirstIndex() {
        return firstIndex;
    }

    public void setFirstIndex(int firstIndex) {
        this.firstIndex = firstIndex;
    }

    public int getLastIndex() {
        return lastIndex;
    }

    public void setLastIndex(int lastIndex) {
        this.lastIndex = lastIndex;
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    public String getSearchVal() {
        return searchVal;
    }

    public void setSearchVal(String searchVal) {
        this.searchVal = searchVal;
    }

    public String getSearchVal2() {
        return searchVal2;
    }

    public void setSearchVal2(String searchVal2) {
        this.searchVal2 = searchVal2;
    }

    public String getSearchVal3() {
        return searchVal3;
    }

    public void setSearchVal3(String searchVal3) {
        this.searchVal3 = searchVal3;
    }

    public String getSearchVal4() {
        return searchVal4;
    }

    public void setSearchVal4(String searchVal4) {
        this.searchVal4 = searchVal4;
    }

    public String getSearchVal5() {
        return searchVal5;
    }

    public void setSearchVal5(String searchVal5) {
        this.searchVal5 = searchVal5;
    }

    public String getSearchVal6() {
        return searchVal6;
    }

    public void setSearchVal6(String searchVal6) {
        this.searchVal6 = searchVal6;
    }

    public String getSearchVal7() {
        return searchVal7;
    }

    public void setSearchVal7(String searchVal7) {
        this.searchVal7 = searchVal7;
    }

    public String getSearchVal8() {
        return searchVal8;
    }

    public void setSearchVal8(String searchVal8) {
        this.searchVal8 = searchVal8;
    }

    public String getSearchVal9() {
        return searchVal9;
    }

    public void setSearchVal9(String searchVal9) {
        this.searchVal9 = searchVal9;
    }

    public String getSearchVal10() {
        return searchVal10;
    }

    public void setSearchVal10(String searchVal10) {
        this.searchVal10 = searchVal10;
    }

    public String getSearchSDate() {
        return searchSDate;
    }

    public void setSearchSDate(String searchSDate) {
        this.searchSDate = searchSDate;
    }

    public String getSearchEDate() {
        return searchEDate;
    }

    public void setSearchEDate(String searchEDate) {
        this.searchEDate = searchEDate;
    }

    public String getSearchKind() {
        return searchKind;
    }

    public void setSearchKind(String searchKind) {
        this.searchKind = searchKind;
    }

    public String getSearchKind2() {
        return searchKind2;
    }

    public void setSearchKind2(String searchKind2) {
        this.searchKind2 = searchKind2;
    }

    public String getSearchKind3() {
        return searchKind3;
    }

    public void setSearchKind3(String searchKind3) {
        this.searchKind3 = searchKind3;
    }

    public String getSearchKind4() {
        return searchKind4;
    }

    public void setSearchKind4(String searchKind4) {
        this.searchKind4 = searchKind4;
    }

    public String getSearchLang() {
        return searchLang;
    }

    public void setSearchLang(String searchLang) {
        this.searchLang = searchLang;
    }

    public String getLang() {
        return lang;
    }

    public void setLang(String lang) {
        this.lang = lang;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getBbs_idx() {
        return bbs_idx;
    }

    public void setBbs_idx(String bbs_idx) {
        this.bbs_idx = bbs_idx;
    }

    public List<String> getSearchArrayVal() {
        return searchArrayVal;
    }

    public void setSearchArrayVal(List<String> searchArrayVal) {
        this.searchArrayVal = searchArrayVal;
    }

    public List<String> getSearchArrayVal2() {
        return searchArrayVal2;
    }

    public void setSearchArrayVal2(List<String> searchArrayVal2) {
        this.searchArrayVal2 = searchArrayVal2;
    }

    public List<String> getSearchArrayVal3() {
        return searchArrayVal3;
    }

    public void setSearchArrayVal3(List<String> searchArrayVal3) {
        this.searchArrayVal3 = searchArrayVal3;
    }
}
