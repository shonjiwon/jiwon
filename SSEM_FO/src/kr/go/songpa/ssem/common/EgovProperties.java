package kr.go.songpa.ssem.common;

import kr.go.songpa.ssem.util.EgovWebUtil;
import org.springframework.core.io.ClassPathResource;

import java.io.*;
import java.util.*;

/**
 * Program Name : kr.go.songpa.ssem.common
 * Author : shlee
 * Date : 2020-09-15
 * Description :
 * History :
 * Version :
 */
public class EgovProperties {
    //프로퍼티값 로드시 에러발생하면 반환되는 에러문자열
    public static final String ERR_CODE = " EXCEPTION OCCURRED";
    public static final String ERR_CODE_FNFE = " EXCEPTION(FNFE) OCCURRED";
    public static final String ERR_CODE_IOE = " EXCEPTION(IOE) OCCURRED";

    //파일구분자
    private static final char FILE_SEPARATOR = File.separatorChar;

    //protected final static Logger logger = LoggerFactory.getLogger(EgovProperties.class);

    //프로퍼티 파일의 물리적 위치
    /*public static final String GLOBALS_PROPERTIES_FILE
    = System.getProperty("user.home") + System.getProperty("file.separator") + "egovProps"
    + System.getProperty("file.separator") + "commonProp.xml";*/


//    public static final String RELATIVE_PATH_PREFIX = EgovProperties.class.getResource("").getPath()
//    + System.getProperty("file.separator") + ".." + System.getProperty("file.separator")
//    + ".." + System.getProperty("file.separator") + ".." + System.getProperty("file.separator");


    public static final String RELATIVE_PATH_PREFIX = EgovProperties.class.getResource("").getPath().substring(0, EgovProperties.class.getResource("").getPath().lastIndexOf("com"));

    //public static final String GLOBALS_PROPERTIES_FILE = RELATIVE_PATH_PREFIX +  "properties" + System.getProperty("file.separator") + "commonProp.xml";
    public static final String GLOBALS_PROPERTIES_FILE = "properties" + System.getProperty("file.separator") + "commonProp.xml";


    /**
     * 인자로 주어진 문자열을 Key값으로 하는 상대경로 프로퍼티 값을 절대경로로 반환한다(Globals.java 전용)
     *
     * @param keyName String
     * @return String
     */
    public static String getPathProperty(String keyName) {
        String value = ERR_CODE;
        value = "99";
        ClassPathResource classPathResource = new ClassPathResource(EgovWebUtil.filePathBlackList(GLOBALS_PROPERTIES_FILE));
        //System.out.println(GLOBALS_PROPERTIES_FILE + " : " + keyName);
        InputStream fis = null;
        try {
            Properties props = new Properties();
            //fis = new FileInputStream(EgovWebUtil.filePathBlackList(GLOBALS_PROPERTIES_FILE));
            fis = classPathResource.getInputStream();
            props.load(new BufferedInputStream(fis));
            if (keyName != null) {
                value = props.getProperty(keyName).trim();
            }
            value = RELATIVE_PATH_PREFIX + "properties" + System.getProperty("file.separator") + value;
        } catch (FileNotFoundException fne) {
            debug(fne);
        } catch (IOException ioe) {
            debug(ioe);
        } catch (Exception e) {
            debug(e);
        } finally {
            try {
                if (fis != null) fis.close();
            } catch (FileNotFoundException fne) {
                debug(fne);
            } catch (IOException ioe) {
                debug(ioe);
            } catch (Exception e) {
                debug(e);
            }
        }
        return value;
    }


    /**
     * 인자로 주어진 문자열을 Key값으로 하는 프로퍼티 값을 반환한다(Globals.java 전용)
     *
     * @param keyName String
     * @return String
     */
    public static String getProperty(String keyName) {
        String value = ERR_CODE;
        value = "99";

        ClassPathResource classPathResource = new ClassPathResource(EgovWebUtil.filePathBlackList(GLOBALS_PROPERTIES_FILE));

        InputStream fis = null;
        try {
            Properties props = new Properties();
            //fis = new FileInputStream(EgovWebUtil.filePathBlackList(GLOBALS_PROPERTIES_FILE));
            fis = classPathResource.getInputStream();
            //fis = new FileInputStream(GLOBALS_PROPERTIES_FILE);
            props.loadFromXML(new BufferedInputStream(fis));
            if (keyName != null) {
                value = props.getProperty(keyName).trim();
            }
        } catch (FileNotFoundException fne) {
            debug(fne);
        } catch (IOException ioe) {
            debug(ioe);
        } catch (Exception e) {
            debug(e);
        } finally {
            try {
                if (fis != null) fis.close();
            } catch (FileNotFoundException fne) {
                debug(fne);
            } catch (IOException ioe) {
                debug(ioe);
            } catch (Exception e) {
                debug(e);
            }

        }
        return value;
    }

