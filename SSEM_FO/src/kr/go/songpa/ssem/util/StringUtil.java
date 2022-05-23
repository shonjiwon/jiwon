package kr.go.songpa.ssem.util;

/**
 * Program Name : kr.go.songpa.ssem.util
 * Author : shlee
 * Date : 2020-10-29
 * Description :
 * History :
 * Version :
 */
public class StringUtil {
    public static String getOneLine(String cont) {
        String rtn = cont;

        rtn = rtn.trim();
        // 첫 <p> 태그 파싱
        int startpos = rtn.indexOf("<p>");
        int endpos = rtn.indexOf("</p>");

        rtn = rtn.substring(startpos, endpos);
        return rtn;
    }

    public static String deleteLastStr(String str, char token) {
        if (str.length() > 0 && str.charAt(str.length()-1)==token) {
            str = str.substring(0, str.length()-1);
        }
        return str;
    }

    public static String getPostCode(String addr) {
        String rtn = "";

        int nStart = addr.indexOf('(');
        if(nStart < 0) return rtn;
        int nEnd = addr.indexOf(')', nStart);
        if(nEnd < 0) return rtn;

        rtn = addr.substring(nStart + 1, nEnd);

        return rtn;
    }

    public static String getAddr(String addr, String postcode) {
        String rtn = addr;
        String removeStr = "(" + postcode + ")";

        rtn = rtn.replace(removeStr, "");

        return rtn.trim();
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
}
