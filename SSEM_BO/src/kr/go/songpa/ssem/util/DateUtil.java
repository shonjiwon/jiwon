package kr.go.songpa.ssem.util;

import java.text.ParseException;
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
public class DateUtil {

    // 현재날짜
    public static String getDate()
    {
        Calendar cal = Calendar.getInstance(Locale.getDefault());
        StringBuffer buf = new StringBuffer();
        buf.append(Integer.toString(cal.get(1)));
        String month = Integer.toString(cal.get(2) + 1);
        if (month.length() == 1)
            month = "0" + month;
        String day = Integer.toString(cal.get(5));
        if (day.length() == 1)
            day = "0" + day;
        buf.append(month);
        buf.append(day);
        return buf.toString();
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
        if (div == 4)
            reDate = yyyy + "년 " + mm + "월 " + dd + "일";
        return reDate;
    }

    /* 현재일과 비교한 날짜를 가져온다. */
    public static String getDateDiff(int op) {
        return getDateDiff("mon", op);
    }
    /* 현재일과 비교한 날짜를 가져온다. */
    public static String getDateDiff(String type, int op) {
        String viewDate = "";
        Calendar calendar = null;
        Date date = new Date();
        String retVal = "";
        try {
            calendar = Calendar.getInstance();
            calendar.setTime(date);
            //calendar.add(java.util.Calendar.MONTH, op);
            if(calendar != null) {
                String yyyy = Integer.toString(calendar.get(Calendar.YEAR));
                String mm = Integer.toString(calendar.get(Calendar.MONTH) + 1);
                String dd = Integer.toString(calendar.get(Calendar.DATE));
                if (mm.length() == 1)
                    mm = "0" + mm;
                if (dd.length() == 1)
                    dd = "0" + dd;

                viewDate = yyyy + mm + dd;
            }
            retVal = getDateDiff(viewDate, type, op);
        } catch (NumberFormatException e) {
            //logger.debug(e.getMessage());
        } catch (Exception e) {
            //logger.debug(e.getMessage());
        }
        return retVal;
    }

    /* 현재일과 비교한 날짜를 가져온다. */
    public static String getDateDiff(String indate, String type, int op) {
        String viewDate = "";
        Calendar calendar = null;
        Date date = null;

        try {
            calendar = Calendar.getInstance();
            calendar.set(Integer.parseInt(indate.substring(0, 4)), Integer
                    .parseInt(indate.substring(4, 6)) -1, Integer
                    .parseInt(indate.substring(6, 8)));
            date = calendar.getTime();
            calendar.setTime(date);
            if(type.equals("year")){
                calendar.add(java.util.Calendar.YEAR, op);
            }else if(type.equals("mon")){
                calendar.add(java.util.Calendar.MONTH, op);
            }else if(type.equals("day")){
                calendar.add(java.util.Calendar.DATE, op);
            }
            if(calendar != null) {
                String yyyy = Integer.toString(calendar.get(Calendar.YEAR));
                String mm = Integer.toString(calendar.get(Calendar.MONTH) + 1);
                String dd = Integer.toString(calendar.get(Calendar.DATE));
                if (mm.length() == 1)
                    mm = "0" + mm;
                if (dd.length() == 1)
                    dd = "0" + dd;

                viewDate = yyyy + "-" + mm + "-" + dd;
            }
        } catch (NumberFormatException e) {
            //logger.debug(e.getMessage());
        } catch (Exception e) {
            //logger.debug(e.getMessage());
        }
        return viewDate;
    }

