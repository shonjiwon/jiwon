package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AdminService;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.util.FileMngUtil;
import kr.go.songpa.ssem.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-09-10
 * Description :
 * History :
 * Version :
 */
public class CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private AdminService adminService;

    @Autowired
    private FileMngUtil fileUtil;

    protected HashMap<String, String> paramMap = null;

    public CommonController() {
        paramMap = new HashMap<String, String>();
    }

    protected SearchVo getSearch(HttpServletRequest request) {
        return getSearch(request, 0);
    }

    protected SearchVo getSearch(HttpServletRequest request, int listSizeIn, String start_dt, String end_dt) {
        this.paramMap = new HashMap<String, String>();
        SearchVo search = new SearchVo();

        search.setSearchVal(ServletRequestUtils.getStringParameter(request, "searchVal", ""));
        search.setSearchVal2(ServletRequestUtils.getStringParameter(request, "searchVal2", ""));
        search.setSearchVal3(ServletRequestUtils.getStringParameter(request, "searchVal3", ""));
        search.setSearchVal4(ServletRequestUtils.getStringParameter(request, "searchVal4", ""));
        search.setSearchVal5(ServletRequestUtils.getStringParameter(request, "searchVal5", ""));
        search.setSearchVal6(ServletRequestUtils.getStringParameter(request, "searchVal6", ""));
        search.setSearchVal7(ServletRequestUtils.getStringParameter(request, "searchVal7", ""));
        search.setSearchVal8(ServletRequestUtils.getStringParameter(request, "searchVal8", ""));
        search.setSearchVal9(ServletRequestUtils.getStringParameter(request, "searchVal9", ""));
        search.setSearchVal10(ServletRequestUtils.getStringParameter(request, "searchVal10", ""));
        search.setSearchSDate(ServletRequestUtils.getStringParameter(request, "searchSDate", start_dt));
        search.setSearchEDate(ServletRequestUtils.getStringParameter(request, "searchEDate", end_dt));
        search.setSearchKind(ServletRequestUtils.getStringParameter(request, "searchKind", ""));
        search.setSearchKind2(ServletRequestUtils.getStringParameter(request, "searchKind2", ""));
        search.setSearchKind3(ServletRequestUtils.getStringParameter(request, "searchKind3", ""));
        search.setSearchKind4(ServletRequestUtils.getStringParameter(request, "searchKind4", ""));
        search.setSearchLang(ServletRequestUtils.getStringParameter(request, "searchLang", ""));

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);

        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);
        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);


        paramMap.put("listSize", Integer.toString(listSize));
        paramMap.put("page", Integer.toString(page));

        paramMap.put("searchVal", search.getSearchVal());
        paramMap.put("searchVal2", search.getSearchVal2());
        paramMap.put("searchVal3", search.getSearchVal3());
        paramMap.put("searchVal4", search.getSearchVal4());
        paramMap.put("searchVal5", search.getSearchVal5());
        paramMap.put("searchVal6", search.getSearchVal6());
        paramMap.put("searchVal7", search.getSearchVal7());
        paramMap.put("searchVal8", search.getSearchVal8());
        paramMap.put("searchVal9", search.getSearchVal9());
        paramMap.put("searchVal10", search.getSearchVal10());
        paramMap.put("searchSDate", search.getSearchSDate());
        paramMap.put("searchEDate", search.getSearchEDate());
        paramMap.put("searchKind", search.getSearchKind());
        paramMap.put("searchKind2", search.getSearchKind2());
        paramMap.put("searchKind3", search.getSearchKind3());
        paramMap.put("searchKind4", search.getSearchKind4());
        paramMap.put("searchLang", search.getSearchLang());

        return search;
    }

    protected SearchVo getSearch(HttpServletRequest request, int listSizeIn) {
        this.paramMap = new HashMap<String, String>();
        SearchVo search = new SearchVo();

        search.setSearchVal(ServletRequestUtils.getStringParameter(request, "searchVal", ""));
        search.setSearchVal2(ServletRequestUtils.getStringParameter(request, "searchVal2", ""));
        search.setSearchVal3(ServletRequestUtils.getStringParameter(request, "searchVal3", ""));
        search.setSearchVal4(ServletRequestUtils.getStringParameter(request, "searchVal4", ""));
        search.setSearchVal5(ServletRequestUtils.getStringParameter(request, "searchVal5", ""));
        search.setSearchVal6(ServletRequestUtils.getStringParameter(request, "searchVal6", ""));
        search.setSearchVal7(ServletRequestUtils.getStringParameter(request, "searchVal7", ""));
        search.setSearchVal8(ServletRequestUtils.getStringParameter(request, "searchVal8", ""));
        search.setSearchVal9(ServletRequestUtils.getStringParameter(request, "searchVal9", ""));
        search.setSearchVal10(ServletRequestUtils.getStringParameter(request, "searchVal10", ""));
        search.setSearchSDate(ServletRequestUtils.getStringParameter(request, "searchSDate", Util.getDateMonthMinus(3, -12)));
        search.setSearchEDate(ServletRequestUtils.getStringParameter(request, "searchEDate", Util.getDate(3)));
        search.setSearchKind(ServletRequestUtils.getStringParameter(request, "searchKind", ""));
        search.setSearchKind2(ServletRequestUtils.getStringParameter(request, "searchKind2", ""));
        search.setSearchKind3(ServletRequestUtils.getStringParameter(request, "searchKind3", ""));
        search.setSearchKind4(ServletRequestUtils.getStringParameter(request, "searchKind4", ""));
        search.setSearchLang(ServletRequestUtils.getStringParameter(request, "searchLang", ""));

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);

        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);
        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);


        paramMap.put("listSize", Integer.toString(listSize));
        paramMap.put("page", Integer.toString(page));

        paramMap.put("searchVal", search.getSearchVal());
        paramMap.put("searchVal2", search.getSearchVal2());
        paramMap.put("searchVal3", search.getSearchVal3());
        paramMap.put("searchVal4", search.getSearchVal4());
        paramMap.put("searchVal5", search.getSearchVal5());
        paramMap.put("searchVal6", search.getSearchVal6());
        paramMap.put("searchVal7", search.getSearchVal7());
        paramMap.put("searchVal8", search.getSearchVal8());
        paramMap.put("searchVal9", search.getSearchVal9());
        paramMap.put("searchVal10", search.getSearchVal10());
        paramMap.put("searchSDate", search.getSearchSDate());
        paramMap.put("searchEDate", search.getSearchEDate());
        paramMap.put("searchKind", search.getSearchKind());
        paramMap.put("searchKind2", search.getSearchKind2());
        paramMap.put("searchKind3", search.getSearchKind3());
        paramMap.put("searchKind4", search.getSearchKind4());
        paramMap.put("searchLang", search.getSearchLang());

        return search;
    }

    protected SearchVo getSearch(HttpServletRequest request, int listSizeIn, int group_idx) {
        this.paramMap = new HashMap<String, String>();
        SearchVo search = new SearchVo();

        search.setSearchVal(ServletRequestUtils.getStringParameter(request, "searchVal", ""));
        search.setSearchVal2(ServletRequestUtils.getStringParameter(request, "searchVal2", ""));
        search.setSearchVal3(ServletRequestUtils.getStringParameter(request, "searchVal3", ""));
        search.setSearchVal4(ServletRequestUtils.getStringParameter(request, "searchVal4", ""));
        search.setSearchVal5(ServletRequestUtils.getStringParameter(request, "searchVal5", ""));
        search.setSearchVal6(ServletRequestUtils.getStringParameter(request, "searchVal6", ""));
        search.setSearchVal7(ServletRequestUtils.getStringParameter(request, "searchVal7", ""));
        search.setSearchVal8(ServletRequestUtils.getStringParameter(request, "searchVal8", ""));
        search.setSearchVal9(ServletRequestUtils.getStringParameter(request, "searchVal9", ""));
        search.setSearchVal10(ServletRequestUtils.getStringParameter(request, "searchVal10", ""));
        search.setSearchSDate(ServletRequestUtils.getStringParameter(request, "searchSDate", Util.getDateMonthMinus(3, -12)));
        search.setSearchEDate(ServletRequestUtils.getStringParameter(request, "searchEDate", Util.getDate(3)));
        search.setSearchKind(ServletRequestUtils.getStringParameter(request, "searchKind", ""));
        search.setSearchKind2(ServletRequestUtils.getStringParameter(request, "searchKind2", ""));
        search.setSearchKind3(ServletRequestUtils.getStringParameter(request, "searchKind3", ""));
        search.setSearchKind4(ServletRequestUtils.getStringParameter(request, "searchKind4", ""));
        search.setSearchLang(ServletRequestUtils.getStringParameter(request, "searchLang", ""));

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);

        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);
        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);
        search.setSearchKind(String.valueOf(group_idx));


        paramMap.put("listSize", Integer.toString(listSize));
        paramMap.put("page", Integer.toString(page));

        paramMap.put("searchVal", search.getSearchVal());
        paramMap.put("searchVal2", search.getSearchVal2());
        paramMap.put("searchVal3", search.getSearchVal3());
        paramMap.put("searchVal4", search.getSearchVal4());
        paramMap.put("searchVal5", search.getSearchVal5());
        paramMap.put("searchVal6", search.getSearchVal6());
        paramMap.put("searchVal7", search.getSearchVal7());
        paramMap.put("searchVal8", search.getSearchVal8());
        paramMap.put("searchVal9", search.getSearchVal9());
        paramMap.put("searchVal10", search.getSearchVal10());
        paramMap.put("searchSDate", search.getSearchSDate());
        paramMap.put("searchEDate", search.getSearchEDate());
        paramMap.put("searchKind", search.getSearchKind());
        paramMap.put("searchKind2", search.getSearchKind2());
        paramMap.put("searchKind3", search.getSearchKind3());
        paramMap.put("searchKind4", search.getSearchKind4());
        paramMap.put("searchLang", search.getSearchLang());

        return search;
    }

    protected SearchVo getSearch(HttpServletRequest request, int listSizeIn, int p_idx, int group_idx) {
        this.paramMap = new HashMap<String, String>();
        SearchVo search = new SearchVo();

        search.setSearchVal(ServletRequestUtils.getStringParameter(request, "searchVal", ""));
        search.setSearchVal2(ServletRequestUtils.getStringParameter(request, "searchVal2", ""));
        search.setSearchVal3(ServletRequestUtils.getStringParameter(request, "searchVal3", ""));
        search.setSearchVal4(ServletRequestUtils.getStringParameter(request, "searchVal4", ""));
        search.setSearchVal5(ServletRequestUtils.getStringParameter(request, "searchVal5", ""));
        search.setSearchVal6(ServletRequestUtils.getStringParameter(request, "searchVal6", ""));
        search.setSearchVal7(ServletRequestUtils.getStringParameter(request, "searchVal7", ""));
        search.setSearchVal8(ServletRequestUtils.getStringParameter(request, "searchVal8", ""));
        search.setSearchVal9(ServletRequestUtils.getStringParameter(request, "searchVal9", ""));
        search.setSearchVal10(ServletRequestUtils.getStringParameter(request, "searchVal10", ""));
        search.setSearchSDate(ServletRequestUtils.getStringParameter(request, "searchSDate", Util.getDateMonthMinus(3, -12)));
        search.setSearchEDate(ServletRequestUtils.getStringParameter(request, "searchEDate", Util.getDate(3)));
        search.setSearchKind(ServletRequestUtils.getStringParameter(request, "searchKind", ""));
        search.setSearchKind2(ServletRequestUtils.getStringParameter(request, "searchKind2", ""));
        search.setSearchKind3(ServletRequestUtils.getStringParameter(request, "searchKind3", ""));
        search.setSearchKind4(ServletRequestUtils.getStringParameter(request, "searchKind4", ""));
        search.setSearchLang(ServletRequestUtils.getStringParameter(request, "searchLang", ""));

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);

        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);
        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);
        search.setSearchVal2(String.valueOf(p_idx));
        search.setSearchVal3(String.valueOf(group_idx));

        paramMap.put("listSize", Integer.toString(listSize));
        paramMap.put("page", Integer.toString(page));

        paramMap.put("searchVal", search.getSearchVal());
        paramMap.put("searchVal2", search.getSearchVal2());
        paramMap.put("searchVal3", search.getSearchVal3());
        paramMap.put("searchVal4", search.getSearchVal4());
        paramMap.put("searchVal5", search.getSearchVal5());
        paramMap.put("searchVal6", search.getSearchVal6());
        paramMap.put("searchVal7", search.getSearchVal7());
        paramMap.put("searchVal8", search.getSearchVal8());
        paramMap.put("searchVal9", search.getSearchVal9());
        paramMap.put("searchVal10", search.getSearchVal10());
        paramMap.put("searchSDate", search.getSearchSDate());
        paramMap.put("searchEDate", search.getSearchEDate());
        paramMap.put("searchKind", search.getSearchKind());
        paramMap.put("searchKind2", search.getSearchKind2());
        paramMap.put("searchKind3", search.getSearchKind3());
        paramMap.put("searchKind4", search.getSearchKind4());
        paramMap.put("searchLang", search.getSearchLang());

        return search;
    }

    protected SearchVo getSearchEx(HttpServletRequest request, int month, int listSizeIn) {
        this.paramMap = new HashMap<String, String>();
        SearchVo search = new SearchVo();

        search.setSearchVal(ServletRequestUtils.getStringParameter(request, "searchVal", ""));
        search.setSearchVal2(ServletRequestUtils.getStringParameter(request, "searchVal2", ""));
        search.setSearchVal3(ServletRequestUtils.getStringParameter(request, "searchVal3", ""));
        search.setSearchVal4(ServletRequestUtils.getStringParameter(request, "searchVal4", ""));
        search.setSearchVal5(ServletRequestUtils.getStringParameter(request, "searchVal5", ""));
        search.setSearchVal6(ServletRequestUtils.getStringParameter(request, "searchVal6", ""));
        search.setSearchVal7(ServletRequestUtils.getStringParameter(request, "searchVal7", ""));
        search.setSearchVal8(ServletRequestUtils.getStringParameter(request, "searchVal8", ""));
        search.setSearchVal9(ServletRequestUtils.getStringParameter(request, "searchVal9", ""));
        search.setSearchVal10(ServletRequestUtils.getStringParameter(request, "searchVal10", ""));
        search.setSearchSDate(ServletRequestUtils.getStringParameter(request, "searchSDate", Util.getDateMonthMinus(3, month)));
        search.setSearchEDate(ServletRequestUtils.getStringParameter(request, "searchEDate", Util.getDate(3)));
        search.setSearchKind(ServletRequestUtils.getStringParameter(request, "searchKind", ""));
        search.setSearchKind2(ServletRequestUtils.getStringParameter(request, "searchKind2", ""));
        search.setSearchKind3(ServletRequestUtils.getStringParameter(request, "searchKind3", ""));
        search.setSearchKind4(ServletRequestUtils.getStringParameter(request, "searchKind4", ""));
        search.setSearchLang(ServletRequestUtils.getStringParameter(request, "searchLang", ""));

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);

        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);
        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);


        paramMap.put("listSize", Integer.toString(listSize));
        paramMap.put("page", Integer.toString(page));

        paramMap.put("searchVal", search.getSearchVal());
        paramMap.put("searchVal2", search.getSearchVal2());
        paramMap.put("searchVal3", search.getSearchVal3());
        paramMap.put("searchVal4", search.getSearchVal4());
        paramMap.put("searchVal5", search.getSearchVal5());
        paramMap.put("searchVal6", search.getSearchVal6());
        paramMap.put("searchVal7", search.getSearchVal7());
        paramMap.put("searchVal8", search.getSearchVal8());
        paramMap.put("searchVal9", search.getSearchVal9());
        paramMap.put("searchVal10", search.getSearchVal10());
        paramMap.put("searchSDate", search.getSearchSDate());
        paramMap.put("searchEDate", search.getSearchEDate());
        paramMap.put("searchKind", search.getSearchKind());
        paramMap.put("searchKind2", search.getSearchKind2());
        paramMap.put("searchKind3", search.getSearchKind3());
        paramMap.put("searchKind4", search.getSearchKind4());
        paramMap.put("searchLang", search.getSearchLang());

        return search;
    }

    protected SearchVo getSearchForTeacher(HttpServletRequest request, int listSizeIn, String teacher_idx) {
        this.paramMap = new HashMap<String, String>();
        SearchVo search = new SearchVo();

        search.setSearchVal(ServletRequestUtils.getStringParameter(request, "searchVal", ""));
        search.setSearchVal2(ServletRequestUtils.getStringParameter(request, "searchVal2", ""));
        search.setSearchVal3(ServletRequestUtils.getStringParameter(request, "searchVal3", ""));
        search.setSearchVal4(ServletRequestUtils.getStringParameter(request, "searchVal4", ""));
        search.setSearchVal5(ServletRequestUtils.getStringParameter(request, "searchVal5", ""));
        search.setSearchVal6(ServletRequestUtils.getStringParameter(request, "searchVal6", ""));
        search.setSearchVal7(ServletRequestUtils.getStringParameter(request, "searchVal7", ""));
        search.setSearchVal8(ServletRequestUtils.getStringParameter(request, "searchVal8", ""));
        search.setSearchVal9(ServletRequestUtils.getStringParameter(request, "searchVal9", ""));
        search.setSearchVal10(ServletRequestUtils.getStringParameter(request, "searchVal10", ""));
        search.setSearchSDate(ServletRequestUtils.getStringParameter(request, "searchSDate", Util.getDateMonthMinus(3, -12)));
        search.setSearchEDate(ServletRequestUtils.getStringParameter(request, "searchEDate", Util.getDate(3)));
        search.setSearchKind(ServletRequestUtils.getStringParameter(request, "searchKind", ""));
        search.setSearchKind2(ServletRequestUtils.getStringParameter(request, "searchKind2", ""));
        search.setSearchKind3(ServletRequestUtils.getStringParameter(request, "searchKind3", ""));
        search.setSearchKind4(ServletRequestUtils.getStringParameter(request, "searchKind4", ""));
        search.setSearchLang(ServletRequestUtils.getStringParameter(request, "searchLang", ""));
        search.setTeacher_idx(ServletRequestUtils.getStringParameter(request, "teacher_idx", ""));

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);

        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);
        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);
        search.setTeacher_idx(teacher_idx);


        paramMap.put("listSize", Integer.toString(listSize));
        paramMap.put("page", Integer.toString(page));

        paramMap.put("searchVal", search.getSearchVal());
        paramMap.put("searchVal2", search.getSearchVal2());
        paramMap.put("searchVal3", search.getSearchVal3());
        paramMap.put("searchVal4", search.getSearchVal4());
        paramMap.put("searchVal5", search.getSearchVal5());
        paramMap.put("searchVal6", search.getSearchVal6());
        paramMap.put("searchVal7", search.getSearchVal7());
        paramMap.put("searchVal8", search.getSearchVal8());
        paramMap.put("searchVal9", search.getSearchVal9());
        paramMap.put("searchVal10", search.getSearchVal10());
        paramMap.put("searchSDate", search.getSearchSDate());
        paramMap.put("searchEDate", search.getSearchEDate());
        paramMap.put("searchKind", search.getSearchKind());
        paramMap.put("searchKind2", search.getSearchKind2());
        paramMap.put("searchKind3", search.getSearchKind3());
        paramMap.put("searchKind4", search.getSearchKind4());
        paramMap.put("searchLang", search.getSearchLang());
        paramMap.put("teacher_idx", search.getTeacher_idx());

        return search;
    }

    protected SearchVo getSearchForMagnet(HttpServletRequest request, int listSizeIn, String hope_study_idx) {
        this.paramMap = new HashMap<String, String>();
        SearchVo search = new SearchVo();

        search.setSearchVal(ServletRequestUtils.getStringParameter(request, "searchVal", ""));
        search.setSearchVal2(ServletRequestUtils.getStringParameter(request, "searchVal2", ""));
        search.setSearchVal3(ServletRequestUtils.getStringParameter(request, "searchVal3", ""));
        search.setSearchVal4(ServletRequestUtils.getStringParameter(request, "searchVal4", ""));
        search.setSearchVal5(ServletRequestUtils.getStringParameter(request, "searchVal5", ""));
        search.setSearchVal6(ServletRequestUtils.getStringParameter(request, "searchVal6", ""));
        search.setSearchVal7(ServletRequestUtils.getStringParameter(request, "searchVal7", ""));
        search.setSearchVal8(ServletRequestUtils.getStringParameter(request, "searchVal8", ""));
        search.setSearchVal9(ServletRequestUtils.getStringParameter(request, "searchVal9", ""));
        search.setSearchVal10(ServletRequestUtils.getStringParameter(request, "searchVal10", ""));
        search.setSearchSDate(ServletRequestUtils.getStringParameter(request, "searchSDate", Util.getDateMonthMinus(3, -12)));
        search.setSearchEDate(ServletRequestUtils.getStringParameter(request, "searchEDate", Util.getDate(3)));
        search.setSearchKind(ServletRequestUtils.getStringParameter(request, "searchKind", ""));
        search.setSearchKind2(ServletRequestUtils.getStringParameter(request, "searchKind2", ""));
        search.setSearchKind3(ServletRequestUtils.getStringParameter(request, "searchKind3", ""));
        search.setSearchKind4(ServletRequestUtils.getStringParameter(request, "searchKind4", ""));
        search.setSearchLang(ServletRequestUtils.getStringParameter(request, "searchLang", ""));
        search.setHope_study_idx(ServletRequestUtils.getStringParameter(request, "hope_study_idx", ""));

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);

        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);
        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);
        search.setHope_study_idx(hope_study_idx);


        paramMap.put("listSize", Integer.toString(listSize));
        paramMap.put("page", Integer.toString(page));

        paramMap.put("searchVal", search.getSearchVal());
        paramMap.put("searchVal2", search.getSearchVal2());
        paramMap.put("searchVal3", search.getSearchVal3());
        paramMap.put("searchVal4", search.getSearchVal4());
        paramMap.put("searchVal5", search.getSearchVal5());
        paramMap.put("searchVal6", search.getSearchVal6());
        paramMap.put("searchVal7", search.getSearchVal7());
        paramMap.put("searchVal8", search.getSearchVal8());
        paramMap.put("searchVal9", search.getSearchVal9());
        paramMap.put("searchVal10", search.getSearchVal10());
        paramMap.put("searchSDate", search.getSearchSDate());
        paramMap.put("searchEDate", search.getSearchEDate());
        paramMap.put("searchKind", search.getSearchKind());
        paramMap.put("searchKind2", search.getSearchKind2());
        paramMap.put("searchKind3", search.getSearchKind3());
        paramMap.put("searchKind4", search.getSearchKind4());
        paramMap.put("searchLang", search.getSearchLang());
        paramMap.put("hope_study_idx", search.getHope_study_idx());

        return search;
    }

    protected SearchVo getSearchForLectureApy(HttpServletRequest request, int listSizeIn, String lecture_idx) {
        this.paramMap = new HashMap<String, String>();
        SearchVo search = new SearchVo();

        search.setSearchVal(ServletRequestUtils.getStringParameter(request, "searchVal", ""));
        search.setSearchVal2(ServletRequestUtils.getStringParameter(request, "searchVal2", ""));
        search.setSearchVal3(ServletRequestUtils.getStringParameter(request, "searchVal3", ""));
        search.setSearchVal4(ServletRequestUtils.getStringParameter(request, "searchVal4", ""));
        search.setSearchVal5(ServletRequestUtils.getStringParameter(request, "searchVal5", ""));
        search.setSearchVal6(ServletRequestUtils.getStringParameter(request, "searchVal6", ""));
        search.setSearchVal7(ServletRequestUtils.getStringParameter(request, "searchVal7", ""));
        search.setSearchVal8(ServletRequestUtils.getStringParameter(request, "searchVal8", ""));
        search.setSearchVal9(ServletRequestUtils.getStringParameter(request, "searchVal9", ""));
        search.setSearchVal10(ServletRequestUtils.getStringParameter(request, "searchVal10", ""));
        search.setSearchSDate(ServletRequestUtils.getStringParameter(request, "searchSDate", Util.getDateMonthMinus(3, -12)));
        search.setSearchEDate(ServletRequestUtils.getStringParameter(request, "searchEDate", Util.getDate(3)));
        search.setSearchKind(ServletRequestUtils.getStringParameter(request, "searchKind", ""));
        search.setSearchKind2(ServletRequestUtils.getStringParameter(request, "searchKind2", ""));
        search.setSearchKind3(ServletRequestUtils.getStringParameter(request, "searchKind3", ""));
        search.setSearchKind4(ServletRequestUtils.getStringParameter(request, "searchKind4", ""));
        search.setSearchLang(ServletRequestUtils.getStringParameter(request, "searchLang", ""));
        search.setLecture_idx(ServletRequestUtils.getStringParameter(request, "lecture_idx", ""));

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);

        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);
        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);
        search.setLecture_idx(lecture_idx);


        paramMap.put("listSize", Integer.toString(listSize));
        paramMap.put("page", Integer.toString(page));

        paramMap.put("searchVal", search.getSearchVal());
        paramMap.put("searchVal2", search.getSearchVal2());
        paramMap.put("searchVal3", search.getSearchVal3());
        paramMap.put("searchVal4", search.getSearchVal4());
        paramMap.put("searchVal5", search.getSearchVal5());
        paramMap.put("searchVal6", search.getSearchVal6());
        paramMap.put("searchVal7", search.getSearchVal7());
        paramMap.put("searchVal8", search.getSearchVal8());
        paramMap.put("searchVal9", search.getSearchVal9());
        paramMap.put("searchVal10", search.getSearchVal10());
        paramMap.put("searchSDate", search.getSearchSDate());
        paramMap.put("searchEDate", search.getSearchEDate());
        paramMap.put("searchKind", search.getSearchKind());
        paramMap.put("searchKind2", search.getSearchKind2());
        paramMap.put("searchKind3", search.getSearchKind3());
        paramMap.put("searchKind4", search.getSearchKind4());
        paramMap.put("searchLang", search.getSearchLang());
        paramMap.put("lecture_idx", search.getLecture_idx());

        return search;
    }

    protected SearchVo getSearchForStudent(HttpServletRequest request, int listSizeIn, String student_idx) {
        this.paramMap = new HashMap<String, String>();
        SearchVo search = new SearchVo();

        search.setSearchVal(ServletRequestUtils.getStringParameter(request, "searchVal", ""));
        search.setSearchVal2(ServletRequestUtils.getStringParameter(request, "searchVal2", ""));
        search.setSearchVal3(ServletRequestUtils.getStringParameter(request, "searchVal3", ""));
        search.setSearchVal4(ServletRequestUtils.getStringParameter(request, "searchVal4", ""));
        search.setSearchVal5(ServletRequestUtils.getStringParameter(request, "searchVal5", ""));
        search.setSearchVal6(ServletRequestUtils.getStringParameter(request, "searchVal6", ""));
        search.setSearchVal7(ServletRequestUtils.getStringParameter(request, "searchVal7", ""));
        search.setSearchVal8(ServletRequestUtils.getStringParameter(request, "searchVal8", ""));
        search.setSearchVal9(ServletRequestUtils.getStringParameter(request, "searchVal9", ""));
        search.setSearchVal10(ServletRequestUtils.getStringParameter(request, "searchVal10", ""));
        search.setSearchSDate(ServletRequestUtils.getStringParameter(request, "searchSDate", Util.getDateMonthMinus(3, -12)));
        search.setSearchEDate(ServletRequestUtils.getStringParameter(request, "searchEDate", Util.getDate(3)));
        search.setSearchKind(ServletRequestUtils.getStringParameter(request, "searchKind", ""));
        search.setSearchKind2(ServletRequestUtils.getStringParameter(request, "searchKind2", ""));
        search.setSearchKind3(ServletRequestUtils.getStringParameter(request, "searchKind3", ""));
        search.setSearchKind4(ServletRequestUtils.getStringParameter(request, "searchKind4", ""));
        search.setSearchLang(ServletRequestUtils.getStringParameter(request, "searchLang", ""));
        search.setStudent_idx(ServletRequestUtils.getStringParameter(request, "student_idx", ""));

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);

        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);
        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);
        search.setStudent_idx(student_idx);


        paramMap.put("listSize", Integer.toString(listSize));
        paramMap.put("page", Integer.toString(page));

        paramMap.put("searchVal", search.getSearchVal());
        paramMap.put("searchVal2", search.getSearchVal2());
        paramMap.put("searchVal3", search.getSearchVal3());
        paramMap.put("searchVal4", search.getSearchVal4());
        paramMap.put("searchVal5", search.getSearchVal5());
        paramMap.put("searchVal6", search.getSearchVal6());
        paramMap.put("searchVal7", search.getSearchVal7());
        paramMap.put("searchVal8", search.getSearchVal8());
        paramMap.put("searchVal9", search.getSearchVal9());
        paramMap.put("searchVal10", search.getSearchVal10());
        paramMap.put("searchSDate", search.getSearchSDate());
        paramMap.put("searchEDate", search.getSearchEDate());
        paramMap.put("searchKind", search.getSearchKind());
        paramMap.put("searchKind2", search.getSearchKind2());
        paramMap.put("searchKind3", search.getSearchKind3());
        paramMap.put("searchKind4", search.getSearchKind4());
        paramMap.put("searchLang", search.getSearchLang());
        paramMap.put("student_idx", search.getStudent_idx());

        return search;
    }

    protected void getModel(HttpServletRequest request, Model model) {
        getModel(request, model, 0);
    }

    protected void getModel(HttpServletRequest request, Model model, int listSizeIn, String start_dt, String end_dt) {
        Calendar cal = Calendar.getInstance();

        SearchVo search = new SearchVo();

        String searchVal = ServletRequestUtils.getStringParameter(request, "searchVal", "");
        String searchVal2 = ServletRequestUtils.getStringParameter(request, "searchVal2", "");
        String searchVal3 = ServletRequestUtils.getStringParameter(request, "searchVal3", "");
        String searchVal4 = ServletRequestUtils.getStringParameter(request, "searchVal4", "");
        String searchVal5 = ServletRequestUtils.getStringParameter(request, "searchVal5", "");
        String searchVal6 = ServletRequestUtils.getStringParameter(request, "searchVal6", "");
        String searchVal7 = ServletRequestUtils.getStringParameter(request, "searchVal7", "");
        String searchVal8 = ServletRequestUtils.getStringParameter(request, "searchVal8", "");
        String searchVal9 = ServletRequestUtils.getStringParameter(request, "searchVal9", "");
        String searchVal10 = ServletRequestUtils.getStringParameter(request, "searchVal10", "");
        String searchSDate = ServletRequestUtils.getStringParameter(request, "searchSDate", start_dt);
        String searchEDate = ServletRequestUtils.getStringParameter(request, "searchEDate", end_dt);
        String searchKind = ServletRequestUtils.getStringParameter(request, "searchKind", "");
        String searchKind2 = ServletRequestUtils.getStringParameter(request, "searchKind2", "");
        String searchKind3 = ServletRequestUtils.getStringParameter(request, "searchKind3", "");
        String searchKind4 = ServletRequestUtils.getStringParameter(request, "searchKind4", "");
        String searchLang = ServletRequestUtils.getStringParameter(request, "searchLang", "");

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);
        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);

        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);

        // 보안 조치 3차 - XSS
        /*searchVal = EgovWebUtil.clearXSSNormal(searchVal);
        searchVal2 = EgovWebUtil.clearXSSNormal(searchVal2);
        searchVal3 = EgovWebUtil.clearXSSNormal(searchVal3);
        searchVal4 = EgovWebUtil.clearXSSNormal(searchVal4);*/

        search.setSearchVal(searchVal);
        search.setSearchVal2(searchVal2);
        search.setSearchVal3(searchVal3);
        search.setSearchVal4(searchVal4);
        search.setSearchVal5(searchVal5);
        search.setSearchVal6(searchVal6);
        search.setSearchVal7(searchVal7);
        search.setSearchVal8(searchVal8);
        search.setSearchVal9(searchVal9);
        search.setSearchVal10(searchVal10);
        search.setSearchSDate(searchSDate);
        search.setSearchEDate(searchEDate);
        search.setSearchKind(searchKind);
        search.setSearchKind2(searchKind2);
        search.setSearchKind3(searchKind3);
        search.setSearchKind4(searchKind4);
        search.setSearchLang(searchLang);

        model.addAttribute("page", page);
        model.addAttribute("listSize", String.valueOf(listSize));

        model.addAttribute("searchVal", searchVal);
        model.addAttribute("searchVal2", searchVal2);
        model.addAttribute("searchVal3", searchVal3);
        model.addAttribute("searchVal4", searchVal4);
        model.addAttribute("searchVal5", searchVal5);
        model.addAttribute("searchVal6", searchVal6);
        model.addAttribute("searchVal7", searchVal7);
        model.addAttribute("searchVal8", searchVal8);
        model.addAttribute("searchVal9", searchVal9);
        model.addAttribute("searchVal10", searchVal10);
        model.addAttribute("searchSDate", searchSDate);
        model.addAttribute("searchEDate", searchEDate);
        model.addAttribute("searchKind", searchKind);
        model.addAttribute("searchKind2", searchKind2);
        model.addAttribute("searchKind3", searchKind3);
        model.addAttribute("searchKind4", searchKind4);
        model.addAttribute("searchLang", searchLang);
    }

    protected void getModel(HttpServletRequest request, Model model, int listSizeIn) {
        Calendar cal = Calendar.getInstance();

        SearchVo search = new SearchVo();

        String searchVal = ServletRequestUtils.getStringParameter(request, "searchVal", "");
        String searchVal2 = ServletRequestUtils.getStringParameter(request, "searchVal2", "");
        String searchVal3 = ServletRequestUtils.getStringParameter(request, "searchVal3", "");
        String searchVal4 = ServletRequestUtils.getStringParameter(request, "searchVal4", "");
        String searchVal5 = ServletRequestUtils.getStringParameter(request, "searchVal5", "");
        String searchVal6 = ServletRequestUtils.getStringParameter(request, "searchVal6", "");
        String searchVal7 = ServletRequestUtils.getStringParameter(request, "searchVal7", "");
        String searchVal8 = ServletRequestUtils.getStringParameter(request, "searchVal8", "");
        String searchVal9 = ServletRequestUtils.getStringParameter(request, "searchVal9", "");
        String searchVal10 = ServletRequestUtils.getStringParameter(request, "searchVal10", "");
        String searchSDate = ServletRequestUtils.getStringParameter(request, "searchSDate", Util.getDateMonthMinus(3, -12));
        String searchEDate = ServletRequestUtils.getStringParameter(request, "searchEDate", Util.getDate(3));
        String searchKind = ServletRequestUtils.getStringParameter(request, "searchKind", "");
        String searchKind2 = ServletRequestUtils.getStringParameter(request, "searchKind2", "");
        String searchKind3 = ServletRequestUtils.getStringParameter(request, "searchKind3", "");
        String searchKind4 = ServletRequestUtils.getStringParameter(request, "searchKind4", "");
        String searchLang = ServletRequestUtils.getStringParameter(request, "searchLang", "");

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);
        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);

        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);

        // 보안 조치 3차 - XSS
        /*searchVal = EgovWebUtil.clearXSSNormal(searchVal);
        searchVal2 = EgovWebUtil.clearXSSNormal(searchVal2);
        searchVal3 = EgovWebUtil.clearXSSNormal(searchVal3);
        searchVal4 = EgovWebUtil.clearXSSNormal(searchVal4);*/

        search.setSearchVal(searchVal);
        search.setSearchVal2(searchVal2);
        search.setSearchVal3(searchVal3);
        search.setSearchVal4(searchVal4);
        search.setSearchVal5(searchVal5);
        search.setSearchVal6(searchVal6);
        search.setSearchVal7(searchVal7);
        search.setSearchVal8(searchVal8);
        search.setSearchVal9(searchVal9);
        search.setSearchVal10(searchVal10);
        search.setSearchSDate(searchSDate);
        search.setSearchEDate(searchEDate);
        search.setSearchKind(searchKind);
        search.setSearchKind2(searchKind2);
        search.setSearchKind3(searchKind3);
        search.setSearchKind4(searchKind4);
        search.setSearchLang(searchLang);

        model.addAttribute("page", page);
        model.addAttribute("listSize", String.valueOf(listSize));

        model.addAttribute("searchVal", searchVal);
        model.addAttribute("searchVal2", searchVal2);
        model.addAttribute("searchVal3", searchVal3);
        model.addAttribute("searchVal4", searchVal4);
        model.addAttribute("searchVal5", searchVal5);
        model.addAttribute("searchVal6", searchVal6);
        model.addAttribute("searchVal7", searchVal7);
        model.addAttribute("searchVal8", searchVal8);
        model.addAttribute("searchVal9", searchVal9);
        model.addAttribute("searchVal10", searchVal10);
        model.addAttribute("searchSDate", searchSDate);
        model.addAttribute("searchEDate", searchEDate);
        model.addAttribute("searchKind", searchKind);
        model.addAttribute("searchKind2", searchKind2);
        model.addAttribute("searchKind3", searchKind3);
        model.addAttribute("searchKind4", searchKind4);
        model.addAttribute("searchLang", searchLang);
    }

    protected void getModel(HttpServletRequest request, Model model, int listSizeIn, int p_idx, int group_idx) {
        Calendar cal = Calendar.getInstance();

        SearchVo search = new SearchVo();

        String searchVal = ServletRequestUtils.getStringParameter(request, "searchVal", "");
        String searchVal2 = ServletRequestUtils.getStringParameter(request, "searchVal2", String.valueOf(p_idx));
        String searchVal3 = ServletRequestUtils.getStringParameter(request, "searchVal3", String.valueOf(group_idx));
        String searchVal4 = ServletRequestUtils.getStringParameter(request, "searchVal4", "");
        String searchVal5 = ServletRequestUtils.getStringParameter(request, "searchVal5", "");
        String searchVal6 = ServletRequestUtils.getStringParameter(request, "searchVal6", "");
        String searchVal7 = ServletRequestUtils.getStringParameter(request, "searchVal7", "");
        String searchVal8 = ServletRequestUtils.getStringParameter(request, "searchVal8", "");
        String searchVal9 = ServletRequestUtils.getStringParameter(request, "searchVal9", "");
        String searchVal10 = ServletRequestUtils.getStringParameter(request, "searchVal10", "");
        String searchSDate = ServletRequestUtils.getStringParameter(request, "searchSDate", Util.getDateMonthMinus(3, -12));
        String searchEDate = ServletRequestUtils.getStringParameter(request, "searchEDate", Util.getDate(3));
        String searchKind = ServletRequestUtils.getStringParameter(request, "searchKind", "");
        String searchKind2 = ServletRequestUtils.getStringParameter(request, "searchKind2", "");
        String searchKind3 = ServletRequestUtils.getStringParameter(request, "searchKind3", "");
        String searchKind4 = ServletRequestUtils.getStringParameter(request, "searchKind4", "");
        String searchLang = ServletRequestUtils.getStringParameter(request, "searchLang", "");

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);
        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);

        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);
        search.setSearchVal2(String.valueOf(p_idx));
        search.setSearchVal3(String.valueOf(group_idx));

        // 보안 조치 3차 - XSS
        /*searchVal = EgovWebUtil.clearXSSNormal(searchVal);
        searchVal2 = EgovWebUtil.clearXSSNormal(searchVal2);
        searchVal3 = EgovWebUtil.clearXSSNormal(searchVal3);
        searchVal4 = EgovWebUtil.clearXSSNormal(searchVal4);*/

        search.setSearchVal(searchVal);
        //search.setSearchVal2(searchVal2);
        //search.setSearchVal3(searchVal3);
        search.setSearchVal4(searchVal4);
        search.setSearchVal5(searchVal5);
        search.setSearchVal6(searchVal6);
        search.setSearchVal7(searchVal7);
        search.setSearchVal8(searchVal8);
        search.setSearchVal9(searchVal9);
        search.setSearchVal10(searchVal10);
        search.setSearchSDate(searchSDate);
        search.setSearchEDate(searchEDate);
        search.setSearchKind(searchKind);
        search.setSearchKind2(searchKind2);
        search.setSearchKind3(searchKind3);
        search.setSearchKind4(searchKind4);
        search.setSearchLang(searchLang);

        model.addAttribute("page", page);
        model.addAttribute("listSize", String.valueOf(listSize));

        model.addAttribute("searchVal", searchVal);
        model.addAttribute("searchVal2", searchVal2);
        model.addAttribute("searchVal3", searchVal3);
        model.addAttribute("searchVal4", searchVal4);
        model.addAttribute("searchVal5", searchVal5);
        model.addAttribute("searchVal6", searchVal6);
        model.addAttribute("searchVal7", searchVal7);
        model.addAttribute("searchVal8", searchVal8);
        model.addAttribute("searchVal9", searchVal9);
        model.addAttribute("searchVal10", searchVal10);
        model.addAttribute("searchSDate", searchSDate);
        model.addAttribute("searchEDate", searchEDate);
        model.addAttribute("searchKind", searchKind);
        model.addAttribute("searchKind2", searchKind2);
        model.addAttribute("searchKind3", searchKind3);
        model.addAttribute("searchKind4", searchKind4);
        model.addAttribute("searchLang", searchLang);
    }

    protected void getModelEx(HttpServletRequest request, Model model, int month, int listSizeIn) {
        Calendar cal = Calendar.getInstance();

        SearchVo search = new SearchVo();

        String searchVal = ServletRequestUtils.getStringParameter(request, "searchVal", "");
        String searchVal2 = ServletRequestUtils.getStringParameter(request, "searchVal2", "");
        String searchVal3 = ServletRequestUtils.getStringParameter(request, "searchVal3", "");
        String searchVal4 = ServletRequestUtils.getStringParameter(request, "searchVal4", "");
        String searchVal5 = ServletRequestUtils.getStringParameter(request, "searchVal5", "");
        String searchVal6 = ServletRequestUtils.getStringParameter(request, "searchVal6", "");
        String searchVal7 = ServletRequestUtils.getStringParameter(request, "searchVal7", "");
        String searchVal8 = ServletRequestUtils.getStringParameter(request, "searchVal8", "");
        String searchVal9 = ServletRequestUtils.getStringParameter(request, "searchVal9", "");
        String searchVal10 = ServletRequestUtils.getStringParameter(request, "searchVal10", "");
        String searchSDate = ServletRequestUtils.getStringParameter(request, "searchSDate", Util.getDateMonthMinus(3, month));
        String searchEDate = ServletRequestUtils.getStringParameter(request, "searchEDate", Util.getDate(3));
        String searchKind = ServletRequestUtils.getStringParameter(request, "searchKind", "");
        String searchKind2 = ServletRequestUtils.getStringParameter(request, "searchKind2", "");
        String searchKind3 = ServletRequestUtils.getStringParameter(request, "searchKind3", "");
        String searchKind4 = ServletRequestUtils.getStringParameter(request, "searchKind4", "");
        String searchLang = ServletRequestUtils.getStringParameter(request, "searchLang", "");

        // 페이징을 위한 처리
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", listSizeIn);
        if (listSize == 0) {
            //if(strPageNumRow.equals("0")){
            listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            //}else{
            //	listSize = Util.nvl(strPageNumRow, 0);
            //}
        }
        search.setPageIndex(page);
        search.setPageSize(listSize);
        int strRow = (search.getPageIndex() - 1) * listSize + 1;
        //int strRow = (search.getPageIndex() - 1) * listSize; // MYSQL LIMIT 0 부터 시작
        int endRow = strRow + (listSize - 1);

        search.setFirstIndex(strRow);
        search.setLastIndex(endRow);

        // 보안 조치 3차 - XSS
        /*searchVal = EgovWebUtil.clearXSSNormal(searchVal);
        searchVal2 = EgovWebUtil.clearXSSNormal(searchVal2);
        searchVal3 = EgovWebUtil.clearXSSNormal(searchVal3);
        searchVal4 = EgovWebUtil.clearXSSNormal(searchVal4);*/

        search.setSearchVal(searchVal);
        search.setSearchVal2(searchVal2);
        search.setSearchVal3(searchVal3);
        search.setSearchVal4(searchVal4);
        search.setSearchVal5(searchVal5);
        search.setSearchVal6(searchVal6);
        search.setSearchVal7(searchVal7);
        search.setSearchVal8(searchVal8);
        search.setSearchVal9(searchVal9);
        search.setSearchVal10(searchVal10);
        search.setSearchSDate(searchSDate);
        search.setSearchEDate(searchEDate);
        search.setSearchKind(searchKind);
        search.setSearchKind2(searchKind2);
        search.setSearchKind3(searchKind3);
        search.setSearchKind4(searchKind4);
        search.setSearchLang(searchLang);

        model.addAttribute("page", page);
        model.addAttribute("listSize", String.valueOf(listSize));

        model.addAttribute("searchVal", searchVal);
        model.addAttribute("searchVal2", searchVal2);
        model.addAttribute("searchVal3", searchVal3);
        model.addAttribute("searchVal4", searchVal4);
        model.addAttribute("searchVal5", searchVal5);
        model.addAttribute("searchVal6", searchVal6);
        model.addAttribute("searchVal7", searchVal7);
        model.addAttribute("searchVal8", searchVal8);
        model.addAttribute("searchVal9", searchVal9);
        model.addAttribute("searchVal10", searchVal10);
        model.addAttribute("searchSDate", searchSDate);
        model.addAttribute("searchEDate", searchEDate);
        model.addAttribute("searchKind", searchKind);
        model.addAttribute("searchKind2", searchKind2);
        model.addAttribute("searchKind3", searchKind3);
        model.addAttribute("searchKind4", searchKind4);
        model.addAttribute("searchLang", searchLang);
    }

    protected Model setCommonModel(MenuMstVo menuMstVo, Model model) throws Exception {
        Model rtnModel = model;

        model.addAttribute("topMenu", menuMstVo.getTopMenu());
        model.addAttribute("subMenu", menuMstVo.getSubMenu());
        model.addAttribute("currentMenu", menuMstVo.getCurrentMenu());
        model.addAttribute("topMenuList", menuMstVo.getTopMenuList());
        model.addAttribute("subMenuList", menuMstVo.getSubMenuList());
        model.addAttribute("menuDept", menuMstVo.getMenuDept());
        model.addAttribute("menuSubDept", menuMstVo.getMenuSubDept());
        model.addAttribute("name", menuMstVo.getName());

        return rtnModel;
    }

    protected MenuMstVo getMenuMstInfo(String url, AdminLoginVo adminLoginVo, String type) throws Exception {
        MenuMstVo menuMstVo = new MenuMstVo();
        MenuVo menu = new MenuVo();
        menu.setYn_use("Y");
        menu.setType("S");
        menu.setLang("KO");

        // context path 관련 예외처리
        url = "/ssemadmin" + url;
        // 메뉴 관련 소스
        List<MenuVo> topMenuList = appService.seletTopMenuList(menu);

        // 서브메뉴
        MenuVo currentMenu = appService.selectMenu(url);
        MenuVo topMenu = currentMenu;
        if (topMenu.getLevel() != 1) {
            do {
                topMenu = appService.selectMenuByIdx(topMenu.getP_menu_idx());
            } while(topMenu.getLevel() != 1);
        }

        // 2단계 메뉴명 가져오기
        MenuVo subMenu = null;
        if (currentMenu.getLevel() == 3) {
            subMenu = appService.selectMenuByIdx(currentMenu.getP_menu_idx());
        }

        List<MenuVo> subMenuList = null;
        for(MenuVo top : topMenuList) {
            subMenuList = appService.selectSubMenuList(top.getMenu_idx());
            if (subMenuList != null) {
                for(MenuVo sMenu : subMenuList) {
                    List<MenuVo> childMenuList = appService.selectSubMenuList(sMenu.getMenu_idx());
                    sMenu.setSublist(childMenuList);
                }
                top.setSublist(subMenuList);
            }
        }

        /*List<MenuVo> subMenuList = appService.selectSubMenuList(topMenu.getMenu_idx());
        if (subMenuList != null) {
            for(MenuVo sMenu : subMenuList) {
                List<MenuVo> childMenuList = appService.selectSubMenuList(sMenu.getMenu_idx());
                sMenu.setSublist(childMenuList);
            }
        }*/

        // 해당 URL에 대한 권한이 있는지 확인한다.
        if (adminLoginVo != null) {
            String menu_info = adminLoginVo.getMenu_info() + ",";
            if(menu_info.indexOf("," + String.valueOf(currentMenu.getMenu_idx() + ",")) == -1 ) {

                // 2depth checking
                if(currentMenu.getLevel() == 3) {
                    if(menu_info.indexOf("," + String.valueOf(subMenu.getMenu_idx() + ",")) == -1) {
                        String idx = Util.getSubString(adminLoginVo.getMenu_info(), ",");
                        String ret_url = appService.selectMenuUrl(Integer.valueOf(idx));

                        menuMstVo.setRet_url(ret_url);
                    }
                } else {
                    String idx = Util.getSubString(adminLoginVo.getMenu_info(), ",");
                    String ret_url = appService.selectMenuUrl(Integer.valueOf(idx));

                    menuMstVo.setRet_url(ret_url);
                }
            }

            //* 뭐지 ? *//*
            /*List<String> arrayIdx = getUrl(type);
            for(String idx : arrayIdx) {
                if(adminLoginVo.getMenu_info().indexOf("," + idx + ",") != -1 ) {
                    menuMstVo.setChild_url(appService.selectMenuUrl(Integer.valueOf(idx)));
                    break;
                } else {
                    menuMstVo.setChild_url(url);
                }
            }*/
        }

        if("1".equals(type)) {
            topMenu.setMenu_idx(-1);
            menuMstVo.setMenuSubDept(-1);
        } else {
            menuMstVo.setMenuSubDept(currentMenu.getMenu_idx());
        }

        menuMstVo.setTopMenu(topMenu);
        menuMstVo.setSubMenu(subMenu);
        menuMstVo.setCurrentMenu(currentMenu);
        menuMstVo.setTopMenuList(topMenuList);
        menuMstVo.setSubMenuList(subMenuList);
        menuMstVo.setMenuDept(topMenu.getMenu_idx());

        return menuMstVo;
    }

    private List<String> getUrl(String type) {
        List<String> arrayUrl = new ArrayList<String>();

        if("1".equals(type)) {
            arrayUrl.add("9");
            arrayUrl.add("12");
            arrayUrl.add("15");
        } else if("2".equals(type)) {
            arrayUrl.add("16");
            arrayUrl.add("17");
            arrayUrl.add("18");
            arrayUrl.add("19");
            arrayUrl.add("118");
            arrayUrl.add("120");
        } else if("3".equals(type)) {
            arrayUrl.add("20");
            arrayUrl.add("21");
            arrayUrl.add("22");
            arrayUrl.add("23");
            arrayUrl.add("24");
        } else if("4".equals(type)) {
            arrayUrl.add("25");
            arrayUrl.add("26");
            arrayUrl.add("27");
            arrayUrl.add("28");
            arrayUrl.add("29");
            arrayUrl.add("30");
        } else if("5".equals(type)) {
            arrayUrl.add("31");
            arrayUrl.add("32");
        } else if("6".equals(type)) {
            arrayUrl.add("33");
            arrayUrl.add("34");
            arrayUrl.add("121");
        } else if("7".equals(type)) {
            arrayUrl.add("35");
            arrayUrl.add("36");
            arrayUrl.add("37");
        } else if("8".equals(type)) {
            arrayUrl.add("41");
            arrayUrl.add("42");
            arrayUrl.add("43");
            arrayUrl.add("44");
            arrayUrl.add("113");
        } else if("112".equals(type)) {
            arrayUrl.add("39");
            arrayUrl.add("40");
            arrayUrl.add("115");
            arrayUrl.add("116");
            arrayUrl.add("117");
        }

        return arrayUrl;
    }

    protected int checkLoginOptions(AdminLoginVo adminLoginVo, HttpServletRequest request) throws Exception {
        /* rtn value */
        /* 1 => 로그인 ID 및 PW 정보 틀림 */
        /* 2 => 접속 IP 틀림 */
        /* 3 => 패스워드 5회 실패에 따른 ID 잠김 */
        /* 4 => 미승인 계정 */
        /* 4 => 미사용 계정 */
        /* 9 => 정상 */
        int rtn = 9;

        //로그인 ID 및 PW 정보 확인
        AdminLoginVo adminVo = adminService.selectAdminInfo(adminLoginVo);

        if (adminVo != null) {
            if ("N".equals(adminVo.getApp_yn())) {
                // 미생성 계정
                return 4;
            }
            if ("N".equals(adminVo.getStatus())) {
                // 미사용 계정
                return 5;
            }

            /*if(adminVo.getLogin_fail_cnt() >= 5) {
                // 패스워드 5회 실패
                return 3;
            }*/
            //접속 IP 확인
            String remoteIP = Util.getRemoteAddr(request);
            if( !remoteIP.equals(adminVo.getLogin_ip())) {
                return 2;
            }
        } else {
            // 로그인 실패 COUNT UPDATE
            adminService.updateLoginFailedCnt(adminLoginVo);

            AdminVo admin = adminService.selectAdminById(adminLoginVo.getAdmin_id());
            if(admin.getLogin_fail_cnt() == 5) {
                adminService.updateAdminNoUse(adminLoginVo.getAdmin_id());
            }

            return 1;
        }

        return rtn;
    }

    protected StatConVo getConnectInfo(AdminLoginVo adminLoginVo, HttpServletRequest request) throws Exception {
        StatConVo statConVo = new StatConVo();

        statConVo.setAdmin_id(adminLoginVo.getAdmin_id());
        statConVo.setGroup_idx(adminLoginVo.getGroup_idx());
        statConVo.setName(adminLoginVo.getName());
        statConVo.setOs(Util.getRemoteOs(request));
        statConVo.setBrowser(Util.getRemoteBrowser(request));
        statConVo.setIp(Util.getRemoteAddr(request));
        statConVo.setType(adminLoginVo.getType());

        return statConVo;
    }

    protected PageHolder setPageNumRow(HttpServletRequest request, int totalCount) throws Exception {
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);
        int listSize = ServletRequestUtils.getIntParameter(request, "listSize", 0);

        HttpSession session = request.getSession();
        session.setAttribute(Constants.SESSION_ATTRIBUTE_PAGENUMROW, 0);
        if (listSize == 0) {
            String strPageNumRow = Util.nvl(session.getAttribute(Constants.SESSION_ATTRIBUTE_PAGENUMROW), "0");
            if (strPageNumRow.equals("0")) {
                session.setAttribute(Constants.SESSION_ATTRIBUTE_PAGENUMROW, String.valueOf(Constants.DEFAULT_LISTSIZE));
                listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            } else {
                listSize = Util.nvl(strPageNumRow, 0);
            }
        } else {
            session.setAttribute(Constants.SESSION_ATTRIBUTE_PAGENUMROW, listSize);
        }

        return new PageHolder(totalCount, page, listSize, paramMap);
    }

    protected PageHolder setPageNumRowEx(HttpServletRequest request, int totalCount, int listSize) throws Exception {
        int page = ServletRequestUtils.getIntParameter(request, "page", 1);

        HttpSession session = request.getSession();

        session.setAttribute(Constants.SESSION_ATTRIBUTE_PAGENUMROW, 0);

        if(listSize == 0){
            String strPageNumRow = Util.nvl(session.getAttribute(Constants.SESSION_ATTRIBUTE_PAGENUMROW), "0");
            if(strPageNumRow.equals("0")){
                session.setAttribute(Constants.SESSION_ATTRIBUTE_PAGENUMROW, String.valueOf(Constants.DEFAULT_LISTSIZE));
                listSize = Integer.parseInt(String.valueOf(Constants.DEFAULT_LISTSIZE));
            }else{
                listSize = Util.nvl(strPageNumRow, 0);
            }
        }
        else
        {
            session.setAttribute(Constants.SESSION_ATTRIBUTE_PAGENUMROW, listSize);
        }

        return new PageHolder(totalCount, page, listSize, paramMap);
    }

    protected CommonVo getAttachFileInfo(MultipartHttpServletRequest multiRequest) {
        CommonVo cmm = new CommonVo();
        boolean ftype_flag = true;
        MultipartFile file = null;
        List<MultipartFile> tmpAttFiles = multiRequest.getFiles("attfile");
        LinkedHashMap<String, MultipartFile> tmpfiles = new LinkedHashMap<String, MultipartFile>();

        int chkcnt = 0;
        for(int i = 0;i< tmpAttFiles.size();i++){
            file = tmpAttFiles.get(i);
            if(file != null)
                if(!file.isEmpty()){
                    if(!fileUtil.chkFileExt(file, Constants.allowExtFile)){
                        ftype_flag = false;
                        break;
                    }
                    tmpfiles.put(file.getName() + i, file);
                    chkcnt ++;
                }
        }

        cmm.setFtype_flag(ftype_flag);
        cmm.setChkcnt(chkcnt);
        cmm.setTmpfiles(tmpfiles);

        return cmm;
    }

    protected CommonVo getAttachFileInfoExcel(MultipartHttpServletRequest multiRequest) {
        CommonVo cmm = new CommonVo();
        boolean ftype_flag = true;
        MultipartFile file = null;
        List<MultipartFile> tmpAttFiles = multiRequest.getFiles("attfile");
        LinkedHashMap<String, MultipartFile> tmpfiles = new LinkedHashMap<String, MultipartFile>();

        int chkcnt = 0;
        for(int i = 0;i< tmpAttFiles.size();i++){
            file = tmpAttFiles.get(i);
            if(file != null)
                if(!file.isEmpty()){
                    if(!fileUtil.chkFileExt(file, Constants.allowExtFileExcel)){
                        ftype_flag = false;
                        break;
                    }
                    tmpfiles.put(file.getName() + i, file);
                    chkcnt ++;
                }
        }

        cmm.setFtype_flag(ftype_flag);
        cmm.setChkcnt(chkcnt);
        cmm.setTmpfiles(tmpfiles);

        return cmm;
    }

    protected CommonVo getAttachImgFileInfo(MultipartHttpServletRequest multiRequest) {
        CommonVo cmm = new CommonVo();
        boolean ftype_flag = true;
        MultipartFile file = null;
        List<MultipartFile> tmpAttFiles = multiRequest.getFiles("attfile");
        LinkedHashMap<String, MultipartFile> tmpfiles = new LinkedHashMap<String, MultipartFile>();

        int chkcnt = 0;
        for(int i = 0;i< tmpAttFiles.size();i++){
            file = tmpAttFiles.get(i);
            if(file != null)
                if(!file.isEmpty()){
                    if(!fileUtil.chkFileExt(file, Constants.allowExtFileImg)){
                        ftype_flag = false;
                        break;
                    }
                    tmpfiles.put(file.getName() + i, file);
                    chkcnt ++;
                }
        }

        cmm.setFtype_flag(ftype_flag);
        cmm.setChkcnt(chkcnt);
        cmm.setTmpfiles(tmpfiles);

        return cmm;
    }

    protected CommonVo getAttachFileInfoEx(MultipartHttpServletRequest multiRequest, String name) {
        CommonVo cmm = new CommonVo();
        boolean ftype_flag = true;
        MultipartFile file = null;
        List<MultipartFile> tmpAttFiles = multiRequest.getFiles(name);
        LinkedHashMap<String, MultipartFile> tmpfiles = new LinkedHashMap<String, MultipartFile>();

        int chkcnt = 0;
        for(int i = 0;i< tmpAttFiles.size();i++){
            file = tmpAttFiles.get(i);
            if(file != null)
                if(!file.isEmpty()){
                    if(!fileUtil.chkFileExt(file, Constants.allowExtFile)){
                        ftype_flag = false;
                        break;
                    }
                    tmpfiles.put(file.getName() + i, file);
                    chkcnt ++;
                }
        }

        cmm.setFtype_flag(ftype_flag);
        cmm.setChkcnt(chkcnt);
        cmm.setTmpfiles(tmpfiles);

        return cmm;
    }

    protected CommonVo getAttachImgFileInfoEx(MultipartHttpServletRequest multiRequest, String name) {
        CommonVo cmm = new CommonVo();
        boolean ftype_flag = true;
        MultipartFile file = null;
        List<MultipartFile> tmpAttFiles = multiRequest.getFiles(name);
        LinkedHashMap<String, MultipartFile> tmpfiles = new LinkedHashMap<String, MultipartFile>();

        int chkcnt = 0;
        for(int i = 0;i< tmpAttFiles.size();i++){
            file = tmpAttFiles.get(i);
            if(file != null)
                if(!file.isEmpty()){
                    if(!fileUtil.chkFileExt(file, Constants.allowExtFileImg)){
                        ftype_flag = false;
                        break;
                    }
                    tmpfiles.put(file.getName() + i, file);
                    chkcnt ++;
                }
        }

        cmm.setFtype_flag(ftype_flag);
        cmm.setChkcnt(chkcnt);
        cmm.setTmpfiles(tmpfiles);

        return cmm;
    }
}
