package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.common.SafeHtmlUtil;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.BbsService;
import kr.go.songpa.ssem.service.FileMngService;
import kr.go.songpa.ssem.service.LectureService;
import kr.go.songpa.ssem.util.DateUtil;
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
 * Date : 2020-11-18
 * Description :
 * History :
 * Version :
 */
@Controller
public class CenterFutureController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private BbsService bbsService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private LectureService lectureService;

    public CenterFutureController() {
    }

    @RequestMapping(value = "/futurecenter/main/main.do", method = RequestMethod.GET)
    public String future_main(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/main/main";

        int group_idx = appService.selectGroupIdx("미래교육센터 오금Hub");
        // 송파청소년센터 메인 배너
        BannerVo bannerVo = new BannerVo();
        bannerVo.setGubun("FUTURE");
        bannerVo.setUse_yn("Y");
        bannerVo.setGroup_idx(group_idx);

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

        // 송파청소년센터 공지사항 목록 최대 4개
        BbsDetailVo bbsDetailVo = new BbsDetailVo();
        bbsDetailVo.setGroup_idx(group_idx);
        bbsDetailVo.setGubun("FUTURE");
        bbsDetailVo.setType_cd("B");

        List<BbsDetailVo> noticeList = bbsService.selectNoticeMainList(bbsDetailVo);
        model.addAttribute("noticeList", noticeList);

        return ret_url;
    }

    @RequestMapping(value = "/futurecenter/intro/intro.do", method = RequestMethod.GET)
    public String future_intro(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/intro/intro";

        return ret_url;
    }

    @RequestMapping("/futurecenter/program/program_list.do")
    public String future_program_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/program/program_list";

        int group_idx = appService.selectGroupIdx("미래교육센터 오금Hub");


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

    @RequestMapping(value = "/futurecenter/program/program_view.do", method = RequestMethod.GET)
    public String future_program_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/program/program_view";

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

        // 첨부파일 처리
        String atchFileId = lectureVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        lectureVo.setFileList(fileVoList);

        model.addAttribute("lectureVo", lectureVo);

        return ret_url;
    }

    @RequestMapping(value = "/futurecenter/program/love_insert.do", method = RequestMethod.POST)
    public String future_program_love_inproc(final MultipartHttpServletRequest multiRequest,
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
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/futurecenter/program/program_view.do?lecture_idx=" + loveVo.getLecture_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                loveVo.setReg_id(loginVo.getUser_id());

                int count = lectureService.checkLoveDupByUserId(loveVo);
                if(count == 0) {
                    lectureService.insertLoveInfo(loveVo);

                    model.addAttribute("msg", "loc");
                    model.addAttribute("locurl", "/ssem/futurecenter/program/program_view.do?lecture_idx=" + loveVo.getLecture_idx());
                } else {
                    lectureService.deleteLoveInfo(loveVo);

                    model.addAttribute("msg", "loc");
                    model.addAttribute("locurl", "/ssem/futurecenter/program/program_view.do?lecture_idx=" + loveVo.getLecture_idx());
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

    @RequestMapping(value = "/futurecenter/biz/major.do", method = RequestMethod.GET)
    public String future_biz_major(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/biz/major";

        return ret_url;
    }

    @RequestMapping(value = "/futurecenter/fac/intro.do", method = RequestMethod.GET)
    public String future_fac_intro(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/fac/intro";

        return ret_url;
    }

    @RequestMapping("/futurecenter/news/notice_list.do")
    public String future_news_notice_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/news/notice_list";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        searchVo.setSearchKind("FUTURE");
        searchVo.setSearchVal3("B");
        searchVo.setSearchKind2("Y");

        List<BbsDetailVo> itemList = bbsService.selectBbsList(searchVo);
        int totalCount = bbsService.selectbbsListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/futurecenter/news/notice_view.do", method = RequestMethod.GET)
    public String future_news_notice_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/news/notice_view";

        int bbs_detail_idx = ServletRequestUtils.getIntParameter(request, "bbs_detail_idx", 0);

        BbsDetailVo bbsDetailVo = new BbsDetailVo();
        bbsDetailVo.setBbs_detail_idx(bbs_detail_idx);

        bbsService.updateBbsViewCnt(bbsDetailVo);
        bbsDetailVo = bbsService.selectBbsInfo(bbsDetailVo);

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

    @RequestMapping(value = "/futurecenter/news/qna_list.do", method = RequestMethod.GET)
    public String future_news_qna_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/news/qna_list";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        searchVo.setSearchKind("FUTURE");
        searchVo.setSearchKind2("Y");
        searchVo.setSearchVal3("F");

        List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
        int totalCount = bbsService.selectbbsListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", bbsList);

        return ret_url;
    }

    @RequestMapping(value = "/futurecenter/main/privacy.do", method = RequestMethod.GET)
    public String main_privacy(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/main/privacy";

        return ret_url;
    }

    @RequestMapping(value = "/futurecenter/main/terms.do", method = RequestMethod.GET)
    public String main_terms(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/main/terms";

        return ret_url;
    }

    @RequestMapping(value = "/futurecenter/main/mail.do", method = RequestMethod.GET)
    public String main_mail(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/main/mail";

        return ret_url;
    }

    @RequestMapping(value = "/futurecenter/main/copyright.do", method = RequestMethod.GET)
    public String main_copyright(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/main/copyright";

        return ret_url;
    }
}
