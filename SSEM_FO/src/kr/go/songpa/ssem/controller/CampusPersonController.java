package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.common.SafeHtmlUtil;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.*;
import kr.go.songpa.ssem.util.DateUtil;
import kr.go.songpa.ssem.util.FileMngUtil;
import kr.go.songpa.ssem.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Field;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-10-22
 * Description :
 * History :
 * Version :
 */
@Controller
public class CampusPersonController extends CommonController {

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    @Autowired
    private CampusService campusService;

    @Autowired
    private CommonService commonService;

    @Autowired
    private BbsService bbsService;

    @Autowired
    private AppService appService;

    public CampusPersonController() {
    }

    @RequestMapping(value = "/youth/campus/person_lib_main.do", method = RequestMethod.GET)
    public String person_lib_main(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_main";

        // 인물도서 메인 배너
        bannerInit("PERSON", model);

        // 인물도서 목록 최대 8개
        List<PersonBookVo> personList = campusService.selectPersonMainList();
        for(PersonBookVo person : personList ) {
            //썸네일 처리
            String thumbFileId = person.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            person.setThumbFileList(thumbFileList);
        }
        model.addAttribute("personList", personList);

        // 이달의 인물도서 가져오기
        String year = DateUtil.getYear();
        String month = DateUtil.getMonth();

        PersonBookVo personBookVo = new PersonBookVo();
        personBookVo.setYear(Integer.valueOf(year));
        personBookVo.setMonth(Integer.valueOf(month));
        personBookVo.setGubun("M");
        personBookVo.setUse_yn("Y");

        PersonBookVo monthInfo = campusService.selectPersonInfoMonthInfo(personBookVo);
        if(monthInfo != null) {
            //썸네일 처리
            String thumbFileId_month = monthInfo.getThumb_atch_file_id();
            String thumb_path_month = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo_month = new FileVo();
            thumbfvo_month.setAtch_file_id(thumbFileId_month);
            List<FileVo> thumbFileList_month = fileMngService.selectFileInfs(thumbfvo_month);
            for (FileVo fileVo : thumbFileList_month) {
                fileVo.setFile_src(thumb_path_month + "/" + fileVo.getFile_nm());
            }
            monthInfo.setThumbFileList(thumbFileList_month);
        }
        model.addAttribute("monthInfo", monthInfo);

        // LIVE 인물도서 목록 최대 4개
        List<PersonBookVo> liveList = campusService.selectLiveMainList();
        for(PersonBookVo live : liveList ) {
            //썸네일 처리
            String thumbFileId = live.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            live.setThumbFileList(thumbFileList);
        }
        model.addAttribute("liveList", liveList);

        // 학교로 찾아가는 인물도서 목록 최대 4개
        List<PersonBookVo> schoolList = campusService.selectSchoolMainList();
        for(PersonBookVo school : schoolList ) {
            //썸네일 처리
            String thumbFileId = school.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            school.setThumbFileList(thumbFileList);
        }
        model.addAttribute("schoolList", schoolList);

        // 인물도서 열람후기 목록 최대 4개
        List<PersonBookVo> reviewList = campusService.selectReviewMainList();
        for(PersonBookVo review : reviewList ) {
            //썸네일 처리
            String thumbFileId = review.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            review.setThumbFileList(thumbFileList);
        }
        model.addAttribute("reviewList", reviewList);

        // 인물도서관 공지사항 목록 최대 4개
        int group_idx = appService.selectGroupIdx("인물도서관");

        BbsDetailVo bbsDetailVo = new BbsDetailVo();
        bbsDetailVo.setGroup_idx(group_idx);
        bbsDetailVo.setGubun("PORTAL");
        bbsDetailVo.setType_cd("B");

        List<BbsDetailVo> noticeList = bbsService.selectNoticeMainList(bbsDetailVo);
        model.addAttribute("noticeList", noticeList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_intro.do", method = RequestMethod.GET)
    public String person_lib_intro(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_intro";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        return ret_url;
    }


    @RequestMapping("/youth/campus/person_lib_book_list.do")
    public String person_lib_book_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_book_list";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 12);
        this.getModel(request, model, 12);

        searchVo.setSearchVal2("N"); // gubun 값
        searchVo.setSearchKind2("Y"); // USE_YN 사용
        searchVo.setSearchKind("ALL");

        for (Field field : searchVo.getClass().getDeclaredFields()){
            field.setAccessible(true);
            Object value=field.get(searchVo);
            if(value instanceof String){
                field.set(searchVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
            }
        }

        List<PersonBookVo> itemList = campusService.selectPersonBookList(searchVo);
        for(PersonBookVo personBookVo : itemList ) {
            //썸네일 처리
            String thumbFileId = personBookVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setThumbFileList(thumbFileList);
        }
        int totalCount = campusService.selectPersonBookListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 12);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_book_view.do", method = RequestMethod.GET)
    public String person_lib_book_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_book_view";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        int person_book_idx = ServletRequestUtils.getIntParameter(request, "person_book_idx", 0);

        PersonBookVo personBookVo = new PersonBookVo();
        personBookVo.setPerson_book_idx(person_book_idx);

        campusService.updatePersonBookViewCnt(personBookVo);
        personBookVo = campusService.selectPersonBookInfo(personBookVo);

        //썸네일 처리
        String thumbFileId = personBookVo.getThumb_atch_file_id();
        String thumb_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo thumbfvo = new FileVo();
        thumbfvo.setAtch_file_id(thumbFileId);
        List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
        for(FileVo fileVo : thumbFileList){
            fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
        }
        personBookVo.setThumbFileList(thumbFileList);

        // 첨부파일 처리
        String atchFileId = personBookVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        personBookVo.setFileList(fileVoList);

        // 이전/다음 목록 가져오기
        PersonBookVo next = campusService.selectNextPersonBook(personBookVo);
        PersonBookVo prev = campusService.selectPrevPersonBook(personBookVo);

        if (next != null) {
            personBookVo.setNext(next);
            personBookVo.setNext_idx((int)next.getPerson_book_idx());
        }

        if (prev != null) {
            personBookVo.setPrev(prev);
            personBookVo.setPrev_idx((int)prev.getPerson_book_idx());
        }

        model.addAttribute("personBookVo", personBookVo);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_book_insert.do", method = RequestMethod.GET)
    public String person_lib_book_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_book_insert";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int person_book_idx = ServletRequestUtils.getIntParameter(request, "person_book_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/person_lib_book_insert.do?person_book_idx=" + person_book_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            PersonBookVo personBookVo = new PersonBookVo();
            personBookVo.setPerson_book_idx(person_book_idx);

            campusService.updatePersonBookViewCnt(personBookVo);
            personBookVo = campusService.selectPersonBookInfo(personBookVo);

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    personBookVo.setMob_1(tokens[0]);
                    personBookVo.setMob_2(tokens[1]);
                    personBookVo.setMob_3(tokens[2]);
                }
            }

