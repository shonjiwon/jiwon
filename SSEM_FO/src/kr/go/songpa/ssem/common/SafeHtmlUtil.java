package kr.go.songpa.ssem.common;

import java.text.Normalizer;
import java.util.regex.Pattern;

/**
 * Program Name : kr.go.songpa.ssem.common
 * Author : shlee
 * Date : 2020-10-25
 * Description :
 * History :
 * Version :
 */
public class SafeHtmlUtil {
    public static final Pattern scriptPattern = Pattern.compile("<script([^'\"]|\"[^\"]*\"|'[^']*')*?</script>",Pattern.DOTALL);
    /**
     * Sanitize user inputs.
     *
     * @param raw the input string to be sanitized
     * @return the sanitized string
     */
    public static String sanitize(String raw) {
        String result = "";
        if(raw == null || raw.length() == 0){
            result = raw;
        }else{
            if(raw.length() > 100) {
                raw = raw.substring(0, 100);
            }
            result = HTMLEntityEncode(raw);
        }
        return  result;
    }

    /**
     * Encode HTML entities.
     *
     * @param input the input string to be encoded
     * @return the encoded string
     */
    public static String HTMLEntityEncode(String input) {
        //String next =
        /**
         StringBuffer sb = new StringBuffer();
         for (int i = 0; i < next.length(); ++i) {
         char ch = next.charAt(i);

         if (ch == '<') {
         sb.append("&lt;");
         } else if (ch == '>') {
         sb.append("&gt;");
         } else {
         sb.append(ch);
         }
         }
         **/

        return scriptPattern.matcher(input).replaceAll("&#x73;script");
    }

    /**
     * Simplify input to its simplest form to make encoding tricks more difficult.
     *
     * @param input the input string to be canonicalized
     * @return the normalized string
     */
    public static String canonicalize(String input) {
        return Normalizer.normalize(input, Normalizer.Form.NFD);
    }
}