    // 일자를 뺀 날자를 가져온다
    public static String getDayMinus(String div, int minus) {
        Calendar temp=Calendar.getInstance ( );
        temp.add ( Calendar.DAY_OF_MONTH, minus );

        int nYear = temp.get ( Calendar.YEAR );
        int nMonth = temp.get ( Calendar.MONTH ) + 1;
        int nDay = temp.get ( Calendar.DAY_OF_MONTH );

        StringBuffer sbDate=new StringBuffer ( );
        sbDate.append ( nYear ); sbDate.append ( div );

        if ( nMonth < 10 ) sbDate.append ( "0" );
        sbDate.append ( nMonth ); sbDate.append ( div );

        if ( nDay < 10 ) sbDate.append ( "0" );
        sbDate.append ( nDay );

        return sbDate.toString();
    }
    // 월을 뺀 날자를 가져온다
    public static String getMonthMinus(String div, int minus) {
        Calendar temp=Calendar.getInstance ( );
        temp.add ( Calendar.MONTH, minus );

        int nYear = temp.get ( Calendar.YEAR );
        int nMonth = temp.get ( Calendar.MONTH ) + 1;

        StringBuffer sbDate=new StringBuffer ( );
        sbDate.append ( nYear ); sbDate.append ( div );

        if ( nMonth < 10 ) sbDate.append ( "0" );
        sbDate.append ( nMonth );

        return sbDate.toString();
    }

