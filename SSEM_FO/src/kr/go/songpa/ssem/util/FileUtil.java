package kr.go.songpa.ssem.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

/**
 * Program Name : kr.go.songpa.ssem.util
 * Author : shlee
 * Date : 2020-09-16
 * Description :
 * History :
 * Version :
 */
public class FileUtil {
    private String errorMsg = "";

    private Vector vFilePath = new Vector();

    private Vector vFileName = new Vector();

    private Vector vFoldereName = new Vector();

    private List<File> lfiles = new ArrayList<File>();

    public List<File> getLfiles() {
        return lfiles;
    }

    public Vector getVfolderename() {
        return vFoldereName;
    }

    protected final static Logger logger = LoggerFactory.getLogger(FileUtil.class);

    public void listFiles(String path) {

        File file = new File(path);
        File[] files = file.listFiles();

        if (files == null) {
            return;
        }

        if (files.length != 0) {
            for (int i = 0; i < files.length; i++) {
                if (files[i].isFile()) {
                    vFilePath.addElement(files[i]);
                    vFileName.addElement(files[i].getName());
                    lfiles.add(files[i]);
                } else {
                    //                  ListFiles(files[i].getPath() );
                }
            }
        }
    }

    public void listFolder(String path) {

        File file = new File(path);
        File[] files = file.listFiles();
        if (files == null) {
            return;
        }

        if (files.length != 0) {
            for (int i = 0; i < files.length; i++) {
                if (files[i].isDirectory()) {
                    vFilePath.addElement(files[i]);
                }
            }
        }
    }

