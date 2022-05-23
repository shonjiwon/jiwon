package kr.go.songpa.ssem.util;

import kr.go.songpa.ssem.model.DongVo;
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

            if( lectureVo.getReg_method().indexOf("4") > -1) {
                return 8;
            }

            if( date_today.compareTo(date_reg_start_st) < 0) {
                return 1;
            }

            if( date_today.compareTo(date_reg_start_st) > 0 && date_today.compareTo(date_reg_end_dt) < 0) {
                if(lectureVo.getOnline_can_qty() > 0 || lectureVo.getTel_can_qty() > 0 || lectureVo.getVisit_can_qty() > 0) {
                    return 2;
                } else if (lectureVo.getOnline_can_qty() == 0 && lectureVo.getWait_can_qty() > 0 && lectureVo.getTel_can_qty() == 0 && lectureVo.getVisit_can_qty() == 0) {
                    return 3;
                } else if (lectureVo.getOnline_can_qty() == 0 && lectureVo.getWait_can_qty() == 0 && lectureVo.getTel_can_qty() == 0 && lectureVo.getVisit_can_qty() == 0) {
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

    public static String getDongName(String code) {
        String rtn = "";

        if("D32300550000".equals(code)) {
            rtn = "가락1동";
        } else if("D32300560000".equals(code)) {
            rtn = "가락2동";
        } else if("D32300540000".equals(code)) {
            rtn = "가락본동";
        } else if("D32300420000".equals(code)) {
            rtn = "거여1동";
        } else if("D32300430000".equals(code)) {
            rtn = "거여2동";
        } else if("D32300440000".equals(code)) {
            rtn = "마천1동";
        } else if("D32300450000".equals(code)) {
            rtn = "마천2동";
        } else if("D32300570000".equals(code)) {
            rtn = "문정1동";
        } else if("D32300580000".equals(code)) {
            rtn = "문정2동";
        } else if("D32300460000".equals(code)) {
            rtn = "방이1동";
        } else if("D32300470000".equals(code)) {
            rtn = "방이2동";
        } else if("D32300530000".equals(code)) {
            rtn = "삼전동";
        } else if("D32300520000".equals(code)) {
            rtn = "석촌동";
        } else if("D32300500000".equals(code)) {
            rtn = "송파1동";
        } else if("D32300510000".equals(code)) {
            rtn = "송파2동";
        } else if("D32300610000".equals(code)) {
            rtn = "잠실2동";
        } else if("D32300620000".equals(code)) {
            rtn = "잠실3동";
        } else if("D32300630000".equals(code)) {
            rtn = "잠실4동";
        } else if("D32300650000".equals(code)) {
            rtn = "잠실6동";
        } else if("D32300660000".equals(code)) {
            rtn = "잠실7동";
        } else if("D32300590000".equals(code)) {
            rtn = "잠실본동";
        } else if("D32300990000".equals(code)) {
            rtn = "장지동";
        } else if("D32300490000".equals(code)) {
            rtn = "오금동";
        } else if("D32300480000".equals(code)) {
            rtn = "오륜동";
        } else if("D32302500000".equals(code)) {
            rtn = "위례동";
        } else if("D32300400000".equals(code)) {
            rtn = "풍납1동";
        } else if("D32300410000".equals(code)) {
            rtn = "풍납2동";
        } else if("D32301070000".equals(code)) {
            rtn = "자치행정과";
        }

        return rtn;
    }

    public static List<DongVo> getDongList() {
        List<DongVo> list = new ArrayList<DongVo>();

        DongVo item_27 = new DongVo();
        item_27.setName("풍납1동");
        item_27.setCode("D32300400000");
        list.add(item_27);

        DongVo item_28 = new DongVo();
        item_28.setName("풍납2동");
        item_28.setCode("D32300410000");
        list.add(item_28);

        DongVo item_4 = new DongVo();
        item_4.setName("거여1동");
        item_4.setCode("D32300420000");
        list.add(item_4);

        DongVo item_5 = new DongVo();
        item_5.setName("거여2동");
        item_5.setCode("D32300430000");
        list.add(item_5);

        DongVo item_6 = new DongVo();
        item_6.setName("마천1동");
        item_6.setCode("D32300440000");
        list.add(item_6);

        DongVo item_7 = new DongVo();
        item_7.setName("마천2동");
        item_7.setCode("D32300450000");
        list.add(item_7);

        DongVo item_10 = new DongVo();
        item_10.setName("방이1동");
        item_10.setCode("D32300460000");
        list.add(item_10);

        DongVo item_11 = new DongVo();
        item_11.setName("방이2동");
        item_11.setCode("D32300470000");
        list.add(item_11);

        DongVo item_25 = new DongVo();
        item_25.setName("오륜동");
        item_25.setCode("D32300480000");
        list.add(item_25);

        DongVo item_24 = new DongVo();
        item_24.setName("오금동");
        item_24.setCode("D32300490000");
        list.add(item_24);

        DongVo item_14 = new DongVo();
        item_14.setName("송파1동");
        item_14.setCode("D32300500000");
        list.add(item_14);

        DongVo item_15 = new DongVo();
        item_15.setName("송파2동");
        item_15.setCode("D32300510000");
        list.add(item_15);

        DongVo item_13 = new DongVo();
        item_13.setName("석촌동");
        item_13.setCode("D32300520000");
        list.add(item_13);

        DongVo item_12 = new DongVo();
        item_12.setName("삼전동");
        item_12.setCode("D32300530000");
        list.add(item_12);

        DongVo item_3 = new DongVo();
        item_3.setName("가락본동");
        item_3.setCode("D32300540000");
        list.add(item_3);

        DongVo item_1 = new DongVo();
        item_1.setName("가락1동");
        item_1.setCode("D32300550000");
        list.add(item_1);

        DongVo item_2 = new DongVo();
        item_2.setName("가락2동");
        item_2.setCode("D32300560000");
        list.add(item_2);

        DongVo item_8 = new DongVo();
        item_8.setName("문정1동");
        item_8.setCode("D32300570000");
        list.add(item_8);

        DongVo item_9 = new DongVo();
        item_9.setName("문정2동");
        item_9.setCode("D32300580000");
        list.add(item_9);

        DongVo item_23 = new DongVo();
        item_23.setName("장지동");
        item_23.setCode("D32300990000");
        //item_23.setCode("D32300590000");
        list.add(item_23);

        DongVo item_26 = new DongVo();
        item_26.setName("위례동");
        //item_26.setCode("D32302500000");
        item_26.setCode("D32306100000");
        list.add(item_26);

        DongVo item_22 = new DongVo();
        item_22.setName("잠실본동");
        item_22.setCode("D32300590000");
        list.add(item_22);

        DongVo item_16 = new DongVo();
        item_16.setName("잠실2동");
        item_16.setCode("D32300610000");
        //item_16.setCode("D32300630000");
        list.add(item_16);

        DongVo item_17 = new DongVo();
        item_17.setName("잠실3동");
        item_17.setCode("D32300620000");
        //item_17.setCode("D32300650000");
        list.add(item_17);

        DongVo item_19 = new DongVo();
        item_19.setName("잠실4동");
        item_19.setCode("D32300630000");
        //item_19.setCode("D32300660000");
        list.add(item_19);

        DongVo item_20 = new DongVo();
        item_20.setName("잠실6동");
        item_20.setCode("D32300650000");
        //item_20.setCode("D32300990000");
        list.add(item_20);

        DongVo item_21 = new DongVo();
        item_21.setName("잠실7동");
        item_21.setCode("D32300660000");
        //item_21.setCode("D32300250000");
        list.add(item_21);

        DongVo item_29 = new DongVo();
        item_29.setName("자치행정과");
        //item_29.setCode("D32301070000");
        item_29.setCode("D32302710000");
        list.add(item_29);

        return list;
    }

    public static String getDongCode(String name) {
        String rtn = "";

        if(!"".equals(Util.nvl(name))) {
            if(name.contains("가락1동")) {
                rtn = "D32300550000";
            } else if(name.contains("가락2동")) {
                rtn = "D32300560000";
            } else if(name.contains("가락본동")) {
                rtn = "D32300540000";
            } else if(name.contains("거여1동")) {
                rtn = "D32300420000";
            } else if(name.contains("거여2동")) {
                rtn = "D32300430000";
            } else if(name.contains("마천1동")) {
                rtn = "D32300440000";
            } else if(name.contains("마천2동")) {
                rtn = "D32300450000";
            } else if(name.contains("문정1동")) {
                rtn = "D32300570000";
            } else if(name.contains("문정2동")) {
                rtn = "D32300580000";
            } else if(name.contains("방이1동")) {
                rtn = "D32300460000";
            } else if(name.contains("방이2동")) {
                rtn = "D32300470000";
            } else if(name.contains("삼전동")) {
                rtn = "D32300530000";
            } else if(name.contains("석촌동")) {
                rtn = "D32300520000";
            } else if(name.contains("송파1동")) {
                rtn = "D32300500000";
            } else if(name.contains("송파2동")) {
                rtn = "D32300510000";
            } else if(name.contains("잠실2동")) {
                rtn = "D32300610000";
                //rtn = "D32300630000";
            } else if(name.contains("잠실3동")) {
                rtn = "D32300620000";
                //rtn = "D32300650000";
            } else if(name.contains("잠실4동")) {
                rtn = "D32300630000";
                //rtn = "D32300660000";
            } else if(name.contains("잠실6동")) {
                rtn = "D32300650000";
                //rtn = "D32300990000";
            } else if(name.contains("잠실7동")) {
                rtn = "D32300660000";
                //rtn = "D32300250000";
            } else if(name.contains("잠실본동")) {
                rtn = "D32300590000";
                //rtn = "D32300620000";
            } else if(name.contains("장지동")) {
                rtn = "D32300990000";
                //rtn = "D32300590000";
            } else if(name.contains("오금동")) {
                rtn = "D32300490000";
            } else if(name.contains("오륜동")) {
                rtn = "D32300480000";
            } else if(name.contains("위례동")) {
                rtn = "D32302500000";
                //rtn = "D32306100000";
            } else if(name.contains("풍납1동")) {
                rtn = "D32300400000";
            } else if(name.contains("풍납2동")) {
                rtn = "D32300410000";
            } else if(name.contains("자치행정과")) {
                //rtn = "D32301070000";
                rtn = "D32302710000";
            }
        }

        return rtn;
    }

    public static int getPrevSumOld(String code) {
        int rtn = 0;

        int prev_2 = 27273503;
        int prev_3 = 14731835;
        int prev_4 = 20210988;
        int prev_5 = 10375657;
        int prev_6 = 24447;
        int prev_7 = 9342510;
        int prev_8 = 10882682;
        int prev_9 = 18513015;
        int prev_10 = 24165920;
        int prev_11 = 45544000;
        int prev_12 = 5149157;
        int prev_13 = 17890069;
        int prev_14 = 3094976;
        int prev_15 = 18607228;
        int prev_16 = 47217552;
        int prev_17 = 61288890;
        int prev_18 = 23793550;
        int prev_19 = 0;
        int prev_20 = 20231516;
        int prev_22 = 8398247;
        int prev_23 = 234181;
        int prev_24 = 27517752;
        int prev_25 = 19017501;
        int prev_26 = 58990160;
        int prev_27 = 1066265;
        int prev_28 = 32244145;
        int prev_29 = 5174815;
        int prev_30 = 23283360;
        int prev_93 = 0;

        if("".equals(code)) {
            rtn = prev_2 + prev_3 + prev_4 + prev_5 + prev_6 + prev_7 + prev_8 + prev_9 + prev_10 + prev_11 + prev_12 + prev_13 + prev_14 + prev_15;
            rtn = rtn + prev_16 + prev_17 + prev_18 + prev_19 + prev_20 + prev_22 + prev_23 + prev_24 + prev_25 + prev_26 + prev_27 + prev_28 + prev_29 + prev_30 + prev_93;
        } else if("2".equals(code)) {
            rtn = prev_2;
        } else if("3".equals(code)) {
            rtn = prev_3;
        } else if("4".equals(code)) {
            rtn = prev_4;
        } else if("5".equals(code)) {
            rtn = prev_5;
        } else if("6".equals(code)) {
            rtn = prev_6;
        } else if("7".equals(code)) {
            rtn = prev_7;
        } else if("8".equals(code)) {
            rtn = prev_8;
        } else if("9".equals(code)) {
            rtn = prev_9;
        } else if("10".equals(code)) {
            rtn = prev_10;
        } else if("11".equals(code)) {
            rtn = prev_11;
        } else if("12".equals(code)) {
            rtn = prev_12;
        } else if("13".equals(code)) {
            rtn = prev_13;
        } else if("14".equals(code)) {
            rtn = prev_14;
        } else if("15".equals(code)) {
            rtn = prev_15;
        } else if("16".equals(code)) {
            rtn = prev_16;
        } else if("17".equals(code)) {
            rtn = prev_17;
        } else if("18".equals(code)) {
            rtn = prev_18;
        } else if("19".equals(code)) {
            rtn = prev_19;
        } else if("20".equals(code)) {
            rtn = prev_20;
        } else if("22".equals(code)) {
            rtn = prev_22;
        } else if("23".equals(code)) {
            rtn = prev_23;
        } else if("24".equals(code)) {
            rtn = prev_24;
        } else if("25".equals(code)) {
            rtn = prev_25;
        } else if("26".equals(code)) {
            rtn = prev_26;
        } else if("27".equals(code)) {
            rtn = prev_27;
        } else if("28".equals(code)) {
            rtn = prev_28;
        } else if("29".equals(code)) {
            rtn = prev_29;
        } else if("30".equals(code)) {
            rtn = prev_30;
        } else if("93".equals(code)) {
            rtn = prev_93;
        }

        return rtn;
    }
}
