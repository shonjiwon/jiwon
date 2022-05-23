package kr.go.songpa.ssem.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Program Name : kr.go.songpa.ssem.util
 * Author : shlee
 * Date : 2020-10-07
 * Description :
 * History :
 * Version :
 */
public class StringUtil {
    public StringUtil() {}
    public final static String ENCODING = "UTF-8";
    private final static Logger logger = LoggerFactory.getLogger(StringUtil.class);

    // 날짜 변환
    public static String dtStyle(Date dt, String st){
        String retVal = "";
        SimpleDateFormat refSdf = new SimpleDateFormat(st);
        Calendar ca = Calendar.getInstance();
        ca.setTime(dt);

        retVal = refSdf.format(ca.getTime());
        return retVal;
    }

    public static String deleteLastStr(String str, char token) {
        if (str.length() > 0 && str.charAt(str.length()-1)==token) {
            str = str.substring(0, str.length()-1);
        }
        return str;
    }

    /**
     * str에 매핑되는 paramMap값으로 치환
     *
     * @param str
     * @param paramMap
     * @return
     */
    public static String mapToStringReplace(String str, Map<String, Object> paramMap) {
        String result = "";
        try {
            if(paramMap == null) return str;
            str = URLEncoder.encode(str, ENCODING);
            Iterator<String> it = paramMap.keySet().iterator();
            while(it.hasNext()) {
                String key = it.next();
                str = str.replaceAll(URLEncoder.encode("#{" + key + "}", ENCODING), URLEncoder.encode(String.valueOf(paramMap.get(key)), ENCODING));
            }
            result = URLDecoder.decode(str, ENCODING);
        } catch (UnsupportedEncodingException e) {
            logger.error("error", e);
        }
        return result;
    }

    /**
     * null값 체크
     *
     * @param obj
     * @return
     */
    public static boolean isNull(Object obj) {
        return obj == null ? true : false;
    }

    /**
     * null값 체크
     *
     * @param str
     * @return
     */
    public static boolean isNull(String str) {
        if(str == null || "null".equals(str) || "".equals(str)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * null 또는 공백일때 def 리턴, 아닐때 str 리턴
     *
     * @param str
     * @param def
     * @return
     */
    public static String nvl(String str, String def) {
        if(isNull(str)) {
            return def;
        } else {
            return str;
        }
    }

    /**
     * 문자열에서 숫자외는 제거후 숫자만 리턴
     * (ex: 12.3$-45!6 -> 123456)
     *
     * @param str
     * @return
     */
    public static String getStrToOnlyNumber(String str) {
        return isNull(str) ? "" : str.replaceAll("[^0-9]", "");
    }

    public static List<String> getWeekStrToWeekCode(String week_codes) {
        List<String> week_list = new ArrayList<String>();

        /* 1: 월, 2: 화, 3: 수, 4: 목, 5: 금, 6: 토, 7: 일 */
        if(!"".equals(week_codes)) {
            String[] tokens = week_codes.split(",");
            for(String token : tokens) {
                if("1".equals(token)) {
                    week_list.add("월");
                } else if ("2".equals(token)) {
                    week_list.add("화");
                } else if ("3".equals(token)) {
                    week_list.add("수");
                } else if ("4".equals(token)) {
                    week_list.add("목");
                } else if ("5".equals(token)) {
                    week_list.add("금");
                } else if ("6".equals(token)) {
                    week_list.add("토");
                } else if ("7".equals(token)) {
                    week_list.add("일");
                }
            }
        }
        return week_list;
    }

    public static String maskName(String name) {
        String rtn = "";
        String first = "";
        String middle = "";
        String last = "";

        if(!"".equals(name)) {
            if (name.length() == 3) {
                first = name.substring(0, 1);
                middle = "*";
                last = name.substring(name.length()-1, name.length());
            } else if (name.length() == 4) {
                first = name.substring(0, 1);
                middle = "**";
                last = name.substring(name.length()-1, name.length());
            } else if (name.length() == 2) {
                first = name.substring(0, 1);
                middle = "*";
                last = "";
            }
        }

        rtn = first + middle + last;

        return rtn;
    }

    public static String maskUserId(String id) {
        String rtn = "";
        String firstStr = "";
        String last = "";

        if(!"".equals(id)) {
            firstStr = id.substring(0, 3);
            int count = id.length();
            for(int i=0; i<count - 3; i++) {
                last += "*";
            }
        }

        rtn = firstStr + last;

        return rtn;
    }

    // 문자열을 리스트로 변환
    public static List<String> transStringToList(String str, String div) {
        List<String> rtn = new ArrayList<String>();

        if(!"".equals(str)) {
            String[] tokens = str.split(div);
            for(String token : tokens) {
                rtn.add(token);
            }
        }

        return rtn;
    }

    public static String substring(String src, int start, int end) {
        String retVal = "";
        if (!(src == null || "".equals(src) || start > src.length() || start > end || start < 0)) {
            if (end > src.length())
                end = src.length();
            retVal = src.substring(start, end);
        }
        return retVal;
    }

    // 숫자 콤마 찍기
    public static String getCostFormat(int cost) {
        DecimalFormat format = new DecimalFormat("###,###");
        return format.format(cost);
    }

    /**
     * 서버 모드
     *
     * @return
     */
    /*public static String getServerMode() {
        return System.getProperty(Constants.ServerMode.KEY);
    }*/

    /**
     * 서버 모드 로컬 여부
     *
     * @return
     */
    /*public static boolean isLocal() {
        return Constants.ServerMode.LOCAL.equals(getServerMode());
    }*/

    /**
     * 서버 모드 개발 여부
     *
     * @return
     */
    /*public static boolean isDev() {
        return Constants.ServerMode.DEV.equals(getServerMode());
    }*/

    /**
     * 서버 모드 스테이징 여부
     *
     * @return
     */
    /*public static boolean isStag() {
        return Constants.ServerMode.STAG.equals(getServerMode());
    }*/

    /**
     * 서버 모드 운영 여부
     *
     * @return
     */
    /*public static boolean isProd() {
        return Constants.ServerMode.PROD.equals(getServerMode());
    }*/
}
