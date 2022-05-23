package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.common.SafeHtmlUtil;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.LectureService;
import kr.go.songpa.ssem.util.StringUtil;
import kr.go.songpa.ssem.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-12-06
 * Description :
 * History :
 * Version :
 */
@Controller
public class SearchController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private LectureService lectureService;

    public SearchController() {
    }

    @RequestMapping("/intro/search/youth_search.do")
    public String intro_youth_search(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth_search";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 20);
        this.getModel(request, model, 20);

        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : itemList) {
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
        }
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 20);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        // 홈페이지 구분
        searchVo.setSearchVal4("S");

        int senior_cnt = lectureService.selectLectureListTotal(searchVo);
        model.addAttribute("senior_cnt", senior_cnt);

        return ret_url;
    }

    @RequestMapping("/intro/search/senior_search.do")
    public String intro_senior_search(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior_search";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 20);
        this.getModel(request, model, 20);

        // 홈페이지 구분
        searchVo.setSearchVal4("S");

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : itemList) {
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
        }
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 20);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        int youth_cnt = lectureService.selectLectureListTotal(searchVo);
        model.addAttribute("youth_cnt", youth_cnt);

        return ret_url;
    }

    @RequestMapping("/youth/search/search.do")
    public String youth_search(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/search/search";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 20);
        this.getModel(request, model, 20);

        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : itemList) {
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
        }
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 20);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping("/senior/search/search.do")
    public String senior_search(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/search/search";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 20);
        this.getModel(request, model, 20);

        // 홈페이지 구분
        searchVo.setSearchVal4("S");

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
        }
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 20);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping("/songpacenter/search/search.do")
    public String songpacenter_search(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "songpacenter/search/search";

        int group_idx = appService.selectGroupIdx("송파청소년센터");

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 20);
        this.getModel(request, model, 20);

        // 소속 정보 셋팅
        searchVo.setSearchVal3(String.valueOf(group_idx));
        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : itemList) {
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
        }
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 20);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping("/machuncenter/search/search.do")
    public String machuncenter_search(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "machuncenter/search/search";

        int group_idx = appService.selectGroupIdx("마천청소년센터");

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 20);
        this.getModel(request, model, 20);

        // 소속 정보 셋팅
        searchVo.setSearchVal3(String.valueOf(group_idx));
        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : itemList) {
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
        }
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 20);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping("/jamsilcenter/search/search.do")
    public String jamsilcenter_search(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "jamsilcenter/search/search";

        int group_idx = appService.selectGroupIdx("잠실청소년센터");

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 20);
        this.getModel(request, model, 20);

        // 소속 정보 셋팅
        searchVo.setSearchVal3(String.valueOf(group_idx));
        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : itemList) {
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
        }
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 20);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping("/futurecenter/search/search.do")
    public String futurecenter_search(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "futurecenter/search/search";

        int group_idx = appService.selectGroupIdx("구립송파청소년미래센터");

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 20);
        this.getModel(request, model, 20);

        // 소속 정보 셋팅
        searchVo.setSearchVal3(String.valueOf(group_idx));
        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : itemList) {
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
        }
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 20);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping("/dream/search/search.do")
    public String dream_search(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "dream/search/search";

        int group_idx = appService.selectGroupIdx("송파진로체험지원센터");

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request, 20);
        this.getModel(request, model, 20);

        // 소속 정보 셋팅
        searchVo.setSearchVal3(String.valueOf(group_idx));
        // 홈페이지 구분
        searchVo.setSearchVal4("J");

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
        for(LectureVo lectureVo : itemList) {
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
        }
        int totalCount = lectureService.selectLectureListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 20);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }
}
