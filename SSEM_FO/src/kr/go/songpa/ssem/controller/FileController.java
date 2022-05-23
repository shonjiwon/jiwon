package kr.go.songpa.ssem.controller;

import com.alibaba.fastjson.JSON;
import kr.go.songpa.ssem.model.FileVo;
import kr.go.songpa.ssem.service.FileMngService;
import kr.go.songpa.ssem.util.FileUtil;
import kr.go.songpa.ssem.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;
import java.util.Map;

/**
 * Program Name : kr.go.songpa.ssem.controller
 * Author : shlee
 * Date : 2020-09-16
 * Description :
 * History :
 * Version :
 */
@Controller
public class FileController extends CommonController {

    @Autowired
    private FileMngService fileMngService;

    public FileController() {
    }

    private String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        String ret_str = "";
        if (header.indexOf("MSIE") > -1) {
            ret_str = "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            ret_str = "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            ret_str = "Opera";
        }else{
            ret_str = "MSIE";
        }
        return ret_str;
    }

    private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String browser = getBrowser(request);

        String dispositionPrefix = "attachment; filename=";
        String encodedFilename = null;
        encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", " ");

        /**
         if (browser.equals("MSIE")) {
         encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
         } else if (browser.equals("Firefox")) {
         encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
         } else if (browser.equals("Opera")) {
         encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
         } else if (browser.equals("Chrome")) {
         StringBuffer sb = new StringBuffer();
         for (int i = 0; i < filename.length(); i++) {
         char c = filename.charAt(i);
         if (c > '~') {
         sb.append(URLEncoder.encode("" + c, "UTF-8"));
         } else {
         sb.append(c);
         }
         }
         encodedFilename = sb.toString();
         } else {
         //throw new RuntimeException("Not supported browser");
         throw new IOException("Not supported browser");
         }
         **/
        response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
        response.setHeader("Content-Transfer-Encoding",  "binary");
        if ("Opera".equals(browser)){
            response.setContentType("application/octet-stream;charset=UTF-8");
        }
    }
    /**
     * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
     *
     * @param commandMap
     * @param response
     * @throws Exception
     */
    @RequestMapping("/file/fileDown.do")
    public void cvplFileDownload(Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

        String atchFileId = (String)request.getParameter("atchFileId");
        String fileSn = (String)request.getParameter("fileNum");

        if("".equals(Util.nvl(fileSn))){
            fileSn = "0";
        }

        if("".equals(Util.nvl(atchFileId))){
            return;
        }

        FileVo fileVO = new FileVo();
        fileVO.setAtch_file_id(atchFileId);
        fileVO.setFile_num(fileSn);
        FileVo fvo = fileMngService.selectFileInf(fileVO);

        File uFile = new File(fvo.getFile_store_path(), fvo.getFile_nm());
        int fSize = (int)uFile.length();

        if (fSize > 0) {
            String mimetype = "application/x-msdownload";

            response.setContentType(mimetype);
            setDisposition(fvo.getFile_ori_nm(), request, response);
            response.setContentLength(fSize);

            BufferedInputStream in = null;
            BufferedOutputStream out = null;

            try {
                in = new BufferedInputStream(new FileInputStream(uFile));
                out = new BufferedOutputStream(response.getOutputStream());

                FileCopyUtils.copy(in, out);
                out.flush();
            } catch (FileNotFoundException ex) {

            } catch(IOException e) {

            } finally {
                if (in != null) {
                    try {
                        in.close();
                    } catch (IOException ignore) {

                    }
                }
                if (out != null) {
                    try {
                        out.close();
                    } catch (IOException ignore) {

                    }
                }
            }
        } else {
            response.setContentType("application/x-msdownload");

            PrintWriter printwriter = response.getWriter();
            printwriter.println("<html>");
            printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fvo.getFile_ori_nm() + "</h2>");
            printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
            printwriter.println("<br><br><br>&copy; webAccess");
            printwriter.println("</html>");
            printwriter.flush();
            printwriter.close();
        }
    }

    @RequestMapping(value="/file/file_delete.do", produces = "text/json; charset=UTF-8")
    public ResponseEntity<String> file_delete(@RequestParam Map<String, Object> parameterMap, HttpServletRequest request, Model model)  throws Exception {
        // 파라미터 세팅
        try {
            String atch_file_id = ServletRequestUtils.getStringParameter(request, "atch_file_id","");
            String file_num = ServletRequestUtils.getStringParameter(request, "file_num","");

            HttpSession session = request.getSession();
            session.setAttribute("check", "Y");

            FileVo fileVo = new FileVo();
            fileVo.setAtch_file_id(atch_file_id);
            fileVo.setFile_num(file_num);
            FileVo resultFile = fileMngService.selectFileInf(fileVo);
            //!! 파일을 물리적으로 삭제 한다.
            if(resultFile != null){
                FileUtil.deleteFile(resultFile.getFile_store_path() + File.separator + resultFile.getFile_nm());
            }
            fileMngService.deleteFileInf(fileVo);

            return new ResponseEntity<String>( JSON.toJSONString( true ), HttpStatus.OK );
        }catch (Exception e){
            return new ResponseEntity<String>( e.getMessage(), HttpStatus.BAD_REQUEST );
        }
    }
}
