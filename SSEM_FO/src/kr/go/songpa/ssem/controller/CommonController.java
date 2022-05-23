package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.model.CommonVo;
import kr.go.songpa.ssem.model.SearchVo;
import kr.go.songpa.ssem.model.TnUserInfoVo;
import kr.go.songpa.ssem.service.UserService;
import kr.go.songpa.ssem.util.FileMngUtil;
import kr.go.songpa.ssem.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-09-29
 * Description :
 * History :
 * Version :
 */
public class CommonController {

    @Autowired
    private UserService userService;

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

    protected int checkLoginOptions(TnUserInfoVo tnUserInfoVo, HttpServletRequest request) throws Exception {
        /* rtn value */
        /* 1 => 로그인 ID 및 PW 정보 틀림 */
        /* 2 => 접속 IP 틀림 */
        /* 3 => 패스워드 5회 실패에 따른 ID 잠김 */
        /* 4 => 미승인 계정 */
        /* 9 => 정상 */
        int rtn = 9;

        //로그인 ID 및 PW 정보 확인
        TnUserInfoVo userVo = userService.selectUserInfo(tnUserInfoVo);

        if (userVo != null) {
            if ("EXIT".equals(userVo.getUser_se())) {
                // 미사용 계정
                return 4;
            }
            /*if ("N".equals(userVo.getApp_yn())) {
                // 미생성 계정
                return 4;
            }
            if ("N".equals(adminVo.getStatus())) {
                // 미사용 계정
                return 4;
            }
            //접속 IP 확인
            String remoteIP = Util.getRemoteAddr(request);
            if( !remoteIP.equals(adminVo.getLogin_ip())) {
                return 2;
            }*/
        } else {
            // 로그인 실패 COUNT UPDATE
            // adminService.updateLoginFailedCnt(adminLoginVo);
            return 1;
        }

        return rtn;
    }
}
