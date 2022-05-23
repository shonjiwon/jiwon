package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.common.SafeHtmlUtil;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.*;
import kr.go.songpa.ssem.util.DateUtil;
import kr.go.songpa.ssem.util.FileMngUtil;
import kr.go.songpa.ssem.util.StringUtil;
import kr.go.songpa.ssem.util.Util;
import lgdacom.XPayClient.XPayClient;
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
import java.util.ArrayList;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-10-23
 * Description :
 * History :
 * Version :
 */
@Controller
public class CampusInstrumentController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    @Autowired
    private CampusService campusService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private BbsService bbsService;

    @Autowired
    private MainService mainService;

    @Autowired
    private MsgService msgService;

    public CampusInstrumentController() {
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_main.do", method = RequestMethod.GET)
    public String instrum_lib_main(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_main";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        // 인물도서 메인 배너
        bannerInit("INSTRUM", model);

        int group_idx = appService.selectGroupIdx("악기도서관");

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 8);
        this.getModel(request, model, 8);

        // 소속 정보 셋팅
        searchVo.setSearchVal3(String.valueOf(group_idx));
        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        // 프로그램 목록
        List<LectureVo> lectureVoList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : lectureVoList) {
            // 썸네일 처리
            String atchFileId = lectureVo.getThumb_atch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            lectureVo.setThumbFileList(fileVoList);

            // 마감임박여부 확인 ( 접속기간이 일주일 이내로 남았을 경우 )
            long day = DateUtil.getRemainDay(lectureVo.getReg_end_dt().substring(0, 10));
            if(day < 7 && day > 0) {
                lectureVo.setClosing_yn("Y");
            } else {
                lectureVo.setClosing_yn("N");
            }

            // 좋아요
            int love_cnt = lectureService.selectLoveCount(lectureVo.getLecture_idx());
            lectureVo.setLove_cnt(love_cnt);

            // 좋아요 본인여부
            if(loginVo != null) {
                LoveVo love = new LoveVo();
                love.setLecture_idx(lectureVo.getLecture_idx());
                love.setReg_id(loginVo.getUser_id());
                int check = lectureService.selectLoveCountBySelf(love);
                if(check != 0) {
                    lectureVo.setLove_self_yn("Y");
                }
            }
        }
        model.addAttribute("lectureVoList", lectureVoList);

        // 대관시설 리스트
        List<RentalFtyVo> rentalList = campusService.selectRentalFtyList();
        for(RentalFtyVo rentalFtyVo : rentalList) {
            //썸네일 처리
            String thumbFileId = rentalFtyVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            rentalFtyVo.setThumbFileList(thumbFileList);
        }
        model.addAttribute("rentalList", rentalList);

        // 악기 리스트 : 최대 4개
        List<InstrumVo> instrumList = campusService.selectInstrumMainList();
        model.addAttribute("instrumList", instrumList);

        // 이용후기 리스트 : 최대 4개
        List<InstrumReviewVo> reviewList = campusService.selectInstrumReviewMainList();
        for(InstrumReviewVo instrumReviewVo : reviewList) {
            //썸네일 처리
            String thumbFileId = instrumReviewVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            instrumReviewVo.setThumbFileList(thumbFileList);
        }
        model.addAttribute("reviewList", reviewList);

        // 악기도서관 공지사항 목록 최대 4개
        BbsDetailVo bbsDetailVo = new BbsDetailVo();
        bbsDetailVo.setGroup_idx(group_idx);
        bbsDetailVo.setGubun("PORTAL");
        bbsDetailVo.setType_cd("B");

        List<BbsDetailVo> noticeList = bbsService.selectNoticeMainList(bbsDetailVo);
        model.addAttribute("noticeList", noticeList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_intro.do", method = RequestMethod.GET)
    public String instrum_lib_intro(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_intro";

        //bannerInit("INSTRUM", model);

        return ret_url;
    }

    @RequestMapping("/youth/campus/instrum_lib_rental_list.do")
    public String instrum_lib_rental_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_rental_list";

        //bannerInit("INSTRUM", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 12);
        this.getModel(request, model, 12);

        searchVo.setSearchKind2("Y");

        List<InstrumVo> itemList = campusService.selectInstrumRegList(searchVo);
        for(InstrumVo instrumVo : itemList) {
            // 첨부파일 처리
            String atchFileId = instrumVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            instrumVo.setFileList(fileVoList);
        }
        int totalCount = campusService.selectInstrumRegListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_rental_view.do", method = RequestMethod.GET)
    public String instrum_lib_rental_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_rental_view";

        //bannerInit("INSTRUM", model);

        int instrum_idx = ServletRequestUtils.getIntParameter(request, "instrum_idx", 0);

        InstrumVo instrumVo = new InstrumVo();
        instrumVo.setInstrum_idx(instrum_idx);

        instrumVo = campusService.selectInstrumInfo(instrumVo);

        // 첨부파일 처리
        String atchFileId = instrumVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        instrumVo.setFileList(fileVoList);

        // 이전/다음 목록 가져오기
        InstrumVo next = campusService.selectNextInstrum(instrumVo);
        InstrumVo prev = campusService.selectPrevInstrum(instrumVo);

        if (next != null) {
            instrumVo.setNext(next);
            instrumVo.setNext_idx((int)next.getInstrum_idx());
        }

        if (prev != null) {
            instrumVo.setPrev(prev);
            instrumVo.setPrev_idx((int)prev.getInstrum_idx());
        }

        model.addAttribute("instrumVo", instrumVo);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_rental_insert.do", method = RequestMethod.GET)
    public String instrum_lib_rental_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_rental_insert";

        //bannerInit("INSTRUM", model);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int instrum_idx = ServletRequestUtils.getIntParameter(request, "instrum_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/instrum_lib_rental_insert.do?instrum_idx=" + instrum_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            InstrumVo instrumVo = campusService.selectInstrumInfoByIdx(instrum_idx);

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    instrumVo.setMob_1(tokens[0]);
                    instrumVo.setMob_2(tokens[1]);
                    instrumVo.setMob_3(tokens[2]);
                }
            }

            model.addAttribute("instrumVo", instrumVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_rental_insert.do", method = RequestMethod.POST)
    public String instrum_lib_rental_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("instrumApyVo") InstrumApyVo instrumApyVo,
                                      BindingResult bindingResult,
                                      Model model,
                                      SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : instrumApyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(instrumApyVo);
                if(value instanceof String){
                    field.set(instrumApyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/instrum_lib_rental_insert.do?instrum_idx=" + instrumApyVo.getInstrum_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                instrumApyVo.setReg_id(loginVo.getUser_id());
                instrumApyVo.setApy_id(loginVo.getUser_id());
                instrumApyVo.setApy_nm(loginVo.getUser_nm());
                instrumApyVo.setApy_birth(loginVo.getBrthdy());

                // 대여목적 엔터처리
                /*String purpose = instrumApyVo.getPurpose();
                purpose = purpose.replaceAll(System.getProperty("line.separator"), "<br/>");
                instrumApyVo.setPurpose(purpose);*/

                // 예외처리 2일 전에는 신청해야 한다.
                if("P".equals(instrumApyVo.getGubun())) {
                    String start_dt = instrumApyVo.getRental_start_dt();
                    if (DateUtil.calDates(start_dt, DateUtil.getDate(3)) < 2) {
                        model.addAttribute("msg", "alterBack");
                        model.addAttribute("altmsg", "악기대여는 대여 희망하는 날의 <br/>이틀전까지 신청하실 수 있습니다.");
                        return ret_url;
                    }
                }

                if("G".equals(instrumApyVo.getGubun())) {
                    String start_dt = instrumApyVo.getGrp_rental_start_dt();
                    if (DateUtil.calDates(start_dt, DateUtil.getDate(3)) < 2) {
                        model.addAttribute("msg", "alterBack");
                        model.addAttribute("altmsg", "악기대여는 대여 희망하는 날의 <br/>이틀전까지 신청하실 수 있습니다.");
                        return ret_url;
                    }

                    instrumApyVo.setRental_start_dt(instrumApyVo.getGrp_rental_start_dt());
                    instrumApyVo.setRental_end_dt(instrumApyVo.getGrp_rental_end_dt());
                }

                campusService.insertInstrumApyInfo(instrumApyVo);

                // 결재대기일 경우라도 취소가 되기 전에는 대여로 잡는다.
                campusService.updateInstrumRentalQtyPlus(instrumApyVo);

                model.addAttribute("msg", "loc");
                model.addAttribute("locurl", "/ssem/youth/campus/instrum_lib_rental_insert_ok.do?instrum_apy_idx=" + instrumApyVo.getInstrum_apy_idx());
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "신청에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_rental_insert_ok.do", method = RequestMethod.GET)
    public String instrum_lib_rental_insert_ok(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_rental_insert_ok";

        //bannerInit("INSTRUM", model);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int instrum_apy_idx = ServletRequestUtils.getIntParameter(request, "instrum_apy_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/instrum_lib_rental_insert_ok.do?instrum_apy_idx=" + instrum_apy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            InstrumApyVo instrumApyVo = campusService.selectInstrumApyInfoByIdx(instrum_apy_idx);
            InstrumVo instrumVo = campusService.selectInstrumInfoByIdx(instrumApyVo.getInstrum_idx());

            // 첨부파일 처리
            String atchFileId = instrumVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            instrumVo.setFileList(fileVoList);

            instrumApyVo.setInstrumVo(instrumVo);

            model.addAttribute("instrumApyVo", instrumApyVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_room_list.do", method = RequestMethod.GET)
    public String instrum_lib_room_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_room_list";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<RentalFtyVo> itemList = campusService.selectRentalFtyList();
        for(RentalFtyVo rentalFtyVo : itemList) {
            //썸네일 처리
            String thumbFileId = rentalFtyVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            rentalFtyVo.setThumbFileList(thumbFileList);
        }

        model.addAttribute("itemList", itemList);

        if("".equals(Util.nvl(searchVo.getSearchVal()))) {
            if(itemList.size() != 0 ){
                searchVo.setSearchVal(String.valueOf(itemList.get(0).getRental_fty_idx()));
                model.addAttribute("searchVal", String.valueOf(itemList.get(0).getRental_fty_idx()));
            }
        }

        RentalFtyVo selected_fty = campusService.selectRentalFtyByIdx(Integer.parseInt(searchVo.getSearchVal()));
        //썸네일 처리
        String thumbFileId = selected_fty.getThumb_atch_file_id();
        String thumb_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo thumbfvo = new FileVo();
        thumbfvo.setAtch_file_id(thumbFileId);
        List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
        for(FileVo fileVo : thumbFileList){
            fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
        }
        selected_fty.setThumbFileList(thumbFileList);

        // 시설안내 엔터처리
        String cont = selected_fty.getCont();
        if(!"".equals(Util.nvl(cont))) {
            cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
            selected_fty.setCont(cont);
        }

        // 현재 날짜 기준 해당 주의 시작일과 마지막일을 구한다.
        if("".equals(Util.nvl(searchVo.getSearchVal2()))) {
            searchVo.setSearchVal2(DateUtil.getDate(3));
            model.addAttribute("searchVal2", DateUtil.getDate(3));
        }

        String start_date = DateUtil.getMonDay(searchVo.getSearchVal2());
        String end_date = DateUtil.getSunDay(searchVo.getSearchVal2());

        selected_fty.setStart_date(start_date);
        selected_fty.setEnd_date(end_date);

        model.addAttribute("selected_fty", selected_fty);

        // 날짜기준의 시간표 가져오기
        List<RentalFtySdVo> can_use_list = campusService.selectRentalFtySDList(selected_fty);
        for(RentalFtySdVo rentalFtySdVo : can_use_list) {
            rentalFtySdVo.setDate_str(String.valueOf(rentalFtySdVo.getDay()));

            RentalFtyApyVo rentalFtyApyVo = new RentalFtyApyVo();
            rentalFtyApyVo.setRental_fty_idx(rentalFtySdVo.getRental_fty_idx());
            String resv_dt = String.format("%4d-%02d-%02d", rentalFtySdVo.getYear(), rentalFtySdVo.getMonth(), rentalFtySdVo.getDay());
            rentalFtyApyVo.setResv_dt(resv_dt);

            List<RentalFtyApyVo> apyList = campusService.selectRentalFtyApyInfoListEx(rentalFtyApyVo);
            for(RentalFtyApyVo apy :  apyList) {
                if (apy != null) {
                    if ("Y".equals(apy.getH9())) {
                        rentalFtySdVo.setH9("R");
                    }
                    if ("Y".equals(apy.getH10())) {
                        rentalFtySdVo.setH10("R");
                    }
                    if ("Y".equals(apy.getH11())) {
                        rentalFtySdVo.setH11("R");
                    }
                    if ("Y".equals(apy.getH12())) {
                        rentalFtySdVo.setH12("R");
                    }
                    if ("Y".equals(apy.getH13())) {
                        rentalFtySdVo.setH13("R");
                    }
                    if ("Y".equals(apy.getH14())) {
                        rentalFtySdVo.setH14("R");
                    }
                    if ("Y".equals(apy.getH15())) {
                        rentalFtySdVo.setH15("R");
                    }
                    if ("Y".equals(apy.getH16())) {
                        rentalFtySdVo.setH16("R");
                    }
                    if ("Y".equals(apy.getH17())) {
                        rentalFtySdVo.setH17("R");
                    }
                    if ("Y".equals(apy.getH18())) {
                        rentalFtySdVo.setH18("R");
                    }
                    if ("Y".equals(apy.getH19())) {
                        rentalFtySdVo.setH19("R");
                    }
                    if ("Y".equals(apy.getH20())) {
                        rentalFtySdVo.setH20("R");
                    }
                }
            }
        }
        model.addAttribute("can_use_list", can_use_list);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_room_insert.do", method = RequestMethod.GET)
    public String instrum_lib_room_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_room_insert";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int rental_fty_idx = ServletRequestUtils.getIntParameter(request, "rental_fty_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/instrum_lib_room_insert.do?rental_fty_idx=" + rental_fty_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            RentalFtyVo selected_fty = campusService.selectRentalFtyByIdx(rental_fty_idx);
            //썸네일 처리
            String thumbFileId = selected_fty.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            selected_fty.setThumbFileList(thumbFileList);

            // 시설안내 엔터처리
            String cont = selected_fty.getCont();
            if(!"".equals(Util.nvl(cont))) {
                cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
                selected_fty.setCont(cont);
            }

            if("".equals(searchVo.getSearchVal())) {
                searchVo.setSearchVal(DateUtil.getDate(3));
                model.addAttribute("searchVal", DateUtil.getDate(3));
            }

            // 사용자 핸드폰 번호
            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    selected_fty.setMob_1(tokens[0]);
                    selected_fty.setMob_2(tokens[1]);
                    selected_fty.setMob_3(tokens[2]);
                }
            }

            model.addAttribute("selected_fty", selected_fty);

            RentalFtySdVo rentalFtySdVo = new RentalFtySdVo();

            String[] tokens = searchVo.getSearchVal().split("-");
            rentalFtySdVo.setYear(Long.parseLong(tokens[0]));
            rentalFtySdVo.setMonth(Long.parseLong(tokens[1]));
            rentalFtySdVo.setDay(Long.parseLong(tokens[2]));

            rentalFtySdVo.setRental_fty_idx(selected_fty.getRental_fty_idx());

            rentalFtySdVo = campusService.selectRentalFtySD(rentalFtySdVo);
            // 예약한 시간 확인 하기
            RentalFtyApyVo rentalFtyApyVo = new RentalFtyApyVo();
            rentalFtyApyVo.setRental_fty_idx(rentalFtySdVo.getRental_fty_idx());
            String resv_dt = String.format("%4d-%02d-%02d", rentalFtySdVo.getYear(), rentalFtySdVo.getMonth(), rentalFtySdVo.getDay());
            rentalFtyApyVo.setResv_dt(resv_dt);

            // 오늘날자 이전의 날짜 선택시 예외 처리
            if(DateUtil.calDates(DateUtil.getDate(3), resv_dt) <= 0) {
                //rentalFtyApyVo = campusService.selectRentalFtyApyInfo(rentalFtyApyVo);
                List<RentalFtyApyVo> apyList = campusService.selectRentalFtyApyInfoListEx(rentalFtyApyVo);
                for(RentalFtyApyVo apy :  apyList) {
                    if (apy != null) {
                        if ("Y".equals(apy.getH9())) {
                            rentalFtySdVo.setH9("R");
                        }
                        if ("Y".equals(apy.getH10())) {
                            rentalFtySdVo.setH10("R");
                        }
                        if ("Y".equals(apy.getH11())) {
                            rentalFtySdVo.setH11("R");
                        }
                        if ("Y".equals(apy.getH12())) {
                            rentalFtySdVo.setH12("R");
                        }
                        if ("Y".equals(apy.getH13())) {
                            rentalFtySdVo.setH13("R");
                        }
                        if ("Y".equals(apy.getH14())) {
                            rentalFtySdVo.setH14("R");
                        }
                        if ("Y".equals(apy.getH15())) {
                            rentalFtySdVo.setH15("R");
                        }
                        if ("Y".equals(apy.getH16())) {
                            rentalFtySdVo.setH16("R");
                        }
                        if ("Y".equals(apy.getH17())) {
                            rentalFtySdVo.setH17("R");
                        }
                        if ("Y".equals(apy.getH18())) {
                            rentalFtySdVo.setH18("R");
                        }
                        if ("Y".equals(apy.getH19())) {
                            rentalFtySdVo.setH19("R");
                        }
                        if ("Y".equals(apy.getH20())) {
                            rentalFtySdVo.setH20("R");
                        }
                    }
                }
            } else {
                rentalFtySdVo.setH9("R");
                rentalFtySdVo.setH10("R");
                rentalFtySdVo.setH11("R");
                rentalFtySdVo.setH12("R");
                rentalFtySdVo.setH13("R");
                rentalFtySdVo.setH14("R");
                rentalFtySdVo.setH15("R");
                rentalFtySdVo.setH16("R");
                rentalFtySdVo.setH17("R");
                rentalFtySdVo.setH18("R");
                rentalFtySdVo.setH19("R");
                rentalFtySdVo.setH20("R");
            }

            model.addAttribute("rentalFtySdVo", rentalFtySdVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_room_insert.do", method = RequestMethod.POST)
    public String instrum_lib_room_inproc(final MultipartHttpServletRequest multiRequest,
                                            @ModelAttribute("rentalFtyApyVo") RentalFtyApyVo rentalFtyApyVo,
                                            BindingResult bindingResult,
                                            Model model,
                                            SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : rentalFtyApyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(rentalFtyApyVo);
                if(value instanceof String){
                    field.set(rentalFtyApyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인이 필요한 서비스입니다.");
                ret_url =  "common/message";
            } else {

                rentalFtyApyVo.setReg_id(loginVo.getUser_id());

                campusService.insertRentalFtyApyInfo(rentalFtyApyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/campus/instrum_lib_room_pay.do?rental_fty_apy_idx=" + rentalFtyApyVo.getRental_fty_apy_idx());
                model.addAttribute("altmsg", "신청되었습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "신청에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_room_pay.do", method = RequestMethod.GET)
    public String instrum_lib_room_pay(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_room_pay";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int rental_fty_apy_idx = ServletRequestUtils.getIntParameter(request, "rental_fty_apy_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/instrum_lib_room_pay.do?rental_fty_apy_idx=" + rental_fty_apy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            RentalFtyApyVo rentalFtyApyVo = campusService.selectRentalFtyApyByIdx(rental_fty_apy_idx);
            model.addAttribute("rentalFtyApyVo", rentalFtyApyVo);
            RentalFtyVo rentalFtyVo = campusService.selectRentalFtyByIdx((int)rentalFtyApyVo.getRental_fty_idx());
            model.addAttribute("rentalFtyVo", rentalFtyVo);

            // 상점아이디 가져오기
            GroupVo groupVo = appService.selectGruopByIdx(rentalFtyVo.getGroup_idx());

            // 결제 관련
            String configPath = EgovProperties.getProperty("xpay.config");
            String CST_PLATFORM = EgovProperties.getProperty("xpay.platform");
            String LGD_TIMESTAMP = DateUtil.getDate(1) + DateUtil.getTime();
            String LGD_MID = groupVo.getPay_shop_id();
            String LGD_OID = "SSEM_" + LGD_TIMESTAMP;
            String LGD_AMOUNT = String.valueOf(rentalFtyApyVo.getPay_sum());
            String LGD_HASHDATA = "";
            XPayClient xpay = null;
            try {
                xpay = new XPayClient();
                xpay.Init(configPath, CST_PLATFORM);

                if("".equals(LGD_TIMESTAMP)) {
                    LGD_TIMESTAMP = xpay.GetTimeStamp();
                }
                LGD_HASHDATA = xpay.GetHashData(LGD_MID, LGD_OID, LGD_AMOUNT, LGD_TIMESTAMP);

                PayVo payVo = new PayVo();
                payVo.setLGD_OID(LGD_OID);
                payVo.setLGD_HASHDATA(LGD_HASHDATA);
                payVo.setLGD_TIMESTAMP(LGD_TIMESTAMP);

                model.addAttribute("payVo", payVo);

            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                xpay = null;
            }

            model.addAttribute("CST_PLATFORM", CST_PLATFORM);
            model.addAttribute("LGD_MID", LGD_MID);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_room_payment.do", method = RequestMethod.POST)
    public String instrum_lib_room_payment_ok(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("payVo") PayVo payVo,
                                       BindingResult bindingResult,
                                       Model model,
                                       SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            String configPath = EgovProperties.getProperty("xpay.config");
            String LGD_MID = payVo.getCST_MID();

            XPayClient xpay = new XPayClient();
            boolean isInitOK = xpay.Init(configPath, payVo.getCST_PLATFORM());

            if( !isInitOK ) {
                //API 초기화 실패 화면처리
                    /*out.println( "결제요청을 초기화 하는데 실패하였습니다.<br>");
                    out.println( "토스페이먼츠에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.<br>");
                    out.println( "mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.<br><br>");
                    out.println( "문의전화 토스페이먼츠 1544-7772<br>");*/
                return ret_url;

            }else{
                try{

                    // (3) Init_TX: 메모리에 mall.conf, lgdacom.conf 할당 및 트랜잭션의 고유한 키 TXID 생성
                    xpay.Init_TX(LGD_MID);
                    xpay.Set("LGD_TXNAME", "PaymentByKey");
                    xpay.Set("LGD_PAYKEY", payVo.getLGD_PAYKEY());

                    //금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
                    //String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
                    //xpay.Set("LGD_AMOUNTCHECKYN", "Y");
                    //xpay.Set("LGD_AMOUNT", DB_AMOUNT);

                }catch(Exception e) {
                        /*out.println("토스페이먼츠 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
                        out.println(""+e.getMessage());*/
                    e.printStackTrace();
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "저장에 실패하였습니다.");
                    return ret_url;
                }
            }

            if(loginVo == null) {
                xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/instrum_lib_room_pay.do?rental_fty_apy_idx=" + payVo.getRental_fty_apy_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                RentalFtyApyVo rentalFtyApyVo = new RentalFtyApyVo();

                if ( xpay.TX() ) {
                    //1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
                    // (5) DB에 인증요청 결과 처리
                    if( "0000".equals( xpay.m_szResCode ) ) {
                        // 통신상의 문제가 없을시
                        // 최종결제요청 결과 성공 DB처리(LGD_RESPCODE 값에 따라 결제가 성공인지, 실패인지 DB처리)
                        //out.println("최종결제요청 성공, DB처리하시기 바랍니다.<br>");
                        //최종결제요청 결과를 DB처리합니다. (결제성공 또는 실패 모두 DB처리 가능)
                        //상점내 DB에 어떠한 이유로 처리를 하지 못한경우 false로 변경해 주세요.
                        rentalFtyApyVo.setRental_fty_apy_idx(payVo.getRental_fty_apy_idx());
                        rentalFtyApyVo.setPay_sucs_yn("Y");
                        rentalFtyApyVo.setPay_sum(Integer.parseInt(xpay.Response("LGD_AMOUNT",0)));
                        rentalFtyApyVo.setTrade_code(xpay.Response("LGD_TID",0));
                        rentalFtyApyVo.setPay_code(payVo.getLGD_PAYKEY());
                        rentalFtyApyVo.setUp_id(loginVo.getUser_id());
                        rentalFtyApyVo.setPay_status("O");

                        String pay_method = xpay.Response("LGD_PAYTYPE",0);
                        if("SC0010".equals(pay_method)) {
                            rentalFtyApyVo.setPay_method("A");
                        } else {
                            rentalFtyApyVo.setPay_method("B");
                        }

                        int check_sucs = campusService.updateRentalFtyApyPayResult(rentalFtyApyVo);
                        if( check_sucs == 0 ) {

                            xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
                            //out.println( "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0) + "<br>");
                            //out.println( "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0) + "<p>");
                            if( "0000".equals( xpay.m_szResCode ) ) {
                                //out.println("자동취소가 정상적으로 완료 되었습니다.<br>");
                            }else{
                                //out.println("자동취소가 정상적으로 처리되지 않았습니다.<br>");
                            }
                        } else {
                            // 대관신청 예약완료 메세지 발송
                            // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            if ("yes".equals(EgovProperties.getProperty("msg.send"))) {
                                RentalFtyApyVo rental = campusService.selectRentalFtyApyByIdx((int)payVo.getRental_fty_apy_idx());
                                RentalFtyVo rentalFtyVo = campusService.selectRentalFtyByIdx((int)rental.getRental_fty_idx());

                                StringBuffer sb = new StringBuffer();
                                sb.append("[송파구청 송파쌤(SSEM)]");
                                sb.append("\r\n");
                                sb.append(String.format("%s님의 대관신청 예약이 완료되었습니다.", rental.getApy_name()));
                                sb.append("\r\n");
                                sb.append("<예약내역>");
                                sb.append("\r\n");
                                sb.append(String.format("- 시설명: %s", rentalFtyVo.getName()));
                                sb.append("\r\n");
                                sb.append(String.format("- 예약날짜: %s", rental.getResv_dt().substring(0, 10)));
                                sb.append("\r\n");
                                String start_time = "";
                                String end_time = "";
                                if ("Y".equals(rental.getH9())) {
                                    start_time = "09:00";
                                    end_time = "10:00";
                                }
                                if ("Y".equals(rental.getH10())) {
                                    if("".equals(start_time)) {
                                        start_time = "10:00";
                                    }
                                    end_time = "11:00";
                                }
                                if ("Y".equals(rental.getH11())) {
                                    if("".equals(start_time)) {
                                        start_time = "11:00";
                                    }
                                    end_time = "12:00";
                                }
                                if ("Y".equals(rental.getH12())) {
                                    if("".equals(start_time)) {
                                        start_time = "12:00";
                                    }
                                    end_time = "13:00";
                                }
                                if ("Y".equals(rental.getH13())) {
                                    if("".equals(start_time)) {
                                        start_time = "13:00";
                                    }
                                    end_time = "14:00";
                                }
                                if ("Y".equals(rental.getH14())) {
                                    if("".equals(start_time)) {
                                        start_time = "14:00";
                                    }
                                    end_time = "15:00";
                                }
                                if ("Y".equals(rental.getH15())) {
                                    if("".equals(start_time)) {
                                        start_time = "15:00";
                                    }
                                    end_time = "16:00";
                                }
                                if ("Y".equals(rental.getH16())) {
                                    if("".equals(start_time)) {
                                        start_time = "16:00";
                                    }
                                    end_time = "17:00";
                                }
                                if ("Y".equals(rental.getH17())) {
                                    if("".equals(start_time)) {
                                        start_time = "17:00";
                                    }
                                    end_time = "18:00";
                                }
                                if ("Y".equals(rental.getH18())) {
                                    if("".equals(start_time)) {
                                        start_time = "18:00";
                                    }
                                    end_time = "19:00";
                                }
                                if ("Y".equals(rental.getH19())) {
                                    if("".equals(start_time)) {
                                        start_time = "19:00";
                                    }
                                    end_time = "20:00";
                                }
                                if ("Y".equals(rental.getH20())) {
                                    if("".equals(start_time)) {
                                        start_time = "20:00";
                                    }
                                    end_time = "21:00";
                                }
                                sb.append(String.format("- 예약시간: %s~%s", start_time, end_time));
                                sb.append("\r\n");
                                sb.append("대관신청 예약확인은 마이페이지에서 확인이 가능하며, 예약취소는 해당 담당자에게 문의해주세요.");
                                sb.append("\r\n");
                                sb.append("감사합니다.");
                                sb.append("\r\n");
                                sb.append("☎ 문의: 송파쌤(SSEM) 악기도서관 02-2147-2544");

                                msgService.sendMsgKakao("대관신청 예약완료", sb.toString(), rental.getApy_name(), rental.getApy_mob_no().replaceAll("-", ""), "UMS_2021061514563739271");
                            }
                            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            model.addAttribute("msg", "loc");
                            model.addAttribute("locurl", "/ssem/youth/campus/instrum_lib_room_insert_ok.do?rental_fty_apy_idx=" + payVo.getRental_fty_apy_idx());
                            ret_url = "common/message";
                        }

                    } else {
                        rentalFtyApyVo.setPay_sucs_yn("N");
                        rentalFtyApyVo.setUp_id(loginVo.getUser_id());
                        rentalFtyApyVo.setPay_status("A");
                        campusService.updateRentalFtyApyPayResult(rentalFtyApyVo);
                        model.addAttribute("msg", "alterBack");
                        model.addAttribute("altmsg", "결제에 실패하였습니다.");
                        return ret_url;
                        //통신상의 문제 발생(최종결제요청 결과 실패 DB처리)
                        //out.println("최종결제요청 결과 실패, DB처리하시기 바랍니다.<br>");
                    }
                } else {
                    //2)API 요청실패 화면처리
                    /*out.println( "결제요청이 실패하였습니다.  <br>");
                    out.println( "TX 결제요청 Response_code = " + xpay.m_szResCode + "<br>");
                    out.println( "TX 결제요청 Response_msg = " + xpay.m_szResMsg + "<p>");*/
                    //최종결제요청 결과 실패 DB처리
                    /*out.println("최종결제요청 결과 실패 DB처리하시기 바랍니다.<br>");*/
                    rentalFtyApyVo.setPay_sucs_yn("N");
                    rentalFtyApyVo.setUp_id(loginVo.getUser_id());
                    rentalFtyApyVo.setPay_status("A");
                    campusService.updateRentalFtyApyPayResult(rentalFtyApyVo);
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "결제에 실패하였습니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "결제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_room_cancel.do", method = RequestMethod.POST)
    public String instrum_lib_room_cancel(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("rentalFtyApyVo") RentalFtyApyVo rentalFtyApyVo,
                                          BindingResult bindingResult,
                                          Model model,
                                          SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            /*// 모든 POST에 XSS 처리
            for (Field field : rentalFtyApyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(rentalFtyApyVo);
                if(value instanceof String){
                    field.set(rentalFtyApyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인이 필요한 서비스입니다.");
                ret_url =  "common/message";
            } else {
                campusService.deleteRentalFtyApyInfo(rentalFtyApyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/campus/instrum_lib_room_list.do");
                model.addAttribute("altmsg", "취소되었습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "취소에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_room_insert_ok.do", method = RequestMethod.GET)
    public String instrum_lib_room_insert_ok(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_room_insert_ok";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int rental_fty_apy_idx = ServletRequestUtils.getIntParameter(request, "rental_fty_apy_idx", 0);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/instrum_lib_room_insert_ok.do?rental_fty_apy_idx=" + rental_fty_apy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            RentalFtyApyVo rentalFtyApyVo = campusService.selectRentalFtyApyByIdx(rental_fty_apy_idx);
            model.addAttribute("rentalFtyApyVo", rentalFtyApyVo);
            RentalFtyVo rentalFtyVo = campusService.selectRentalFtyByIdx((int)rentalFtyApyVo.getRental_fty_idx());
            model.addAttribute("rentalFtyVo", rentalFtyVo);
        }

        return ret_url;
    }

    @RequestMapping("/youth/campus/instrum_lib_program_list.do")
    public String instrum_lib_program_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_program_list";

        //bannerInit("INSTRUM", model);

        int group_idx = appService.selectGroupIdx("악기도서관");

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 12);
        this.getModel(request, model, 12);

        // 소속 정보 셋팅
        searchVo.setSearchVal3(String.valueOf(group_idx));
        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        for (Field field : searchVo.getClass().getDeclaredFields()){
            field.setAccessible(true);
            Object value=field.get(searchVo);
            if(value instanceof String){
                field.set(searchVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
            }
        }

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : itemList) {
            // 썸네일 처리
            String atchFileId = lectureVo.getThumb_atch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            lectureVo.setThumbFileList(fileVoList);

            // 마감임박여부 확인 ( 접속기간이 일주일 이내로 남았을 경우 )
            long day = DateUtil.getRemainDay(lectureVo.getReg_end_dt().substring(0, 10));
            if(day < 7 && day > 0) {
                lectureVo.setClosing_yn("Y");
            } else {
                lectureVo.setClosing_yn("N");
            }

            //교육대상 가져오기
            List<String> array_tgt = new ArrayList<String>();
            String tgt_code = lectureVo.getTgt_code();
            String[] tokens = tgt_code.split(",");
            for(String code : tokens) {
                String code_txt = appService.selectCodeByIdx(Integer.parseInt(code));
                array_tgt.add(code_txt);
            }
            lectureVo.setArray_tgt(array_tgt);

            // 교육분야 가져오기
            String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
            lectureVo.setPart_name(part_name);

            // 좋아요
            int love_cnt = lectureService.selectLoveCount(lectureVo.getLecture_idx());
            lectureVo.setLove_cnt(love_cnt);

            // 좋아요 본인여부
            if(loginVo != null) {
                LoveVo love = new LoveVo();
                love.setLecture_idx(lectureVo.getLecture_idx());
                love.setReg_id(loginVo.getUser_id());
                int check = lectureService.selectLoveCountBySelf(love);
                if(check != 0) {
                    lectureVo.setLove_self_yn("Y");
                }
            }
        }
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 12);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        // 교육대상
        List<CodeVo> tgtList = appService.selectCodeList("STUDY_TGT");
        model.addAttribute("tgtList", tgtList);

        // 교육분야
        List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
        model.addAttribute("codeList", codeList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_program_view.do", method = RequestMethod.GET)
    public String instrum_lib_program_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_program_view";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        LectureVo lectureVo = new LectureVo();
        lectureVo.setLecture_idx(lecture_idx);

        lectureVo = lectureService.selectLectureInfo(lectureVo);

        //교육대상 가져오기
        List<String> array_tgt = new ArrayList<String>();
        String tgt_code = lectureVo.getTgt_code();
        String[] tokens = tgt_code.split(",");
        for(String code : tokens) {
            String code_txt = appService.selectCodeByIdx(Integer.valueOf(code));
            array_tgt.add(code_txt);
        }
        lectureVo.setArray_tgt(array_tgt);

        // 교육분야 가져오기
        String part_name = appService.selectCodeByIdx(lectureVo.getPart_code_idx());
        lectureVo.setPart_name(part_name);

        // 교육시간
        String dt_str = "";
        String dt_type = lectureVo.getDt_type();
        if("W".equals(dt_type)) {
            dt_str += "매주 ";
        } else if("T".equals(dt_type)) {
            dt_str += "격주 ";
        } else if("Z".equals(dt_type)) {
            dt_str += "기타 ";
        }

        String[] weeks = lectureVo.getDt_week().split(",");
        for(String week : weeks) {
            if("1".equals(week)) {
                dt_str += "월, ";
            } else if("2".equals(week)) {
                dt_str += "화, ";
            } else if("3".equals(week)) {
                dt_str += "수, ";
            } else if("4".equals(week)) {
                dt_str += "목, ";
            } else if("5".equals(week)) {
                dt_str += "금, ";
            } else if("6".equals(week)) {
                dt_str += "토, ";
            } else if("7".equals(week)) {
                dt_str += "일, ";
            }
        }
        lectureVo.setDt_str(StringUtil.deleteLastStr(dt_str.trim(), ','));

        // 접수방법
        String reg_method_str = "";
        String[] methods = lectureVo.getReg_method().split(",");
        for(String method : methods) {
            if("1".equals(method)) {
                reg_method_str += "온라인, ";
            } else if("2".equals(method)) {
                reg_method_str += "방문, ";
            } else if("3".equals(method)) {
                reg_method_str += "전화, ";
            } else if("4".equals(method)) {
                reg_method_str += "외부홈페이지, ";
            }
        }
        lectureVo.setReg_method_str(StringUtil.deleteLastStr(reg_method_str.trim(), ','));

        // 조직 정보
        GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
        lectureVo.setGroup(groupVo);

        // 시설 정보
        StudyPlaceVo place = lectureService.selectStudyPlaceByIdx(lectureVo.getStudy_place_idx());
        lectureVo.setPlace(place);

        // 감면 정보
        List<DiscountVo> array_discount = new ArrayList<DiscountVo>();
        if(lectureVo.getDiscount_str() != null) {
            String[] discounts = lectureVo.getDiscount_str().split(",");
            for (String discount : discounts) {
                DiscountVo dis = lectureService.selectDiscountByIdx(Integer.valueOf(discount));
                array_discount.add(dis);
            }
        }
        lectureVo.setArray_discount(array_discount);

        // 강사 정보
        TeacherVo teacher = lectureService.selectTeacherInfoByIdx(lectureVo.getTeacher_idx());
        if(teacher != null) {
            // 첨부파일 처리
            String atchFileId = teacher.getPic_atch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for (FileVo fileVo : fileVoList) {
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            teacher.setPicFileList(fileVoList);

            // 주요경력 엔터처리
            String career = teacher.getCareer();
            if(!"".equals(Util.nvl(career))) {
                career = career.replaceAll(System.getProperty("line.separator"), "<br/>");
                teacher.setCareer(career);
            }

            teacher.setLecture_idx(lectureVo.getLecture_idx());

            // score => 0 : 평가 없음
            // score => 1 : 금
            // score => 2 : 은
            // score => 3 : 동
            int score = 0;
            int total_cnt = lectureService.selectTeacherScoreTotalCnt(teacher);
            if(total_cnt != 0) {
                int total_score = lectureService.selectTeacherScoreTotal(teacher);
                score = Util.getTeacherScore(total_cnt, total_score);
            } else {
                score = 0;
            }
            teacher.setScore(score);

            lectureVo.setTeacher(teacher);
        }

        // 특이사항 엔터처리
        String desc_txt = lectureVo.getDesc_txt();
        if(!"".equals(Util.nvl(desc_txt))) {
            desc_txt = desc_txt.replaceAll(System.getProperty("line.separator"), "<br/>");
            lectureVo.setDesc_txt(desc_txt);
        }

        // 환불정책 엔터처리
        String refund_txt = lectureVo.getRefund_txt();
        if(!"".equals(Util.nvl(refund_txt))) {
            refund_txt = refund_txt.replaceAll(System.getProperty("line.separator"), "<br/>");
            lectureVo.setRefund_txt(refund_txt);
        }

        // 좋아요 카운트
        int love_cnt = lectureService.selectLoveCount(lectureVo.getLecture_idx());
        lectureVo.setLove_cnt(love_cnt);

        // 좋아요 본인여부
        if(loginVo != null) {
            LoveVo love = new LoveVo();
            love.setLecture_idx(lecture_idx);
            love.setReg_id(loginVo.getUser_id());
            int check = lectureService.selectLoveCountBySelf(love);
            if(check != 0) {
                lectureVo.setLove_self_yn("Y");
            }
        }

        // 프로그램 상태 체크
        // 1. 접수대기 : 접수날짜 도래 하지 않음
        // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
        // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
        // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
        // 5. 교육전 :
        // 6. 교육중 : 교육날짜 내
        // 7. 교육종료 : 교육날짜 지남
        // 8. 외부홈페이지 : 외부 홈페이지일 경우
        int code = Util.getProgramStatus(lectureVo);
        lectureVo.setStatus_code(code);

        model.addAttribute("lectureVo", lectureVo);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_love_insert.do", method = RequestMethod.POST)
    public String instrum_lib_love_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("loveVo") LoveVo loveVo,
                                      BindingResult bindingResult,
                                      Model model,
                                      SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/instrum_lib_program_view.do?lecture_idx=" + loveVo.getLecture_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                loveVo.setReg_id(loginVo.getUser_id());

                int count = lectureService.checkLoveDupByUserId(loveVo);
                if(count == 0) {
                    lectureService.insertLoveInfo(loveVo);

                    model.addAttribute("msg", "loc");
                    model.addAttribute("locurl", "/ssem/youth/campus/instrum_lib_program_view.do?lecture_idx=" + loveVo.getLecture_idx());
                } else {
                    lectureService.deleteLoveInfo(loveVo);

                    model.addAttribute("msg", "loc");
                    model.addAttribute("locurl", "/ssem/youth/campus/instrum_lib_program_view.do?lecture_idx=" + loveVo.getLecture_idx());
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_donate_insert.do", method = RequestMethod.GET)
    public String instrum_lib_donate_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_donate_insert";

        //bannerInit("INSTRUM", model);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/instrum_lib_donate_insert.do");
            model.addAttribute("altmsg", "로그인이 필요한 서비스입니다.");
            ret_url =  "common/message";
        } else {
            InstrumDntVo instrumDntVo = new InstrumDntVo();

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    instrumDntVo.setMob_1(tokens[0]);
                    instrumDntVo.setMob_2(tokens[1]);
                    instrumDntVo.setMob_3(tokens[2]);
                }
            }
            model.addAttribute("instrumDntVo", instrumDntVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_donate_insert.do", method = RequestMethod.POST)
    public String instrum_lib_donate_inproc(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("instrumDntVo") InstrumDntVo instrumDntVo,
                                    BindingResult bindingResult,
                                    Model model,
                                    SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : instrumDntVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(instrumDntVo);
                if(value instanceof String){
                    field.set(instrumDntVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url);
                model.addAttribute("altmsg", "로그인이 필요한 서비스입니다.");
                ret_url =  "common/message";
            } else {
                // 사진파일 처리
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "IT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    instrumDntVo.setAtch_file_id(atchFileId);
                    instrumDntVo.setReg_id(loginVo.getUser_id());

                    // 악기설명 엔터처리
                    /*String cont = instrumDntVo.getCont();
                    cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
                    instrumDntVo.setCont(cont);*/

                    campusService.insertInstrumDntInfo(instrumDntVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssem/youth/mypage/instrum_donation_list.do");
                    model.addAttribute("altmsg", "신청완료 되었습니다.");

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

    @RequestMapping("/youth/campus/instrum_lib_review_list.do")
    public String instrum_lib_review_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_review_list";

        //bannerInit("INSTRUM", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        for (Field field : searchVo.getClass().getDeclaredFields()){
            field.setAccessible(true);
            Object value=field.get(searchVo);
            if(value instanceof String){
                field.set(searchVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
            }
        }

        List<InstrumReviewVo> itemList = campusService.selectInstrumReviewList(searchVo);
        for(InstrumReviewVo instrumReviewVo : itemList ) {
            //썸네일 처리
            String thumbFileId = instrumReviewVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            instrumReviewVo.setThumbFileList(thumbFileList);

            // 내용 한 줄 처리
            instrumReviewVo.setCont(StringUtil.getOneLine(instrumReviewVo.getCont()));
        }
        int totalCount = campusService.selectInstrumReviewListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/instrum_lib_review_view.do", method = RequestMethod.GET)
    public String instrum_lib_review_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/instrum_lib_review_view";

        //bannerInit("INSTRUM", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        int instrum_review_idx = ServletRequestUtils.getIntParameter(request, "instrum_review_idx", 0);

        InstrumReviewVo instrumReviewVo = new InstrumReviewVo();
        instrumReviewVo.setInstrum_review_idx(instrum_review_idx);

        campusService.updateInstrumReviewViewCnt(instrumReviewVo);
        instrumReviewVo = campusService.selectInstrumReviewInfo(instrumReviewVo);

        //썸네일 처리
        String thumbFileId = instrumReviewVo.getThumb_atch_file_id();
        String thumb_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo thumbfvo = new FileVo();
        thumbfvo.setAtch_file_id(thumbFileId);
        List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
        for(FileVo fileVo : thumbFileList){
            fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
        }
        instrumReviewVo.setThumbFileList(thumbFileList);

        // 첨부파일 처리
        String atchFileId = instrumReviewVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        instrumReviewVo.setFileList(fileVoList);

        // 이전/다음 목록 가져오기
        InstrumReviewVo next = campusService.selectNextInstrumReview(instrumReviewVo);
        InstrumReviewVo prev = campusService.selectPrevInstrumReview(instrumReviewVo);

        if (next != null) {
            instrumReviewVo.setNext(next);
            instrumReviewVo.setNext_idx((int)next.getInstrum_review_idx());
        }

        if (prev != null) {
            instrumReviewVo.setPrev(prev);
            instrumReviewVo.setPrev_idx((int)prev.getInstrum_review_idx());
        }

        model.addAttribute("instrumReviewVo", instrumReviewVo);

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
