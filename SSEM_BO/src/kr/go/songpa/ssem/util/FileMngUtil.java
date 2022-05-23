package kr.go.songpa.ssem.util;

import kr.go.songpa.ssem.common.EgovProperties;
import kr.go.songpa.ssem.model.FileVo;
import kr.go.songpa.ssem.service.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.channels.FileChannel;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Program Name : kr.go.songpa.ssem.util
 * Author : shlee
 * Date : 2020-09-16
 * Description :
 * History :
 * Version :
 */
@Component("FileMngUtil")
public class FileMngUtil {
    public static final int BUFF_SIZE = 2048;

    protected final static Logger logger = LoggerFactory.getLogger(FileMngUtil.class);

    @Autowired
    private CommonService commonService;

    /**
     * 첨부파일에 대한 목록 정보를 취득한다.
     *
     * @param files
     * @return
     * @throws Exception
     */
    public List<FileVo> parseFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam, String atchFileId, String storePath) throws Exception {
        int fileKey = fileKeyParam;

        String storePathString = "";
        String atchFileIdString = "";

        storePathString = storePath;
        // 파일 아이디 생성
        if ("".equals(atchFileId) || atchFileId == null) {
            atchFileIdString = "FID" + commonService.getNextStringId();
        } else {
            atchFileIdString = atchFileId;
        }

        File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString));

        if (!saveFolder.exists() || saveFolder.isFile()) {
            try {
                if (!saveFolder.mkdirs()) {
                    logger.debug("디렉토리 생성 실패");
                }
            } catch (Exception e) {
                logger.debug(e.getMessage());
            }
        }

        Iterator<Map.Entry<String, MultipartFile>> itr = files.entrySet().iterator();
        MultipartFile file;
        String filePath = "";
        List<FileVo> result = new ArrayList<FileVo>();
        FileVo fvo;

        while (itr.hasNext()) {
            Map.Entry<String, MultipartFile> entry = itr.next();

            file = entry.getValue();
            String orginFileName = file.getOriginalFilename();

            //--------------------------------------
            // 원 파일명이 없는 경우 처리
            // (첨부가 되지 않은 input file type)
            //--------------------------------------
            if ("".equals(orginFileName)) {
                continue;
            }
            ////------------------------------------

            int index = orginFileName.lastIndexOf(".");
            //String fileName = orginFileName.substring(0, index);
            String fileExt = orginFileName.substring(index + 1);
            String newName = KeyStr + getTimeStamp() + fileKey + "." + fileExt;


            if (!"".equals(orginFileName)) {
                filePath = storePathString + File.separator + newName;
                file.transferTo(new File(EgovWebUtil.filePathBlackList(filePath)));
            }
            fvo = new FileVo();
            fvo.setFile_ext(fileExt);
            fvo.setFile_store_path(storePathString);
            fvo.setFile_ori_nm(orginFileName);
            fvo.setFile_nm(newName);
            fvo.setAtch_file_id(atchFileIdString);
            fvo.setFile_num(String.valueOf(fileKey));

            writeFile(file, newName, storePathString);
            result.add(fvo);

            fileKey++;
        }
        return result;
    }

    public List<FileVo> parseFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam, String atchFileId, String storePath, Map<String, String> files_alt) throws Exception {
        int fileKey = fileKeyParam;

        String storePathString = "";
        String atchFileIdString = "";


        storePathString = storePath;
        // 파일 아이디 생성
        if ("".equals(atchFileId) || atchFileId == null) {
            atchFileIdString = "FID" + commonService.getNextStringId();
        } else {
            atchFileIdString = atchFileId;
        }

        File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString));

        if (!saveFolder.exists() || saveFolder.isFile()) {
            try {
                if (!saveFolder.mkdirs()) {
                    logger.debug("디렉토리 생성 실패");
                }
            } catch (Exception e) {
                logger.debug(e.getMessage());
            }
        }

        Iterator<Map.Entry<String, MultipartFile>> itr = files.entrySet().iterator();
        MultipartFile file;
        String filePath = "";
        List<FileVo> result = new ArrayList<FileVo>();
        FileVo fvo;
        int alt_i = 0;
        while (itr.hasNext()) {
            Map.Entry<String, MultipartFile> entry = itr.next();

            file = entry.getValue();
            String orginFileName = file.getOriginalFilename();

            //--------------------------------------
            // 원 파일명이 없는 경우 처리
            // (첨부가 되지 않은 input file type)
            //--------------------------------------
            if ("".equals(orginFileName)) {
                continue;
            }
            ////------------------------------------

            int index = orginFileName.lastIndexOf(".");
            //String fileName = orginFileName.substring(0, index);
            String fileExt = orginFileName.substring(index + 1);
            String newName = KeyStr + getTimeStamp() + fileKey + "." + fileExt;


            if (!"".equals(orginFileName)) {
                filePath = storePathString + File.separator + newName;
                file.transferTo(new File(EgovWebUtil.filePathBlackList(filePath)));
            }
            fvo = new FileVo();
            fvo.setFile_ext(fileExt);
            fvo.setFile_store_path(storePathString);
            fvo.setFile_ori_nm(orginFileName);
            fvo.setFile_nm(newName);
            fvo.setAtch_file_id(atchFileIdString);
            fvo.setFile_num(String.valueOf(fileKey));
            fvo.setAtch_file_id(files_alt.get(file.getName() + (alt_i++)));
            writeFile(file, newName, storePathString);
            result.add(fvo);

            fileKey++;
        }
        return result;
    }

    /**
     * 첨부파일에 대한 정보를 취득한다.
     *
     * @param files
     * @return
     * @throws Exception
     */
    public FileVo parseFileInfOne(MultipartFile files, String KeyStr, int fileKeyParam, String atchFileId, String storePath) throws Exception {
        int fileKey = fileKeyParam;

        String storePathString = "";
        String atchFileIdString = "";

        if ("".equals(storePath) || storePath == null) {
            //storePathString = commonProp.getProperty("Globals.fileStorePath");
            storePathString = EgovProperties.getProperty("Globals.fileStorePath");
        } else {
            storePathString = EgovProperties.getProperty("Globals.fileStorePath") + storePath;
        }

        if ("".equals(atchFileId) || atchFileId == null) {
            //atchFileIdString = idgenService.getNextStringId();
        } else {
            // atchFileIdString = atchFileId;
        }

        File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString));

        if (!saveFolder.exists() || saveFolder.isFile()) {
            try {
                if (!saveFolder.mkdirs()) {
                    logger.debug("디렉토리 생성 실패");
                }
            } catch (Exception e) {
                logger.debug(e.getMessage());
            }
        }

        String filePath = "";
        FileVo fvo;

        String orginFileName = files.getOriginalFilename();

        int index = orginFileName.lastIndexOf(".");
        //String fileName = orginFileName.substring(0, index);
        String fileExt = orginFileName.substring(index + 1);
        //String newName = KeyStr + getTimeStamp() + fileKey;
        String newName = KeyStr + getTimeStamp() + fileKey + "." + fileExt;


        if (!"".equals(orginFileName)) {
            filePath = storePathString + File.separator + newName;
            files.transferTo(new File(EgovWebUtil.filePathBlackList(filePath)));
        }
        fvo = new FileVo();
        fvo.setFile_ext(fileExt);
        fvo.setFile_store_path(storePathString);
        fvo.setFile_ori_nm(orginFileName);
        fvo.setFile_nm(newName);
        fvo.setAtch_file_id(atchFileIdString);
        fvo.setFile_num(String.valueOf(fileKey));

        return fvo;
    }

    /**
     * 첨부파일에 대한 정보를 취득한다.
     *
     * @param files
     * @return
     * @throws Exception
     */
    public FileVo parseRealFileInfOne(File files, String KeyStr, int fileKeyParam, String atchFileId, String storePath) throws Exception {
        int fileKey = fileKeyParam;

        String storePathString = storePath;
        String atchFileIdString = "";
        /**
         if ("".equals(storePath) || storePath == null) {
         storePathString = commonProp.getProperty("Globals.fileStorePath");
         } else {
         storePathString = commonProp.getProperty("Globals.fileStorePath") + storePath;
         }
         **/
        if ("".equals(atchFileId) || atchFileId == null) {
            atchFileIdString = "FID" + commonService.getNextStringId();
        } else {
            atchFileIdString = atchFileId;
        }

        File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString));

        if (!saveFolder.exists() || saveFolder.isFile()) {
            try {
                if (!saveFolder.mkdirs()) {
                    logger.debug("디렉토리 생성 실패");
                }
            } catch (Exception e) {
                logger.debug(e.getMessage());
            }
        }

        String filePath = "";
        FileVo fvo;

        String orginFileName = files.getName();

        int index = orginFileName.lastIndexOf(".");
        //String fileName = orginFileName.substring(0, index);
        String fileExt = orginFileName.substring(index + 1);
        //String newName = KeyStr + getTimeStamp() + fileKey;
        String newName = KeyStr + getTimeStamp() + fileKey + "." + fileExt;


        if (!"".equals(orginFileName)) {
            filePath = storePathString + File.separator + newName;
            FileInputStream inputStream = null;
            FileOutputStream outputStream = null;
            FileChannel fcin = null;
            FileChannel fcout = null;

            try {
                inputStream = new FileInputStream(files);
                outputStream = new FileOutputStream(EgovWebUtil.filePathBlackList(filePath));
                fcin = inputStream.getChannel();
                fcout = outputStream.getChannel();
                long size = fcin.size();
                fcin.transferTo(0, size, fcout);
            } catch (Exception e) {

            } finally {
                fcout.close();
                fcin.close();
                outputStream.close();
                inputStream.close();
            }
        }
        fvo = new FileVo();
        fvo.setFile_ext(fileExt);
        fvo.setFile_store_path(storePathString);
        fvo.setFile_ori_nm(orginFileName);
        fvo.setFile_nm(newName);
        fvo.setAtch_file_id(atchFileIdString);
        fvo.setFile_num(String.valueOf(fileKey));

        return fvo;
    }

    /**
     * 첨부파일을 서버에 저장한다.
     *
     * @param file
     * @param newName
     * @param stordFilePath
     * @throws Exception
     */
    protected void writeUploadedFile(MultipartFile file, String newName, String stordFilePath) throws Exception {
        InputStream stream = null;
        OutputStream bos = null;

        try {
            stream = file.getInputStream();
            File cFile = new File(stordFilePath);

            if (!cFile.isDirectory()) {
                boolean _flag = cFile.mkdir();
                if (!_flag) {
                    throw new IOException("Directory creation Failed ");
                }
            }

            bos = new FileOutputStream(stordFilePath + File.separator + newName);

            int bytesRead = 0;
            byte[] buffer = new byte[BUFF_SIZE];

            while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }
        } catch (FileNotFoundException e) {
            logger.debug(e.getMessage());
        } catch (IOException e) {
            logger.debug(e.getMessage());
        } catch (Exception e) {
            logger.debug(e.getMessage());
        } finally {
            if (bos != null) {
                try {
                    bos.close();
                } catch (IOException ignore) {
                    logger.debug(ignore.getMessage());
                } catch (Exception e) {
                    logger.debug(e.getMessage());
                }
            }
            if (stream != null) {
                try {
                    stream.close();
                } catch (IOException ignore) {
                    logger.debug(ignore.getMessage());
                } catch (Exception e) {
                    logger.debug(e.getMessage());
                }
            }
        }
    }

    /**
     * 서버의 파일을 다운로드한다.
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public static void downFile(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String downFileName = "";
        String orgFileName = "";

        if ((String) request.getAttribute("downFile") == null) {
            downFileName = "";
        } else {
            downFileName = (String) request.getAttribute("downFile");
        }

        if ((String) request.getAttribute("orgFileName") == null) {
            orgFileName = "";
        } else {
            orgFileName = (String) request.getAttribute("orginFile");
        }

        orgFileName = orgFileName.replaceAll("\r", "").replaceAll("\n", "");

        File file = new File(EgovWebUtil.fileNameReplaceAll(downFileName));

        if (!file.exists()) {
            throw new FileNotFoundException(downFileName);
        }

        if (!file.isFile()) {
            throw new FileNotFoundException(downFileName);
        }

        byte[] b = new byte[BUFF_SIZE]; //buffer size 2K.

        response.setContentType("application/x-msdownload");
        response.setHeader("Content-Disposition:", "attachment; filename=" + new String(orgFileName.getBytes(), "UTF-8"));
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        BufferedInputStream fin = null;
        BufferedOutputStream outs = null;

        try {
            fin = new BufferedInputStream(new FileInputStream(file));
            outs = new BufferedOutputStream(response.getOutputStream());
            int read = 0;

            while ((read = fin.read(b)) != -1) {
                outs.write(b, 0, read);
            }
        } catch (FileNotFoundException e) {
            logger.debug(e.getMessage());
        } catch (IOException e) {
            logger.debug(e.getMessage());
        } catch (Exception e) {
            logger.debug(e.getMessage());
        } finally {
            if (outs != null) {
                try {
                    outs.close();
                } catch (FileNotFoundException e) {
                    logger.debug(e.getMessage());
                } catch (IOException e) {
                    logger.debug(e.getMessage());
                } catch (Exception e) {
                    logger.debug(e.getMessage());
                }
            }
            if (fin != null) {
                try {
                    fin.close();
                } catch (FileNotFoundException e) {
                    logger.debug(e.getMessage());
                } catch (IOException e) {
                    logger.debug(e.getMessage());
                } catch (Exception e) {
                    logger.debug(e.getMessage());
                }
            }
        }
    }


    /**
     * 파일을 실제 물리적인 경로에 생성한다.
     *
     * @param file
     * @param newName
     * @param stordFilePath
     * @throws Exception
     */
    protected static void writeFile(MultipartFile file, String newName, String stordFilePath) throws Exception {
        InputStream stream = null;
        OutputStream bos = null;

        try {
            stream = file.getInputStream();
            File cFile = new File(EgovWebUtil.filePathBlackList(stordFilePath));

            if (!cFile.isDirectory()) {
                try {
                    if (!cFile.mkdir()) {
                        logger.debug("디렉토리 생성 실패");
                    }
                } catch (Exception e) {
                    logger.debug(e.getMessage());
                }
            }

            bos = new FileOutputStream(EgovWebUtil.filePathBlackList(stordFilePath + File.separator + newName));

            int bytesRead = 0;
            byte[] buffer = new byte[BUFF_SIZE];

            while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }
        } catch (FileNotFoundException e) {
            logger.debug(e.getMessage());
        } catch (IOException e) {
            logger.debug(e.getMessage());
        } catch (Exception e) {
            logger.debug(e.getMessage());
        } finally {
            if (bos != null) {
                try {
                    bos.close();
                } catch (FileNotFoundException e) {
                    logger.debug(e.getMessage());
                } catch (IOException e) {
                    logger.debug(e.getMessage());
                } catch (Exception e) {
                    logger.debug(e.getMessage());
                }
            }
            if (stream != null) {
                try {
                    stream.close();
                } catch (FileNotFoundException e) {
                    logger.debug(e.getMessage());
                } catch (IOException e) {
                    logger.debug(e.getMessage());
                } catch (Exception e) {
                    logger.debug(e.getMessage());
                }
            }
        }
    }

    /**
     * 서버 파일에 대하여 다운로드를 처리한다.
     *
     * @param response
     * @param streFileNm  : 파일저장 경로가 포함된 형태
     * @param orignFileNm
     * @throws Exception
     */
    public void downFile(HttpServletResponse response, String streFileNm, String orignFileNm) throws Exception {
        String downFileName = streFileNm;
        String orgFileName = orignFileNm;

        File file = new File(downFileName);

        if (!file.exists()) {
            throw new FileNotFoundException(downFileName);
        }

        if (!file.isFile()) {
            throw new FileNotFoundException(downFileName);
        }

        //byte[] b = new byte[BUFF_SIZE]; //buffer size 2K.
        int fSize = (int) file.length();
        if (fSize > 0) {
            BufferedInputStream in = null;

            try {
                in = new BufferedInputStream(new FileInputStream(file));

                String mimetype = "text/html"; //"application/x-msdownload"

                response.setBufferSize(fSize);
                response.setContentType(mimetype);
                response.setHeader("Content-Disposition:", "attachment; filename=" + orgFileName);
                response.setContentLength(fSize);
                //response.setHeader("Content-Transfer-Encoding","binary");
                //response.setHeader("Pragma","no-cache");
                //response.setHeader("Expires","0");
                FileCopyUtils.copy(in, response.getOutputStream());
            } catch (FileNotFoundException e) {
                logger.debug(e.getMessage());
            } catch (IOException e) {
                logger.debug(e.getMessage());
            } catch (Exception e) {
                logger.debug(e.getMessage());
            } finally {
                if (in != null) {
                    try {
                        in.close();
                    } catch (FileNotFoundException e) {
                        logger.debug(e.getMessage());
                    } catch (IOException e) {
                        logger.debug(e.getMessage());
                    } catch (Exception e) {
                        logger.debug(e.getMessage());
                    }
                }
            }
            response.getOutputStream().flush();
            response.getOutputStream().close();
        }

	/*
	String uploadPath = propertiesService.getString("fileDir");

	File uFile = new File(uploadPath, requestedFile);
	int fSize = (int) uFile.length();

	if (fSize > 0) {
	    BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));

	    String mimetype = "text/html";

	    response.setBufferSize(fSize);
	    response.setContentType(mimetype);
	    response.setHeader("Content-Disposition", "attachment; filename=\""
					+ requestedFile + "\"");
	    response.setContentLength(fSize);

	    FileCopyUtils.copy(in, response.getOutputStream());
	    in.close();
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
	} else {
	    response.setContentType("text/html");
	    PrintWriter printwriter = response.getWriter();
	    printwriter.println("<html>");
	    printwriter.println("<br><br><br><h2>Could not get file name:<br>" + requestedFile + "</h2>");
	    printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
	    printwriter.println("<br><br><br>&copy; webAccess");
	    printwriter.println("</html>");
	    printwriter.flush();
	    printwriter.close();
	}
	//*/


	/*
	response.setContentType("application/x-msdownload");
	response.setHeader("Content-Disposition:", "attachment; filename=" + new String(orgFileName.getBytes(),"UTF-8" ));
	response.setHeader("Content-Transfer-Encoding","binary");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Expires","0");

	BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
	BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
	int read = 0;

	while ((read = fin.read(b)) != -1) {
	    outs.write(b,0,read);
	}
	log.debug(this.getClass().getName()+" BufferedOutputStream Write Complete!!! ");

	outs.close();
    	fin.close();
	//*/
    }

    /**
     * 첨부로 등록된 파일을 서버에 업로드한다.
     *
     * @param file
     * @return
     * @throws Exception
     */
    public static HashMap<String, String> uploadFile(MultipartFile file, String filePath) throws Exception {

        HashMap<String, String> map = new HashMap<String, String>();
        String newName = "";
        String stordFilePath = filePath;
        String orginFileName = file.getOriginalFilename();

        int index = orginFileName.lastIndexOf(".");
        String fileExt = orginFileName.substring(index + 1);
        long size = file.getSize();

        newName = getTimeStamp() + "." + fileExt;
        writeFile(file, newName, stordFilePath);
        //storedFilePath는 지정
        map.put("origin_file_nm", orginFileName);
        map.put("upload_file_nm", newName);
        map.put("file_ext", fileExt);
        map.put("file_path", stordFilePath);
        map.put("file_size", String.valueOf(size));

        return map;
    }

    public static HashMap<String, String> uploadFile(MultipartFile file) throws Exception {

        HashMap<String, String> map = new HashMap<String, String>();
        //Write File 이후 Move File????
        String newName = "";
        String stordFilePath = EgovProperties.getProperty("Globals.fileStorePath");
        String orginFileName = file.getOriginalFilename();
        if (orginFileName.endsWith(".exe") || orginFileName.endsWith(".cmd") || orginFileName.endsWith(".sh")) {
            map = null;
        } else {
            int index = orginFileName.lastIndexOf(".");
            //String fileName = orginFileName.substring(0, _index);
            String fileExt = orginFileName.substring(index + 1);
            long size = file.getSize();

            //newName 은 Naming Convention에 의해서 생성
            newName = getTimeStamp() + "." + fileExt;
            writeFile(file, newName, stordFilePath);
            //storedFilePath는 지정
            map.put("origin_file_nm", orginFileName);
            map.put("upload_file_nm", newName);
            map.put("file_ext", fileExt);
            map.put("file_path", stordFilePath);
            map.put("file_size", String.valueOf(size));

        }
        return map;
    }

    /**
     * 2011.08.09
     * 공통 컴포넌트 utl.fcc 패키지와 Dependency제거를 위해 내부 메서드로 추가 정의함
     * 응용어플리케이션에서 고유값을 사용하기 위해 시스템에서17자리의TIMESTAMP값을 구하는 기능
     *
     * @param
     * @return Timestamp 값
     * @see
     */
    private static String getTimeStamp() {

        String rtnStr = null;

        // 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
        String pattern = "yyyyMMddhhmmssSSS";

        try {
            SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
            Timestamp ts = new Timestamp(System.currentTimeMillis());

            rtnStr = sdfCurrent.format(ts.getTime());
        } catch (NumberFormatException e) {
            logger.debug(e.getMessage());
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }

        return rtnStr;
    }

    /**
     * 첨부파일 허용된 확장자 확인
     *
     * @param files    [MultipartFile]
     * @param allowstr [str,str]
     * @return
     */
    public boolean chkFileExt(MultipartFile files, String allowstr) {
        boolean inchk = false;

        String orginFileName = files.getOriginalFilename();
        int index = orginFileName.lastIndexOf(".");
        //String fileName = orginFileName.substring(0, index);
        String fileExt = orginFileName.substring(index + 1).toLowerCase();
        //long _size = files.getSize();

        String[] allowstrArr = allowstr.split(",");
        for (int i = 0; i < allowstrArr.length; i++) {
            if (fileExt.equals(allowstrArr[i])) {
                inchk = true;
                break;
            }
        }

        return inchk;
    }

    /**
     * 첨부파일 사이즈 확인
     *
     * @param files   [MultipartFile]
     * @param maxsize [long]
     * @return
     */
    public boolean chkFileSize(MultipartFile files, long maxsize) {
        boolean inchk = true;
        long _size = files.getSize();

        if (_size >= maxsize) {
            inchk = false;
        }

        return inchk;
    }
}
