package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.common.SafeHtmlUtil;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.BbsService;
import kr.go.songpa.ssem.service.FileMngService;
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
 * Date : 2020-12-01
 * Description :
 * History :
 * Version :
 */
@Controller
public class SsemController extends CommonController {

    @Autowired
    private BbsService bbsService;

    @Autowired
    private FileMngService fileMngService;

    public SsemController() {
    }

    @RequestMapping(value = "/youth/ssem/vision.do", method = RequestMethod.GET)
    public String youth_ssem_vision(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/ssem/vision";

        return ret_url;
    }

    @RequestMapping(value = "/youth/ssem/organ.do", method = RequestMethod.GET)
    public String youth_ssem_organ(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/ssem/organ";

        return ret_url;
    }

    @RequestMapping("/youth/ssem/notice_list.do")
    public String youth_ssem_notice_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/ssem/notice_list";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        searchVo.setSearchVal3("B");
        searchVo.setSearchKind2("Y");

        for (Field field : searchVo.getClass().getDeclaredFields()){
            field.setAccessible(true);
            Object value=field.get(searchVo);
            if(value instanceof String){
                field.set(searchVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
            }
        }

        List<BbsDetailVo> itemList = bbsService.selectBbsListEx(searchVo);
        int totalCount = bbsService.selectbbsListTotalEx(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/ssem/notice_view.do", method = RequestMethod.GET)
    public String youth_ssem_notice_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/ssem/notice_view";

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
        BbsDetailVo next = bbsService.selectNextBbsEx(bbsDetailVo);
        BbsDetailVo prev = bbsService.selectPrevBbsEx(bbsDetailVo);

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

    @RequestMapping("/youth/ssem/survey_list.do")
    public String youth_ssem_survey_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/ssem/survey_list";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        searchVo.setSearchKind("Y");

        List<SvyMstVo> itemList = bbsService.selectSurveyList(searchVo);
        for(SvyMstVo survey : itemList) {
            // 접수유무 확인
            String today = Util.getDate(1);
            if (Integer.valueOf(today) < Integer.valueOf(survey.getStart_dt().substring(0, 10).replaceAll("-", ""))) {
                survey.setSrv_yn("예정");
            } else if (Integer.valueOf(today) > Integer.valueOf(survey.getEnd_dt().substring(0, 10).replaceAll("-", ""))) {
                survey.setSrv_yn("종료");
            } else {
                survey.setSrv_yn("진행 중");
            }
        }
        int totalCount = bbsService.selectSurveyListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/youth/ssem/survey_insert.do", method = RequestMethod.GET)
    public String youth_ssem_survey_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/ssem/survey_insert";

        int svy_idx = ServletRequestUtils.getIntParameter(request, "svy_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/ssem/survey_insert.do?svy_idx=" + svy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            SvyMstVo svyMstVo = new SvyMstVo();
            svyMstVo.setSvy_idx(svy_idx);

            svyMstVo = bbsService.selectSurvey(svyMstVo);

            List<SvyQstVo> questList = bbsService.selectQuestList(svyMstVo);
            for(SvyQstVo quest : questList) {
                List<SvyItemVo> itemList = bbsService.selectItemList(quest);
                quest.setItemList(itemList);
            }

            svyMstVo.setQuestList(questList);

            model.addAttribute("svyMstVo", svyMstVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/ssem/survey_insert.do", method = RequestMethod.POST)
    public String youth_ssem_survey_inproc(final MultipartHttpServletRequest multiRequest,
                                @ModelAttribute("svyMstVo") SvyMstVo svyMstVo,
                                BindingResult bindingResult,
                                Model model,
                                SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/youth/ssem/survey_insert.do?svy_idx=" + svyMstVo.getSvy_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                // 설문 참여여부확인
                SvyMstVo survey = new SvyMstVo();
                survey.setSvy_idx(svyMstVo.getSvy_idx());
                survey.setReg_id(loginVo.getUser_id());

                int check = bbsService.checkSurveyReply(survey);
                if (check > 0) {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "이미 설문조사에 참여하셨습니다.");

                    return ret_url;
                }

                List<SvyQstVo> questList = svyMstVo.getQuestList();
                for(SvyQstVo quest : questList) {
                    SvyRpyVo surveyReplyVo = new SvyRpyVo();

                    surveyReplyVo.setReg_id(loginVo.getUser_id());
                    surveyReplyVo.setSvy_idx(svyMstVo.getSvy_idx());
                    surveyReplyVo.setSvy_qst_idx(quest.getSvy_qst_idx());
                    String type = quest.getType();
                    if("S".equals(type)) {
                        surveyReplyVo.setSvy_item_idx(Integer.valueOf(quest.getSelect_item_idx()));
                        surveyReplyVo.setRpy_yn("Y");

                        bbsService.insertSurveyReplyInfo(surveyReplyVo);
                    } else if ("M".equals(type)) {
                        surveyReplyVo.setRpy_yn("Y");

                        String[] tokens = quest.getSelect_item_idx().split(",");
                        for(String token : tokens) {
                            surveyReplyVo.setSvy_item_idx(Integer.valueOf(token));

                            bbsService.insertSurveyReplyInfo(surveyReplyVo);
                        }
                    } else {
                        surveyReplyVo.setSvy_item_idx(Integer.valueOf(quest.getSelect_item_idx()));
                        surveyReplyVo.setRpy_yn("Y");
                        surveyReplyVo.setAnswer(quest.getAnswer());
                        //surveyReplyVo.setAnswer(EgovWebUtil.clearXSSMinimum(quest.getAnswer()));

                        bbsService.insertSurveyReplyInfo(surveyReplyVo);
                    }
                }

                bbsService.updateSurveyReplyCnt(svyMstVo.getSvy_idx());

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/youth/ssem/survey_insert_ok.do?svy_idx=" + svyMstVo.getSvy_idx());
                model.addAttribute("altmsg", "설문조사가 완료되었습니다.");

            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "설문정보 등록에 실패 하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/youth/ssem/survey_preview.do", method = RequestMethod.GET)
    public String youth_ssem_survey_preview(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/ssem/survey_preview";

        int svy_idx = ServletRequestUtils.getIntParameter(request, "svy_idx", 0);

        SvyMstVo svyMstVo = new SvyMstVo();
        svyMstVo.setSvy_idx(svy_idx);

        svyMstVo = bbsService.selectSurvey(svyMstVo);

        List<SvyQstVo> questList = bbsService.selectQuestList(svyMstVo);
        for(SvyQstVo quest : questList) {
            List<SvyItemVo> itemList = bbsService.selectItemList(quest);
            quest.setItemList(itemList);
        }

        svyMstVo.setQuestList(questList);

        model.addAttribute("svyMstVo", svyMstVo);

        return ret_url;
    }

    @RequestMapping(value = "/youth/ssem/survey_insert_ok.do", method = RequestMethod.GET)
    public String youth_ssem_survey_insert_ok(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/ssem/survey_insert_ok";

        int svy_idx = ServletRequestUtils.getIntParameter(request, "svy_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        SvyMstVo svyMstVo = new SvyMstVo();
        svyMstVo.setSvy_idx(svy_idx);

        svyMstVo = bbsService.selectSurvey(svyMstVo);

        List<SvyQstVo> questList = bbsService.selectQuestList(svyMstVo);
        for(SvyQstVo quest : questList) {
            List<SvyItemVo> itemList = bbsService.selectItemList(quest);

            for(SvyItemVo item : itemList) {
                List<SvyRpyVo> replyList = bbsService.selectReplyList(item);
                int item_cnt = replyList.size();
                int tot_cnt = bbsService.selectQuestTotalReply(item);

                if(tot_cnt == 0) break;

                double percent = (double) item_cnt / (double) tot_cnt * 100.0;

                item.setTot_reply_cnt(item_cnt);
                item.setReply_percent(String.format("%.2f", percent) + "%");

                item.setReplyList(replyList);
            }

            quest.setItemList(itemList);
        }

        svyMstVo.setQuestList(questList);

        model.addAttribute("svyMstVo", svyMstVo);

        return ret_url;
    }

    @RequestMapping(value = "/youth/ssem/qna.do", method = RequestMethod.GET)
    public String youth_ssem_qna(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "youth/ssem/qna";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        searchVo.setSearchKind("PORTAL");
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

    @RequestMapping(value = "/senior/ssem/vision.do", method = RequestMethod.GET)
    public String senior_ssem_vision(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/ssem/vision";

        return ret_url;
    }

    @RequestMapping(value = "/senior/ssem/organ.do", method = RequestMethod.GET)
    public String senior_ssem_organ(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/ssem/organ";

        return ret_url;
    }

    @RequestMapping("/senior/ssem/notice_list.do")
    public String senior_ssem_notice_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/ssem/notice_list";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        searchVo.setSearchVal3("B");
        searchVo.setSearchKind2("Y");

        List<BbsDetailVo> itemList = bbsService.selectBbsListEx(searchVo);
        int totalCount = bbsService.selectbbsListTotalEx(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/senior/ssem/notice_view.do", method = RequestMethod.GET)
    public String senior_ssem_notice_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/ssem/notice_view";

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
        BbsDetailVo next = bbsService.selectNextBbsEx(bbsDetailVo);
        BbsDetailVo prev = bbsService.selectPrevBbsEx(bbsDetailVo);

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

    @RequestMapping("/senior/ssem/survey_list.do")
    public String senior_ssem_survey_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/ssem/survey_list";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        searchVo.setSearchKind("Y");

        for (Field field : searchVo.getClass().getDeclaredFields()){
            field.setAccessible(true);
            Object value=field.get(searchVo);
            if(value instanceof String){
                field.set(searchVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
            }
        }

        List<SvyMstVo> itemList = bbsService.selectSurveyList(searchVo);
        for(SvyMstVo survey : itemList) {
            // 접수유무 확인
            String today = Util.getDate(1);
            if (Integer.valueOf(today) < Integer.valueOf(survey.getStart_dt().substring(0, 10).replaceAll("-", ""))) {
                survey.setSrv_yn("예정");
            } else if (Integer.valueOf(today) > Integer.valueOf(survey.getEnd_dt().substring(0, 10).replaceAll("-", ""))) {
                survey.setSrv_yn("종료");
            } else {
                survey.setSrv_yn("진행 중");
            }
        }
        int totalCount = bbsService.selectSurveyListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/senior/ssem/survey_insert.do", method = RequestMethod.GET)
    public String senior_ssem_survey_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/ssem/survey_insert";

        int svy_idx = ServletRequestUtils.getIntParameter(request, "svy_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/ssem/survey_insert.do?svy_idx=" + svy_idx);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            SvyMstVo svyMstVo = new SvyMstVo();
            svyMstVo.setSvy_idx(svy_idx);

            svyMstVo = bbsService.selectSurvey(svyMstVo);

            List<SvyQstVo> questList = bbsService.selectQuestList(svyMstVo);
            for(SvyQstVo quest : questList) {
                List<SvyItemVo> itemList = bbsService.selectItemList(quest);
                quest.setItemList(itemList);
            }

            svyMstVo.setQuestList(questList);

            model.addAttribute("svyMstVo", svyMstVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/ssem/survey_insert.do", method = RequestMethod.POST)
    public String senior_ssem_survey_inproc(final MultipartHttpServletRequest multiRequest,
                                           @ModelAttribute("svyMstVo") SvyMstVo svyMstVo,
                                           BindingResult bindingResult,
                                           Model model,
                                           SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            /*for (Field field : memberVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(memberVo);
                if(value instanceof String){
                    field.set(memberVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
                }
            }*/

            HttpSession session = multiRequest.getSession();
            TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

            if(loginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/ssem/survey_insert.do?svy_idx=" + svyMstVo.getSvy_idx());
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
                ret_url =  "common/message";
            } else {
                // 설문 참여여부확인
                SvyMstVo survey = new SvyMstVo();
                survey.setSvy_idx(svyMstVo.getSvy_idx());
                survey.setReg_id(loginVo.getUser_id());

                int check = bbsService.checkSurveyReply(survey);
                if (check > 0) {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "이미 설문조사에 참여하셨습니다.");

                    return ret_url;
                }

                List<SvyQstVo> questList = svyMstVo.getQuestList();
                for(SvyQstVo quest : questList) {
                    SvyRpyVo surveyReplyVo = new SvyRpyVo();

                    surveyReplyVo.setReg_id(loginVo.getUser_id());
                    surveyReplyVo.setSvy_idx(svyMstVo.getSvy_idx());
                    surveyReplyVo.setSvy_qst_idx(quest.getSvy_qst_idx());
                    String type = quest.getType();
                    if("S".equals(type)) {
                        surveyReplyVo.setSvy_item_idx(Integer.valueOf(quest.getSelect_item_idx()));
                        surveyReplyVo.setRpy_yn("Y");

                        bbsService.insertSurveyReplyInfo(surveyReplyVo);
                    } else if ("M".equals(type)) {
                        surveyReplyVo.setRpy_yn("Y");

                        String[] tokens = quest.getSelect_item_idx().split(",");
                        for(String token : tokens) {
                            surveyReplyVo.setSvy_item_idx(Integer.valueOf(token));

                            bbsService.insertSurveyReplyInfo(surveyReplyVo);
                        }
                    } else {
                        surveyReplyVo.setSvy_item_idx(Integer.valueOf(quest.getSelect_item_idx()));
                        surveyReplyVo.setRpy_yn("Y");
                        surveyReplyVo.setAnswer(quest.getAnswer());
                        //surveyReplyVo.setAnswer(EgovWebUtil.clearXSSMinimum(quest.getAnswer()));

                        bbsService.insertSurveyReplyInfo(surveyReplyVo);
                    }
                }

                bbsService.updateSurveyReplyCnt(svyMstVo.getSvy_idx());

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/ssem/survey_insert_ok.do?svy_idx=" + svyMstVo.getSvy_idx());
                model.addAttribute("altmsg", "설문조사가 완료되었습니다.");

            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "설문정보 등록에 실패 하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/ssem/survey_preview.do", method = RequestMethod.GET)
    public String senior_ssem_survey_preview(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/ssem/survey_preview";

        int svy_idx = ServletRequestUtils.getIntParameter(request, "svy_idx", 0);

        SvyMstVo svyMstVo = new SvyMstVo();
        svyMstVo.setSvy_idx(svy_idx);

        svyMstVo = bbsService.selectSurvey(svyMstVo);

        List<SvyQstVo> questList = bbsService.selectQuestList(svyMstVo);
        for(SvyQstVo quest : questList) {
            List<SvyItemVo> itemList = bbsService.selectItemList(quest);
            quest.setItemList(itemList);
        }

        svyMstVo.setQuestList(questList);

        model.addAttribute("svyMstVo", svyMstVo);

        return ret_url;
    }

    @RequestMapping(value = "/senior/ssem/survey_insert_ok.do", method = RequestMethod.GET)
    public String senior_ssem_survey_insert_ok(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/ssem/survey_insert_ok";

        int svy_idx = ServletRequestUtils.getIntParameter(request, "svy_idx", 0);

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        SvyMstVo svyMstVo = new SvyMstVo();
        svyMstVo.setSvy_idx(svy_idx);

        svyMstVo = bbsService.selectSurvey(svyMstVo);

        List<SvyQstVo> questList = bbsService.selectQuestList(svyMstVo);
        for(SvyQstVo quest : questList) {
            List<SvyItemVo> itemList = bbsService.selectItemList(quest);

            for(SvyItemVo item : itemList) {
                List<SvyRpyVo> replyList = bbsService.selectReplyList(item);
                int item_cnt = replyList.size();
                int tot_cnt = bbsService.selectQuestTotalReply(item);

                if(tot_cnt == 0) break;

                double percent = (double) item_cnt / (double) tot_cnt * 100.0;

                item.setTot_reply_cnt(item_cnt);
                item.setReply_percent(String.format("%.2f", percent) + "%");

                item.setReplyList(replyList);
            }

            quest.setItemList(itemList);
        }

        svyMstVo.setQuestList(questList);

        model.addAttribute("svyMstVo", svyMstVo);

        return ret_url;
    }

    @RequestMapping(value = "/senior/ssem/qna.do", method = RequestMethod.GET)
    public String senior_ssem_qna(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/ssem/qna";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        searchVo.setSearchKind("PORTAL");
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
}