    public static String makeFileName(String filename, String filepath) {
        boolean chk_name = true;
        String strName = "";
        String strExe = "";
        String filenamec = "";
        int countfilenum = 0;
        try {
            strName = Util.substring(filename, 0, filename.indexOf("."));
            strExe = Util.substring(filename, filename.indexOf(".") + 1,
                    filename.length());
            filenamec = strName + "." + strExe;
            while (chk_name) {
                File chk_file = new File(filepath + "/" + filenamec);
                if (chk_file.exists()) {
                    countfilenum++;
                    filenamec = "";
                    filenamec = strName + Integer.toString(countfilenum) + "."
                            + strExe;
                } else {
                    chk_name = false;
                }

            }
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        return filenamec;
    }

    public Vector getVfilepath() {
        return vFilePath;
    }

    public Vector getVfilename() {
        return vFileName;
    }

    public boolean saveDBConfig(String saveData) throws Exception {
        FileOutputStream fi = null;
        boolean result = false;
        try {
            String USER_HOME = System.getProperty("user.home");
            String fileName = USER_HOME + File.separator + "transure" + File.separator;

            dicCreate(EgovWebUtil.fileNameReplaceAll(fileName));
            fileName += "Config.properties";

            fi = new FileOutputStream(EgovWebUtil.fileNameReplaceAll(fileName));
            fi.write(saveData.getBytes());
            result = true;
        } catch (FileNotFoundException e) {
            result = false;
            logger.debug(e.getMessage());
        } catch (IOException e) {
            result = false;
            logger.debug(e.getMessage());
        } catch (Exception e) {
            result = false;
            logger.debug(e.getMessage());
        } finally {
            try {
                fi.close();
            } catch (FileNotFoundException e) {
                logger.debug(e.getMessage());
            } catch (IOException e) {
                logger.debug(e.getMessage());
            } catch (Exception e) {
                logger.debug(e.getMessage());
            }
        }

        return result;
    }

    public static boolean save(String content, String fileName) {
        BufferedOutputStream bos = null;
        boolean result = false;
        try {
            bos = new BufferedOutputStream(new FileOutputStream(fileName));
            bos.write(content.getBytes());
            result = true;

        } catch (FileNotFoundException e) {
            result = false;
            logger.debug(e.getMessage());
        } catch (IOException e) {
            result = false;
            logger.debug(e.getMessage());
        } catch (Exception e) {
            result = false;
            logger.debug(e.getMessage());
        } finally {
            try {
                bos.flush();
                bos.close();
            } catch (FileNotFoundException e) {
                logger.debug(e.getMessage());
            } catch (IOException e) {
                logger.debug(e.getMessage());
            } catch (Exception e) {
                logger.debug(e.getMessage());
            }
        }
        return result;
    }

    public static void deleteFilesAndDirs(String path, long systemtime) {
        deleteFiles(path, systemtime);
        deleteDirs(path);
    }

    public static void deleteFiles(String path, long systemtime) {
        File file = new File(path);
        File[] files = file.listFiles();
        if (files == null) {
            return;
        }

        if (files.length != 0) {
            for (int i = 0; i < files.length; i++) {
                if (files[i].isFile()) {
                    if (systemtime > 0) {
                        if (files[i].lastModified() < systemtime) {
                            try {
                                if(!files[i].delete()) {
                                    logger.debug("파일 삭제 실패");
                                }
                            } catch (Exception e) {
                                logger.debug(e.getMessage());
                            }
                        }
                    } else {
                        try {
                            files[i].delete();
                        } catch (Exception e) {
                            logger.debug(e.getMessage());
                        }
                    }
                } else {
                    deleteFiles(files[i].getPath(), systemtime);
                }
            }
        }
    }

    public static void deleteFile(String filename) {
        File file = new File(filename);
        if (file == null) {
            return;
        }
        if (file.isFile()) {
            try {
                if(!file.delete()) {
                    logger.debug("파일 삭제 실패");
                }
            } catch (Exception e) {
                logger.debug(e.getMessage());
            }
        }
    }

    public static void deleteDirs(String path) {
        File dir = new File(path);
        File[] dirs = dir.listFiles();

        if (dirs == null) {
            return;
        }

        if (dirs.length != 0) {
            for (int i = 0; i < dirs.length; i++) {
                if (dirs[i].isDirectory()) {
                    try {
                        if (dirs[i].listFiles().length == 0) {
                            try {
                                if(!dirs[i].delete()) {
                                    logger.debug("디렉토리 삭제 실패");
                                }
                            } catch (Exception e) {
                                logger.debug(e.getMessage());
                            }
                        } else {
                            deleteDirs(dirs[i].getPath());
                        }
                    } catch(NullPointerException e) {
                        logger.debug(e.getMessage());
                    }
                } else {
                    try {
                        dirs[i].delete();
                    } catch (Exception e) {
                        logger.debug(e.getMessage());
                    }
                }
            }

        }
        dir.delete();
    }

    public static boolean makeDir(String dirname) {
        boolean result = false;
        try {
            File dir = new File(dirname);
            if (!dir.exists()) {
                try {
                    if(!dir.mkdirs()) {
                        logger.debug("디렉토리 생성 실패");
                    }
                } catch(Exception e) {
                    logger.debug(e.getMessage());
                }
            }
            result = true;
        } catch (Exception e) {
            result = false;
            logger.debug(e.getMessage());
        }
        return result;
    }

    public static void fileMove(String fromfilename, String tofilename)
            throws Exception {

        File up1 = null;
        File up2 = null;

        up1 = new File(fromfilename);
        up2 = new File(tofilename);
        if (up1.exists()) {
            try {
                if(!up1.renameTo(up2)) {
                    logger.debug("파일명 변경 실패");
                }
            } catch (Exception e) {
                logger.debug(e.getMessage());
            }
        }
        if (up1.exists()) {
            try {
                if(!up1.delete()) {
                    logger.debug("파일 삭제 실패");
                }
            } catch (Exception e) {
                logger.debug(e.getMessage());
            }
        }
    }

    public static void fileCopy(String fromfilename, String tofilename)
            throws Exception {
        File fromFile = null;
        File toFile = null;

        fromFile = new File(fromfilename);
        toFile = new File(tofilename);
        if (!fromFile.canRead()) {
            throw new Exception(fromFile.getName() + " file can not read.");
        }
        FileInputStream fis = null;
        FileOutputStream fos = null;
        try {
            fis = new FileInputStream(fromFile);
            fos = new FileOutputStream(toFile);

            byte[] buff = new byte[4096];

            int len = 0;
            while ((len = fis.read(buff)) != -1) {
                fos.write(buff, 0, len);
                fos.flush();
            }
        } catch(FileNotFoundException e) {
            logger.debug(e.getMessage());
        } catch (IOException e) {
            logger.debug(e.getMessage());
        } catch (Exception e) {
            logger.debug(e.getMessage());
        } finally {
            if (fis != null) {
                try {
                    fis.close();
                } catch(FileNotFoundException e) {
                    logger.debug(e.getMessage());
                } catch (IOException e) {
                    logger.debug(e.getMessage());
                } catch (Exception e) {
                    logger.debug(e.getMessage());
                }
            }
            if (fos != null) {
                try {
                    fos.close();
                } catch(FileNotFoundException e) {
                    logger.debug(e.getMessage());
                } catch (IOException e) {
                    logger.debug(e.getMessage());
                } catch (Exception e) {
                    logger.debug(e.getMessage());
                }
            }
        }
    }

    public static boolean fileExist(String fileName) {
        boolean result = false;
        try {
            File file = new File(fileName);
            result = file.exists();
        } catch (Exception e) {
            logger.debug(e.getMessage());
        }
        return result;
    }

    public void dicCreate(String dicPath) throws Exception {
        File fileLoc = new File(dicPath);
        if (!fileLoc.exists()) {
            try {
                if(!fileLoc.mkdirs()) {
                    logger.debug("디렉토리 생성 실패");
                }
            } catch (Exception e) {
                logger.debug(e.getMessage());
            }
        }
    }

    public String getExt(String filename, int flag) {
        int i_ext;
        String result = "";
        i_ext = filename.lastIndexOf(".");    //���ڿ� ���ʿ��� . ��ġ ã��
        String cur_FileName_ONLY = "";
        cur_FileName_ONLY = filename.substring(0, i_ext);    //Ȯ���ڸ� ������, ����� ���ϸ�.

        String cur_FileName_EXT = "";
        cur_FileName_EXT = filename.substring(i_ext, filename.length());
        if (flag == 0) {
            result = cur_FileName_ONLY;
        } else {
            result = cur_FileName_EXT;
        }
        return result;
    }

    public static String readFile(String filePath) {
        StringBuffer returnStr = new StringBuffer();
        BufferedReader br = null;
        if (!fileExist(filePath)) {
            returnStr = null;
        }
        try {
            br = new BufferedReader(new FileReader(filePath));
            do {
                int tempChar = br.read();
                if (tempChar == -1) //
                    break;
                returnStr.append((char) tempChar);
            } while (true);
        } catch (FileNotFoundException e) {
            logger.debug(e.getMessage());
        } catch (IOException e) {
            logger.debug(e.getMessage());
        } catch (Exception e) {
            logger.debug(e.getMessage());
        } finally {
            try {
                br.close();
            } catch (FileNotFoundException e) {
                logger.debug(e.getMessage());
            } catch (IOException e) {
                logger.debug(e.getMessage());
            } catch (Exception e) {
                logger.debug(e.getMessage());
            }

            if (returnStr != null)
                return returnStr.toString();
            else
                return null;
        }
    }

    public void setError (String errString){
        errorMsg += errString;
    }

    public String getError () {
        return errorMsg;
    }
}
