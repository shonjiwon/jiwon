package kr.go.songpa.ssem.util;

import kr.go.songpa.ssem.model.LectureVo;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Program Name : kr.go.songpa.ssem.util
 * Author : shlee
 * Date : 2020-09-13
 * Description :
 * History :
 * Version :
 */
public class Util {

    private static Properties commonProp;
    public static void setCommonProp(Properties prop) {
        commonProp = prop;
    }

    public static String getSubString(String src, String token) {
        return src.substring(0,  src.indexOf(token));
    }

    public static String getDate(int div) {
        Calendar cal = Calendar.getInstance();
        String yyyy = Integer.toString(cal.get(Calendar.YEAR));
        String mm = Integer.toString(cal.get(Calendar.MONTH) + 1);
        String dd = Integer.toString(cal.get(Calendar.DATE));
        if (mm.length() == 1)
            mm = "0" + mm;
        if (dd.length() == 1)
            dd = "0" + dd;

        String reDate = "";
        if (div == 1)
            reDate = yyyy + mm + dd;
        if (div == 2)
            reDate = yyyy + "/" + mm + "/" + dd;
        if (div == 3)
            reDate = yyyy + "-" + mm + "-" + dd;
        return reDate;
    }

    public static String getDateMonthMinus(int div, int minus) {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.MONTH, minus);

        String yyyy = Integer.toString(cal.get(Calendar.YEAR));
        String mm = Integer.toString(cal.get(Calendar.MONTH) + 1);
        String dd = Integer.toString(cal.get(Calendar.DATE));

        if (mm.length() == 1)
            mm = "0" + mm;
        if (dd.length() == 1)
            dd = "0" + dd;

        String reDate = "";
        if (div == 1)
            reDate = yyyy + mm + dd;
        if (div == 2)
            reDate = yyyy + "/" + mm + "/" + dd;
        if (div == 3)
            reDate = yyyy + "-" + mm + "-" + dd;

