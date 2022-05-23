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
                calendar.add(Calendar.YEAR, op);
            }else if(type.equals("mon")){
                calendar.add(Calendar.MONTH, op);
            }else if(type.equals("day")){
                calendar.add(Calendar.DATE, op);
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

        StringBuffer sbDate = new StringBuffer ( );
        sbDate.append ( nYear ); sbDate.append ( div );

        if ( nMonth < 10 ) sbDate.append ( "0" );
        sbDate.append ( nMonth );

        return sbDate.toString();
    }

    // 월을 뺀 전체 날짜를 가져온다.
    public static String getMonthMinusFullDate(String div, int minus) {
        Calendar temp=Calendar.getInstance ( );
        temp.add ( Calendar.MONTH, minus );

        int nYear = temp.get ( Calendar.YEAR );
        int nMonth = temp.get ( Calendar.MONTH ) + 1;
        int nDay = temp.get ( Calendar.DAY_OF_MONTH );

        StringBuffer sbDate = new StringBuffer ( );
        sbDate.append ( nYear ); sbDate.append ( div );

        if ( nMonth < 10 ) sbDate.append ( "0" );
        sbDate.append ( nMonth ); sbDate.append ( div );

        if ( nDay < 10 ) sbDate.append ( "0" );
        sbDate.append ( nDay );

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

    public static String getTimeEx()
    {
        Calendar cal = Calendar.getInstance(Locale.getDefault());
        StringBuffer buf = new StringBuffer();
        String hour = Integer.toString(cal.get(11));
        if (hour.length() == 1)
            hour = "0" + hour;
        String min = Integer.toString(cal.get(12));
        if (min.length() == 1)
            min = ":0" + min;
        String sec = Integer.toString(cal.get(13));
        if (sec.length() == 1)
            sec = ":0" + sec;
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
    public static String getDateTimeEx()
    {
        return getDate(3) + getTimeEx();
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
            long first = FirstDate.getTime();
            long second = SecondDate.getTime();

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

    // 현재월
    public static String getMonth()
    {
        Calendar cal = Calendar.getInstance(Locale.getDefault());
        StringBuffer buf = new StringBuffer();
        String month = Integer.toString(cal.get(2) + 1);
        if (month.length() == 1) month = month;

        buf.append(month);
        return buf.toString();
    }

    public static long getRemainDay(String end_dt) {
        long calDateDays = 0;
        try{ // String Type을 Date Type으로 캐스팅하면서 생기는 예외로 인해 여기서 예외처리 해주지 않으면 컴파일러에서 에러가 발생해서 컴파일을 할 수 없다.
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            // date1, date2 두 날짜를 parse()를 통해 Date형으로 변환.
            Date today = new Date();
            Date SecondDate = format.parse(end_dt.substring(0, 10));

            // Date로 변환된 두 날짜를 계산한 뒤 그 리턴값으로 long type 변수를 초기화 하고 있다.
            // 연산결과 -950400000. long type 으로 return 된다.
            long calDate = SecondDate.getTime() - today.getTime();

            if(calDate < 0) return -1;
            // Date.getTime() 은 해당날짜를 기준으로1970년 00:00:00 부터 몇 초가 흘렀는지를 반환해준다.
            // 이제 24*60*60*1000(각 시간값에 따른 차이점) 을 나눠주면 일수가 나온다.
            calDateDays = calDate / ( 24*60*60*1000);

            calDateDays = Math.abs(calDateDays);
            calDateDays++;
        }
        catch(ParseException e)
        {
            // 예외 처리
        }

        return calDateDays;
    }

    // 입력날짜 기준의 월요일
    public static String getMonDay(String date)
    {
        String reDate = "";
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date today = format.parse(date);

            Calendar cal = Calendar.getInstance();
            cal.setTime(today);
            cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

            String yyyy = Integer.toString(cal.get(Calendar.YEAR));
            String mm = Integer.toString(cal.get(Calendar.MONTH) + 1);
            String dd = Integer.toString(cal.get(Calendar.DATE));

            if (mm.length() == 1)
                mm = "0" + mm;
            if (dd.length() == 1)
                dd = "0" + dd;

            reDate = yyyy + "-" + mm + "-" + dd;

        }
        catch(ParseException e)
        {
            // 예외 처리
        }

        return reDate;
    }

    // 입력날짜 기준의 일요일
    public static String getSunDay(String date)
    {
        String reDate = "";
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date today = format.parse(date);

            Calendar cal = Calendar.getInstance();
            cal.setTime(today);
            cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);

            cal.add(Calendar.DATE, 7);

            String yyyy = Integer.toString(cal.get(Calendar.YEAR));
            String mm = Integer.toString(cal.get(Calendar.MONTH) + 1);
            String dd = Integer.toString(cal.get(Calendar.DATE));

            if (mm.length() == 1)
                mm = "0" + mm;
            if (dd.length() == 1)
                dd = "0" + dd;

            reDate = yyyy + "-" + mm + "-" + dd;

        }
        catch(ParseException e)
        {
            // 예외 처리
        }

        return reDate;
    }

    // 만 나이 계산
    // birth 형식 : YYYY-MM-DD
    public static int getRealAge(String birth)
    {
        int toYear = Integer.parseInt(StringUtil.substring(getDate(3), 0, 4));
        int toMonth = Integer.parseInt(StringUtil.substring(getDate(3), 5, 7));
        int toDay = Integer.parseInt(StringUtil.substring(getDate(3), 8, 10));
        int birthYear = Integer.parseInt(StringUtil.substring(birth, 0, 4));
        int birthMonth = Integer.parseInt(StringUtil.substring(birth, 5, 7));
        int birthDay = Integer.parseInt(StringUtil.substring(birth, 8, 10));

        int age = toYear - birthYear; //만나이

        //생일체크해서 한살을 더 뺄지 그냥 놔둘지 결정
        if(birthMonth == toMonth){ //
            if(birthDay > toDay){ //생일이 안지났다면 한살 빼기
                age = age - 1;

            }
        }else if(birthMonth > toMonth) //달이 안됐으면 생일도 안지남
        {
            age = age - 1;
        }

        return age;
    }
}