            model.addAttribute("personBookVo", personBookVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_book_insert.do", method = RequestMethod.POST)
    public String person_lib_book_inproc(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("personBookApyVo") PersonBookApyVo personBookApyVo,
                                     BindingResult bindingResult,
                                     Model model,
                                     SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : personBookApyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(personBookApyVo);
                if(value instanceof String){
                    field.set(personBookApyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                personBookApyVo.setReg_id(loginVo.getUser_id());

                // 엔터처리
                /*String reason = personBookApyVo.getReason();
                reason = reason.replaceAll(System.getProperty("line.separator"), "<br/>");
                personBookApyVo.setReason(reason);*/

                campusService.insertPersonBookApyInfo(personBookApyVo);

                model.addAttribute("msg", "loc");
                model.addAttribute("locurl", "/ssem/youth/campus/person_lib_book_insert_ok.do?person_book_apy_idx=" + personBookApyVo.getPerson_book_apy_idx());

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "신청에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_book_insert_ok.do", method = RequestMethod.GET)
    public String person_lib_book_insert_ok(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_book_insert_ok";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            int person_book_apy_idx = ServletRequestUtils.getIntParameter(request, "person_book_apy_idx", 0);

            PersonBookApyVo personBookApyVo = new PersonBookApyVo();
            personBookApyVo.setPerson_book_apy_idx(person_book_apy_idx);

            personBookApyVo = campusService.selectPersonBookApplyInfo(personBookApyVo);

            // 엔터처리
            String reason = personBookApyVo.getReason();
            if(!"".equals(Util.nvl(reason))) {
                reason = reason.replaceAll(System.getProperty("line.separator"), "<br/>");
                personBookApyVo.setReason(reason);
            }

            model.addAttribute("personBookApyVo", personBookApyVo);
        }

        return ret_url;
    }

    @RequestMapping("/youth/campus/person_lib_month_list.do")
    public String person_lib_month_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_month_list";

        // 인물도서 메인 배너
        bannerInit("PERSON", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 12);
        this.getModel(request, model, 12);

        searchVo.setSearchVal2("M"); // gubun 값
        searchVo.setSearchKind2("Y"); // USE_YN 사용
        searchVo.setSearchKind("ALL"); // USE_YN 사용

        List<PersonBookVo> itemList = campusService.selectPersonBookList(searchVo);
        for(PersonBookVo personBookVo : itemList ) {
            //썸네일 처리
            String thumbFileId = personBookVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setThumbFileList(thumbFileList);
        }
        int totalCount = campusService.selectPersonBookListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        // 이달의 인물도서 가져오기
        String year = DateUtil.getYear();
        String month = DateUtil.getMonth();

        PersonBookVo personBookVo = new PersonBookVo();
        personBookVo.setYear(Integer.valueOf(year));
        personBookVo.setMonth(Integer.valueOf(month));
        personBookVo.setGubun("M");
        personBookVo.setUse_yn("Y");

        PersonBookVo monthInfo = campusService.selectPersonInfoMonthInfo(personBookVo);
        if(monthInfo != null) {
            //썸네일 처리
            String thumbFileId = monthInfo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for (FileVo fileVo : thumbFileList) {
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            monthInfo.setThumbFileList(thumbFileList);
        }
        model.addAttribute("monthInfo", monthInfo);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_month_view.do", method = RequestMethod.GET)
    public String person_lib_month_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_month_view";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        int person_book_idx = ServletRequestUtils.getIntParameter(request, "person_book_idx", 0);

        PersonBookVo personBookVo = new PersonBookVo();
        personBookVo.setPerson_book_idx(person_book_idx);

        campusService.updatePersonBookViewCnt(personBookVo);
        personBookVo = campusService.selectPersonBookInfo(personBookVo);

        //썸네일 처리
        String thumbFileId = personBookVo.getThumb_atch_file_id();
        String thumb_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo thumbfvo = new FileVo();
        thumbfvo.setAtch_file_id(thumbFileId);
        List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
        for(FileVo fileVo : thumbFileList){
            fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
        }
        personBookVo.setThumbFileList(thumbFileList);

        // 첨부파일 처리
        String atchFileId = personBookVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        personBookVo.setFileList(fileVoList);

        // 이전/다음 목록 가져오기
        PersonBookVo next = campusService.selectNextPersonBook(personBookVo);
        PersonBookVo prev = campusService.selectPrevPersonBook(personBookVo);

        if (next != null) {
            personBookVo.setNext(next);
            personBookVo.setNext_idx((int)next.getPerson_book_idx());
        }

        if (prev != null) {
            personBookVo.setPrev(prev);
            personBookVo.setPrev_idx((int)prev.getPerson_book_idx());
        }

        model.addAttribute("personBookVo", personBookVo);

        return ret_url;
    }

    @RequestMapping("/youth/campus/person_lib_live_list.do")
    public String person_lib_live_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_live_list";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 12);
        this.getModel(request, model, 12);

        searchVo.setSearchVal2("L"); // gubun 값
        searchVo.setSearchKind2("Y"); // USE_YN 사용
        searchVo.setSearchKind("ALL");

        List<PersonBookVo> itemList = campusService.selectPersonBookList(searchVo);
        for(PersonBookVo personBookVo : itemList ) {
            //썸네일 처리
            String thumbFileId = personBookVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setThumbFileList(thumbFileList);
        }
        int totalCount = campusService.selectPersonBookListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 12);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_live_view.do", method = RequestMethod.GET)
    public String person_lib_live_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_live_view";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        int person_book_idx = ServletRequestUtils.getIntParameter(request, "person_book_idx", 0);

        PersonBookVo personBookVo = new PersonBookVo();
        personBookVo.setPerson_book_idx(person_book_idx);

        campusService.updatePersonBookViewCnt(personBookVo);
        personBookVo = campusService.selectPersonBookInfo(personBookVo);

        //썸네일 처리
        String thumbFileId = personBookVo.getThumb_atch_file_id();
        String thumb_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo thumbfvo = new FileVo();
        thumbfvo.setAtch_file_id(thumbFileId);
        List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
        for(FileVo fileVo : thumbFileList){
            fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
        }
        personBookVo.setThumbFileList(thumbFileList);

        // 첨부파일 처리
        String atchFileId = personBookVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        personBookVo.setFileList(fileVoList);

        // 이전/다음 목록 가져오기
        PersonBookVo next = campusService.selectNextPersonBook(personBookVo);
        PersonBookVo prev = campusService.selectPrevPersonBook(personBookVo);

        if (next != null) {
            personBookVo.setNext(next);
            personBookVo.setNext_idx((int)next.getPerson_book_idx());
        }

        if (prev != null) {
            personBookVo.setPrev(prev);
            personBookVo.setPrev_idx((int)prev.getPerson_book_idx());
        }

        model.addAttribute("personBookVo", personBookVo);

        return ret_url;
    }