        return reDate;
    }

    public static List<String> getLocalTelNo() {
        ArrayList<String> localTelNoList = new ArrayList<String>();

        localTelNoList.add("010");		/* 모바일 */
        localTelNoList.add("02");		/* 서울특별시 */
        localTelNoList.add("031");		/* 경기도 */
        localTelNoList.add("032");		/* 인천광역시, 경기도 부천시 */
        localTelNoList.add("033");		/* 강원도 */
        localTelNoList.add("041");		/* 충청남도 */
        localTelNoList.add("042");		/* 대전광역시 */
        localTelNoList.add("043");		/* 충청북도 */
        localTelNoList.add("051");		/* 부산광역시 */
        localTelNoList.add("052");		/* 울산광역시 */
        localTelNoList.add("053");		/* 대구광역시 */
        localTelNoList.add("054");		/* 경상북도 */
        localTelNoList.add("055");		/* 경상남도 */
        localTelNoList.add("061");		/* 전라남도 */
        localTelNoList.add("062");		/* 광주광역시 */
        localTelNoList.add("063");		/* 전라북도 */
        localTelNoList.add("064");		/* 제주도 */

        return localTelNoList;
    }

    public static String getRemoteAddr(HttpServletRequest request) {
        String ip = null;
        ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-RealIP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("REMOTE_ADDR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    public static String getRemoteOs(HttpServletRequest request) {
        String agent = request.getHeader("User-Agent");
        String os = "";

        if(agent.contains("NT 6.0")) os = "Windows Vista/Server 2008";
        else if(agent.contains("NT 5.2")) os = "Windows Server 2003";
        else if(agent.contains("NT 5.1")) os = "Windows XP";
        else if(agent.contains("NT 5.0")) os = "Windows 2000";
        else if(agent.contains("NT 7.0")) os = "Windows 7";
        else if(agent.contains("NT 10.0")) os = "Windows 10";
        else if(agent.contains("NT")) os = "Windows NT";
        else if(agent.contains("9x 4.90")) os = "Windows Me";
        else if(agent.contains("98")) os = "Windows 98";
        else if(agent.contains("95")) os = "Windows 95";
        else if(agent.contains("Win16")) os = "Windows 3.x";
        else if(agent.contains("Windows")) os = "Windows";
        else if(agent.contains("Linux")) os = "Linux";
        else if(agent.contains("Macintosh")) os = "Macintosh";
        else os = "";

        return os;
    }

    public static String getRemoteBrowser(HttpServletRequest request) {
        String agent = request.getHeader("User-Agent");
        String brower = "";

        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + agent);

        if (agent != null) {
            if (agent.contains("Trident")) {
                brower = "MSIE";
            } else if (agent.contains("Edg")) {
                brower = "Edge";
            } else if (agent.contains("Firefox")) {
                brower = "Firefox";
            } else if (agent.contains("Chrome")) {
                brower = "Chrome";
            } else if (agent.contains("Opera")) {
                brower = "Opera";
            } else if (agent.contains("iPhone") && agent.contains("Mobile")) {
                brower = "iPhone";
            } else if (agent.contains("Android") && agent.contains("Mobile")) {
                brower = "Android";
            }
        }

        return brower;
    }

    public static synchronized String nvl(Object object, String result) {
        String retVal = result;
        if (object != null) {
            retVal = object.toString();
        }
        return retVal;
    }

    public static synchronized int nvl(Object object, int result) {
        int retVal = result;
        if (object != null) {
            retVal = Integer.parseInt((String) object.toString());
        }
        return retVal;
    }

    public static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }

    public static synchronized String nvl(Object object)
    {
        String _s = null;
        if (object == null || object.equals("null"))
            _s = new String("");
        else
            _s = object.toString();
        return _s;
    }

    public static String substring(String src, int start, int end)
    {
        String retVal = "";
        if (!(src == null || "".equals(src) || start > src.length() || start > end || start < 0)){
            if (end > src.length())
                end = src.length();
            retVal = src.substring(start, end);
        }
        return retVal;
    }

    public static String getArrayToStr(String[] array) {
        StringBuilder rtn = new StringBuilder();

        int size = array.length;
        if (size != 0) {
            for(String item : array) {
                rtn.append(item).append(",");
            }
        }
        return rtn.toString().substring(0, rtn.toString().length()-1);
    }

    public static String getPwdTemp(String mob_no) {
        String pwd = "";
        String[] tokens = mob_no.split("-");

        if(tokens.length == 3) {
            pwd = "ssem@" + tokens[2] + "!";
        } else {
            pwd = "ssem@0000!";
        }

        return pwd;
    }

    public static String admintype(String code) {
        String rtnStr = "";

        if("S".equals(code)) {
            rtnStr = "마스터관리자";
        } else if("G".equals(code)) {
            rtnStr = "기관관리자";
        } else if("N".equals(code)) {
            rtnStr = "일반관리자";
        } else if("B".equals(code)) {
            rtnStr = "게시판관리자";
        } else if ("".equals(code)) {
            rtnStr = "신규가입자";
        }

        return rtnStr;
    }

    public static List<String> getRateList() {
        List<String> minList = new ArrayList<String>();
        int strMin = 5;

        while(100 >= strMin) {
            minList.add(String.valueOf(strMin));
            strMin = strMin + 5;
        }

        return minList;
    }

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

    public static int getProgramStatus(LectureVo lectureVo) {
        int rtn = 0;

        try {
            // 프로그램 상태 체크
            // 1. 접수대기 : 접수날짜 도래 하지 않음
            // 2. 신청가능 : 접수날짜 내, 신청인원 마감 안됨
            // 3. 대기신청 : 신청인원 마감되고 대기인원 마감 안됨
            // 4. 신청마감 : 신청기간내에 신청인원 마감된 경우
            // 5. 교육전 : 신청기간이 지나고 교육시작 시간이 안된 경우
            // 6. 교육중 : 교육날짜 내
            // 7. 교육종료 : 교육날짜 지남
            // 8. 외부홈페이지 : 외부 홈페이지일 경우
            SimpleDateFormat today_fmt = new SimpleDateFormat("yyyyMMddHHmmss");
            String today = DateUtil.getDateTime();

            SimpleDateFormat db_fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            Date date_today = today_fmt.parse(today);
            Date date_reg_start_st = db_fmt.parse(lectureVo.getReg_start_st());
            Date date_reg_end_dt = db_fmt.parse(lectureVo.getReg_end_dt());
            Date date_start_dt = db_fmt.parse(lectureVo.getStart_dt() + " 00:00:00");
            Date date_end_dt = db_fmt.parse(lectureVo.getEnd_dt() + " 00:00:00");

            /*if( lectureVo.getReg_method().indexOf("4") > -1) {
                return 8;
            }*/

            if( date_today.compareTo(date_reg_start_st) < 0) {
                return 1;
            }

            if( date_today.compareTo(date_reg_start_st) > 0 && date_today.compareTo(date_reg_end_dt) < 0) {
                if(lectureVo.getOnline_can_qty() > 0) {
                    return 2;
                } else if (lectureVo.getOnline_can_qty() == 0 && lectureVo.getWait_can_qty() > 0) {
                    return 3;
                } else if (lectureVo.getOnline_can_qty() == 0 && lectureVo.getWait_can_qty() == 0) {
                    return 4;
                }
            }

            if( date_today.compareTo(date_reg_end_dt) > 0) {
                if( date_today.compareTo(date_start_dt) >= 0 && date_today.compareTo(date_end_dt) <= 0) {
                    return 6;
                } else if (date_today.compareTo(date_end_dt) > 0) {
                    return 7;
                } else {
                    return 5;
                }
            }

        } catch(Exception e) {

        }

        return rtn;
    }

    public static int getTeacherScore(int total, int score) {
        int rtn = 0;
        // score => 0 : 평가 없음
        // score => 1 : 금
        // score => 2 : 은
        // score => 3 : 동
        if(total != 0) {
            float avg = score / (float)total;

            if(avg >= 8.0) {
                rtn = 1;
            } else if(avg > 3.0 && avg < 8.0) {
                rtn = 2;
            } else {
                rtn = 3;
            }
        }
        return rtn;
    }

    public static String getMasK(String src, int size, String type) {
        String rtn = "";
        String show = "";
        String mask = "";
        int mask_length = 0;
        if("TEL".equals(type)) {
            String[] tokens = src.split("-");
            String no_1 = getMasK(tokens[0], size, "");
            String no_2 = getMasK(tokens[1], size, "");
            String no_3 = getMasK(tokens[2], size, "");

            rtn = no_1 + "-" + no_2 + "-" + no_3;

        } else {
            show = src.substring(0, size);
            mask_length = src.length() - size;

            for(int i=1; i <= mask_length; i++) {
                mask += "*";
            }

            rtn = show + mask;
        }

        return rtn;
    }

    public static String getMasKName(String src) {
        String rtn = "";
        String show = "";
        String mask = "";
        int mask_length = 0;

        if(src.length() == 3) {
            String first = src.substring(0, 1);
            String second = "*";
            String third = src.substring(2, 3);

            rtn = first + second + third;
        } else {
            String first = src.substring(0, 1);
            String second = "*";

            rtn = first + second;
        }

        return rtn;
    }

}
