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
public class CampusEtcController extends CommonController {

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    @Autowired
    private CampusService campusService;

    @Autowired
    private BbsService bbsService;

    @Autowired
    private AppService appService;

    @Autowired
    private LectureService lectureService;


    public CampusEtcController() {
    }

    @RequestMapping(value = "/youth/campus/future_main.do", method = RequestMethod.GET)
    public String future_main(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/future_main";

        bannerInit("FEDU", model);

        // 미래교육센터 프로그램 리스트 8개
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 8);
        this.getModel(request, model, 8);

        // 소속 정보 셋팅
        List<String> idxList = appService.selectGroupIdxList("미래교육센터");
        searchVo.setSearchArrayVal(idxList);
        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        List<LectureVo> lectureList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : lectureList) {
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
        model.addAttribute("lectureList", lectureList);

        // 미래교육센터 센터 소개
        List<FutureEduIntroVo> introList = campusService.selectFutureEduIntroMainList();
        for(FutureEduIntroVo futureEduIntroVo : introList ) {
            //썸네일 처리
            String thumbFileId = futureEduIntroVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            futureEduIntroVo.setThumbFileList(thumbFileList);
        }
        model.addAttribute("introList", introList);

        // 미래교육센터 이용후기
        List<FutureEduReviewVo> reviewList = campusService.selectFutureEduReviewMainList();
        for(FutureEduReviewVo futureEduReviewVo : reviewList ) {
            //썸네일 처리
            String thumbFileId = futureEduReviewVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            futureEduReviewVo.setThumbFileList(thumbFileList);
        }
        model.addAttribute("reviewList", reviewList);

        // 미래교육센터 공지사항 목록 최대 4개
        BbsDetailVo bbsDetailVo = new BbsDetailVo();
        bbsDetailVo.setArray_group_idx(idxList);
        //bbsDetailVo.setGroup_idx(group_idx);
        bbsDetailVo.setGubun("PORTAL");
        bbsDetailVo.setType_cd("B");

        List<BbsDetailVo> noticeList = bbsService.selectNoticeMainList(bbsDetailVo);
        model.addAttribute("noticeList", noticeList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/future_intro.do", method = RequestMethod.GET)
    public String future_intro(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/future_intro";

        //bannerInit("FEDU", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 14);
        this.getModel(request, model, 14);

        List<FutureEduIntroVo> itemList = campusService.selectFutureEduIntroList(searchVo);
        for(FutureEduIntroVo futureEduIntroVo : itemList ) {
            //썸네일 처리
            String thumbFileId = futureEduIntroVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            futureEduIntroVo.setThumbFileList(thumbFileList);

            //썸네일 처리 서브1
            String thumbFileId1 = futureEduIntroVo.getThumb_sub_file_id1();
            FileVo thumbfvo1 = new FileVo();
            thumbfvo1.setAtch_file_id(thumbFileId1);
            List<FileVo> thumbSubFileList1 = fileMngService.selectFileInfs(thumbfvo1);
            for(FileVo fileVo : thumbSubFileList1){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            futureEduIntroVo.setThumbSubFileList1(thumbSubFileList1);

            //썸네일 처리 서브2
            String thumbFileId2 = futureEduIntroVo.getThumb_sub_file_id2();
            FileVo thumbfvo2 = new FileVo();
            thumbfvo2.setAtch_file_id(thumbFileId2);
            List<FileVo> thumbSubFileList2 = fileMngService.selectFileInfs(thumbfvo2);
            for(FileVo fileVo : thumbSubFileList2){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            futureEduIntroVo.setThumbSubFileList2(thumbSubFileList2);

            // 프로그램 엔터처리
            String cont = futureEduIntroVo.getCont();
            if(!"".equals(Util.nvl(cont))) {
                cont = cont.replaceAll(System.getProperty("line.separator"), "<br/>");
                futureEduIntroVo.setCont(cont);
            }

            // 이용안내 엔터처리
            String explain = futureEduIntroVo.getExplain();
            if(!"".equals(Util.nvl(explain))) {
                explain = explain.replaceAll(System.getProperty("line.separator"), "<br/>");
                futureEduIntroVo.setExplain(explain);
            }
        }
        int totalCount = campusService.selectFutureEduIntroListTotal(searchVo);

        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/future_drone.do", method = RequestMethod.GET)
    public String future_drone(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/future_drone";

        //bannerInit("FEDU", model);

        return ret_url;
    }

    @RequestMapping("/youth/campus/future_program_list.do")
    public String future_program_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/future_program_list";

        //bannerInit("FEDU", model);

        List<String> idxList = appService.selectGroupIdxList("미래교육센터");

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 12);
        this.getModel(request, model, 12);

        searchVo.setSearchArrayVal(idxList);

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

    @RequestMapping(value = "/youth/campus/future_program_view.do", method = RequestMethod.GET)
    public String future_program_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/future_program_view";

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

    @RequestMapping(value = "/youth/campus/future_love_insert.do", method = RequestMethod.POST)
    public String future_love_inproc(final MultipartHttpServletRequest multiRequest,
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
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/future_program_view.do?lecture_idx=" + loveVo.getLecture_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                loveVo.setReg_id(loginVo.getUser_id());

                int count = lectureService.checkLoveDupByUserId(loveVo);
                if(count == 0) {
                    lectureService.insertLoveInfo(loveVo);

                    model.addAttribute("msg", "loc");
                    model.addAttribute("locurl", "/ssem/youth/campus/future_program_view.do?lecture_idx=" + loveVo.getLecture_idx());
                } else {
                    lectureService.deleteLoveInfo(loveVo);

                    model.addAttribute("msg", "loc");
                    model.addAttribute("locurl", "/ssem/youth/campus/future_program_view.do?lecture_idx=" + loveVo.getLecture_idx());
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

    @RequestMapping("/youth/campus/future_review_list.do")
    public String future_review_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/future_review_list";

        //bannerInit("FEDU", model);

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

        List<FutureEduReviewVo> itemList = campusService.selectFutureEduReviewList(searchVo);
        for(FutureEduReviewVo futureEduReviewVo : itemList ) {
            //썸네일 처리
            String thumbFileId = futureEduReviewVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            futureEduReviewVo.setThumbFileList(thumbFileList);

            // 내용 한 줄 처리
            futureEduReviewVo.setCont(StringUtil.getOneLine(futureEduReviewVo.getCont()));
        }
        int totalCount = campusService.selectFutureEduReviewListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/future_review_view.do", method = RequestMethod.GET)
    public String future_review_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/future_review_view";

        //bannerInit("FEDU", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        int future_edu_review_idx = ServletRequestUtils.getIntParameter(request, "future_edu_review_idx", 0);

        FutureEduReviewVo futureEduReviewVo = new FutureEduReviewVo();
        futureEduReviewVo.setFuture_edu_review_idx(future_edu_review_idx);

        campusService.updateFutureEduReviewViewCnt(futureEduReviewVo);
        futureEduReviewVo = campusService.selectFutureEduReviewInfo(futureEduReviewVo);

        //썸네일 처리
        String thumbFileId = futureEduReviewVo.getThumb_atch_file_id();
        String thumb_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo thumbfvo = new FileVo();
        thumbfvo.setAtch_file_id(thumbFileId);
        List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
        for(FileVo fileVo : thumbFileList){
            fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
        }
        futureEduReviewVo.setThumbFileList(thumbFileList);

        // 첨부파일 처리
        String atchFileId = futureEduReviewVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        futureEduReviewVo.setFileList(fileVoList);

        // 이전/다음 목록 가져오기
        FutureEduReviewVo next = campusService.selectNextFutureReview(futureEduReviewVo);
        FutureEduReviewVo prev = campusService.selectPrevFutureReview(futureEduReviewVo);

        if (next != null) {
            futureEduReviewVo.setNext(next);
            futureEduReviewVo.setNext_idx((int)next.getFuture_edu_review_idx());
        }

        if (prev != null) {
            futureEduReviewVo.setPrev(prev);
            futureEduReviewVo.setPrev_idx((int)prev.getFuture_edu_review_idx());
        }

        model.addAttribute("futureEduReviewVo", futureEduReviewVo);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/self_main.do", method = RequestMethod.GET)
    public String self_main(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/self_main";

        bannerInit("SELF", model);

        int group_idx = appService.selectGroupIdx("송파구 진학학습지원센터");
        // 자기주도학습관 프로그램 리스트 8개
        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 8);
        this.getModel(request, model, 8);

        // 소속 정보 셋팅
        searchVo.setSearchVal3(String.valueOf(group_idx));
        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        List<LectureVo> lectureList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : lectureList) {
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
        model.addAttribute("lectureList", lectureList);

        // 자기주도학습관 진학학습정보
        List<SelfEduIntroVo> eduList = campusService.selectSelfEduIntroMainList();
        for(SelfEduIntroVo selfEduIntroVo : eduList ) {
            //썸네일 처리
            String thumbFileId = selfEduIntroVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            selfEduIntroVo.setThumbFileList(thumbFileList);

            // 내용 한 줄 처리
            //futureEduReviewVo.setCont(StringUtil.getOneLine(futureEduReviewVo.getCont()));
        }
        model.addAttribute("eduList", eduList);

        // 자기주도학습관 공지사항 목록 최대 4개
        BbsDetailVo bbsDetailVo = new BbsDetailVo();
        bbsDetailVo.setGroup_idx(group_idx);
        bbsDetailVo.setGubun("PORTAL");
        bbsDetailVo.setType_cd("B");

        List<BbsDetailVo> noticeList = bbsService.selectNoticeMainList(bbsDetailVo);
        model.addAttribute("noticeList", noticeList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/self_intro.do", method = RequestMethod.GET)
    public String self_intro(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/self_intro";

        //bannerInit("SELF", model);

        return ret_url;
    }

    @RequestMapping("/youth/campus/self_study_list.do")
    public String self_study_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/self_study_list";

        //bannerInit("SELF", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 12);
        this.getModel(request, model, 12);

        for (Field field : searchVo.getClass().getDeclaredFields()){
            field.setAccessible(true);
            Object value=field.get(searchVo);
            if(value instanceof String){
                field.set(searchVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
            }
        }

        List<SelfEduIntroVo> itemList = campusService.selectSelfEduIntroList(searchVo);
        for(SelfEduIntroVo selfEduIntroVo : itemList ) {
            //썸네일 처리
            String thumbFileId = selfEduIntroVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            selfEduIntroVo.setThumbFileList(thumbFileList);

            // 내용 한 줄 처리
            //futureEduReviewVo.setCont(StringUtil.getOneLine(futureEduReviewVo.getCont()));
        }
        int totalCount = campusService.selectSelfEduIntroListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 12);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/self_study_view.do", method = RequestMethod.GET)
    public String self_study_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/self_study_view";

        //bannerInit("SELF", model);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        int self_edu_intro_idx = ServletRequestUtils.getIntParameter(request, "self_edu_intro_idx", 0);

        SelfEduIntroVo selfEduIntroVo = new SelfEduIntroVo();
        selfEduIntroVo.setSelf_edu_intro_idx(self_edu_intro_idx);

        campusService.updateSelfEduIntroViewCnt(selfEduIntroVo);
        selfEduIntroVo = campusService.selectSelfEduIntroInfo(selfEduIntroVo);

        //썸네일 처리
        String thumbFileId = selfEduIntroVo.getThumb_atch_file_id();
        String thumb_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo thumbfvo = new FileVo();
        thumbfvo.setAtch_file_id(thumbFileId);
        List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
        for(FileVo fileVo : thumbFileList){
            fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
        }
        selfEduIntroVo.setThumbFileList(thumbFileList);

        // 첨부파일 처리
        String atchFileId = selfEduIntroVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        selfEduIntroVo.setFileList(fileVoList);

        // 이전/다음 목록 가져오기
        SelfEduIntroVo next = campusService.selectNextSelfIntro(selfEduIntroVo);
        SelfEduIntroVo prev = campusService.selectPrevSelfIntro(selfEduIntroVo);

        if (next != null) {
            selfEduIntroVo.setNext(next);
            selfEduIntroVo.setNext_idx((int)next.getSelf_edu_intro_idx());
        }

        if (prev != null) {
            selfEduIntroVo.setPrev(prev);
            selfEduIntroVo.setPrev_idx((int)prev.getSelf_edu_intro_idx());
        }

        model.addAttribute("selfEduIntroVo", selfEduIntroVo);

        return ret_url;
    }

    @RequestMapping("/youth/campus/self_program_list.do")
    public String self_program_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/self_program_list";

        //bannerInit("SELF", model);

        int group_idx = appService.selectGroupIdx("송파구 진학학습지원센터");

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
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount,12);

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

    @RequestMapping(value = "/youth/campus/self_program_view.do", method = RequestMethod.GET)
    public String self_program_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/self_program_view";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        //bannerInit("SELF", model);

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

    @RequestMapping(value = "/youth/campus/self_love_insert.do", method = RequestMethod.POST)
    public String self_love_inproc(final MultipartHttpServletRequest multiRequest,
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
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/self_program_view.do?lecture_idx=" + loveVo.getLecture_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                loveVo.setReg_id(loginVo.getUser_id());

                int count = lectureService.checkLoveDupByUserId(loveVo);
                if(count == 0) {
                    lectureService.insertLoveInfo(loveVo);

                    model.addAttribute("msg", "loc");
                    model.addAttribute("locurl", "/ssem/youth/campus/self_program_view.do?lecture_idx=" + loveVo.getLecture_idx());
                } else {
                    lectureService.deleteLoveInfo(loveVo);

                    model.addAttribute("msg", "loc");
                    model.addAttribute("locurl", "/ssem/youth/campus/self_program_view.do?lecture_idx=" + loveVo.getLecture_idx());
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

    @RequestMapping(value = "/youth/campus/self_counsel_insert.do", method = RequestMethod.GET)
    public String self_counsel_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/self_counsel_insert";

        //bannerInit("SELF", model);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/campus/self_counsel_insert.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            SelfCounselVo selfCounselVo = new SelfCounselVo();

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    selfCounselVo.setMob_1(tokens[0]);
                    selfCounselVo.setMob_2(tokens[1]);
                    selfCounselVo.setMob_3(tokens[2]);
                }
            }

            model.addAttribute("selfCounselVo", selfCounselVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/self_counsel_insert.do", method = RequestMethod.POST)
    public String self_counsel_inproc(final MultipartHttpServletRequest multiRequest,
                                            @ModelAttribute("selfCounselVo") SelfCounselVo selfCounselVo,
                                            BindingResult bindingResult,
                                            Model model,
                                            SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : selfCounselVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(selfCounselVo);
                if(value instanceof String){
                    field.set(selfCounselVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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

                // 첨부파일 처리
                CommonVo thumb_img = this.getAttachFileInfoEx(multiRequest, "atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "SELF_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        thumbFileid = fileMngService.insertFileInfs(result);
                    }

                    selfCounselVo.setAtch_file_id(thumbFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                selfCounselVo.setReg_id(loginVo.getUser_id());

                // 신청자 메모 엔터처리
                /*String apy_memo = selfCounselVo.getApy_memo();
                apy_memo = apy_memo.replaceAll(System.getProperty("line.separator"), "<br/>");
                selfCounselVo.setApy_memo(apy_memo);*/

                campusService.insertSelfCounselInfo(selfCounselVo);

                model.addAttribute("msg", "loc");
                model.addAttribute("locurl", "/ssem/youth/campus/self_counsel_insert_ok.do?self_counsel_idx=" + selfCounselVo.getSelf_counsel_idx());
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "신청에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/self_counsel_insert_ok.do", method = RequestMethod.GET)
    public String self_counsel_insert_ok(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/self_counsel_insert_ok";

        //bannerInit("SELF", model);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            int self_counsel_idx = ServletRequestUtils.getIntParameter(request, "self_counsel_idx", 0);

            SelfCounselVo selfCounselVo = new SelfCounselVo();
            selfCounselVo.setSelf_counsel_idx(self_counsel_idx);

            selfCounselVo = campusService.selectSelfEduCounselInfo(selfCounselVo);

            // 첨부파일 처리
            String atchFileId = selfCounselVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            selfCounselVo.setFileList(fileVoList);

            model.addAttribute("selfCounselVo", selfCounselVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/songpa_vision.do", method = RequestMethod.GET)
    public String songpa_vision(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/songpa_vision";

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/songpa_biz.do", method = RequestMethod.GET)
    public String songpa_biz(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/songpa_biz";

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/songpa_group.do", method = RequestMethod.GET)
    public String songpa_group(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/songpa_group";

        return ret_url;
    }

    @RequestMapping("/youth/campus/songpa_gallery_list.do")
    public String songpa_gallery_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/songpa_gallery_list";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 12);
        this.getModel(request, model, 12);

        searchVo.setSearchKind("SONGEDU");
        searchVo.setSearchVal3("G");
        searchVo.setSearchKind2("Y");

        List<BbsDetailVo> itemList = bbsService.selectBbsList(searchVo);
        for(BbsDetailVo bbs : itemList) {
            //썸네일 처리
            String thumbFileId = bbs.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            bbs.setThumbFileList(thumbFileList);
        }
        int totalCount = bbsService.selectbbsListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 12);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/campus/songpa_gallery_view.do", method = RequestMethod.GET)
    public String songpa_gallery_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/campus/songpa_gallery_view";

        int bbs_detail_idx = ServletRequestUtils.getIntParameter(request, "bbs_detail_idx", 0);

        BbsDetailVo bbsDetailVo = new BbsDetailVo();
        bbsDetailVo.setBbs_detail_idx(bbs_detail_idx);

        bbsService.updateBbsViewCnt(bbsDetailVo);
        bbsDetailVo = bbsService.selectBbsInfo(bbsDetailVo);

        //썸네일 처리
        String thumbFileId = bbsDetailVo.getThumb_atch_file_id();
        String thumb_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo thumbfvo = new FileVo();
        thumbfvo.setAtch_file_id(thumbFileId);
        List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
        for(FileVo fileVo : thumbFileList){
            fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
        }
        bbsDetailVo.setThumbFileList(thumbFileList);

        // 첨부파일 처리
        String atchFileId = bbsDetailVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        bbsDetailVo.setFileList(fileVoList);

        // 이전/다음 목록 가져오기
        BbsDetailVo next = bbsService.selectNextBbs(bbsDetailVo);
        BbsDetailVo prev = bbsService.selectPrevBbs(bbsDetailVo);

        if (next != null) {
            bbsDetailVo.setNext(next);
            bbsDetailVo.setNext_idx((int)next.getBbs_detail_idx());
        }

        if (prev != null) {
            bbsDetailVo.setPrev(prev);
            bbsDetailVo.setPrev_idx((int)prev.getBbs_detail_idx());
        }

        model.addAttribute("bbsDetailVo", bbsDetailVo);

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
