package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.FileMngService;
import kr.go.songpa.ssem.service.LectureService;
import kr.go.songpa.ssem.service.MsgService;
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
import java.util.ArrayList;
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-09-14
 * Description :
 * History :
 * Version :
 */
@Controller
public class LectureController extends CommonController {
    @Autowired
    private AppService appService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    @Autowired
    private MsgService msgService;

    public LectureController() {
    }

    @RequestMapping("/cont/lecture/lecture_list.do")
    public String lecture_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/lecture_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            /*if("".equals(searchVo.getSearchVal2())) {
                searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
            }

            if("".equals(searchVo.getSearchVal3())) {
                searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
            }*/

            if(!"S".equals(adminLoginVo.getType())) {
                if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }

                if ("".equals(searchVo.getSearchVal3())) {
                    searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                    model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
                }
            } else {
                /*if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }*/
            }

            if(!"".equals(searchVo.getSearchVal8())) {
                List<String> searchArrayVal = Util.transStringToList(searchVo.getSearchVal8(), " ");
                if(searchArrayVal.size() != 0) {
                    searchVo.setSearchArrayVal(searchArrayVal);
                }
            }

            List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
            for(LectureVo lecture : itemList) {
                String code_name = appService.selectCodeByIdx(lecture.getPart_code_idx());
                lecture.setPart_name(code_name);

                // 요일 정보
                lecture.setWeekList(StringUtil.getWeekStrToWeekCode(lecture.getDt_week()));

                // 프로그램 상태 체크
                // 1. 접수대기 : 접수날짜 도래 하지 않음
                // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                // 5. 교육전 :
                // 6. 교육중 : 교육날짜 내
                // 7. 교육종료 : 교육날짜 지남
                // 8. 외부홈페이지 : 외부 홈페이지일 경우
                int code = Util.getProgramStatus(lecture);
                lecture.setStatus_code(code);
            }
            int totalCount = lectureService.selectLectureListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);

            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            // 교육대상
            List<CodeVo> tgtList = appService.selectCodeList("STUDY_TGT");
            model.addAttribute("tgtList", tgtList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/lecture_inscr.do", method = RequestMethod.GET)
    public String lecture_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/lecture_inscr";
        String menu_url = "cont/lecture/lecture_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);

            // 교육분야
            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            // 교육대상
            List<CodeVo> tgtList = appService.selectCodeList("STUDY_TGT");
            model.addAttribute("tgtList", tgtList);

            // 시간
            List<String> hourList = DateUtil.getHourList();
            model.addAttribute("hourList", hourList);

            // 분
            List<String> minList = DateUtil.getMinList();
            model.addAttribute("minList", minList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/lecture_inscr.do", method = RequestMethod.POST)
    public String lecture_inproc(final MultipartHttpServletRequest multiRequest,
                              @ModelAttribute("lectureVo") LectureVo lectureVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {

                // 첨부파일 처리
                CommonVo file_cmm = this.getAttachFileInfo(multiRequest);
                if (file_cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (file_cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(file_cmm.getTmpfiles(), "LECT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);

                        lectureVo.setAtch_file_id(atchFileId);
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }


                // 썸네일 처리
                CommonVo cmm = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (cmm.isFtype_flag()) {
                    // 사진파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PIC_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    lectureVo.setThumb_atch_file_id(atchFileId);
                    lectureVo.setReg_id(adminLoginVo.getAdmin_id());

                    if(lectureVo.getGroup_idx() == 0) {
                        lectureVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    }

                    // 온라인, 유료결제 선택시 조직정보에 상점아이디가 없다면 예외처리한다.
                    GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
                    if("S".equals(lectureVo.getFee_type())) {
                        if(lectureVo.getReg_method().contains("1")) {
                            if(groupVo.getPay_shop_id() == null) {
                                model.addAttribute("msg", "alterBack");
                                model.addAttribute("altmsg", "상점아이디가 등록되지 않아 유료 온라인<br/> 프로그램을 등록하실 수 없습니다.");
                                return ret_url;
                            }
                        }
                    }

                    lectureService.insertLectureInfo(lectureVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/lecture/lecture_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/lecture_view.do", method = RequestMethod.GET)
    public String lecture_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/lecture_view";
        String menu_url = "cont/lecture/lecture_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

            LectureVo lectureVo = new LectureVo();
            lectureVo.setLecture_idx(lecture_idx);

            lectureVo = lectureService.selectLectureInfo(lectureVo);

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

            // 첨부파일 처리
            String fileId = lectureVo.getAtch_file_id();
            String file_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo_atch = new FileVo();
            fvo_atch.setAtch_file_id(fileId);
            List<FileVo> atchFileVoList = fileMngService.selectFileInfs(fvo_atch);
            for(FileVo fileVo : atchFileVoList){
                fileVo.setFile_src(file_path + "/" + fileVo.getFile_nm());
            }
            lectureVo.setFileList(atchFileVoList);

            // 교육시간 분리
            String start_hour = lectureVo.getStart_time().substring(0, 2);
            String start_min = lectureVo.getStart_time().substring(3, 5);
            String end_hour = lectureVo.getEnd_time().substring(0, 2);
            String end_min = lectureVo.getEnd_time().substring(3, 5);

            lectureVo.setStart_hour(start_hour);
            lectureVo.setStart_min(start_min);
            lectureVo.setEnd_hour(end_hour);
            lectureVo.setEnd_min(end_min);

            // 감면여부 정보 가져오기
            // 감면 대상 정보
            List<DiscountVo> discountList = new ArrayList<DiscountVo>();
            String discount_str = Util.nvl(lectureVo.getDiscount_str());
            if(!"".equals(discount_str)) {
                String[] tokens = discount_str.split(",");
                for(String token : tokens) {
                    DiscountVo discountVo = lectureService.selectDiscountByIdx(Integer.parseInt(token));
                    discountList.add(discountVo);
                }
            }
            model.addAttribute("discountList", discountList);

            // 교육장소명 가져오기
            String study_place_name = lectureService.selectStudyPlaceNameByIdx(lectureVo.getStudy_place_idx());
            lectureVo.setStudy_place_name(study_place_name);

            model.addAttribute("lectureVo", lectureVo);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);

            // 교육분야
            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            // 교육대상
            List<CodeVo> tgtList = appService.selectCodeList("STUDY_TGT");
            model.addAttribute("tgtList", tgtList);

            // 시간
            List<String> hourList = DateUtil.getHourList();
            model.addAttribute("hourList", hourList);

            // 분
            List<String> minList = DateUtil.getMinList();
            model.addAttribute("minList", minList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/lecture_view.do", method = RequestMethod.POST)
    public String lecture_view_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("lectureVo") LectureVo lectureVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {

                // 첨부파일 처리
                CommonVo file_cmm = this.getAttachFileInfo(multiRequest);

                if(file_cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(file_cmm.getChkcnt() > 0){
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(lectureVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(file_cmm.getTmpfiles(), "LECT_",cnt, lectureVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(file_cmm.getTmpfiles(), "LECT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            lectureVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(lectureVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            lectureVo.setAtch_file_id("");
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 썸네일 처리
                CommonVo cmm = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(lectureVo.getThumb_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PIC_",cnt, lectureVo.getThumb_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PIC_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            lectureVo.setThumb_atch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(lectureVo.getThumb_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            lectureVo.setThumb_atch_file_id("");
                        }
                    }

                    lectureVo.setUp_id(adminLoginVo.getAdmin_id());

                    if(lectureVo.getGroup_idx() == 0) {
                        lectureVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    }

                    // 온라인, 유료결제 선택시 조직정보에 상점아이디가 없다면 예외처리한다.
                    GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
                    if("S".equals(lectureVo.getFee_type())) {
                        if(lectureVo.getReg_method().contains("1")) {
                            if(groupVo.getPay_shop_id() == null) {
                                model.addAttribute("msg", "alterBack");
                                model.addAttribute("altmsg", "상점아이디가 등록되지 않아 유료 온라인<br/> 프로그램을 수정하실 수 없습니다.");
                                return ret_url;
                            }
                        }
                    }

                    // 수강생이 있는지 여부 확인
                    /*int apy_cnt = lectureService.selectLectureApyCountByIdx(lectureVo.getLecture_idx());
                    if(apy_cnt != 0) {
                        model.addAttribute("msg", "alterBack");
                        model.addAttribute("altmsg", "등록된 수강생이 있습니다.<br/> 프로그램을 수정하실 수 없습니다.");
                        return ret_url;
                    }*/

                    lectureService.updateLectureInfo(lectureVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/lecture/lecture_list.do");
                    model.addAttribute("altmsg", "수정되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "수정에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/lecture_view_back.do", method = RequestMethod.GET)
    public String lecture_view_back(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/lecture_view_back";
        String menu_url = "cont/lecture/lecture_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

            LectureVo lectureVo = new LectureVo();
            lectureVo.setLecture_idx(lecture_idx);

            lectureVo = lectureService.selectLectureInfo(lectureVo);

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

            // 교육시간 분리
            String start_hour = lectureVo.getStart_time().substring(0, 2);
            String start_min = lectureVo.getStart_time().substring(3, 5);
            String end_hour = lectureVo.getEnd_time().substring(0, 2);
            String end_min = lectureVo.getEnd_time().substring(3, 5);

            lectureVo.setStart_hour(start_hour);
            lectureVo.setStart_min(start_min);
            lectureVo.setEnd_hour(end_hour);
            lectureVo.setEnd_min(end_min);

            // 감면여부 정보 가져오기
            // 감면 대상 정보
            List<DiscountVo> discountList = new ArrayList<DiscountVo>();
            String discount_str = Util.nvl(lectureVo.getDiscount_str());
            if(!"".equals(discount_str)) {
                String[] tokens = discount_str.split(",");
                for(String token : tokens) {
                    if(!"".equals(token)) {
                        DiscountVo discountVo = lectureService.selectDiscountByIdx(Integer.parseInt(token));
                        discountList.add(discountVo);
                    }
                }
            }
            model.addAttribute("discountList", discountList);

            // 교육장소명 가져오기
            String study_place_name = lectureService.selectStudyPlaceNameByIdx(lectureVo.getStudy_place_idx());
            lectureVo.setStudy_place_name(study_place_name);

            model.addAttribute("lectureVo", lectureVo);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);

            // 교육분야
            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            // 교육대상
            List<CodeVo> tgtList = appService.selectCodeList("STUDY_TGT");
            model.addAttribute("tgtList", tgtList);

            // 시간
            List<String> hourList = DateUtil.getHourList();
            model.addAttribute("hourList", hourList);

            // 분
            List<String> minList = DateUtil.getMinList();
            model.addAttribute("minList", minList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/lecture_view_back.do", method = RequestMethod.POST)
    public String lecture_view_back_proc(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("lectureVo") LectureVo lectureVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                // 첨부파일 처리
                CommonVo cmm = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(lectureVo.getThumb_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PIC_",cnt, lectureVo.getThumb_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PIC_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            lectureVo.setThumb_atch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(lectureVo.getThumb_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            lectureVo.setThumb_atch_file_id("");
                        }
                    }

                    lectureVo.setUp_id(adminLoginVo.getAdmin_id());

                    if(lectureVo.getGroup_idx() == 0) {
                        lectureVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    }

                    // 온라인, 유료결제 선택시 조직정보에 상점아이디가 없다면 예외처리한다.
                    GroupVo groupVo = appService.selectGruopByIdx(lectureVo.getGroup_idx());
                    if("S".equals(lectureVo.getFee_type())) {
                        if(lectureVo.getReg_method().contains("1")) {
                            if(groupVo.getPay_shop_id() == null) {
                                model.addAttribute("msg", "alterBack");
                                model.addAttribute("altmsg", "상점아이디가 등록되지 않아 유료 온라인<br/> 프로그램을 수정하실 수 없습니다.");
                                return ret_url;
                            }
                        }
                    }

                    // 수강생이 있는지 여부 확인
                    /*int apy_cnt = lectureService.selectLectureApyCountByIdx(lectureVo.getLecture_idx());
                    if(apy_cnt != 0) {
                        model.addAttribute("msg", "alterBack");
                        model.addAttribute("altmsg", "등록된 수강생이 있습니다.<br/> 프로그램을 수정하실 수 없습니다.");
                        return ret_url;
                    }*/

                    lectureService.updateLectureInfo(lectureVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/lecture/lecture_list.do");
                    model.addAttribute("altmsg", "수정되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "수정에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/lecture_delete.do", method = RequestMethod.POST)
    public String lecture_delete(final MultipartHttpServletRequest multiRequest,
                                 @ModelAttribute("lectureVo") LectureVo lectureVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {
                // 신청자 존재여부 확인 할 것
                int apy_count = lectureService.selectLectureApyCountByIdx(lectureVo.getLecture_idx());
                if(apy_count == 0) {
                    lectureService.deleteLectureInfoByIdx(lectureVo.getLecture_idx());

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/lecture/lecture_list.do");
                    model.addAttribute("altmsg", "삭제 되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "해당 강좌의 신청자가 존재합니다.<br/>신청자정보를 확인후 삭제해 주세요.");
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/apply_list.do")
    public String apply_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/apply_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }

                if ("".equals(searchVo.getSearchVal3())) {
                    searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                    model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
                }
            } else {
                /*if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }*/
            }

            if(!"".equals(searchVo.getSearchVal8())) {
                List<String> searchArrayVal = Util.transStringToList(searchVo.getSearchVal8(), " ");
                if(searchArrayVal.size() != 0) {
                    searchVo.setSearchArrayVal(searchArrayVal);
                }
            }

            List<LectureVo> itemList = lectureService.selectLectureList(searchVo);
            for(LectureVo lecture : itemList) {

                // 신청방법
                String reg_method_str = "";
                String[] methods = lecture.getReg_method().split(",");
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
                lecture.setReg_method_str(StringUtil.deleteLastStr(reg_method_str.trim(), ','));

                // 프로그램 상태 체크
                // 1. 접수대기 : 접수날짜 도래 하지 않음
                // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                // 5. 교육전 :
                // 6. 교육중 : 교육날짜 내
                // 7. 교육종료 : 교육날짜 지남
                // 8. 외부홈페이지 : 외부 홈페이지일 경우
                int code = Util.getProgramStatus(lecture);
                lecture.setStatus_code(code);
            }
            int totalCount = lectureService.selectLectureListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);

            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            // 교육대상
            List<CodeVo> tgtList = appService.selectCodeList("STUDY_TGT");
            model.addAttribute("tgtList", tgtList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/apply_view.do")
    public String apply_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/apply_view";
        String menu_url = "cont/lecture/apply_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForLectureApy(request, 10, String.valueOf(lecture_idx));
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }



            LectureVo lectureVo = new LectureVo();
            lectureVo.setLecture_idx(lecture_idx);

            lectureVo = lectureService.selectLectureInfo(lectureVo);

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

            //교육대상 가져오기
            List<String> array_tgt = new ArrayList<String>();
            String tgt_code = lectureVo.getTgt_code();
            String[] tokens = tgt_code.split(",");
            for(String codeStr : tokens) {
                String code_txt = appService.selectCodeByIdx(Integer.parseInt(codeStr));
                array_tgt.add(code_txt);
            }
            lectureVo.setArray_tgt(array_tgt);

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

            // 인원관련 정보 취득
            int apy_cancel_cnt = lectureService.selectLectureApyCancelCnttByIdx(lecture_idx);
            int pay_wait_cnt = lectureService.selectLecturePayWaitCntByIdx(lecture_idx);
            int pay_ok_cnt = lectureService.selectLecturePayOkCntByIdx(lecture_idx);
            int pay_cancel_cnt = lectureService.selectLecturePayCancelCntByIdx(lecture_idx);
            int refund_apy_cnt = lectureService.selectLectureRefundApyCntByIdx(lecture_idx);
            int refund_ok_cnt = lectureService.selectLectureRefundOkCntByIdx(lecture_idx);
            int free_ok_cnt = lectureService.selectLectureFreeOkCntByIdx(lecture_idx);
            int appv_ok_cnt = lectureService.selectLectureAppvOkCntByIdx(lecture_idx);
            int appv_cancel_cnt = lectureService.selectLectureAppvCancelCntByIdx(lecture_idx);
            int appv_no_cnt = lectureService.selectLectureAppvNoCntByIdx(lecture_idx);

            lectureVo.setApy_cancel_cnt(apy_cancel_cnt);
            lectureVo.setPay_wait_cnt(pay_wait_cnt);
            lectureVo.setPay_ok_cnt(pay_ok_cnt);
            lectureVo.setPay_cancel_cnt(pay_cancel_cnt);
            lectureVo.setRefund_apy_cnt(refund_apy_cnt);
            lectureVo.setRefund_ok_cnt(refund_ok_cnt);
            lectureVo.setAppv_ok_cnt(appv_ok_cnt);
            lectureVo.setAppv_cancel_cnt(appv_cancel_cnt);
            lectureVo.setAppv_no_cnt(appv_no_cnt);
            lectureVo.setFree_ok_cnt(free_ok_cnt);

            model.addAttribute("lectureVo", lectureVo);

            searchVo.setSearchVal7(String.valueOf(lecture_idx));

            List<LectureApyVo> itemList = lectureService.selectLectureApyList(searchVo);
            int totalCount = lectureService.selectLectureApyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/apply_student_inscr.do", method = RequestMethod.GET)
    public String apply_student_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/apply_student_inscr";
        String menu_url = "cont/lecture/apply_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

            LectureVo lectureVo = new LectureVo();
            lectureVo.setLecture_idx(lecture_idx);

            lectureVo = lectureService.selectLectureInfo(lectureVo);

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

            //교육대상 가져오기
            List<String> array_tgt = new ArrayList<String>();
            String tgt_code = lectureVo.getTgt_code();
            String[] tokens = tgt_code.split(",");
            for(String codeStr : tokens) {
                String code_txt = appService.selectCodeByIdx(Integer.parseInt(codeStr));
                array_tgt.add(code_txt);
            }
            lectureVo.setArray_tgt(array_tgt);

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

            model.addAttribute("lectureVo", lectureVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/apply_student_inscr.do", method = RequestMethod.POST)
    public String apply_student_inproc(final MultipartHttpServletRequest multiRequest,
                              @ModelAttribute("lectureApyVo") LectureApyVo lectureApyVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {
                lectureApyVo.setReg_id(adminLoginVo.getAdmin_id());

                lectureService.insertLectureApyInfo(lectureApyVo);

                // 방문/전화 인원 COUNTING
                if("2".equals(lectureApyVo.getApy_method())) {
                    // 방문
                    lectureService.updateVisitCanQtyMinusByIdx(lectureApyVo.getLecture_idx());
                } else if("3".equals(lectureApyVo.getApy_method())) {
                    // 전화
                    lectureService.updateTelCanQtyMinusByIdx(lectureApyVo.getLecture_idx());
                }

                // 승인 등록시 수강생 등록 프로세스 거칠 것
                // 데이터 입력
                if("1".equals(lectureApyVo.getAppv_cd())) {
                    StudentVo studentVo = new StudentVo();

                    studentVo.setPostcode(lectureApyVo.getPostcode());
                    studentVo.setAddr1(lectureApyVo.getApy_addr1());
                    studentVo.setAddr2(lectureApyVo.getApy_addr2());

                    if (lectureApyVo.getApy_ref() == null || "".equals(lectureApyVo.getApy_ref())) {
                        studentVo.setUser_id(lectureApyVo.getApy_id());
                        studentVo.setName(lectureApyVo.getApy_name());
                        studentVo.setBirth(lectureApyVo.getApy_birth());
                        studentVo.setGender(lectureApyVo.getApy_gender());
                        studentVo.setMob_no(lectureApyVo.getApy_mob_no());

                        studentVo.setRef_yn("N");

                        // !!!매우 중요!!!
                        // 송파구청 회원 아이디 기준으로 등록된 수강생은 강의 데이터만 입력한다. (본인 신청인 경우)
                        StudentVo student = lectureService.selectStudentInfoByID(lectureApyVo.getApy_id());
                        if (student != null) {
                            StudentLectVo studentLectVo = new StudentLectVo();

                            studentLectVo.setStudent_idx(student.getStudent_idx());
                            studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());
                            studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());

                            GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                            studentLectVo.setP_idx(groupVo.getP_idx());

                            lectureService.insertStudentLectInfo(studentLectVo);
                        } else {
                            // 기존 수강생 (대리신청 포함) 가져오기 해서 등록시
                            StudentVo student_offline = lectureService.selectStudentInfo(studentVo);
                            if(student_offline != null) {
                                StudentLectVo studentLectVo = new StudentLectVo();

                                studentLectVo.setStudent_idx(student_offline.getStudent_idx());
                                studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());
                                studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                                studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());

                                GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                                studentLectVo.setP_idx(groupVo.getP_idx());

                                lectureService.insertStudentLectInfo(studentLectVo);
                            } else {
                                lectureService.insertStudentInfo(studentVo);

                                StudentLectVo studentLectVo = new StudentLectVo();

                                studentLectVo.setStudent_idx(studentVo.getStudent_idx());
                                studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                                studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());
                                studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());

                                GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                                studentLectVo.setP_idx(groupVo.getP_idx());

                                lectureService.insertStudentLectInfo(studentLectVo);
                            }
                        }
                    } else {
                        studentVo.setName(lectureApyVo.getApy_real_name());
                        studentVo.setMob_no(lectureApyVo.getApy_ref_mob_no());

                        studentVo.setRef_yn("Y");

                        studentVo.setRef_id(lectureApyVo.getApy_id());
                        studentVo.setRef_name(lectureApyVo.getApy_name());
                        studentVo.setRef_rel(lectureApyVo.getApy_ref());
                        studentVo.setRef_mob_no(lectureApyVo.getApy_mob_no());

                        // !!!매우 중요!!!
                        // 이름과 전화번호 기준으로 등록된 수강생은 강의 데이터만 입력한다. (대리 신청인 경우)
                        StudentVo student = lectureService.selectStudentInfo(studentVo);
                        if (student != null) {
                            StudentLectVo studentLectVo = new StudentLectVo();

                            studentLectVo.setStudent_idx(student.getStudent_idx());
                            studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());

                            GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                            studentLectVo.setP_idx(groupVo.getP_idx());

                            lectureService.insertStudentLectInfo(studentLectVo);
                        } else {
                            lectureService.insertStudentInfo(studentVo);

                            StudentLectVo studentLectVo = new StudentLectVo();

                            studentLectVo.setStudent_idx(studentVo.getStudent_idx());
                            studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());

                            GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                            studentLectVo.setP_idx(groupVo.getP_idx());

                            lectureService.insertStudentLectInfo(studentLectVo);
                        }
                    }
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/lecture/apply_view.do?lecture_idx=" + lectureApyVo.getLecture_idx());
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/apply_student_view.do")
    public String apply_student_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/apply_student_view";
        String menu_url = "cont/lecture/apply_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int lecture_apy_idx = 0;
            if(!"".equals(searchVo.getSearchVal7())) {
                lecture_apy_idx = ServletRequestUtils.getIntParameter(request, "lecture_apy_idx", Integer.parseInt(searchVo.getSearchVal7()));
            } else {
                lecture_apy_idx = ServletRequestUtils.getIntParameter(request, "lecture_apy_idx", 0);
            }

            LectureApyVo lectureApyVo = lectureService.selectLectureApyInfoByIdx(lecture_apy_idx);

            int lecture_idx = (int)lectureApyVo.getLecture_idx();

            LectureVo lectureVo = new LectureVo();
            lectureVo.setLecture_idx(lecture_idx);

            lectureVo = lectureService.selectLectureInfo(lectureVo);

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

            //교육대상 가져오기
            List<String> array_tgt = new ArrayList<String>();
            String tgt_code = lectureVo.getTgt_code();
            String[] tokens = tgt_code.split(",");
            for(String codeStr : tokens) {
                String code_txt = appService.selectCodeByIdx(Integer.parseInt(codeStr));
                array_tgt.add(code_txt);
            }
            lectureVo.setArray_tgt(array_tgt);

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

            model.addAttribute("lectureVo", lectureVo);
            model.addAttribute("lectureApyVo", lectureApyVo);

            // 선택한 감면정보
            if(Util.nvl(lectureApyVo.getDiscount_idx(), 0) != 0) {
                DiscountVo discountVo = lectureService.selectDiscountByIdx((int)lectureApyVo.getDiscount_idx());
                model.addAttribute("discountVo", discountVo);
            }

            // 수강이력 정보는 반드시 APY_ID가 있는 경우에 표시한다. - 승인처리된 데이터
            // searchVal8 => 유저아이디
            if(!"".equals(Util.nvl(lectureApyVo.getApy_id()))) {
                searchVo.setSearchVal8(lectureApyVo.getApy_id());
                List<LectureApyVo> itemList = lectureService.selectLectureUserHistoryList(searchVo);
                for(LectureApyVo apply : itemList) {
                    LectureVo lecture = lectureService.selectLectureByIdx(apply.getLecture_idx());

                    // 프로그램 상태 체크
                    // 1. 접수대기 : 접수날짜 도래 하지 않음
                    // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                    // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                    // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                    // 5. 교육전 :
                    // 6. 교육중 : 교육날짜 내
                    // 7. 교육종료 : 교육날짜 지남
                    // 8. 외부홈페이지 : 외부 홈페이지일 경우
                    int code_val = Util.getProgramStatus(lecture);
                    lecture.setStatus_code(code_val);

                    apply.setLectureVo(lecture);

                    if(Util.nvl(apply.getDiscount_idx(), 0) != 0) {
                        DiscountVo discountVo = lectureService.selectDiscountByIdx((int)apply.getDiscount_idx());
                        apply.setDiscountVo(discountVo);
                    }
                }
                int totalCount = lectureService.selectLectureUserHistoryListTotal(searchVo);
                PageHolder pageholder = this.setPageNumRow(request, totalCount);

                model.addAttribute("pageholder", pageholder);
                model.addAttribute("totalCount", totalCount);
                model.addAttribute("itemList", itemList);
            }
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/apply_student_offline_view.do")
    public String apply_student_offline_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/apply_student_offline_view";
        String menu_url = "cont/lecture/apply_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int lecture_apy_idx = 0;
            if(!"".equals(searchVo.getSearchVal7())) {
                lecture_apy_idx = ServletRequestUtils.getIntParameter(request, "lecture_apy_idx", Integer.parseInt(searchVo.getSearchVal7()));
            } else {
                lecture_apy_idx = ServletRequestUtils.getIntParameter(request, "lecture_apy_idx", 0);
            }

            LectureApyVo lectureApyVo = lectureService.selectLectureApyInfoByIdx(lecture_apy_idx);

            int lecture_idx = (int)lectureApyVo.getLecture_idx();

            LectureVo lectureVo = new LectureVo();
            lectureVo.setLecture_idx(lecture_idx);

            lectureVo = lectureService.selectLectureInfo(lectureVo);

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

            //교육대상 가져오기
            List<String> array_tgt = new ArrayList<String>();
            String tgt_code = lectureVo.getTgt_code();
            String[] tokens = tgt_code.split(",");
            for(String codeStr : tokens) {
                String code_txt = appService.selectCodeByIdx(Integer.parseInt(codeStr));
                array_tgt.add(code_txt);
            }
            lectureVo.setArray_tgt(array_tgt);

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

            model.addAttribute("lectureVo", lectureVo);
            model.addAttribute("lectureApyVo", lectureApyVo);

            // 선택한 감면정보
            if(Util.nvl(lectureApyVo.getDiscount_idx(), 0) != 0) {
                DiscountVo discountVo = lectureService.selectDiscountByIdx((int)lectureApyVo.getDiscount_idx());
                model.addAttribute("discountVo", discountVo);
            }

            // 수강이력 정보는 반드시 APY_ID가 있는 경우에 표시한다. - 승인처리된 데이터
            // searchVal8 => 유저아이디
            if(!"".equals(Util.nvl(lectureApyVo.getApy_id()))) {
                searchVo.setSearchVal8(lectureApyVo.getApy_id());
                List<LectureApyVo> itemList = lectureService.selectLectureUserHistoryList(searchVo);
                for(LectureApyVo apply : itemList) {
                    LectureVo lecture = lectureService.selectLectureByIdx(apply.getLecture_idx());

                    // 프로그램 상태 체크
                    // 1. 접수대기 : 접수날짜 도래 하지 않음
                    // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                    // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                    // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                    // 5. 교육전 :
                    // 6. 교육중 : 교육날짜 내
                    // 7. 교육종료 : 교육날짜 지남
                    // 8. 외부홈페이지 : 외부 홈페이지일 경우
                    int code_val = Util.getProgramStatus(lecture);
                    lecture.setStatus_code(code_val);

                    apply.setLectureVo(lecture);

                    if(Util.nvl(apply.getDiscount_idx(), 0) != 0) {
                        DiscountVo discountVo = lectureService.selectDiscountByIdx((int)apply.getDiscount_idx());
                        apply.setDiscountVo(discountVo);
                    }
                }
                int totalCount = lectureService.selectLectureUserHistoryListTotal(searchVo);
                PageHolder pageholder = this.setPageNumRow(request, totalCount);

                model.addAttribute("pageholder", pageholder);
                model.addAttribute("totalCount", totalCount);
                model.addAttribute("itemList", itemList);
            }
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/apply_student_update.do", method = RequestMethod.POST)
    public String apply_student_upproc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("lectureApyVo") LectureApyVo lectureApyVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {

                // 1. 미승인에서 승인처리시 수강생 테이블에 데이터 입력
                // 2. 승인에서 승인취소시 수강생 테이블에서 데이터 삭제
                // 3. 승인취소에서 승인상태일 수강생 테이블에 데이터 입력
                LectureApyVo oldlectureApyVo = lectureService.selectLectureApyInfoByIdx((int)lectureApyVo.getLecture_apy_idx());

                // 신청 취소 시 COUNTING
                if("1".equals(oldlectureApyVo.getApy_status()) && "3".equals(lectureApyVo.getApy_status())) {
                    if("1".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateOnlineCanQtyPlusByIdx(oldlectureApyVo.getLecture_idx());
                    } else if("2".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateVisitCanQtyPlusByIdx(oldlectureApyVo.getLecture_idx());
                    } else if("3".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateTelCanQtyPlusByIdx(oldlectureApyVo.getLecture_idx());
                    }
                }

                // 다시 신청 시 COUNTING
                if("3".equals(oldlectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getApy_status())) {
                    if("1".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateOnlineCanQtyMinusByIdx(oldlectureApyVo.getLecture_idx());
                    } else if("2".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateVisitCanQtyMinusByIdx(oldlectureApyVo.getLecture_idx());
                    } else if("3".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateTelCanQtyMinusByIdx(oldlectureApyVo.getLecture_idx());
                    }
                }

                // 대기 신청 취소 시 COUNTING
                if("2".equals(oldlectureApyVo.getApy_status()) && "3".equals(lectureApyVo.getApy_status())) {
                    if("1".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateWaitCanQtyPlusByIdx(oldlectureApyVo.getLecture_idx());
                    }
                }

                // 대기 신청을 신청 시 COUNTING
                if("2".equals(oldlectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getApy_status())) {
                    if("1".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateWaitCanQtyPlusByIdx(oldlectureApyVo.getLecture_idx());
                    }
                }

                // 다시 대기 신청 시 COUNTING
                if("3".equals(oldlectureApyVo.getApy_status()) && "2".equals(lectureApyVo.getApy_status())) {
                    if("1".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateWaitCanQtyMinusByIdx(oldlectureApyVo.getLecture_idx());
                    }
                }

                if( ("2".equals(oldlectureApyVo.getAppv_cd()) && "1".equals(lectureApyVo.getAppv_cd())) || ("3".equals(oldlectureApyVo.getAppv_cd()) && "1".equals(lectureApyVo.getAppv_cd())) || ("2".equals(oldlectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getAppv_cd())) || ("3".equals(oldlectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getAppv_cd()))) {
                    // 데이터 입력
                    StudentVo studentVo = new StudentVo();

                    studentVo.setPostcode(lectureApyVo.getPostcode());
                    studentVo.setAddr1(lectureApyVo.getApy_addr1());
                    studentVo.setAddr2(lectureApyVo.getApy_addr2());
                    if(lectureApyVo.getApy_ref() == null || "".equals(lectureApyVo.getApy_ref())) {
                        studentVo.setUser_id(lectureApyVo.getApy_id());
                        studentVo.setName(lectureApyVo.getApy_name());
                        studentVo.setBirth(lectureApyVo.getApy_birth());
                        studentVo.setGender(lectureApyVo.getApy_gender());
                        studentVo.setMob_no(lectureApyVo.getApy_mob_no());

                        studentVo.setRef_yn("N");

                        // !!!매우 중요!!!
                        // 송파구청 회원 아이디 기준으로 등록된 수강생은 강의 데이터만 입력한다. (본인 신청인 경우)
                        StudentVo student = lectureService.selectStudentInfoByID(lectureApyVo.getApy_id());
                        if(student != null) {
                            StudentLectVo studentLectVo = new StudentLectVo();

                            studentLectVo.setStudent_idx(student.getStudent_idx());
                            studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                            studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                            GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                            studentLectVo.setP_idx(groupVo.getP_idx());

                            lectureService.insertStudentLectInfo(studentLectVo);
                        } else {
                            lectureService.insertStudentInfo(studentVo);

                            StudentLectVo studentLectVo = new StudentLectVo();

                            studentLectVo.setStudent_idx(studentVo.getStudent_idx());
                            studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                            studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                            GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                            studentLectVo.setP_idx(groupVo.getP_idx());

                            lectureService.insertStudentLectInfo(studentLectVo);
                        }
                    } else {
                        studentVo.setName(lectureApyVo.getApy_real_name());
                        studentVo.setMob_no(lectureApyVo.getApy_ref_mob_no());

                        studentVo.setRef_yn("Y");

                        studentVo.setRef_id(lectureApyVo.getApy_id());
                        studentVo.setRef_name(lectureApyVo.getApy_name());
                        studentVo.setRef_rel(lectureApyVo.getApy_ref());
                        studentVo.setRef_mob_no(lectureApyVo.getApy_mob_no());

                        // !!!매우 중요!!!
                        // 이름과 전화번호 기준으로 등록된 수강생은 강의 데이터만 입력한다. (대리 신청인 경우)
                        StudentVo student = lectureService.selectStudentInfo(studentVo);
                        if(student != null) {
                            StudentLectVo studentLectVo = new StudentLectVo();

                            studentLectVo.setStudent_idx(student.getStudent_idx());
                            studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                            studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                            GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                            studentLectVo.setP_idx(groupVo.getP_idx());

                            lectureService.insertStudentLectInfo(studentLectVo);
                        } else {
                            lectureService.insertStudentInfo(studentVo);

                            StudentLectVo studentLectVo = new StudentLectVo();

                            studentLectVo.setStudent_idx(studentVo.getStudent_idx());
                            studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                            studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                            GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                            studentLectVo.setP_idx(groupVo.getP_idx());

                            lectureService.insertStudentLectInfo(studentLectVo);
                        }
                    }

                } else if("1".equals(oldlectureApyVo.getAppv_cd()) && "3".equals(lectureApyVo.getAppv_cd()) || "1".equals(oldlectureApyVo.getAppv_cd()) && "2".equals(lectureApyVo.getAppv_cd()) || "3".equals(lectureApyVo.getApy_status()) || "2".equals(lectureApyVo.getApy_status())) {
                    // 데이터 삭제
                    // 1. 수강한 강의가 남아 있는 경우 해당 프로그램 이력만 삭제
                    // 2. 수강한 강의가 없는 경우 수강생 데이터도 삭제
                    StudentVo studentVo = new StudentVo();
                    if(lectureApyVo.getApy_ref() == null || "".equals(lectureApyVo.getApy_ref())) {
                        studentVo.setUser_id(lectureApyVo.getApy_id());
                        // 본인신청
                        int count = lectureService.selectStudentLectCheckByID(studentVo);
                        StudentVo delete_student = lectureService.selectStudentInfoByID(lectureApyVo.getApy_id());

                        if(delete_student != null) {
                            delete_student.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            StudentLectVo delete_lect = lectureService.selectStudentLectInfo(delete_student);

                            if (count == 1) {
                                lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                                lectureService.deleteStudentInfoByIdx(delete_student.getStudent_idx());
                            } else {
                                lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                            }
                        } else {
                            // 오프라인 등록한 수강색이력도 삭제 ( 아이디가 없음 )
                            delete_student = lectureService.selectStudentInfoByName(oldlectureApyVo);
                            if(delete_student != null) {
                                delete_student.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                                StudentLectVo delete_lect = lectureService.selectStudentLectInfo(delete_student);

                                lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                                lectureService.deleteStudentInfoByIdx(delete_student.getStudent_idx());
                            }
                        }
                    } else {
                        studentVo.setName(lectureApyVo.getApy_real_name());
                        studentVo.setMob_no(lectureApyVo.getApy_ref_mob_no());
                        studentVo.setRef_id(lectureApyVo.getApy_id());
                        // 대리신청
                        int count = lectureService.selectStudentLectCheck(studentVo);
                        //StudentVo delete_student = lectureService.selectStudentInfoByID(lectureApyVo.getApy_id());
                        // 대리신청 교육생 정보 가져오기
                        StudentVo delete_student = lectureService.selectStudentInfoByDaeri(studentVo);
                        if(delete_student != null) {
                            delete_student.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            StudentLectVo delete_lect = lectureService.selectStudentLectInfo(delete_student);
                            if (count == 1) {
                                lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                                lectureService.deleteStudentInfoByIdx(delete_student.getStudent_idx());
                            } else {
                                lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                            }
                        }
                    }
                }

                lectureApyVo.setUp_id(adminLoginVo.getAdmin_id());

                lectureService.updateLectureApyInfo(lectureApyVo);

                // 대기신청 승인시 메세지 발송
                if("2".equals(lectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getAppv_cd())) {
                    // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    if ("yes".equals(EgovProperties.getProperty("msg.send"))) {
                        LectureVo lectureVo = lectureService.selectLecureInfoByIdx(lectureApyVo.getLecture_idx());
                        GroupVo groupVo = lectureService.selectGroupInfoByIdx((int) lectureVo.getGroup_idx());

                        StringBuffer sb = new StringBuffer();
                        sb.append("[송파구청 송파쌤(SSEM)]");
                        sb.append("\r\n");
                        sb.append(String.format("%s님의 프로그램 대기요청이 신청처리 되었습니다.", lectureApyVo.getApy_name()));
                        sb.append("\r\n");
                        sb.append("<대기 신청내역>");
                        sb.append("\r\n");
                        sb.append(String.format("- 프로그램: %s", lectureVo.getName()));
                        sb.append("\r\n");
                        sb.append("결제 또는 프로그램 신청 확인은 마이페이지를 참고해주세요.");
                        sb.append("\r\n");
                        sb.append("감사합니다.");
                        sb.append("\r\n");
                        sb.append(String.format("☎ 문의: %s", groupVo.getTel_no()));
                        sb.append("\r\n");
                        sb.append(String.format("송파쌤(SSEM) %s", groupVo.getName()));

                        msgService.sendMsgKakao("대기신청 처리안내", sb.toString(), lectureApyVo.getApy_name(), lectureApyVo.getApy_mob_no().replaceAll("-", ""), "10209");
                    }
                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                }
                // 환불처리시 메세지 발송
                if("5".equals(lectureApyVo.getPay_status())) {
                    // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    if ("yes".equals(EgovProperties.getProperty("msg.send"))) {
                        LectureVo lectureVo = lectureService.selectLecureInfoByIdx(lectureApyVo.getLecture_idx());
                        GroupVo groupVo = lectureService.selectGroupInfoByIdx((int) lectureVo.getGroup_idx());

                        StringBuffer sb = new StringBuffer();
                        sb.append("[송파구청 송파쌤(SSEM)]");
                        sb.append("\r\n");
                        sb.append(String.format("%s님의 환불신청이 처리되었습니다.", lectureApyVo.getApy_name()));
                        sb.append("\r\n");
                        sb.append("<환불처리내역>");
                        sb.append("\r\n");
                        sb.append(String.format("- 프로그램: %s", lectureVo.getName()));
                        sb.append("\r\n");
                        sb.append("상세내역은 담당기관에 문의하시기 바랍니다.");
                        sb.append("\r\n");
                        sb.append("감사합니다.");
                        sb.append("\r\n");
                        sb.append(String.format("☎ 문의: %s", groupVo.getTel_no()));
                        sb.append("\r\n");
                        sb.append(String.format("송파쌤(SSEM) %s", groupVo.getName()));

                        msgService.sendMsgKakao("환불처리 안내", sb.toString(), lectureApyVo.getApy_name(), lectureApyVo.getApy_mob_no().replaceAll("-", ""), "10208");
                    }
                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/lecture/apply_view.do?lecture_idx=" + lectureApyVo.getLecture_idx());
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/apply_student_offline_update.do", method = RequestMethod.POST)
    public String apply_student_offline_upproc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("lectureApyVo") LectureApyVo lectureApyVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {

                // 1. 미승인에서 승인처리시 수강생 테이블에 데이터 입력
                // 2. 승인에서 승인취소시 수강생 테이블에서 데이터 삭제
                // 3. 승인취소에서 승인상태일 수강생 테이블에 데이터 입력
                LectureApyVo oldlectureApyVo = lectureService.selectLectureApyInfoByIdx((int)lectureApyVo.getLecture_apy_idx());

                // 신청 취소 시 COUNTING
                if("1".equals(oldlectureApyVo.getApy_status()) && "3".equals(lectureApyVo.getApy_status())) {
                    if("1".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateOnlineCanQtyPlusByIdx(oldlectureApyVo.getLecture_idx());
                    } else if("2".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateVisitCanQtyPlusByIdx(oldlectureApyVo.getLecture_idx());
                    } else if("3".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateTelCanQtyPlusByIdx(oldlectureApyVo.getLecture_idx());
                    }
                }

                // 다시 신청 시 COUNTING
                if("3".equals(oldlectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getApy_status())) {
                    if("1".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateOnlineCanQtyMinusByIdx(oldlectureApyVo.getLecture_idx());
                    } else if("2".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateVisitCanQtyMinusByIdx(oldlectureApyVo.getLecture_idx());
                    } else if("3".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateTelCanQtyMinusByIdx(oldlectureApyVo.getLecture_idx());
                    }
                }

                // 대기 신청 취소 시 COUNTING
                if("2".equals(oldlectureApyVo.getApy_status()) && "3".equals(lectureApyVo.getApy_status())) {
                    if("1".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateWaitCanQtyPlusByIdx(oldlectureApyVo.getLecture_idx());
                    }
                }

                // 대기 신청을 신청 시 COUNTING
                if("2".equals(oldlectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getApy_status())) {
                    if("1".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateWaitCanQtyPlusByIdx(oldlectureApyVo.getLecture_idx());
                    }
                }

                // 다시 대기 신청 시 COUNTING
                if("3".equals(oldlectureApyVo.getApy_status()) && "2".equals(lectureApyVo.getApy_status())) {
                    if("1".equals(oldlectureApyVo.getApy_method())) {
                        lectureService.updateWaitCanQtyMinusByIdx(oldlectureApyVo.getLecture_idx());
                    }
                }

                if( ("2".equals(oldlectureApyVo.getAppv_cd()) && "1".equals(lectureApyVo.getAppv_cd())) || ("3".equals(oldlectureApyVo.getAppv_cd()) && "1".equals(lectureApyVo.getAppv_cd())) || ("2".equals(oldlectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getAppv_cd())) || ("3".equals(oldlectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getAppv_cd())) ) {
                    // 데이터 입력
                    StudentVo studentVo = new StudentVo();

                    studentVo.setPostcode(lectureApyVo.getPostcode());
                    studentVo.setAddr1(lectureApyVo.getApy_addr1());
                    studentVo.setAddr2(lectureApyVo.getApy_addr2());
                    if(lectureApyVo.getApy_ref() == null || "".equals(lectureApyVo.getApy_ref())) {
                        studentVo.setUser_id(lectureApyVo.getApy_id());
                        studentVo.setName(lectureApyVo.getApy_name());
                        studentVo.setBirth(lectureApyVo.getApy_birth());
                        studentVo.setGender(lectureApyVo.getApy_gender());
                        studentVo.setMob_no(lectureApyVo.getApy_mob_no());

                        studentVo.setRef_yn("N");

                        // !!!매우 중요!!!
                        // 송파구청 회원 아이디 기준으로 등록된 수강생은 강의 데이터만 입력한다. (본인 신청인 경우)
                        StudentVo student = lectureService.selectStudentInfoByID(lectureApyVo.getApy_id());
                        if(student != null) {
                            StudentLectVo studentLectVo = new StudentLectVo();

                            studentLectVo.setStudent_idx(student.getStudent_idx());
                            studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                            studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                            GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                            studentLectVo.setP_idx(groupVo.getP_idx());

                            lectureService.insertStudentLectInfo(studentLectVo);
                        } else {
                            StudentLectVo studentLectVo = new StudentLectVo();
                            // 오픈라인 등록 교육생 조사 (대리와 동일)
                            StudentVo student_offline = lectureService.selectStudentInfoByOffLine(studentVo);
                            if(student_offline == null) {
                                lectureService.insertStudentInfo(studentVo);
                                studentLectVo.setStudent_idx(studentVo.getStudent_idx());
                            } else {
                                studentLectVo.setStudent_idx(student_offline.getStudent_idx());
                            }

                            studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                            studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                            GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                            studentLectVo.setP_idx(groupVo.getP_idx());

                            lectureService.insertStudentLectInfo(studentLectVo);
                        }
                    } else {
                        studentVo.setName(lectureApyVo.getApy_real_name());
                        studentVo.setMob_no(lectureApyVo.getApy_ref_mob_no());

                        studentVo.setRef_yn("Y");

                        studentVo.setRef_id(lectureApyVo.getApy_id());
                        studentVo.setRef_name(lectureApyVo.getApy_name());
                        studentVo.setRef_rel(lectureApyVo.getApy_ref());
                        studentVo.setRef_mob_no(lectureApyVo.getApy_mob_no());

                        // !!!매우 중요!!!
                        // 이름과 전화번호 기준으로 등록된 수강생은 강의 데이터만 입력한다. (대리 신청인 경우)
                        StudentVo student = lectureService.selectStudentInfo(studentVo);
                        if(student != null) {
                            StudentLectVo studentLectVo = new StudentLectVo();

                            studentLectVo.setStudent_idx(student.getStudent_idx());
                            studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                            studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                            GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                            studentLectVo.setP_idx(groupVo.getP_idx());

                            lectureService.insertStudentLectInfo(studentLectVo);
                        } else {
                            lectureService.insertStudentInfo(studentVo);

                            StudentLectVo studentLectVo = new StudentLectVo();

                            studentLectVo.setStudent_idx(studentVo.getStudent_idx());
                            studentLectVo.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            studentLectVo.setGroup_idx(lectureApyVo.getGroup_idx());
                            studentLectVo.setLecture_idx(lectureApyVo.getLecture_idx());

                            GroupVo groupVo = appService.selectGruopByIdx(lectureApyVo.getGroup_idx());
                            studentLectVo.setP_idx(groupVo.getP_idx());

                            lectureService.insertStudentLectInfo(studentLectVo);
                        }
                    }

                } else if("1".equals(oldlectureApyVo.getAppv_cd()) && "3".equals(lectureApyVo.getAppv_cd()) || "1".equals(oldlectureApyVo.getAppv_cd()) && "2".equals(lectureApyVo.getAppv_cd()) || "3".equals(lectureApyVo.getApy_status()) || "2".equals(lectureApyVo.getApy_status()) ) {
                    // 데이터 삭제
                    // 1. 수강한 강의가 남아 있는 경우 해당 프로그램 이력만 삭제
                    // 2. 수강한 강의가 없는 경우 수강생 데이터도 삭제
                    StudentVo studentVo = new StudentVo();
                    if(lectureApyVo.getApy_ref() == null || "".equals(lectureApyVo.getApy_ref())) {
                        studentVo.setUser_id(lectureApyVo.getApy_id());
                        // 본인신청
                        int count = lectureService.selectStudentLectCheckByID(studentVo);
                        StudentVo delete_student = lectureService.selectStudentInfoByID(lectureApyVo.getApy_id());

                        if(delete_student != null) {
                            delete_student.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            StudentLectVo delete_lect = lectureService.selectStudentLectInfo(delete_student);

                            if (count == 1) {
                                lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                                lectureService.deleteStudentInfoByIdx(delete_student.getStudent_idx());
                            } else {
                                lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                            }
                        } else {
                            studentVo.setName(lectureApyVo.getApy_name());
                            studentVo.setMob_no(lectureApyVo.getApy_mob_no());

                            count = lectureService.selectStudentLectCheck(studentVo);

                            delete_student = lectureService.selectStudentInfoByName(oldlectureApyVo);
                            delete_student.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            StudentLectVo delete_lect = lectureService.selectStudentLectInfo(delete_student);

                            if(count == 1) {
                                // 대시신청에서 신청취소일 경우, 신청취소에서 대기신청일 경우 삭제 안됨
                                if(delete_lect != null) {
                                    lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                                    lectureService.deleteStudentInfoByIdx(delete_student.getStudent_idx());
                                }
                            } else {
                                // 대시신청에서 신청취소일 경우, 신청취소에서 대기신청일 경우 삭제 안됨
                                if(delete_lect != null) {
                                    lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                                }
                            }
                            // 오프라인 등록한 수강색이력도 삭제 ( 아이디가 없음 )
                            //delete_student = lectureService.selectStudentInfoByName(oldlectureApyVo);
                            /*if(delete_student != null) {
                                delete_student.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                                StudentLectVo delete_lect = lectureService.selectStudentLectInfo(delete_student);

                                lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                                lectureService.deleteStudentInfoByIdx(delete_student.getStudent_idx());
                            }*/
                        }
                    } else {
                        studentVo.setName(lectureApyVo.getApy_real_name());
                        studentVo.setMob_no(lectureApyVo.getApy_ref_mob_no());
                        // 대리신청
                        int count = lectureService.selectStudentLectCheck(studentVo);
                        //StudentVo delete_student = lectureService.selectStudentInfoByID(lectureApyVo.getApy_id());
                        // 대리신청 교육생 정보 가져오기
                        StudentVo delete_student = lectureService.selectStudentInfoByDaeri(studentVo);
                        if(delete_student != null) {
                            delete_student.setLecture_apy_idx(lectureApyVo.getLecture_apy_idx());
                            StudentLectVo delete_lect = lectureService.selectStudentLectInfo(delete_student);
                            if (count == 1) {
                                lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                                lectureService.deleteStudentInfoByIdx(delete_student.getStudent_idx());
                            } else {
                                lectureService.deleteStudentLectInfoByIdx(delete_lect.getStudent_lect_idx());
                            }
                        }
                    }
                }

                lectureApyVo.setUp_id(adminLoginVo.getAdmin_id());
                lectureService.updateLectureApyOfflineInfo(lectureApyVo);

                // 대기신청 승인시 메세지 발송
                if("2".equals(lectureApyVo.getApy_status()) && "1".equals(lectureApyVo.getAppv_cd())) {
                    // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    if ("yes".equals(EgovProperties.getProperty("msg.send"))) {
                        LectureVo lectureVo = lectureService.selectLecureInfoByIdx(lectureApyVo.getLecture_idx());
                        GroupVo groupVo = lectureService.selectGroupInfoByIdx((int) lectureVo.getGroup_idx());

                        StringBuffer sb = new StringBuffer();
                        sb.append("[송파구청 송파쌤(SSEM)]");
                        sb.append("\r\n");
                        sb.append(String.format("%s님의 프로그램 대기요청이 신청처리 되었습니다.", lectureApyVo.getApy_name()));
                        sb.append("\r\n");
                        sb.append("<대기 신청내역>");
                        sb.append("\r\n");
                        sb.append(String.format("- 프로그램: %s", lectureVo.getName()));
                        sb.append("\r\n");
                        sb.append("결제 또는 프로그램 신청 확인은 마이페이지를 참고해주세요.");
                        sb.append("\r\n");
                        sb.append("감사합니다.");
                        sb.append("\r\n");
                        sb.append(String.format("☎ 문의: %s", groupVo.getTel_no()));
                        sb.append("\r\n");
                        sb.append(String.format("송파쌤(SSEM) %s", groupVo.getName()));

                        msgService.sendMsgKakao("대기신청 처리안내", sb.toString(), lectureApyVo.getApy_name(), lectureApyVo.getApy_mob_no().replaceAll("-", ""), "10209");
                    }
                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                }
                // 환불처리시 메세지 발송
                if("5".equals(lectureApyVo.getPay_status())) {
                    // MSG Send ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    if ("yes".equals(EgovProperties.getProperty("msg.send"))) {
                        LectureVo lectureVo = lectureService.selectLecureInfoByIdx(lectureApyVo.getLecture_idx());
                        GroupVo groupVo = lectureService.selectGroupInfoByIdx((int) lectureVo.getGroup_idx());

                        StringBuffer sb = new StringBuffer();
                        sb.append("[송파구청 송파쌤(SSEM)]");
                        sb.append("\r\n");
                        sb.append(String.format("%s님의 환불신청이 처리되었습니다.", lectureApyVo.getApy_name()));
                        sb.append("\r\n");
                        sb.append("<환불처리내역>");
                        sb.append("\r\n");
                        sb.append(String.format("- 프로그램: %s", lectureVo.getName()));
                        sb.append("\r\n");
                        sb.append("상세내역은 담당기관에 문의하시기 바랍니다.");
                        sb.append("\r\n");
                        sb.append("감사합니다.");
                        sb.append("\r\n");
                        sb.append(String.format("☎ 문의: %s", groupVo.getTel_no()));
                        sb.append("\r\n");
                        sb.append(String.format("송파쌤(SSEM) %s", groupVo.getName()));

                        msgService.sendMsgKakao("환불처리 안내", sb.toString(), lectureApyVo.getApy_name(), lectureApyVo.getApy_mob_no().replaceAll("-", ""), "10208");
                    }
                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/lecture/apply_view.do?lecture_idx=" + lectureApyVo.getLecture_idx());
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/lect_student_list.do")
    public String lect_student_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/lect_student_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            /*if(!"S".equals(adminLoginVo.getType())) {
                if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }

                if ("".equals(searchVo.getSearchVal3())) {
                    searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                    model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
                }
            } else {
                if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }
            }*/

            /*if("".equals(searchVo.getSearchVal2())) {
                searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
            }

            if("".equals(searchVo.getSearchVal3())) {
                searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
            }*/

            if(!"S".equals(adminLoginVo.getType())) {
                if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }

                if ("".equals(searchVo.getSearchVal3())) {
                    searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                    model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
                }
            } else {
                /*if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }*/
            }

            if(!"".equals(searchVo.getSearchVal8())) {
                List<String> searchArrayVal = Util.transStringToList(searchVo.getSearchVal8(), " ");
                if(searchArrayVal.size() != 0) {
                    searchVo.setSearchArrayVal(searchArrayVal);
                }
            }

            List<LectureVo> itemList = lectureService.selectLectureStudentList(searchVo);
            for(LectureVo lecture : itemList) {
                int student_cnt = lectureService.selectLectureStudentCntByIdx(lecture.getLecture_idx());
                lecture.setStudent_cnt(student_cnt);
                // 프로그램 상태 체크
                // 1. 접수대기 : 접수날짜 도래 하지 않음
                // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                // 5. 교육전 :
                // 6. 교육중 : 교육날짜 내
                // 7. 교육종료 : 교육날짜 지남
                // 8. 외부홈페이지 : 외부 홈페이지일 경우
                int code_val = Util.getProgramStatus(lecture);
                lecture.setStatus_code(code_val);
            }
            int totalCount = lectureService.selectLectureStudentListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);

            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            // 교육대상
            List<CodeVo> tgtList = appService.selectCodeList("STUDY_TGT");
            model.addAttribute("tgtList", tgtList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/lect_student_view.do")
    public String lect_student_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/lect_student_view";
        String menu_url = "cont/lecture/lect_student_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        int lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForLectureApy(request, 10, String.valueOf(lecture_idx));
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            /*int lecture_idx = 0;
            if(!"".equals(searchVo.getSearchVal7())) {
                lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", Integer.parseInt(searchVo.getSearchVal7()));
            } else {
                lecture_idx = ServletRequestUtils.getIntParameter(request, "lecture_idx", 0);
            }*/

            LectureVo lectureVo = new LectureVo();
            lectureVo.setLecture_idx(lecture_idx);

            lectureVo = lectureService.selectLectureInfo(lectureVo);

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

            //교육대상 가져오기
            List<String> array_tgt = new ArrayList<String>();
            String tgt_code = lectureVo.getTgt_code();
            String[] tokens = tgt_code.split(",");
            for(String codeStr : tokens) {
                String code_txt = appService.selectCodeByIdx(Integer.parseInt(codeStr));
                array_tgt.add(code_txt);
            }
            lectureVo.setArray_tgt(array_tgt);

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

            model.addAttribute("lectureVo", lectureVo);

            // 교육생 리스트
            searchVo.setSearchVal7(String.valueOf(lecture_idx));
            searchVo.setSearchVal6("1");

            List<LectureApyVo> itemList = lectureService.selectLectureApyList(searchVo);
            int totalCount = lectureService.selectLectureApyListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/lect_student_detail.do")
    public String lect_student_detail(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/lect_student_detail";
        String menu_url = "cont/lecture/lect_student_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int lecture_apy_idx = 0;
            if(!"".equals(searchVo.getSearchVal7())) {
                lecture_apy_idx = ServletRequestUtils.getIntParameter(request, "lecture_apy_idx", Integer.parseInt(searchVo.getSearchVal7()));
            } else {
                lecture_apy_idx = ServletRequestUtils.getIntParameter(request, "lecture_apy_idx", 0);
            }

            LectureApyVo lectureApyVo = lectureService.selectLectureApyInfoByIdx(lecture_apy_idx);

            int lecture_idx = (int)lectureApyVo.getLecture_idx();

            LectureVo lectureVo = new LectureVo();
            lectureVo.setLecture_idx(lecture_idx);

            lectureVo = lectureService.selectLectureInfo(lectureVo);

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

            //교육대상 가져오기
            List<String> array_tgt = new ArrayList<>();
            String tgt_code = lectureVo.getTgt_code();
            String[] tokens = tgt_code.split(",");
            for(String codeStr : tokens) {
                String code_txt = appService.selectCodeByIdx(Integer.parseInt(codeStr));
                array_tgt.add(code_txt);
            }
            lectureVo.setArray_tgt(array_tgt);

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

            model.addAttribute("lectureVo", lectureVo);
            model.addAttribute("lectureApyVo", lectureApyVo);

            // 수강이력 정보는 반드시 APY_ID가 있는 경우에 표시한다. - 승인처리된 데이터
            // searchVal8 => 유저아이디
            if(!"".equals(Util.nvl(lectureApyVo.getApy_id()))) {
                searchVo.setSearchVal8(lectureApyVo.getApy_id());
                List<LectureApyVo> itemList = lectureService.selectLectureUserHistoryList(searchVo);
                for(LectureApyVo apply : itemList) {
                    LectureVo lecture = lectureService.selectLectureByIdx(apply.getLecture_idx());

                    // 프로그램 상태 체크
                    // 1. 접수대기 : 접수날짜 도래 하지 않음
                    // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                    // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                    // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                    // 5. 교육전 :
                    // 6. 교육중 : 교육날짜 내
                    // 7. 교육종료 : 교육날짜 지남
                    // 8. 외부홈페이지 : 외부 홈페이지일 경우
                    int code_val = Util.getProgramStatus(lecture);
                    lecture.setStatus_code(code_val);

                    apply.setLectureVo(lecture);

                    if(Util.nvl(apply.getDiscount_idx(), 0) != 0) {
                        DiscountVo discountVo = lectureService.selectDiscountByIdx((int)apply.getDiscount_idx());
                        apply.setDiscountVo(discountVo);
                    }
                }
                int totalCount = lectureService.selectLectureUserHistoryListTotal(searchVo);
                PageHolder pageholder = this.setPageNumRow(request, totalCount);

                model.addAttribute("pageholder", pageholder);
                model.addAttribute("totalCount", totalCount);
                model.addAttribute("itemList", itemList);
            }
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/lect_student_update.do", method = RequestMethod.POST)
    public String lect_student_upproc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("lectureApyVo") LectureApyVo lectureApyVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {
                lectureApyVo.setUp_id(adminLoginVo.getAdmin_id());

                lectureService.updateLectureApyCompleteInfo(lectureApyVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/lecture/lect_student_detail.do?lecture_apy_idx=" + lectureApyVo.getLecture_apy_idx());
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/student_list.do")
    public String student_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/student_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(!"S".equals(adminLoginVo.getType())) {
                if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }

                if ("".equals(searchVo.getSearchVal3())) {
                    searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                    model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
                }
            } else {
                /*if ("".equals(searchVo.getSearchVal2())) {
                    searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                    model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
                }*/
            }

            List<StudentVo> itemList = lectureService.selectStudentList(searchVo);
            int totalCount = lectureService.selectStudentListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/student_view.do")
    public String student_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/student_view";
        String menu_url = "cont/lecture/student_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        int student_idx = ServletRequestUtils.getIntParameter(request, "student_idx", 0);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForStudent(request, 10, String.valueOf(student_idx));
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            StudentVo studentVo = lectureService.selectStudentInfoByIdx(student_idx);

            // 메모 엔터처리
            String memo = studentVo.getMemo();
            if(memo != null) {
                memo = memo.replaceAll(System.getProperty("line.separator"), "<br/>");
                studentVo.setMemo_html(memo);
            }

            model.addAttribute("studentVo", studentVo);

            // 수강이력 정보는 반드시 USER_ID가 있는 경우에 표시한다. - 승인처리된 데이터
            // searchVal8 => 유저아이디
            if(!"".equals(Util.nvl(studentVo.getUser_id()))) {
                searchVo.setSearchVal8(studentVo.getUser_id());
                List<LectureApyVo> itemList = lectureService.selectLectureUserHistoryList(searchVo);
                for(LectureApyVo apply : itemList) {
                    LectureVo lecture = lectureService.selectLectureByIdx(apply.getLecture_idx());

                    // 프로그램 상태 체크
                    // 1. 접수대기 : 접수날짜 도래 하지 않음
                    // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                    // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                    // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                    // 5. 교육전 :
                    // 6. 교육중 : 교육날짜 내
                    // 7. 교육종료 : 교육날짜 지남
                    // 8. 외부홈페이지 : 외부 홈페이지일 경우
                    int code_val = Util.getProgramStatus(lecture);
                    lecture.setStatus_code(code_val);

                    apply.setLectureVo(lecture);

                    if(Util.nvl(apply.getDiscount_idx(), 0) != 0) {
                        DiscountVo discountVo = lectureService.selectDiscountByIdx((int)apply.getDiscount_idx());
                        apply.setDiscountVo(discountVo);
                    }
                }
                int totalCount = lectureService.selectLectureUserHistoryListTotal(searchVo);
                PageHolder pageholder = this.setPageNumRow(request, totalCount);

                model.addAttribute("pageholder", pageholder);
                model.addAttribute("totalCount", totalCount);
                model.addAttribute("itemList", itemList);
            }
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/student_like_insert.do", method = RequestMethod.POST)
    public String student_view_upproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("studentVo") StudentVo studentVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {
                studentVo.setUp_id(adminLoginVo.getAdmin_id());

                lectureService.updateStudentInfo(studentVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/lecture/student_view.do?student_idx=" + studentVo.getStudent_idx());
                model.addAttribute("altmsg", "등록되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "등록에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/teacher_list.do")
    public String teacher_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/teacher_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if("".equals(searchVo.getSearchVal2())) {
                searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
            }

            if("".equals(searchVo.getSearchVal3())) {
                searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
            }

            List<TeacherVo> itemList = lectureService.selectTeacherList(searchVo);
            for(TeacherVo teacher : itemList) {
                String code_name = appService.selectCodeByIdx(teacher.getCode_idx());
                teacher.setCode_name(code_name);
            }
            int totalCount = lectureService.selectTeacherListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);

            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/teacher_inscr.do", method = RequestMethod.GET)
    public String teacher_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/teacher_inscr";
        String menu_url = "cont/lecture/teacher_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);

            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/teacher_inscr.do", method = RequestMethod.POST)
    public String teacher_inproc(final MultipartHttpServletRequest multiRequest,
                              @ModelAttribute("teacherVo") TeacherVo teacherVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {
                // 사진파일 처리
                CommonVo cmm = this.getAttachImgFileInfoEx(multiRequest, "pic_atch_file_id");
                if (cmm.isFtype_flag()) {
                    // 사진파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PIC_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    teacherVo.setPic_atch_file_id(atchFileId);
                    teacherVo.setReg_id(adminLoginVo.getAdmin_id());

                    if(teacherVo.getGroup_idx() == 0) {
                        teacherVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    }

                    lectureService.insertTeacherInfo(teacherVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/lecture/teacher_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/teacher_view.do")
    public String teacher_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/teacher_view";
        String menu_url = "cont/lecture/teacher_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        int teacher_idx = ServletRequestUtils.getIntParameter(request, "teacher_idx", 0);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearchForTeacher(request, 10, String.valueOf(teacher_idx));
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if(teacher_idx == 0) {
                teacher_idx = Integer.parseInt(searchVo.getSearchVal4());
            }

            TeacherVo teacherVo = new TeacherVo();
            teacherVo.setTeacher_idx(teacher_idx);

            teacherVo = lectureService.selectTeacherInfo(teacherVo);

            // 첨부파일 처리
            String atchFileId = teacherVo.getPic_atch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            teacherVo.setPicFileList(fileVoList);

            // score => 0 : 평가 없음
            // score => 1 : 금
            // score => 2 : 은
            // score => 3 : 동
            int score = 0;
            int total_cnt = lectureService.selectTeacherScoreTotalCnt(teacherVo);
            if(total_cnt != 0) {
                int total_score = lectureService.selectTeacherScoreTotal(teacherVo);
                score = Util.getTeacherScore(total_cnt, total_score);
            } else {
                score = 0;
            }
            teacherVo.setScore(score);

            model.addAttribute("teacherVo", teacherVo);

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);

            List<CodeVo> codeList = appService.selectCodeList("STUDY_CATE");
            model.addAttribute("codeList", codeList);

            if("".equals(searchVo.getSearchVal2())) {
                searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
            }

            if("".equals(searchVo.getSearchVal3())) {
                searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
            }

            if("".equals(searchVo.getSearchVal4())) {
                searchVo.setSearchVal4(String.valueOf(teacherVo.getTeacher_idx()));
            }

            List<LectureVo> itemList = lectureService.selectLectureForTeacherList(searchVo);
            for(LectureVo lecture : itemList) {
                // 프로그램 상태 체크
                // 1. 접수대기 : 접수날짜 도래 하지 않음
                // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
                // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
                // 4. 신청마감 : 신청인원 마감되고, 대기인원도 마감됨, 마감일 도래한 경우
                // 5. 교육전 :
                // 6. 교육중 : 교육날짜 내
                // 7. 교육종료 : 교육날짜 지남
                // 8. 외부홈페이지 : 외부 홈페이지일 경우
                int code = Util.getProgramStatus(lecture);
                lecture.setStatus_code(code);
            }
            int totalCount = lectureService.selectLectureForTeacherListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/teacher_update.do", method = RequestMethod.POST)
    public String teacher_update(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("teacherVo") TeacherVo teacherVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                // 첨부파일 처리
                CommonVo cmm = this.getAttachImgFileInfoEx(multiRequest, "pic_atch_file_id");

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(teacherVo.getPic_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PIC_",cnt, teacherVo.getPic_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PIC_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            teacherVo.setPic_atch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(teacherVo.getPic_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            teacherVo.setPic_atch_file_id("");
                        }
                    }

                    teacherVo.setUp_id(adminLoginVo.getAdmin_id());

                    if(teacherVo.getGroup_idx() == 0) {
                        teacherVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    }

                    lectureService.updateTeacherInfo(teacherVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/lecture/teacher_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/teacher_program_update.do", method = RequestMethod.POST)
    public String teacher_program_update(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("lectureVo") LectureVo lectureVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            } else {
                lectureVo.setUp_id(adminLoginVo.getAdmin_id());

                lectureService.updateLectureForTeacher(lectureVo);

                model.addAttribute("msg", "alterCloseCReload");
                model.addAttribute("altmsg", "프로그램이 등록되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/teacher_delete.do", method = RequestMethod.POST)
    public String teacher_delete(final MultipartHttpServletRequest multiRequest,
                              @ModelAttribute("teacherVo") TeacherVo teacherVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {
                // 강사 사용여부 확인 할 것
                int teacher_count = lectureService.selectTeacherUseYn(teacherVo);
                if(teacher_count == 0) {
                    lectureService.deleteTeacherInfo(teacherVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/lecture/teacher_list.do");
                    model.addAttribute("altmsg", "삭제 되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "해당 강사는 프로그램과 연동된 정보가 존재합니다.<br/>프로그램 연동 정보를 확인 후 삭제해 주세요.");
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/room_list.do")
    public String room_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/room_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if("".equals(searchVo.getSearchVal2())) {
                searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
            }

            if("".equals(searchVo.getSearchVal3())) {
                searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
            }

            List<GroupVo> itemList = lectureService.selectGroupRoomList(searchVo);
            int totalCount = lectureService.selectGroupRoomListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);


            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/room_item_list.do")
    public String room_item_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/room_item_list";
        String menu_url = "cont/lecture/room_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);
            searchVo.setSearchKind(String.valueOf(group_idx));

            List<StudyPlaceVo> itemList = lectureService.selectRoomList(searchVo);
            int totalCount = lectureService.selectRoomListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            GroupVo groupVo = lectureService.selectGroupInfoByIdx(group_idx);
            int room_cnt = lectureService.selectRoomCntByGroupIdx(group_idx);
            groupVo.setRoom_cnt(room_cnt);
            model.addAttribute("groupVo", groupVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/room_inscr.do", method = RequestMethod.POST)
    public String room_inproc(final MultipartHttpServletRequest multiRequest,
                                  @ModelAttribute("studyPlaceVo") StudyPlaceVo studyPlaceVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {
                studyPlaceVo.setReg_id(adminLoginVo.getAdmin_id());

                lectureService.insertRoomInfo(studyPlaceVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/lecture/room_item_list.do?group_idx=" + studyPlaceVo.getGroup_idx());
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/room_upscr.do", method = RequestMethod.POST)
    public String room_upproc(final MultipartHttpServletRequest multiRequest,
                                  @ModelAttribute("studyPlaceVo") StudyPlaceVo studyPlaceVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {
                studyPlaceVo.setUp_id(adminLoginVo.getAdmin_id());

                lectureService.updateRoomInfo(studyPlaceVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/lecture/room_item_list.do?group_idx=" + studyPlaceVo.getGroup_idx());
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/room_delete.do", method = RequestMethod.POST)
    public String room_delete(final MultipartHttpServletRequest multiRequest,
                                  @ModelAttribute("studyPlaceVo") StudyPlaceVo studyPlaceVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {


                // 감면율 사용여부 확인 할 것
                int room_count = lectureService.selectRoomUseYn(studyPlaceVo);
                if(room_count == 0) {
                    lectureService.deleteRoomInfo(studyPlaceVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/lecture/room_item_list.do?group_idx=" + studyPlaceVo.getGroup_idx());
                    model.addAttribute("altmsg", "삭제 되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "해당 교육시설은 프로그램과 연동된 정보가 존재합니다.<br/>프로그램 연동 정보를 확인 후 삭제해 주세요.");
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/discount_list.do")
    public String discount_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/discount_list";
        String in_url = "/" + ret_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if("".equals(searchVo.getSearchVal2())) {
                searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
            }

            if("".equals(searchVo.getSearchVal3())) {
                searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
            }

            List<GroupVo> itemList = lectureService.selectGroupDiscountList(searchVo);
            int totalCount = lectureService.selectGroupDiscountListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);


            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/discount_item_list.do")
    public String discount_item_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/discount_item_list";
        String menu_url = "cont/lecture/discount_list";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = null;
        int group_idx = ServletRequestUtils.getIntParameter(request, "group_idx", 0);
        if(group_idx != 0) {
            searchVo = this.getSearch(request, 10, group_idx);
        } else {
            searchVo = this.getSearch(request);
        }
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            List<DiscountVo> itemList = lectureService.selectDiscountList(searchVo);
            int totalCount = lectureService.selectDiscountListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", itemList);

            GroupVo groupVo = lectureService.selectGroupInfoByIdx(group_idx);
            model.addAttribute("groupVo", groupVo);

            // 감면율
            List<String> rateList = Util.getRateList();
            model.addAttribute("rateList", rateList);

        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/discount_inscr.do", method = RequestMethod.POST)
    public String discount_inproc(final MultipartHttpServletRequest multiRequest,
                              @ModelAttribute("discountVo") DiscountVo discountVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {
                discountVo.setReg_id(adminLoginVo.getAdmin_id());

                lectureService.insertDiscountInfo(discountVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/lecture/discount_item_list.do?group_idx=" + discountVo.getGroup_idx());
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/discount_upscr.do", method = RequestMethod.POST)
    public String discount_upproc(final MultipartHttpServletRequest multiRequest,
                                  @ModelAttribute("discountVo") DiscountVo discountVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {
                discountVo.setUp_id(adminLoginVo.getAdmin_id());

                lectureService.updateDiscountInfo(discountVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/lecture/discount_item_list.do?group_idx=" + discountVo.getGroup_idx());
                model.addAttribute("altmsg", "저장되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "저장에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/lecture/discount_delete.do", method = RequestMethod.POST)
    public String discount_delete(final MultipartHttpServletRequest multiRequest,
                                  @ModelAttribute("discountVo") DiscountVo discountVo,
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
            AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

            if(adminLoginVo == null) {
                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", Constants.login_url);
                model.addAttribute("altmsg", "로그인 후 사용가능합니다.");

                ret_url =  "common/message";
            } else {


                // 감면율 사용여부 확인 할 것
                int use_count = lectureService.selectDiscountUseYn(discountVo);
                if(use_count == 0) {
                    lectureService.deleteDiscountInfo(discountVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/lecture/discount_item_list.do?group_idx=" + discountVo.getGroup_idx());
                    model.addAttribute("altmsg", "삭제 되었습니다.");

                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "해당 감면정보는 프로그램과 연동된 정보가 존재합니다.<br/>프로그램 연동 정보를 확인 후 삭제해 주세요.");
                }
            }
        } catch (Exception e) {
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/lecture/room_status.do")
    public String room_status(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/lecture/room_status";
        String menu_url = "cont/lecture/room_status";
        String in_url = "/" + menu_url + Constants.global_ext;


        HttpSession session = request.getSession();
        AdminLoginVo adminLoginVo = (AdminLoginVo) session.getAttribute(Constants.ADMIN_LOGIN_VO);

        // 파라미터 세팅
        SearchVo searchVo = this.getSearch(request);
        this.getModel(request, model);

        // 공통
        MenuMstVo menuMstVo = this.getMenuMstInfo(in_url, adminLoginVo, "4");
        model  = this.setCommonModel(menuMstVo, model);

        if(adminLoginVo == null) {
            model.addAttribute("msg", "alterloc");
            model.addAttribute("locurl", Constants.login_url);
            model.addAttribute("altmsg", "로그인 후 사용가능합니다.");
            ret_url =  "common/message";
        } else {
            if(!"".equals(menuMstVo.getRet_url()))  {
                model.addAttribute("msg", "alterBack");
                model.addAttribute("altmsg", "접근권한이 없습니다.");

                return "common/message";
            }

            if("".equals(searchVo.getSearchVal2())) {
                searchVo.setSearchVal2(String.valueOf(adminLoginVo.getP_idx()));
                model.addAttribute("searchVal2", String.valueOf(adminLoginVo.getP_idx()));
            }

            if("".equals(searchVo.getSearchVal3())) {
                searchVo.setSearchVal3(String.valueOf(adminLoginVo.getGroup_idx()));
                model.addAttribute("searchVal3", String.valueOf(adminLoginVo.getGroup_idx()));
            }

            if(!"".equals(searchVo.getSearchVal4())) {
                // 선택된 강의실 정보를 가져온다.
                StudyPlaceVo studyPlaceVo = lectureService.selectStudyPlaceByIdx(Integer.parseInt(searchVo.getSearchVal4()));
                model.addAttribute("studyPlaceVo", studyPlaceVo);

                List<CalendarVo> calList = new ArrayList<CalendarVo>();

                // 해당 강의실의 프로그램 일정을 가져온다.
                List<LectureVo> lectureList = lectureService.selectLectureRoomList(searchVo);
                for(LectureVo lecture : lectureList) {
                    //일정을 추출한다.
                    // 1. 기간을 일단위로 분리
                    String start_dt = lecture.getStart_dt();
                    String end_dt = lecture.getEnd_dt();
                    String start_time = lecture.getStart_time();
                    String end_time = lecture.getEnd_time();
                    String dt_week = lecture.getDt_week();
                    String dt_type = lecture.getDt_type();
                    String group_id = String.valueOf(lecture.getLecture_idx());
                    // 2. 요일타입과 요일에 해당하는 날짜만 가져온다.
                    List<String> dates = DateUtil.getTwoDate(start_dt, end_dt, dt_week, dt_type);
                    for(String date : dates) {
                        CalendarVo cal = new CalendarVo();
                        cal.setGroupId(group_id);
                        cal.setTitle(lecture.getName());
                        cal.setStart(date + " " + start_time);
                        cal.setEnd(date + " " + end_time);
                        cal.setColor("#f58127");
                        cal.setTextColor("#fff");
                        cal.setUrl("/ssemadmin/cont/lecture/lecture_view.do?lecture_idx=" + lecture.getLecture_idx());

                        calList.add(cal);
                    }
                }

                // 수동예약 일정을 가져온다.
                List<RegStudyPlaceVo> regList = lectureService.selectRegStudyPlaceList(searchVo);
                for(RegStudyPlaceVo regStudyPlaceVo : regList) {
                    //일정을 추출한다.
                    // 1. 기간을 일단위로 분리
                    String start_dt = regStudyPlaceVo.getStart_dt().substring(0, 10);
                    String end_dt = regStudyPlaceVo.getEnd_dt().substring(0, 10);
                    String start_time = regStudyPlaceVo.getStart_time();
                    String end_time = regStudyPlaceVo.getEnd_time();
                    String dt_week = regStudyPlaceVo.getDt_week();
                    String dt_type = "";
                    String group_id = String.valueOf(regStudyPlaceVo.getReg_study_place_idx());
                    // 2. 요일타입과 요일에 해당하는 날짜만 가져온다.
                    List<String> dates = DateUtil.getTwoDate(start_dt, end_dt, dt_week, dt_type);
                    for(String date : dates) {
                        CalendarVo cal = new CalendarVo();
                        cal.setGroupId(group_id);
                        cal.setTitle(regStudyPlaceVo.getName());
                        cal.setStart(date + " " + start_time);
                        cal.setEnd(date + " " + end_time);
                        cal.setColor("#009688");
                        cal.setTextColor("#fff");
                        cal.setUrl("/ssemadmin/popup/lecture/reg_room_update.do?reg_study_place_idx=" + regStudyPlaceVo.getReg_study_place_idx());
                        cal.setPopup_yn("Y");

                        calList.add(cal);
                    }
                }

                model.addAttribute("calList", calList);
            }

            // 소속정보 가져오기
            List<GroupVo> masterGroupList = appService.getMasterGroupList();
            model.addAttribute("masterGroupList", masterGroupList);
        }

        return ret_url;
    }
}
