package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.common.SafeHtmlUtil;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.ClubService;
import kr.go.songpa.ssem.service.FileMngService;
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
 * Date : 2020-11-24
 * Description :
 * History :
 * Version :
 */
@Controller
public class ForeverController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private ClubService clubService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    public ForeverController() {
    }

    @RequestMapping(value = "/senior/forever/history.do", method = RequestMethod.GET)
    public String forever_history(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/history";

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/history_two.do", method = RequestMethod.GET)
    public String forever_history_two(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/history_two";

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/vision.do", method = RequestMethod.GET)
    public String forever_vision(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/vision";

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/unesco.do", method = RequestMethod.GET)
    public String forever_unesco(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/unesco";

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/bylaw.do", method = RequestMethod.GET)
    public String forever_bylaw(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/bylaw";

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/learning_status.do", method = RequestMethod.GET)
    public String forever_learning_status(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/learning_status";

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/learning_tocome.do", method = RequestMethod.GET)
    public String forever_learning_tocome(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/learning_tocome";

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/circle_intro.do", method = RequestMethod.GET)
    public String forever_circle_intro(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/circle_intro";

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/circle_insert.do", method = RequestMethod.GET)
    public String forever_circle_insert(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/circle_insert";

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/circle_insert_form.do", method = RequestMethod.GET)
    public String forever_circle_insert_form(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/circle_insert_form";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/forever/circle_insert_form.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            ClubVo clubVo = new ClubVo();

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    clubVo.setMob_1(tokens[0]);
                    clubVo.setMob_2(tokens[1]);
                    clubVo.setMob_3(tokens[2]);
                }
            }

            model.addAttribute("clubVo", clubVo);

            List<CodeVo> codeList = appService.selectCodeList("CLUB_CATE");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/circle_insert_form.do", method = RequestMethod.POST)
    public String forever_circle_inproc(final MultipartHttpServletRequest multiRequest,
                                                  @ModelAttribute("clubVo") ClubVo clubVo,
                                                  BindingResult bindingResult,
                                                  Model model,
                                                  SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : clubVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(clubVo);
                if(value instanceof String){
                    field.set(clubVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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

                // 파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "CL_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }
                    clubVo.setAtch_file_id(atchFileId);
                    clubService.insertClubInfo(clubVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssem/senior/mypage/circle_reg_list.do");
                    model.addAttribute("altmsg", "동아리 등록 및 신청이 완료되었습니다..");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "등록에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/senior/forever/club_status_list.do")
    public String forever_club_status_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/club_status_list";

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        List<ClubStatusVo> itemList = clubService.selectClubStatusList(searchVo);
        int totalCount = clubService.selectClubStatusListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRow(request, totalCount);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);
        // 교육분야
        List<CodeVo> codeList = appService.selectCodeList("CLUB_CATE");
        model.addAttribute("codeList", codeList);

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/club_status_view.do", method = RequestMethod.GET)
    public String forever_club_status_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/club_status_view";

        int club_status_idx = ServletRequestUtils.getIntParameter(request, "club_status_idx", 0);

        ClubStatusVo clubStatusVo = new ClubStatusVo();
        clubStatusVo.setClub_status_idx(club_status_idx);

        clubStatusVo = clubService.selectClubStatusInfo(clubStatusVo);

        // 동아리소개 엔터처리
        String intro = clubStatusVo.getIntro();
        if(!"".equals(Util.nvl(intro))) {
            intro = intro.replaceAll(System.getProperty("line.separator"), "<br/>");
            clubStatusVo.setIntro(intro);
        }

        // 주요활동 엔터처리
        String action = clubStatusVo.getAction();
        if(!"".equals(Util.nvl(action))) {
            action = action.replaceAll(System.getProperty("line.separator"), "<br/>");
            clubStatusVo.setAction(action);
        }

        // 이전/다음 목록 가져오기
        /*ChannelStudyVo next = magnetService.selectNextChannelStudy(channelStudyVo);
        ChannelStudyVo prev = magnetService.selectPrevChannelStudy(channelStudyVo);

        if (next != null) {
            channelStudyVo.setNext(next);
            channelStudyVo.setNext_idx((int)next.getChannel_study_idx());
        }

        if (prev != null) {
            channelStudyVo.setPrev(prev);
            channelStudyVo.setPrev_idx((int)prev.getChannel_study_idx());
        }*/

        model.addAttribute("clubStatusVo", clubStatusVo);

        return ret_url;
    }

    @RequestMapping("/senior/forever/club_news_list.do")
    public String forever_club_news_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/club_news_list";

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

        List<ClubNewsVo> itemList = clubService.selectClubNewsList(searchVo);
        for(ClubNewsVo clubNewsVo : itemList) {
            //썸네일 처리
            String thumbFileId = clubNewsVo.getThumb_atch_file_id();
            String thumb_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo thumbfvo = new FileVo();
            thumbfvo.setAtch_file_id(thumbFileId);
            List<FileVo> thumbFileList = fileMngService.selectFileInfs(thumbfvo);
            for(FileVo fileVo : thumbFileList){
                fileVo.setFile_src(thumb_path + "/" + fileVo.getFile_nm());
            }
            clubNewsVo.setThumbFileList(thumbFileList);
        }
        int totalCount = clubService.selectClubNewsListTotal(searchVo);
        PageHolder pageholder = this.setPageNumRowEx(request, totalCount, 12);

        model.addAttribute("pageholder", pageholder);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("itemList", itemList);

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/club_news_view.do", method = RequestMethod.GET)
    public String forever_club_news_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/club_news_view";

        int club_news_idx = ServletRequestUtils.getIntParameter(request, "club_news_idx", 0);

        ClubNewsVo clubNewsVo = new ClubNewsVo();
        clubNewsVo.setClub_news_idx(club_news_idx);

        clubService.updateClubNewsViewCnt(clubNewsVo);
        clubNewsVo = clubService.selectClubNewsInfo(clubNewsVo);

        // 첨부파일 처리
        String atchFileId = clubNewsVo.getAtch_file_id();
        String min_img_path = EgovProperties.getProperty("bd.file.url.path");
        FileVo fvo = new FileVo();
        fvo.setAtch_file_id(atchFileId);
        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
        for(FileVo fileVo : fileVoList){
            fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
        }
        clubNewsVo.setFileList(fileVoList);

        // 이전/다음 목록 가져오기
        ClubNewsVo next = clubService.selectNextClubNews(clubNewsVo);
        ClubNewsVo prev = clubService.selectPrevClubNews(clubNewsVo);

        if (next != null) {
            clubNewsVo.setNext(next);
            clubNewsVo.setNext_idx((int)next.getClub_news_idx());
        }

        if (prev != null) {
            clubNewsVo.setPrev(prev);
            clubNewsVo.setPrev_idx((int)prev.getClub_news_idx());
        }

        model.addAttribute("clubNewsVo", clubNewsVo);

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/center_self_hall.do", method = RequestMethod.GET)
    public String forever_center_self_hall(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/center_self_hall";

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/center_ict_hall.do", method = RequestMethod.GET)
    public String forever_center_ict_hall(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/center_ict_hall";

        return ret_url;
    }

    @RequestMapping(value = "/senior/forever/center_woman_hall.do", method = RequestMethod.GET)
    public String forever_center_woman_hall(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/forever/center_woman_hall";

        return ret_url;
    }
}
