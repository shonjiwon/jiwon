package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.Constants;
import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.common.PageHolder;
import kr.go.songpa.ssem.model.*;
import kr.go.songpa.ssem.service.AppService;
import kr.go.songpa.ssem.service.BbsService;
import kr.go.songpa.ssem.service.FileMngService;
import kr.go.songpa.ssem.util.FileMngUtil;
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
import java.util.List;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-09-15
 * Description :
 * History :
 * Version :
 */
@Controller
public class CenterHomeController extends CommonController {

    @Autowired
    private AppService appService;

    @Autowired
    private FileMngService fileMngService;

    @Autowired
    private FileMngUtil fileUtil;

    @Autowired
    private BbsService bbsService;

    public CenterHomeController() {
    }

    @RequestMapping("/cont/center/dream_banner_list.do")
    public String dream_banner_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_banner_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("DREAM");

            List<BannerVo> bannerList = bbsService.selectBannerList(searchVo);
            int totalCount = bbsService.selectBannerListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bannerList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_banner_inscr.do", method = RequestMethod.GET)
    public String dream_banner_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_banner_inscr";
        String menu_url = "cont/center/dream_banner_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_banner_inscr.do", method = RequestMethod.POST)
    public String dream_banner_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                // 이미지파일 처리
                CommonVo cmm = this.getAttachImgFileInfoEx(multiRequest, "pic_atch_file_id");
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bannerVo.setAtch_file_id(atchFileId);
                    bannerVo.setReg_id(adminLoginVo.getAdmin_id());
                    bannerVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bannerVo.setGubun("DREAM"); // 송파진로체험지원센터(꿈마루)

                    bbsService.insertBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/dream_banner_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/dream_banner_view.do", method = RequestMethod.GET)
    public String dream_banner_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_banner_view";
        String menu_url = "cont/center/dream_banner_list";
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
            int banner_idx = ServletRequestUtils.getIntParameter(request, "banner_idx", 0);

            BannerVo bannerVo = new BannerVo();
            bannerVo.setBanner_idx(banner_idx);

            bannerVo = bbsService.selectBannerInfo(bannerVo);

            // 첨부파일 처리
            String atchFileId = bannerVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            bannerVo.setFileList(fileVoList);

            model.addAttribute("bannerVo", bannerVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_banner_view.do", method = RequestMethod.POST)
    public String dream_banner_view_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bannerVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_",cnt, bannerVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bannerVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bannerVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bannerVo.setAtch_file_id("");
                        }
                    }

                    bannerVo.setUp_id(adminLoginVo.getAdmin_id());
                    bannerVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bannerVo.setGubun("DREAM"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/dream_banner_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/dream_banner_delete.do", method = RequestMethod.POST)
    public String dream_banner_delete(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                bbsService.deleteBannerInfo(bannerVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/dream_banner_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_banner_ord.do", method = RequestMethod.POST)
    public String dream_banner_ord_proc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bannerVo") BannerVo bannerVo,
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

                // 슨서 처리
                if(bannerVo.getOrdList().size() > 0) {
                    for (OrdVo ord : bannerVo.getOrdList()) {
                        bbsService.updateBannerOrd(ord);
                    }
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/dream_banner_list.do");
                model.addAttribute("altmsg", "수정 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
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

    @RequestMapping("/cont/center/dream_together.do")
    public String dream_together(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_together";
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
            List<TogetherVo> togetherList = bbsService.selectTogetherInfo();

            String img_path = EgovProperties.getProperty("bd.file.url.path");

            for(TogetherVo together : togetherList) {
                // 첨부파일 처리
                String atchFileId = together.getAtch_file_id();
                FileVo fvo = new FileVo();
                fvo.setAtch_file_id(atchFileId);
                List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                for (FileVo fileVo : fileVoList) {
                    fileVo.setFile_src(img_path + "/" + fileVo.getFile_nm());
                }

                together.setFileList(fileVoList);

                /*if(together.getIdx() == 1) {
                    together.setOneFileList(fileVoList);
                } else if(together.getIdx() == 2) {
                    together.setOneFileList(fileVoList);
                } else if(together.getIdx() == 2) {
                    together.setOneFileList(fileVoList);
                } else if(together.getIdx() == 2) {
                    together.setOneFileList(fileVoList);
                } else if(together.getIdx() == 2) {
                    together.setOneFileList(fileVoList);
                } else if(together.getIdx() == 2) {
                    together.setOneFileList(fileVoList);
                }*/
            }

            model.addAttribute("togetherList", togetherList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_together.do", method = RequestMethod.POST)
    public String dream_together_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("togetherVo") TogetherVo togetherVo,
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
                CommonVo cmm1 = this.getAttachFileInfoEx(multiRequest, "atch_file_id_1");
                CommonVo cmm2 = this.getAttachFileInfoEx(multiRequest, "atch_file_id_2");
                CommonVo cmm3 = this.getAttachFileInfoEx(multiRequest, "atch_file_id_3");
                CommonVo cmm4 = this.getAttachFileInfoEx(multiRequest, "atch_file_id_4");
                CommonVo cmm5 = this.getAttachFileInfoEx(multiRequest, "atch_file_id_5");
                CommonVo cmm6 = this.getAttachFileInfoEx(multiRequest, "atch_file_id_6");

                TogetherVo together = new TogetherVo();

                if(cmm1.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    together.setIdx(1);

                    if(cmm1.getChkcnt() > 0){

                        List<FileVo> result = fileUtil.parseFileInf(cmm1.getTmpfiles(), "TG_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);

                        if(!"".equals(togetherVo.getAtch_file_id_one())) {
                            // 업데이트
                            together.setUp_id(adminLoginVo.getAdmin_id());
                            together.setAtch_file_id(atchFileId);
                        } else {
                            // 신규
                            together.setReg_id(adminLoginVo.getAdmin_id());
                            together.setAtch_file_id(atchFileId);
                        }

                        bbsService.updateTogetherInfo(together);

                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                if(cmm2.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    together.setIdx(2);

                    if(cmm2.getChkcnt() > 0){

                        List<FileVo> result = fileUtil.parseFileInf(cmm2.getTmpfiles(), "TG_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);

                        if(!"".equals(togetherVo.getAtch_file_id_two())) {
                            // 업데이트
                            together.setUp_id(adminLoginVo.getAdmin_id());
                            together.setAtch_file_id(atchFileId);
                        } else {
                            // 신규
                            together.setReg_id(adminLoginVo.getAdmin_id());
                            together.setAtch_file_id(atchFileId);
                        }

                        bbsService.updateTogetherInfo(together);

                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                if(cmm3.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    together.setIdx(3);

                    if(cmm3.getChkcnt() > 0){

                        List<FileVo> result = fileUtil.parseFileInf(cmm3.getTmpfiles(), "TG_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);

                        if(!"".equals(togetherVo.getAtch_file_id_three())) {
                            // 업데이트
                            together.setUp_id(adminLoginVo.getAdmin_id());
                            together.setAtch_file_id(atchFileId);
                        } else {
                            // 신규
                            together.setReg_id(adminLoginVo.getAdmin_id());
                            together.setAtch_file_id(atchFileId);
                        }

                        bbsService.updateTogetherInfo(together);

                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                if(cmm4.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    together.setIdx(4);

                    if(cmm4.getChkcnt() > 0){

                        List<FileVo> result = fileUtil.parseFileInf(cmm4.getTmpfiles(), "TG_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);

                        if(!"".equals(togetherVo.getAtch_file_id_four())) {
                            // 업데이트
                            together.setUp_id(adminLoginVo.getAdmin_id());
                            together.setAtch_file_id(atchFileId);
                        } else {
                            // 신규
                            together.setReg_id(adminLoginVo.getAdmin_id());
                            together.setAtch_file_id(atchFileId);
                        }

                        bbsService.updateTogetherInfo(together);

                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                if(cmm5.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    together.setIdx(5);

                    if(cmm5.getChkcnt() > 0){

                        List<FileVo> result = fileUtil.parseFileInf(cmm5.getTmpfiles(), "TG_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);

                        if(!"".equals(togetherVo.getAtch_file_id_five())) {
                            // 업데이트
                            together.setUp_id(adminLoginVo.getAdmin_id());
                            together.setAtch_file_id(atchFileId);
                        } else {
                            // 신규
                            together.setReg_id(adminLoginVo.getAdmin_id());
                            together.setAtch_file_id(atchFileId);
                        }

                        bbsService.updateTogetherInfo(together);

                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                if(cmm6.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    together.setIdx(6);

                    if(cmm6.getChkcnt() > 0){

                        List<FileVo> result = fileUtil.parseFileInf(cmm6.getTmpfiles(), "TG_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);

                        if(!"".equals(togetherVo.getAtch_file_id_six())) {
                            // 업데이트
                            together.setUp_id(adminLoginVo.getAdmin_id());
                            together.setAtch_file_id(atchFileId);
                        } else {
                            // 신규
                            together.setReg_id(adminLoginVo.getAdmin_id());
                            together.setAtch_file_id(atchFileId);
                        }

                        bbsService.updateTogetherInfo(together);

                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/dream_together.do");
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

    @RequestMapping("/cont/center/dream_notice_list.do")
    public String dream_notice_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_notice_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("DREAM");
            searchVo.setSearchVal3("B");

            List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
            int totalCount = bbsService.selectbbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_notice_inscr.do", method = RequestMethod.GET)
    public String dream_notice_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_notice_inscr";
        String menu_url = "cont/center/dream_notice_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_notice_inscr.do", method = RequestMethod.POST)
    public String dream_notice_inproc(final MultipartHttpServletRequest multiRequest,
                                    @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("DREAM"); // 송파진로체험지원센터(꿈마루)
                    bbsDetailVo.setType_cd("B");
                    bbsDetailVo.setMain_use_yn("N");
                    bbsDetailVo.setP_top_yn("N");

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/dream_notice_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/dream_notice_view.do", method = RequestMethod.GET)
    public String dream_notice_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_notice_view";
        String menu_url = "cont/center/dream_notice_list";
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

            model.addAttribute("bbsDetailVo", bbsDetailVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_notice_view.do", method = RequestMethod.POST)
    public String dream_notice_view_proc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("DREAM"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/dream_notice_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/dream_notice_delete.do", method = RequestMethod.POST)
    public String dream_notice_delete(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/dream_notice_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/center/dream_press_list.do")
    public String dream_press_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_press_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("DREAM");
            searchVo.setSearchVal3("P");

            List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
            int totalCount = bbsService.selectbbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_press_inscr.do", method = RequestMethod.GET)
    public String dream_press_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_press_inscr";
        String menu_url = "cont/center/dream_press_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_press_inscr.do", method = RequestMethod.POST)
    public String dream_press_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PR_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("DREAM"); // 송파진로체험지원센터(꿈마루)
                    bbsDetailVo.setType_cd("P"); // 보도자료

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/dream_press_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/dream_press_view.do", method = RequestMethod.GET)
    public String dream_press_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_press_view";
        String menu_url = "cont/center/dream_press_list";
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

            model.addAttribute("bbsDetailVo", bbsDetailVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_press_view.do", method = RequestMethod.POST)
    public String dream_press_view_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PR_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "PR_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("DREAM"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/dream_press_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/dream_press_delete.do", method = RequestMethod.POST)
    public String dream_press_delete(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/dream_press_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/center/dream_gallery_list.do")
    public String dream_gallery_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_gallery_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("DREAM");
            searchVo.setSearchVal3("G");

            List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
            int totalCount = bbsService.selectbbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_gallery_inscr.do", method = RequestMethod.GET)
    public String dream_gallery_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_gallery_inscr";
        String menu_url = "cont/center/dream_gallery_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_gallery_inscr.do", method = RequestMethod.POST)
    public String dream_gallery_inproc(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                // 썸네일 등록 정보
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "GA_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        thumbFileid = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setThumb_atch_file_id(thumbFileid);
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "GA_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("DREAM"); // 송파진로체험지원센터(꿈마루)
                    bbsDetailVo.setType_cd("G"); // 갤러리

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/dream_gallery_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/dream_gallery_view.do", method = RequestMethod.GET)
    public String dream_gallery_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/dream_gallery_view";
        String menu_url = "cont/center/dream_gallery_list";
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

            model.addAttribute("bbsDetailVo", bbsDetailVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/dream_gallery_view.do", method = RequestMethod.POST)
    public String dream_gallery_view_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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

                // 썸네일 처리
                CommonVo thumb_img = this.getAttachImgFileInfoEx(multiRequest, "thumb_atch_file_id");
                if (thumb_img.isFtype_flag()) {
                    String thumbFileid = "";
                    if (thumb_img.getChkcnt() > 0) {

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getThumb_atch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "GA_",cnt, bbsDetailVo.getThumb_atch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(thumb_img.getTmpfiles(), "GA_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            thumbFileid = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setThumb_atch_file_id(thumbFileid);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getThumb_atch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setThumb_atch_file_id("");
                        }
                    }
                } else {
                    model.addAttribute("msg", "alterBack");
                    model.addAttribute("altmsg", "허용되지 않은 파일 형태 입니다.");
                    return ret_url;
                }

                // 첨부파일 처리
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "GA_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "GA_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("DREAM"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/dream_gallery_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/dream_gallery_delete.do", method = RequestMethod.POST)
    public String dream_gallery_delete(final MultipartHttpServletRequest multiRequest,
                                     @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/dream_gallery_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/center/songpa_banner_list.do")
    public String songpa_banner_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/songpa_banner_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("SONGPA");

            List<BannerVo> bannerList = bbsService.selectBannerList(searchVo);
            int totalCount = bbsService.selectBannerListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bannerList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/songpa_banner_inscr.do", method = RequestMethod.GET)
    public String songpa_banner_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/songpa_banner_inscr";
        String menu_url = "cont/center/songpa_banner_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/songpa_banner_inscr.do", method = RequestMethod.POST)
    public String songpa_banner_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                // 이미지파일 처리
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bannerVo.setAtch_file_id(atchFileId);
                    bannerVo.setReg_id(adminLoginVo.getAdmin_id());
                    bannerVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bannerVo.setGubun("SONGPA"); // 송파진로체험지원센터(꿈마루)

                    bbsService.insertBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/songpa_banner_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/songpa_banner_view.do", method = RequestMethod.GET)
    public String songpa_banner_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/songpa_banner_view";
        String menu_url = "cont/center/songpa_banner_list";
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
            int banner_idx = ServletRequestUtils.getIntParameter(request, "banner_idx", 0);

            BannerVo bannerVo = new BannerVo();
            bannerVo.setBanner_idx(banner_idx);

            bannerVo = bbsService.selectBannerInfo(bannerVo);

            // 첨부파일 처리
            String atchFileId = bannerVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            bannerVo.setFileList(fileVoList);

            model.addAttribute("bannerVo", bannerVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/songpa_banner_view.do", method = RequestMethod.POST)
    public String songpa_banner_view_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bannerVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_",cnt, bannerVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bannerVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bannerVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bannerVo.setAtch_file_id("");
                        }
                    }

                    bannerVo.setUp_id(adminLoginVo.getAdmin_id());
                    bannerVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bannerVo.setGubun("SONGPA"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/songpa_banner_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/songpa_banner_delete.do", method = RequestMethod.POST)
    public String songpa_banner_delete(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                bbsService.deleteBannerInfo(bannerVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/songpa_banner_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/songpa_banner_ord.do", method = RequestMethod.POST)
    public String songpa_banner_ord_proc(final MultipartHttpServletRequest multiRequest,
                                        @ModelAttribute("bannerVo") BannerVo bannerVo,
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

                // 슨서 처리
                if(bannerVo.getOrdList().size() > 0) {
                    for (OrdVo ord : bannerVo.getOrdList()) {
                        bbsService.updateBannerOrd(ord);
                    }
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/songpa_banner_list.do");
                model.addAttribute("altmsg", "수정 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
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

    @RequestMapping("/cont/center/songpa_notice_list.do")
    public String songpa_notice_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/songpa_notice_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("SONGPA");
            searchVo.setSearchVal3("B");

            List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
            int totalCount = bbsService.selectbbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/songpa_notice_inscr.do", method = RequestMethod.GET)
    public String songpa_notice_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/songpa_notice_inscr";
        String menu_url = "cont/center/songpa_notice_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/songpa_notice_inscr.do", method = RequestMethod.POST)
    public String songpa_notice_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("SONGPA"); // 송파진로체험지원센터(꿈마루)
                    bbsDetailVo.setType_cd("B");
                    bbsDetailVo.setMain_use_yn("N");
                    bbsDetailVo.setP_top_yn("N");

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/songpa_notice_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/songpa_notice_view.do", method = RequestMethod.GET)
    public String songpa_notice_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/songpa_notice_view";
        String menu_url = "cont/center/songpa_notice_list";
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

            model.addAttribute("bbsDetailVo", bbsDetailVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/songpa_notice_view.do", method = RequestMethod.POST)
    public String songpa_notice_view_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("SONGPA"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/songpa_notice_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/songpa_notice_delete.do", method = RequestMethod.POST)
    public String songpa_notice_delete(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/songpa_notice_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/center/songpa_guest_list.do")
    public String songpa_guest_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/songpa_guest_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("SONGPA");
            searchVo.setSearchVal3("F");

            List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
            int totalCount = bbsService.selectbbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/songpa_guest_inscr.do", method = RequestMethod.GET)
    public String songpa_guest_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/songpa_guest_inscr";
        String menu_url = "cont/center/songpa_guest_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/songpa_guest_inscr.do", method = RequestMethod.POST)
    public String songpa_guest_inproc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("SONGPA"); // 송파진로체험지원센터(꿈마루)
                    bbsDetailVo.setType_cd("F");

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/songpa_guest_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/songpa_guest_view.do", method = RequestMethod.GET)
    public String songpa_guest_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/songpa_guest_view";
        String menu_url = "cont/center/songpa_guest_list";
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

            model.addAttribute("bbsDetailVo", bbsDetailVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/songpa_guest_view.do", method = RequestMethod.POST)
    public String songpa_guest_view_proc(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("SONGPA"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/songpa_guest_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/songpa_guest_delete.do", method = RequestMethod.POST)
    public String songpa_guest_delete(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/songpa_guest_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/center/machun_banner_list.do")
    public String machun_banner_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/machun_banner_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("MACHUN");

            List<BannerVo> bannerList = bbsService.selectBannerList(searchVo);
            int totalCount = bbsService.selectBannerListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bannerList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/machun_banner_inscr.do", method = RequestMethod.GET)
    public String machun_banner_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/machun_banner_inscr";
        String menu_url = "cont/center/machun_banner_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/machun_banner_inscr.do", method = RequestMethod.POST)
    public String machun_banner_inproc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                // 이미지파일 처리
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bannerVo.setAtch_file_id(atchFileId);
                    bannerVo.setReg_id(adminLoginVo.getAdmin_id());
                    bannerVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bannerVo.setGubun("MACHUN"); // 송파진로체험지원센터(꿈마루)

                    bbsService.insertBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/machun_banner_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/machun_banner_view.do", method = RequestMethod.GET)
    public String machun_banner_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/machun_banner_view";
        String menu_url = "cont/center/machun_banner_list";
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
            int banner_idx = ServletRequestUtils.getIntParameter(request, "banner_idx", 0);

            BannerVo bannerVo = new BannerVo();
            bannerVo.setBanner_idx(banner_idx);

            bannerVo = bbsService.selectBannerInfo(bannerVo);

            // 첨부파일 처리
            String atchFileId = bannerVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            bannerVo.setFileList(fileVoList);

            model.addAttribute("bannerVo", bannerVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/machun_banner_view.do", method = RequestMethod.POST)
    public String machun_banner_view_proc(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bannerVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_",cnt, bannerVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bannerVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bannerVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bannerVo.setAtch_file_id("");
                        }
                    }

                    bannerVo.setUp_id(adminLoginVo.getAdmin_id());
                    bannerVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bannerVo.setGubun("MACHUN"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/machun_banner_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/machun_banner_delete.do", method = RequestMethod.POST)
    public String machun_banner_delete(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                bbsService.deleteBannerInfo(bannerVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/machun_banner_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/machun_banner_ord.do", method = RequestMethod.POST)
    public String machun_banner_ord_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bannerVo") BannerVo bannerVo,
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

                // 슨서 처리
                if(bannerVo.getOrdList().size() > 0) {
                    for (OrdVo ord : bannerVo.getOrdList()) {
                        bbsService.updateBannerOrd(ord);
                    }
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/machun_banner_list.do");
                model.addAttribute("altmsg", "수정 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
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

    @RequestMapping("/cont/center/machun_notice_list.do")
    public String machun_notice_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/machun_notice_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("MACHUN");
            searchVo.setSearchVal3("B");

            List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
            int totalCount = bbsService.selectbbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/machun_notice_inscr.do", method = RequestMethod.GET)
    public String machun_notice_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/machun_notice_inscr";
        String menu_url = "cont/center/machun_notice_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/machun_notice_inscr.do", method = RequestMethod.POST)
    public String machun_notice_inproc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("MACHUN"); // 송파진로체험지원센터(꿈마루)
                    bbsDetailVo.setType_cd("B");
                    bbsDetailVo.setMain_use_yn("N");
                    bbsDetailVo.setP_top_yn("N");

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/machun_notice_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/machun_notice_view.do", method = RequestMethod.GET)
    public String machun_notice_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/machun_notice_view";
        String menu_url = "cont/center/machun_notice_list";
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

            model.addAttribute("bbsDetailVo", bbsDetailVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/machun_notice_view.do", method = RequestMethod.POST)
    public String machun_notice_view_proc(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("MACHUN"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/machun_notice_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/machun_notice_delete.do", method = RequestMethod.POST)
    public String machun_notice_delete(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/machun_notice_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/center/machun_guest_list.do")
    public String machun_guest_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/machun_guest_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("MACHUN");
            searchVo.setSearchVal3("F");

            List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
            int totalCount = bbsService.selectbbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/machun_guest_inscr.do", method = RequestMethod.GET)
    public String machun_guest_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/machun_guest_inscr";
        String menu_url = "cont/center/machun_guest_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/machun_guest_inscr.do", method = RequestMethod.POST)
    public String machun_guest_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("MACHUN"); // 송파진로체험지원센터(꿈마루)
                    bbsDetailVo.setType_cd("F");

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/machun_guest_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/machun_guest_view.do", method = RequestMethod.GET)
    public String machun_guest_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/machun_guest_view";
        String menu_url = "cont/center/machun_guest_list";
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

            model.addAttribute("bbsDetailVo", bbsDetailVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/machun_guest_view.do", method = RequestMethod.POST)
    public String machun_guest_view_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("MACHUN"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/machun_guest_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/machun_guest_delete.do", method = RequestMethod.POST)
    public String machun_guest_delete(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/machun_guest_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/center/jamsil_banner_list.do")
    public String jamsil_banner_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/jamsil_banner_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("JAMSIL");

            List<BannerVo> bannerList = bbsService.selectBannerList(searchVo);
            int totalCount = bbsService.selectBannerListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bannerList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/jamsil_banner_inscr.do", method = RequestMethod.GET)
    public String jamsil_banner_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/jamsil_banner_inscr";
        String menu_url = "cont/center/jamsil_banner_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/jamsil_banner_inscr.do", method = RequestMethod.POST)
    public String jamsil_banner_inproc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                // 이미지파일 처리
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bannerVo.setAtch_file_id(atchFileId);
                    bannerVo.setReg_id(adminLoginVo.getAdmin_id());
                    bannerVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bannerVo.setGubun("JAMSIL"); // 송파진로체험지원센터(꿈마루)

                    bbsService.insertBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/jamsil_banner_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/jamsil_banner_view.do", method = RequestMethod.GET)
    public String jamsil_banner_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/jamsil_banner_view";
        String menu_url = "cont/center/jamsil_banner_list";
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
            int banner_idx = ServletRequestUtils.getIntParameter(request, "banner_idx", 0);

            BannerVo bannerVo = new BannerVo();
            bannerVo.setBanner_idx(banner_idx);

            bannerVo = bbsService.selectBannerInfo(bannerVo);

            // 첨부파일 처리
            String atchFileId = bannerVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            bannerVo.setFileList(fileVoList);

            model.addAttribute("bannerVo", bannerVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/jamsil_banner_view.do", method = RequestMethod.POST)
    public String jamsil_banner_view_proc(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bannerVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_",cnt, bannerVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bannerVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bannerVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bannerVo.setAtch_file_id("");
                        }
                    }

                    bannerVo.setUp_id(adminLoginVo.getAdmin_id());
                    bannerVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bannerVo.setGubun("JAMSIL"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/jamsil_banner_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/jamsil_banner_delete.do", method = RequestMethod.POST)
    public String jamsil_banner_delete(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                bbsService.deleteBannerInfo(bannerVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/jamsil_banner_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/jamsil_banner_ord.do", method = RequestMethod.POST)
    public String jamsil_banner_ord_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bannerVo") BannerVo bannerVo,
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

                // 슨서 처리
                if(bannerVo.getOrdList().size() > 0) {
                    for (OrdVo ord : bannerVo.getOrdList()) {
                        bbsService.updateBannerOrd(ord);
                    }
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/jamsil_banner_list.do");
                model.addAttribute("altmsg", "수정 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
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

    @RequestMapping("/cont/center/jamsil_notice_list.do")
    public String jamsil_notice_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/jamsil_notice_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("JAMSIL");
            searchVo.setSearchVal3("B");

            List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
            int totalCount = bbsService.selectbbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/jamsil_notice_inscr.do", method = RequestMethod.GET)
    public String jamsil_notice_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/jamsil_notice_inscr";
        String menu_url = "cont/center/jamsil_notice_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/jamsil_notice_inscr.do", method = RequestMethod.POST)
    public String jamsil_notice_inproc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("JAMSIL"); // 송파진로체험지원센터(꿈마루)
                    bbsDetailVo.setType_cd("B");
                    bbsDetailVo.setMain_use_yn("N");
                    bbsDetailVo.setP_top_yn("N");

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/jamsil_notice_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/jamsil_notice_view.do", method = RequestMethod.GET)
    public String jamsil_notice_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/jamsil_notice_view";
        String menu_url = "cont/center/jamsil_notice_list";
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

            model.addAttribute("bbsDetailVo", bbsDetailVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/jamsil_notice_view.do", method = RequestMethod.POST)
    public String jamsil_notice_view_proc(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("MACHUN"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/jamsil_notice_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/jamsil_notice_delete.do", method = RequestMethod.POST)
    public String jamsil_notice_delete(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/jamsil_notice_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/center/jamsil_guest_list.do")
    public String jamsil_guest_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/jamsil_guest_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("JAMSIL");
            searchVo.setSearchVal3("F");

            List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
            int totalCount = bbsService.selectbbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/jamsil_guest_inscr.do", method = RequestMethod.GET)
    public String jamsil_guest_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/jamsil_guest_inscr";
        String menu_url = "cont/center/jamsil_guest_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/jamsil_guest_inscr.do", method = RequestMethod.POST)
    public String jamsil_guest_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("JAMSIL"); // 송파진로체험지원센터(꿈마루)
                    bbsDetailVo.setType_cd("F");

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/jamsil_guest_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/jamsil_guest_view.do", method = RequestMethod.GET)
    public String jamsil_guest_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/jamsil_guest_view";
        String menu_url = "cont/center/jamsil_guest_list";
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

            model.addAttribute("bbsDetailVo", bbsDetailVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/jamsil_guest_view.do", method = RequestMethod.POST)
    public String jamsil_guest_view_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("JAMSIL"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/jamsil_guest_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/jamsil_guest_delete.do", method = RequestMethod.POST)
    public String jamsil_guest_delete(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/jamsil_guest_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/center/future_banner_list.do")
    public String future_banner_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/future_banner_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("FUTURE");

            List<BannerVo> bannerList = bbsService.selectBannerList(searchVo);
            int totalCount = bbsService.selectBannerListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bannerList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/future_banner_inscr.do", method = RequestMethod.GET)
    public String future_banner_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/future_banner_inscr";
        String menu_url = "cont/center/future_banner_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/future_banner_inscr.do", method = RequestMethod.POST)
    public String future_banner_inproc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                // 이미지파일 처리
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bannerVo.setAtch_file_id(atchFileId);
                    bannerVo.setReg_id(adminLoginVo.getAdmin_id());
                    bannerVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bannerVo.setGubun("FUTURE"); // 송파진로체험지원센터(꿈마루)

                    bbsService.insertBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/future_banner_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/future_banner_view.do", method = RequestMethod.GET)
    public String future_banner_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/future_banner_view";
        String menu_url = "cont/center/future_banner_list";
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
            int banner_idx = ServletRequestUtils.getIntParameter(request, "banner_idx", 0);

            BannerVo bannerVo = new BannerVo();
            bannerVo.setBanner_idx(banner_idx);

            bannerVo = bbsService.selectBannerInfo(bannerVo);

            // 첨부파일 처리
            String atchFileId = bannerVo.getAtch_file_id();
            String min_img_path = EgovProperties.getProperty("bd.file.url.path");
            FileVo fvo = new FileVo();
            fvo.setAtch_file_id(atchFileId);
            List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
            for(FileVo fileVo : fileVoList){
                fileVo.setFile_src(min_img_path + "/" + fileVo.getFile_nm());
            }
            bannerVo.setFileList(fileVoList);

            model.addAttribute("bannerVo", bannerVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/future_banner_view.do", method = RequestMethod.POST)
    public String future_banner_view_proc(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                CommonVo cmm = this.getAttachImgFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bannerVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_",cnt, bannerVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "BN_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bannerVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bannerVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bannerVo.setAtch_file_id("");
                        }
                    }

                    bannerVo.setUp_id(adminLoginVo.getAdmin_id());
                    bannerVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bannerVo.setGubun("FUTURE"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBannerInfo(bannerVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/future_banner_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/future_banner_delete.do", method = RequestMethod.POST)
    public String future_banner_delete(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bannerVo") BannerVo bannerVo,
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
                bbsService.deleteBannerInfo(bannerVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/future_banner_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/future_banner_ord.do", method = RequestMethod.POST)
    public String future_banner_ord_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bannerVo") BannerVo bannerVo,
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

                // 슨서 처리
                if(bannerVo.getOrdList().size() > 0) {
                    for (OrdVo ord : bannerVo.getOrdList()) {
                        bbsService.updateBannerOrd(ord);
                    }
                }

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/future_banner_list.do");
                model.addAttribute("altmsg", "수정 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
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

    @RequestMapping("/cont/center/future_notice_list.do")
    public String future_notice_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/future_notice_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("FUTURE");
            searchVo.setSearchVal3("B");

            List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
            int totalCount = bbsService.selectbbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/future_notice_inscr.do", method = RequestMethod.GET)
    public String future_notice_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/future_notice_inscr";
        String menu_url = "cont/center/future_notice_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/future_notice_inscr.do", method = RequestMethod.POST)
    public String future_notice_inproc(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("FUTURE"); // 송파진로체험지원센터(꿈마루)
                    bbsDetailVo.setType_cd("B");
                    bbsDetailVo.setMain_use_yn("N");
                    bbsDetailVo.setP_top_yn("N");

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/future_notice_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/future_notice_view.do", method = RequestMethod.GET)
    public String future_notice_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/future_notice_view";
        String menu_url = "cont/center/future_notice_list";
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

            model.addAttribute("bbsDetailVo", bbsDetailVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/future_notice_view.do", method = RequestMethod.POST)
    public String future_notice_view_proc(final MultipartHttpServletRequest multiRequest,
                                          @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("FUTURE"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/future_notice_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/future_notice_delete.do", method = RequestMethod.POST)
    public String future_notice_delete(final MultipartHttpServletRequest multiRequest,
                                       @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/future_notice_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }

    @RequestMapping("/cont/center/future_guest_list.do")
    public String future_guest_list(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/future_guest_list";
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

            searchVo.setSearchVal2(String.valueOf(adminLoginVo.getGroup_idx()));
            searchVo.setSearchKind("FUTURE");
            searchVo.setSearchVal3("F");

            List<BbsDetailVo> bbsList = bbsService.selectBbsList(searchVo);
            int totalCount = bbsService.selectbbsListTotal(searchVo);
            PageHolder pageholder = this.setPageNumRow(request, totalCount);

            model.addAttribute("pageholder", pageholder);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("itemList", bbsList);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/future_guest_inscr.do", method = RequestMethod.GET)
    public String future_guest_inscr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/future_guest_inscr";
        String menu_url = "cont/center/future_guest_list";
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
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/future_guest_inscr.do", method = RequestMethod.POST)
    public String future_guest_inproc(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);
                if (cmm.isFtype_flag()) {
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if (cmm.getChkcnt() > 0) {
                        List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                        atchFileId = fileMngService.insertFileInfs(result);
                    }

                    bbsDetailVo.setAtch_file_id(atchFileId);
                    bbsDetailVo.setReg_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("FUTURE"); // 송파진로체험지원센터(꿈마루)
                    bbsDetailVo.setType_cd("F");

                    bbsService.insertNoticeInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/future_guest_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "C", "NEWS", 0);
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

    @RequestMapping(value = "/cont/center/future_guest_view.do", method = RequestMethod.GET)
    public String future_guest_view(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
        String ret_url = "cont/center/future_guest_view";
        String menu_url = "cont/center/future_guest_list";
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

            model.addAttribute("bbsDetailVo", bbsDetailVo);
        }

        return ret_url;
    }

    @RequestMapping(value = "/cont/center/future_guest_view.do", method = RequestMethod.POST)
    public String future_guest_view_proc(final MultipartHttpServletRequest multiRequest,
                                         @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                CommonVo cmm = this.getAttachFileInfo(multiRequest);

                if(cmm.isFtype_flag()){
                    // 첨부파일 정보 등록
                    String atchFileId = "";
                    if(cmm.getChkcnt() > 0){

                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> chkList = fileMngService.selectFileInfs(fvo);

                        if(chkList.size() > 0){
                            // 기존에 등록 된게 있으면
                            int cnt = fileMngService.getMaxFileSN(fvo);

                            List<FileVo> _result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_",cnt, bbsDetailVo.getAtch_file_id(), EgovProperties.getProperty("bd.file.path"));
                            fileMngService.updateFileInfs(_result);
                        }else{
                            //없으면 신규 등록 한다.
                            List<FileVo> result = fileUtil.parseFileInf(cmm.getTmpfiles(), "NT_", 1, "", EgovProperties.getProperty("bd.file.path"));
                            atchFileId = fileMngService.insertFileInfs(result);
                            bbsDetailVo.setAtch_file_id(atchFileId);
                        }
                    } else {
                        FileVo fvo = new FileVo();
                        fvo.setAtch_file_id(bbsDetailVo.getAtch_file_id());
                        List<FileVo> fileVoList = fileMngService.selectFileInfs(fvo);
                        if (fileVoList.size() == 0) {
                            bbsDetailVo.setAtch_file_id("");
                        }
                    }

                    bbsDetailVo.setUp_id(adminLoginVo.getAdmin_id());
                    bbsDetailVo.setGroup_idx(adminLoginVo.getGroup_idx());
                    bbsDetailVo.setGubun("JAMSIL"); // 송파진로체험지원센터(꿈마루)

                    bbsService.updateBbsInfo(bbsDetailVo);

                    model.addAttribute("msg", "alterloc");
                    model.addAttribute("locurl", "/ssemadmin/cont/center/future_guest_list.do");
                    model.addAttribute("altmsg", "저장되었습니다.");

                    //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());

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

    @RequestMapping(value = "/cont/center/future_guest_delete.do", method = RequestMethod.POST)
    public String future_guest_delete(final MultipartHttpServletRequest multiRequest,
                                      @ModelAttribute("bbsDetailVo") BbsDetailVo bbsDetailVo,
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
                bbsService.deleteBbsInfo(bbsDetailVo);

                model.addAttribute("msg", "alterloc");
                model.addAttribute("locurl", "/ssemadmin/cont/center/future_guest_list.do");
                model.addAttribute("altmsg", "삭제 되었습니다.");

                //this.insertConnectInfo(multiRequest, adminLoginVo, "새소식", "U", "NEWS", newsVo.getNews_idx());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "alterBack");
            model.addAttribute("altmsg", "삭제에 실패하였습니다.");
        } finally {
            status.setComplete();
        }

        return ret_url;
    }
}
