package kr.go.songpa.ssem.controller;

import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.util.FileMngUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-09-15
 * Description :
 * History :
 * Version :
 */
@Controller
public class CKEditorController extends CommonController {
    private final static String saveFolder = EgovProperties.getProperty("ckeditor.file.path");
    private final static String urlPath = EgovProperties.getProperty("ckeditor.file.url.path");

    public CKEditorController() {
    }

    @ResponseBody
    @RequestMapping("/editor/imgUpload.do")
    public String imgUpload(Model model, @RequestParam(value="upload", required = false) MultipartFile fileload, HttpServletRequest request) throws Exception
    {
        try {
            //실제 파일이 업로드 되는 부분
            HashMap saveData = FileMngUtil.uploadFile(fileload, saveFolder);
            return "{ \"uploaded\" : true, \"url\" : \"" + urlPath + saveData.get("upload_file_nm") + "\" }";
        } catch (IOException e) {
            // TODO Auto-generated catch block
            return "{ \"uploaded\" : false, \"error\": { \"message\": \"업로드 중 에러가 발생했습니다. 다시 시도해 주세요.\" } }";
        }
    }
}
