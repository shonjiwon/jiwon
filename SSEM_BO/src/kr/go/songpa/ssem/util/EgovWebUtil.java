package kr.go.songpa.ssem.util;

import java.util.regex.Pattern;

/**
 * Program Name : kr.go.songpa.ssem.util
 * Author : shlee
 * Date : 2020-09-15
 * Description :
 * History :
 * Version :
 */
public class EgovWebUtil {
    public static String clearXSSMinimum(String value) {
        String returnValue = "";
        if (value == null || value.trim().equals("")) {
            returnValue = "";
        } else {

            returnValue = value;

            returnValue = returnValue.replaceAll("&", "&amp;");
            returnValue = returnValue.replaceAll("<", "&lt;");
            returnValue = returnValue.replaceAll(">", "&gt;");
            returnValue = returnValue.replaceAll("\"", "&#34;");
            returnValue = returnValue.replaceAll("\'", "&#39;");
        }
        return returnValue;
    }

    public static String clearXSSMaximum(String value) {
        String returnValue = value;
        returnValue = clearXSSMinimum(returnValue);

        returnValue = returnValue.replaceAll("%00", null);

        returnValue = returnValue.replaceAll("%", "&#37;");

        // \\. => .

        returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
        returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\
        returnValue = returnValue.replaceAll("\\./", ""); // ./
        returnValue = returnValue.replaceAll("%2F", "");

        return returnValue;
    }

    public static String filePathBlackList(String value) {
        String returnValue = value;
        if (returnValue == null || returnValue.trim().equals("")) {
            returnValue = "";
        } else {
            returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
            returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\
        }
        return returnValue;
    }

    /**
     * 행안부 보안취약점 점검 조치 방안.
     *
     * @param value
     * @return
     */
    public static String filePathReplaceAll(String value) {
        String returnValue = value;
        if (returnValue == null || returnValue.trim().equals("")) {
            returnValue = "";
        } else {
            returnValue = returnValue.replaceAll("/", "");
            /*returnValue = returnValue.replaceAll("\\", "");*/
            returnValue = returnValue.replaceAll("\\.\\.", ""); // ..
            returnValue = returnValue.replaceAll("&", "");
        }
        return returnValue;
    }

    /**
     * 행안부 보안취약점 점검 조치 방안 - 파일명.
     *
     * @param value
     * @return
     */
    public static String fileNameReplaceAll(String value) {
        String returnValue = "";
        if (returnValue == null || returnValue.trim().equals("")) {
            returnValue = "";
        } else {
            /* "!\"#$%&(){}@`*:+;-.<>,^~|'[]"; => 제거 */
            returnValue = returnValue.replaceAll("!\"#[$]%&\\(\\)\\{\\}@`[*]:[+];-.<>,\\^~|'\\[\\]", "");
        }
        return returnValue;


    }

    public static String filePathWhiteList(String value) {
        return value; // TODO
    }

    public static boolean isIPAddress(String str) {
        Pattern ipPattern = Pattern.compile("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}");

        return ipPattern.matcher(str).matches();
    }

    /*
    public static void main(String[] args) {
	String test = null;

	test = "<script language='javascript' encoding=\"utf-8\">q&a</script>";
	System.out.println("clearXSSMinimum() Test");
	System.out.println(test);
	System.out.println("=>");
	System.out.println(clearXSSMinimum(test));
	System.out.println();

	test = "/a/b/c../..\\";
	System.out.println("clearXSSMaximum() Test");
	System.out.println(test);
	System.out.println(" =>");
	System.out.println(clearXSSMaximum(test));
	System.out.println();

	test = "/a/b/c/../../../..\\..\\";
	System.out.println("filePathBlackList() Test");
	System.out.println(test);
	System.out.println("=>");
	System.out.println(filePathBlackList(test));
	System.out.println();

	test = "192.168.0.1";
	System.out.println("isIPAddress() test");
	System.out.println("IP : " + test + " => " + isIPAddress(test));
    }
    //*/
}