    // 기준 년월에 월을 뺀 날짜를 가져온다.
    public static String getMonthMinusEx(String sdate, String div, int minus) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Integer.parseInt(sdate.substring(0, 4)), Integer.parseInt(sdate.substring(4, 6)), 1);
        calendar.add ( Calendar.MONTH, minus );

        int nYear = calendar.get ( Calendar.YEAR );
        int nMonth = calendar.get ( Calendar.MONTH ) + 1;

        StringBuffer sbDate = new StringBuffer ( );
        sbDate.append ( nYear ); sbDate.append ( div );

        if ( nMonth < 10 ) sbDate.append ( "0" );
        sbDate.append ( nMonth );

        return sbDate.toString();
    }

    // 년을 뺀 날자를 가져온다
    public static String getYearMinus(int minus) {
        Calendar temp=Calendar.getInstance ( );
        temp.add ( Calendar.YEAR, minus );

        int nYear = temp.get ( Calendar.YEAR );

        StringBuffer sbDate=new StringBuffer ( );
        sbDate.append ( nYear );

        return sbDate.toString();
    }
    // 현재 시간을 가져온다
    public static String getTime()
    {
        Calendar cal = Calendar.getInstance(Locale.getDefault());
        StringBuffer buf = new StringBuffer();
        String hour = Integer.toString(cal.get(11));
        if (hour.length() == 1)
            hour = "0" + hour;
        String min = Integer.toString(cal.get(12));
        if (min.length() == 1)
            min = "0" + min;
        String sec = Integer.toString(cal.get(13));
        if (sec.length() == 1)
            sec = "0" + sec;
        buf.append(hour);
        buf.append(min);
        buf.append(sec);
        return buf.toString();
    }

    //  현재일자와 현재 시간을 가져온다.
    public static String getDateTime()
    {
        return getDate() + getTime();
    }

    /* 두 날짜 사이의 차를 구함 */
    public static long calDates(String date1, String date2) {
        long calDateDays = 0L;

        try	{ // String Type을 Date Type으로 캐스팅하면서 생기는 예외로 인해 여기서 예외처리 해주지 않으면 컴파일러에서 에러가 발생해서 컴파일을 할 수 없다.
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            // date1, date2 두 날짜를 parse()를 통해 Date형으로 변환.
            Date FirstDate = format.parse(date1);
            Date SecondDate = format.parse(date2);

            // Date로 변환된 두 날짜를 계산한 뒤 그 리턴값으로 long type 변수를 초기화 하고 있다.
            // 연산결과 -950400000. long type 으로 return 된다.
            long calDate = FirstDate.getTime() - SecondDate.getTime();

            // Date.getTime() 은 해당날짜를 기준으로1970년 00:00:00 부터 몇 초가 흘렀는지를 반환해준다.
            // 이제 24*60*60*1000(각 시간값에 따른 차이점) 을 나눠주면 일수가 나온다.
            calDateDays = calDate / (24*60*60*1000);
            //calDateDays = Math.abs(calDateDays);
        } catch(ParseException e) {
            //logger.debug(e.getMessage());
        } catch (Exception e) {
            //logger.debug(e.getMessage());
        }

        return calDateDays;
    }

    // 당해년도 포함 5년치 년도 반환
    public static List<String> getYearList() {
        List<String> yearList = new ArrayList<String>();

        int curYear = Integer.parseInt(getYear());

        yearList.add(String.valueOf(curYear));
        yearList.add(String.valueOf(curYear + 1));
        yearList.add(String.valueOf(curYear + 2));
        yearList.add(String.valueOf(curYear + 3));
        yearList.add(String.valueOf(curYear + 4));

        return yearList;
    }

    // 해당 월의 모든 날짜 반환
    public static List<String> getDayList(int year, int month) {
        List<String> dayList = new ArrayList<String>();

        int curYear = Integer.parseInt(getYear());

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.set(year, month-1, 1);

        int last_day = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        for (int i=1; i <= last_day; i++ ) {
            String day = "";
            String mon = "";
            if(i < 10) {
                day = "0" + i;
            } else {
                day = String.valueOf(i);
            }

            if( month < 10) {
                mon = "0" + month;
            } else {
                mon = String.valueOf(month);
            }
            dayList.add(year + "-" + mon + "-" + day);

        }
        return dayList;
    }

    public static List<String> getHourList() {
        List<String> hourList = new ArrayList<String>();
        int strHour = 0;

        while(23 >= strHour) {
            if(strHour < 10)
                hourList.add("0" + String.valueOf(strHour));
            else
                hourList.add(String.valueOf(strHour));
            strHour++;
        }

        return hourList;
    }

    public static List<String> getMinList() {
        List<String> minList = new ArrayList<String>();
        int strMin = 0;

        while(59 >= strMin) {
            if(strMin < 10)
                minList.add("0" + String.valueOf(strMin));
            else
                minList.add(String.valueOf(strMin));
            strMin++;
        }

        return minList;
    }

    // 당해년도
    public static String getYear()
    {
        Calendar cal = Calendar.getInstance(Locale.getDefault());
        String yyyy = Integer.toString(cal.get(Calendar.YEAR));
        return yyyy;
    }

    // 당 월
    public static String getMonth()
    {
        Calendar cal = Calendar.getInstance(Locale.getDefault());
        String mm = Integer.toString(cal.get(Calendar.MONTH) + 1);
        return mm;
    }

    // 만나이 계산
    public static String getRealAge(String birth) {
        int toYear = Integer.parseInt(StringUtil.substring(getDate(), 0, 4));
        int toMonth = Integer.parseInt(StringUtil.substring(getDate(), 5, 6));
        int toDay = Integer.parseInt(StringUtil.substring(getDate(), 6, 8));
        int birthYear = Integer.parseInt(StringUtil.substring(birth, 0, 4));
        int birthMonth = Integer.parseInt(StringUtil.substring(birth, 5, 6));
        int birthDay = Integer.parseInt(StringUtil.substring(birth, 6, 8));

        int age = toYear - birthYear; //만나이

        //생일체크해서 한살을 더 뺄지 그냥 놔둘지 결정
        if (birthMonth == toMonth) { //
            if (birthDay > toDay) { //생일이 안지났다면 한살 빼기
                age = age - 1;

            }
        } else if (birthMonth > toMonth) //달이 안됐으면 생일도 안지남
        {
            age = age - 1;
        }

        return Integer.toString(age);
    }

    public static String dateEngToDigit(String date) {
        String digit = "";

        SimpleDateFormat original_format = new SimpleDateFormat("MMM.-d-yyyy", new Locale("en", "US"));
        SimpleDateFormat new_format = new SimpleDateFormat("yyyyMMdd");

        try {
            // 문자열 타입을 날짜 타입으로 변환한다.
            Date original_date = original_format.parse(date);
            // 날짜 형식을 원하는 타입으로 변경한다.
            digit = new_format.format(original_date);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return digit;
    }

    public static String dateDigitToEng(String date) {
        String digit = "";

        SimpleDateFormat original_format = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat new_format = new SimpleDateFormat("MMM. d, yyyy", new Locale("en", "US"));

        try {
            // 문자열 타입을 날짜 타입으로 변환한다.
            Date original_date = original_format.parse(date);
            // 날짜 형식을 원하는 타입으로 변경한다.
            digit = new_format.format(original_date);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return digit;
    }

    public static String dateDigitToEng(String date, String format) {
        String digit = "";

        SimpleDateFormat original_format = new SimpleDateFormat(format);
        SimpleDateFormat new_format = new SimpleDateFormat("MMM. d, yyyy", new Locale("en", "US"));

        try {
            // 문자열 타입을 날짜 타입으로 변환한다.
            Date original_date = original_format.parse(date);
            // 날짜 형식을 원하는 타입으로 변경한다.
            digit = new_format.format(original_date);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return digit;
    }

    public static String dateDigitToEngTime(String date, String format) {
        String digit = "";

        SimpleDateFormat original_format = new SimpleDateFormat(format);
        SimpleDateFormat new_format = new SimpleDateFormat("MMM. d, yyyy h:mm (a)", new Locale("en", "US"));

        try {
            // 문자열 타입을 날짜 타입으로 변환한다.
            Date original_date = original_format.parse(date);
            // 날짜 형식을 원하는 타입으로 변경한다.
            digit = new_format.format(original_date);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return digit;
    }

    // 년도 리스트
    public static List<String> getArrayYear(String min_year) {

        List<String> rtn = new ArrayList<String>();

        Calendar cal = Calendar.getInstance();
        String yyyy = Integer.toString(cal.get(Calendar.YEAR));

        for(int i = Integer.parseInt(min_year); i <= Integer.parseInt(yyyy); i++) {
            rtn.add(String.valueOf(i));
        }

        return rtn;
    }

    // 월 리스트
    public static List<String> getArrayMonth(String select_year) {
        List<String> rtn = new ArrayList<String>();
        for(int i = 1; i <= 12; i++) {
            rtn.add(String.format("%02d", i));
        }
        return rtn;
    }

    // 두날짜 사이의 날짜 리스트 반환
    public static List<String> getTwoDate(String start, String end) {
        final String DATE_PATTERN = "yyyy-MM-dd";
        List<String> dates = new ArrayList<String>();
        try {
            SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
            Date startDate = sdf.parse(start);
            Date endDate = sdf.parse(end);
            Date currentDate = startDate;
            while (currentDate.compareTo(endDate) <= 0) {
                dates.add(sdf.format(currentDate));
                Calendar c = Calendar.getInstance();
                c.setTime(currentDate);
                c.add(Calendar.DAY_OF_MONTH, 1);
                currentDate = c.getTime();
            }
        } catch (ParseException e) {

        } catch (Exception e) {

        }

        return dates;
    }

    // 두날짜 사이의 해당 요일의 날짜 리스트 반환
    public static List<String> getTwoDate(String start, String end, String dt_week, String dt_type) {
        // dt_week 정보
        // 교육기간요일(1:월,2:화,3:수,4:목,5:금,6:토,7:일)
        // dt_type 정보
        // 교육기간분류(W:매주,T:격주,Z:기타)
        final String DATE_PATTERN = "yyyy-MM-dd";
        List<String> dates = new ArrayList<String>();
        try {
            SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
            Date startDate = sdf.parse(start);
            Date endDate = sdf.parse(end);
            Date currentDate = startDate;
            int start_week = getWeekNumForYear(currentDate);
            while (currentDate.compareTo(endDate) <= 0) {
                if("T".equals(dt_type)) {
                    // 격주처리
                    // 시작 일자의 일년중 주차를 구한다.
                    int cur_week = getWeekNumForYear(currentDate);
                    if((cur_week - start_week) % 2 == 0) {
                        if (!"".equals(dt_week)) {
                            if (dt_week.indexOf(String.valueOf(getWeek(currentDate))) >= 0) {
                                dates.add(sdf.format(currentDate));
                            }
                            Calendar c = Calendar.getInstance();
                            c.setTime(currentDate);
                            c.add(Calendar.DAY_OF_MONTH, 1);
                            currentDate = c.getTime();
                        } else {
                            dates.add(sdf.format(currentDate));
                            Calendar c = Calendar.getInstance();
                            c.setTime(currentDate);
                            c.add(Calendar.DAY_OF_MONTH, 1);
                            currentDate = c.getTime();
                        }
                    } else {
                        Calendar c = Calendar.getInstance();
                        c.setTime(currentDate);
                        c.add(Calendar.DAY_OF_MONTH, 1);
                        currentDate = c.getTime();
                    }
                } else {
                    if(!"".equals(dt_week)) {
                        if(dt_week.indexOf(String.valueOf(getWeek(currentDate))) >= 0) {
                            dates.add(sdf.format(currentDate));
                        }
                        Calendar c = Calendar.getInstance();
                        c.setTime(currentDate);
                        c.add(Calendar.DAY_OF_MONTH, 1);
                        currentDate = c.getTime();
                    } else {
                        dates.add(sdf.format(currentDate));
                        Calendar c = Calendar.getInstance();
                        c.setTime(currentDate);
                        c.add(Calendar.DAY_OF_MONTH, 1);
                        currentDate = c.getTime();
                    }
                }
            }
        } catch (ParseException e) {

        } catch (Exception e) {

        }

        return dates;
    }

    // 특정날짜의 주차 구하기
    public static int getWeekNumForYear(Date date) {
        int week = 0;
        Calendar cal = Calendar.getInstance() ;
        cal.setTime(date);

        week = cal.get(Calendar.WEEK_OF_MONTH);

        return week;
    }

    // 특정 날짜의 요일
    public static int getWeek(Date date) throws Exception {
        // 교육기간요일(1:월,2:화,3:수,4:목,5:금,6:토,7:일)
        int rtn = 0;
        Calendar cal = Calendar.getInstance() ;
        cal.setTime(date);
        int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
        switch(dayNum){
            case 1:
                rtn = 7; /* 일 */
                break ;
            case 2:
                rtn = 1;  /* 월 */
                break ;
            case 3:
                rtn = 2;  /* 화 */
                break ;
            case 4:
                rtn = 3;  /* 수 */
                break ;
            case 5:
                rtn = 4;  /* 목 */
                break ;
            case 6:
                rtn = 5;  /* 금 */
                break ;
            case 7:
                rtn = 6;  /* 토 */
                break ;
        }
        return rtn ;
    }


    // 특정 날짜의 요일
    public static String getDateDay(String date, String dateType) throws Exception {
        String day = "" ;
        SimpleDateFormat dateFormat = new SimpleDateFormat(dateType) ;
        Date nDate = dateFormat.parse(date) ;
        Calendar cal = Calendar.getInstance() ;
        cal.setTime(nDate);
        int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
        switch(dayNum){
            case 1:
                day = "일";
                break ;
            case 2:
                day = "월";
                break ;
            case 3:
                day = "화";
                break ;
            case 4:
                day = "수";
                break ;
            case 5:
                day = "목";
                break ;
            case 6:
                day = "금";
                break ;
            case 7:
                day = "토";
                break ;
        }
        return day ;
    }

    // 날짜 형태를 변경 YYYYMMDD -> YYYY-MM-DD
    public static String dateFormat(String dateStr) {
        String fmt = "";

        String year = dateStr.substring(0, 4);
        String month = dateStr.substring(4, 6);
        String day = dateStr.substring(6, 8);

        fmt = year + "-" + month + "-" + day;
        return fmt;
    }

    public static String dateFormatEx(String dateStr) {
        String fmt = "";

        String year = dateStr.substring(0, 4);
        String month = dateStr.substring(4, 6);
        String day = dateStr.substring(6, 8);

        fmt = year + ". " + month + ". " + day;
        return fmt;
    }

    // 날짜 형태를 변경 YYYYMMDD -> YYYY-MM-DD
    public static String dateFormatHangul(String dateStr) {
        String fmt = "";

        String year = dateStr.substring(0, 4);
        String month = dateStr.substring(4, 6);
        String day = dateStr.substring(6, 8);

        fmt = year + "년 " + month + "월 " + day + "일";
        return fmt;
    }
    // 날짜 형태를 변경 YYYY-MM-DD ->
    public static String dateFormatHangulEx(String dateStr) {
        String fmt = "";

        String year = dateStr.substring(0, 4);
        String month = dateStr.substring(5, 7);
        String day = dateStr.substring(8, 10);

        fmt = year + "년 " + month + "월 " + day + "일";
        return fmt;
    }

    public static String dateFormatEx2(String dateStr) {
        String fmt = "";

        String year = dateStr.substring(0, 4);
        String month = dateStr.substring(5, 7);
        String day = dateStr.substring(8, 10);

        fmt = year + ". " + month + ". " + day;
        return fmt;
    }
}
