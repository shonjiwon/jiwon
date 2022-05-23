package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.SafeHtmlUtil;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.FileMngService;
import kr.go.songpa.ssem.service.MagnetService;
import kr.go.songpa.ssem.service.MainService;
import kr.go.songpa.ssem.util.DateUtil;
import kr.go.songpa.ssem.util.FileMngUtil;
import kr.go.songpa.ssem.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
 * Date : 2020-09-29
 * Description :
 * History :
 * Version :
 */
@Controller
public class SeniorMainController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    @Autowired
    private MagnetService magnetService;

    @Autowired
    private MainService mainService;

    public SeniorMainController() {
    }

    @RequestMapping(value = "/senior/main/main.do", method = RequestMethod.GET)
    public String senior_main(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/main/main";

        // 메인 이미지 배너
        List<MainImgVo> mainImgList = mainService.selectMainImgSeniorList();
        for(MainImgVo mainImgVo : mainImgList) {
            // 첨부파일 처리
            String atchFileId = mainImgVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            mainImgVo.setFileList(fileVoList);
        }
        model.addAttribute("mainImgList", mainImgList);

        // 추천 프로그램 리스트
        List<LectureVo> lectureList = mainService.selectLectureSeniorMainList();
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
        }
        model.addAttribute("lectureList", lectureList);

        // 공지사항 리스트 - 4개
        List<BbsDetailVo> noticeList = mainService.selectNoticeMainList();
        model.addAttribute("noticeList", noticeList);

        // 팝업 리스트
        List<PopupVo> popupList = mainService.selectPopupMainList("S");
        for(PopupVo popupVo : popupList) {
            // 이미지 처리
            String atchFileId = popupVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            popupVo.setFileList(fileVoList);
        }
        model.addAttribute("popupList", popupList);

        return ret_url;
    }

    @RequestMapping(value = "/senior/main/teacher_reg.do", method = RequestMethod.GET)
    public String senior_teacher_reg(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/main/teacher_reg";

        HttpSession session = request.getSession();
        TnUserInfoVo loginVo = (TnUserInfoVo) session.getAttribute(Constants.LOGIN_VO);

        if(loginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.youth_login_url + "?return_url=/senior/main/teacher_reg.do");
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {

            TeacherApyVo teacherApyVo = new TeacherApyVo();

            String mob_no = loginVo.getMoblphon();
            if(!"".equals(Util.nvl(mob_no)) && !"--".equals(mob_no)) {
                if(mob_no.length() == 13) {
                    String[] tokens = mob_no.split("-");
                    teacherApyVo.setMob_1(tokens[0]);
                    teacherApyVo.setMob_2(tokens[1]);
                    teacherApyVo.setMob_3(tokens[2]);
                }
            }

            model.addAttribute("teacherApyVo", teacherApyVo);

            // 교육분야
            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/main/teacher_reg.do", method = RequestMethod.POST)
    public String senior_teacher_reg_inpro(final MultipartHttpServletRequest multiRequest,
                                            @ModelAttribute("teacherApyVo") TeacherApyVo teacherApyVo,
                                            BindingResult bindingResult,
                                            Model model,
                                            SessionStatus status)  throws Exception {

        String ret_url = "common/message";

        try {
            // 모든 POST에 XSS 처리
            for (Field field : teacherApyVo.getClass().getDeclaredFields()){
                field.setAccessible(true);
                Object value=field.get(teacherApyVo);
                if(value instanceof String){
                    field.set(teacherApyVo, SafeHtmlUtil.sanitize(Util.nvl(value)));
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
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "pic_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "TR_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        thumbFileid = fileMngService.insertFileInfs(result);
                    }

                    teacherApyVo.setPic_atch_file_id(thumbFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 강사이력파일 처리
                CommonVo career_file = this.getAttachFileInfoEx(multiRequest, "career_atch_file_id");
                if (career_file.isFtype_flag()) {
                    String careerFileid = "";
                    if (career_file.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(career_file.getTmpfiles(), "TR_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        careerFileid = fileMngService.insertFileInfs(result);
                    }

                    teacherApyVo.setCareer_atch_file_id(careerFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                teacherApyVo.setReg_id(loginVo.getUser_id());

                magnetService.insertTeacherApyInfo(teacherApyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssem/senior/main/main.do");
                model.addAttribute("altmsg", "강사신청이 완료되었습니다.");

            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "강사신청에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/senior/main/privacy.do", method = RequestMethod.GET)
    public String senior_main_privacy(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/main/privacy";

        return ret_url;
    }

    @RequestMapping(value = "/senior/main/terms.do", method = RequestMethod.GET)
    public String senior_main_terms(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/main/terms";

        return ret_url;
    }

    @RequestMapping(value = "/senior/main/mail.do", method = RequestMethod.GET)
    public String senior_main_mail(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/main/mail";

        return ret_url;
    }

    @RequestMapping(value = "/senior/main/copyright.do", method = RequestMethod.GET)
    public String senior_main_copyright(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/main/copyright";

        return ret_url;
    }

    @RequestMapping(value = "/senior/main/sitemap.do", method = RequestMethod.GET)
    public String senior_main_sitemap(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/main/sitemap";

        return ret_url;
    }

    @RequestMapping(value = "/senior/main/family_site.do", method = RequestMethod.GET)
    public String senior_main_family_site(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "senior/main/family_site";

        return ret_url;
    }
}