    /**
     * 주어진 파일에서 인자로 주어진 문자열을 Key값으로 하는 프로퍼티 상대 경로값을 절대 경로값으로 반환한다
     *
     * @param fileName String
     * @param key      String
     * @return String
     */
    public static String getPathProperty(String fileName, String key) {
        ClassPathResource classPathResource = new ClassPathResource(EgovWebUtil.filePathBlackList(fileName));
        InputStream fis = null;
        String rtn_val = "";
        try {
            Properties props = new Properties();
            //fis = new FileInputStream(EgovWebUtil.filePathBlackList(fileName));
            //fis = new FileInputStream(EgovWebUtil.filePathBlackList(fileName));
            fis = classPathResource.getInputStream();
            props.loadFromXML(new BufferedInputStream(fis));
            fis.close();

            String value = props.getProperty(key);
            rtn_val = RELATIVE_PATH_PREFIX + "properties" + System.getProperty("file.separator") + value;
        } catch (FileNotFoundException fne) {
            rtn_val = ERR_CODE_FNFE;
        } catch (IOException ioe) {
            rtn_val = ERR_CODE_IOE;
        } finally {
            try {
                if (fis != null) fis.close();
            } catch (FileNotFoundException fne) {
                debug(fne);
            } catch (IOException ioe) {
                debug(ioe);
            } catch (Exception e) {
                debug(e);
            }
        }
        return rtn_val;
    }


    /**
     * 주어진 파일에서 인자로 주어진 문자열을 Key값으로 하는 프로퍼티 값을 반환한다
     *
     * @param fileName String
     * @param key      String
     * @return String
     */
    public static String getProperty(String fileName, String key) {
        ClassPathResource classPathResource = new ClassPathResource(EgovWebUtil.filePathBlackList(fileName));
        InputStream fis = null;
        String value = null;
        try {
            Properties props = new Properties();
            //fis = new FileInputStream(EgovWebUtil.filePathBlackList(fileName));
            fis = classPathResource.getInputStream();
            props.loadFromXML(new BufferedInputStream(fis));
            fis.close();
            value = props.getProperty(key);
            //return value;
        } catch (FileNotFoundException fne) {
            value = ERR_CODE_FNFE;
        } catch (IOException ioe) {
            value = ERR_CODE_IOE;
        } finally {
            try {
                if (fis != null) fis.close();
            } catch (FileNotFoundException fne) {
                debug(fne);
            } catch (IOException ioe) {
                debug(ioe);
            } catch (Exception e) {
                debug(e);
            }
        }
        return value;
    }

    /**
     * 주어진 프로파일의 내용을 파싱하여 (key-value) 형태의 구조체 배열을 반환한다.
     *
     * @param property String
     * @return ArrayList
     */
    public static ArrayList loadPropertyFile(String property) {

        // key - value 형태로 된 배열 결과
        ArrayList keyList = new ArrayList();

        String src = property.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
        FileInputStream fis = null;
        try {

            File srcFile = new File(EgovWebUtil.filePathBlackList(src));
            if (srcFile.exists()) {

                Properties props = new Properties();
                fis = new FileInputStream(src);
                props.loadFromXML(new BufferedInputStream(fis));
                fis.close();

                Enumeration plist = props.propertyNames();
                if (plist != null) {
                    while (plist.hasMoreElements()) {
                        Map map = new HashMap();
                        String key = (String) plist.nextElement();
                        map.put(key, props.getProperty(key));
                        keyList.add(map);
                    }
                }
            }
        } catch (Exception ex) {
            //ex.printStackTrace();
            debug(ex);    // 2011.10.10 보안점검 후속조치
        } finally {
            try {
                if (fis != null) fis.close();
            } catch (FileNotFoundException fne) {
                debug(fne);
            } catch (IOException ioe) {
                debug(ioe);
            } catch (Exception e) {
                debug(e);
            }
        }

        return keyList;
    }

    /**
     * 시스템 로그를 출력한다.
     *
     * @param obj Object
     */
    private static void debug(Object obj) {
        if (obj instanceof Exception) {
            //logger.debug(((Exception) obj).getMessage());
        }
    }
}