    @RequestMapping("/youth/campus/person_lib_school_list.do")
    public String person_lib_school_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_school_list";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 12);
        this.getModel(request, model, 12);

        searchVo.setSearchVal2("S"); // gubun 값
        searchVo.setSearchKind2("Y"); // USE_YN 사용
        searchVo.setSearchKind("ALL");

        List<PersonBookVo> itemList = campusService.selectPersonBookList(searchVo);
        for(PersonBookVo personBookVo : itemList ) {
            //썸네일 처리
            String thumbFileId = personBookVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setThumbFileList(thumbFileList);
        }
        int totalCount = campusService.selectPersonBookListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 12);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_school_view.do", method = RequestMethod.GET)
    public String person_lib_school_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_school_view";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        int person_book_idx = ServletRequestUtils.getIntParameter(request, "person_book_idx", 0);

        PersonBookVo personBookVo = new PersonBookVo();
        personBookVo.setPerson_book_idx(person_book_idx);

        campusService.updatePersonBookViewCnt(personBookVo);
        personBookVo = campusService.selectPersonBookInfo(personBookVo);

        //썸네일 처리
        String thumbFileId = personBookVo.getThumb_atch_file_id();
        String thumb_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo thumbfvo = new FileVo();
        thumbfvo.setAtch_file_id(thumbFileId);
        List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
        for(FileVo fileVo : thumbFileList){
            fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
        }
        personBookVo.setThumbFileList(thumbFileList);

        // 첨부파일 처리
        String atchFileId = personBookVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        personBookVo.setFileList(fileVoList);

        // 이전/다음 목록 가져오기
        PersonBookVo next = campusService.selectNextPersonBook(personBookVo);
        PersonBookVo prev = campusService.selectPrevPersonBook(personBookVo);

        if (next != null) {
            personBookVo.setNext(next);
            personBookVo.setNext_idx((int)next.getPerson_book_idx());
        }

        if (prev != null) {
            personBookVo.setPrev(prev);
            personBookVo.setPrev_idx((int)prev.getPerson_book_idx());
        }

        model.addAttribute("personBookVo", personBookVo);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_school_insert.do", method = RequestMethod.GET)
    public String person_lib_school_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_school_insert";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int person_book_idx = ServletRequestUtils.getIntParameter(request, "person_book_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/person_lib_school_insert.do?person_book_idx=" + person_book_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            PersonBookVo personBookVo = new PersonBookVo();
            personBookVo.setPerson_book_idx(person_book_idx);

            campusService.updatePersonBookViewCnt(personBookVo);
            personBookVo = campusService.selectPersonBookInfo(personBookVo);

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    personBookVo.setMob_1(tokens[0]);
                    personBookVo.setMob_2(tokens[1]);
                    personBookVo.setMob_3(tokens[2]);
                }
            }

            model.addAttribute("personBookVo", personBookVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_school_insert.do", method = RequestMethod.POST)
    public String person_lib_school_inproc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("personBookApyVo") PersonBookApyVo personBookApyVo,
                                         BindingResult bindingResult,
                                         Model model,
                                         SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : personBookApyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(personBookApyVo);
                if(value instanceof String){
                    field.set(personBookApyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                personBookApyVo.setReg_id(loginVo.getUser_id());

                // 엔터처리
                /*String reason = personBookApyVo.getReason();
                reason = reason.replaceAll(System.getProperty("line.separator"), "<br/>");
                personBookApyVo.setReason(reason);*/

                campusService.insertPersonBookApyInfo(personBookApyVo);

                model.addAttribute("msg", "loc");
                model.addAttribute("locurl", "/ssem/youth/campus/person_lib_school_insert_ok.do?person_book_apy_idx=" + personBookApyVo.getPerson_book_apy_idx());

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "신청에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_school_insert_ok.do", method = RequestMethod.GET)
    public String person_lib_school_insert_ok(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_school_insert_ok";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            int person_book_apy_idx = ServletRequestUtils.getIntParameter(request, "person_book_apy_idx", 0);

            PersonBookApyVo personBookApyVo = new PersonBookApyVo();
            personBookApyVo.setPerson_book_apy_idx(person_book_apy_idx);

            personBookApyVo = campusService.selectPersonBookApplyInfo(personBookApyVo);

            // 엔터처리
            String reason = personBookApyVo.getReason();
            if(!"".equals(Util.nvl(reason))) {
                reason = reason.replaceAll(System.getProperty("line.separator"), "<br/>");
                personBookApyVo.setReason(reason);
            }

            model.addAttribute("personBookApyVo", personBookApyVo);
        }

        return ret_url;
    }

    @RequestMapping("/youth/campus/person_lib_review_list.do")
    public String person_lib_review_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_review_list";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        searchVo.setSearchVal2("R"); // gubun 값
        searchVo.setSearchKind2("Y"); // USE_YN 사용

        List<PersonBookVo> itemList = campusService.selectPersonBookList(searchVo);
        for(PersonBookVo personBookVo : itemList ) {
            //썸네일 처리
            String thumbFileId = personBookVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            personBookVo.setThumbFileList(thumbFileList);
        }
        int totalCount = campusService.selectPersonBookListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_review_view.do", method = RequestMethod.GET)
    public String person_lib_review_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_review_view";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        int person_book_idx = ServletRequestUtils.getIntParameter(request, "person_book_idx", 0);

        PersonBookVo personBookVo = new PersonBookVo();
        personBookVo.setPerson_book_idx(person_book_idx);

        campusService.updatePersonBookViewCnt(personBookVo);
        personBookVo = campusService.selectPersonBookInfo(personBookVo);

        //썸네일 처리
        String thumbFileId = personBookVo.getThumb_atch_file_id();
        String thumb_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo thumbfvo = new FileVo();
        thumbfvo.setAtch_file_id(thumbFileId);
        List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
        for(FileVo fileVo : thumbFileList){
            fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
        }
        personBookVo.setThumbFileList(thumbFileList);

        // 첨부파일 처리
        String atchFileId = personBookVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        personBookVo.setFileList(fileVoList);

        // 이전/다음 목록 가져오기
        PersonBookVo next = campusService.selectNextPersonBook(personBookVo);
        PersonBookVo prev = campusService.selectPrevPersonBook(personBookVo);

        if (next != null) {
            personBookVo.setNext(next);
            personBookVo.setNext_idx((int)next.getPerson_book_idx());
        }

        if (prev != null) {
            personBookVo.setPrev(prev);
            personBookVo.setPrev_idx((int)prev.getPerson_book_idx());
        }

        model.addAttribute("personBookVo", personBookVo);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_insert.do", method = RequestMethod.GET)
    public String person_lib_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/person_lib_insert";

        // 인물도서 메인 배너
        //bannerInit("PERSON", model);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/person_lib_insert.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            PersonBookRegVo personBookRegVo = new PersonBookRegVo();

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    personBookRegVo.setMob_1(tokens[0]);
                    personBookRegVo.setMob_2(tokens[1]);
                    personBookRegVo.setMob_3(tokens[2]);
                }
            }

            model.addAttribute("personBookRegVo", personBookRegVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/person_lib_insert.do", method = RequestMethod.POST)
    public String person_lib_inproc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("personBookRegVo") PersonBookRegVo personBookRegVo,
                                         BindingResult bindingResult,
                                         Model model,
                                         SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : personBookRegVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(personBookRegVo);
                if(value instanceof String){
                    field.set(personBookRegVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                // 사진파일 처리
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    personBookRegVo.setAtch_file_id(atchFileId);
                    personBookRegVo.setReg_id(loginVo.getUser_id());

                    // 대표경력 엔터처리
                    String career = personBookRegVo.getCareer();
                    if(!"".equals(Util.nvl(career))) {
                        career = career.replaceAll(System.getProperty("line.separator"), "<br/>");
                        personBookRegVo.setCareer(career);
                    }

                    // 소개글 엔터처리
                    String intro = personBookRegVo.getIntro();
                    if(!"".equals(Util.nvl(intro))) {
                        intro = intro.replaceAll(System.getProperty("line.separator"), "<br/>");
                        personBookRegVo.setIntro(intro);
                    }

                    campusService.insertPersonRegInfo(personBookRegVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssem/youth/mypage/person_reg_list.do");
                    model.addAttribute("altmsg", "인물도서 등록 신청이 완료되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "신청에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    private void bannerInit(String gubun, Model model) throws Exception {
        BannerVo bannerVo = new BannerVo();
        bannerVo.setGubun(gubun);
        bannerVo.setUse_yn("Y");

        List<BannerVo> bannerList = bbsService.selectBannerMainList(bannerVo);
        for(BannerVo banner : bannerList) {
            // 첨부파일 처리
            String atchFileId = banner.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            banner.setFileList(fileVoList);
        }
        model.addAttribute("bannerList", bannerList);
    }
}
