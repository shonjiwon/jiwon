package kr.go.songpa.ssem.common;

/**
 * Program Name : kr.go.songpa.ssem.common
 * Author : shlee
 * Date : 2020-09-13
 * Description :
 * History :
 * Version :
 */
public class Constants {
    /**
     * 로컬과 실서버 구분
     */
    public static final String LOCAL_YN = "N";  //Y:로컬 , N:실서버

    // 회원 레벨
    public static final int ADMIN_MASTER_LEVEL = 16;
    public static final int ADMIN_USER_LEVEL = 8;
    public static final int MEM_CONFIRM = 4;


    public static final int FORNT_LEVEL = 2;

    // 회원 레벨명
    public static final String ADMIN_MASTER_NAME = "통합관리자";
    public static final String ADMIN_USER_NAME = "관리자";


    // 세션 vo 명
    public static final String	LOGIN_VO		    = "loginVo";
    public static final String	ADMIN_LOGIN_VO		= "adminLoginVo";

    /**
     * 목록 조회 수
     */
    public static final String	SESSION_ATTRIBUTE_PAGENUMROW = "pageNumRow";

    /**
     * 디폴트 페이지당 라인 수
     */
    public static final int 	DEFAULT_LISTSIZE	= 10;

    /**
     * 디폴트 그룹당 페이지 수
     */
    public static final int 	DEFAULT_PAGESIZE	= 10;

    public static final int 	DEFAULT_PAGESIZE_USER	= 10;

    public static final String allowExtFileDoc = "doc,xls,docx,xlsx,ppt,pptx,hwp,pdf,zip,alz,egg,tar";
    public static final String allowExtFileZip = "zip,alz,egg,tar";
    public static final String allowExtFile = "jpg,jpeg,gif,png,bmp,doc,xls,docx,xlsx,ppt,pptx,hwp,pdf,zip,alz,egg,tar";
    public static final String allowExtFileAvi = "flv,mp4,avi,wmv";
    public static final String allowExtFileExcel = "xls,xlsx";
    public static final String allowExtFileImg = "jpg,gif,png,bmp,jpeg";

    public static final long maxImgFileSize = 1024 * 1024 * 3;   //업로드 최대 사이즈 설정 (3M)
    public static final long maxFileSize = 1024 * 1024 * 10;   //업로드 최대 사이즈 설정 (10M)
    public static final long maxAviFileSize = 1024 * 1024 * 10;   //동영상 최대 사이즈 설정 (10M)

    public static final String RET_URL = "return_url";

    // 기관 구분
    public static final String ORG_CD_HP = "OG01000000";	 // 병원
    public static final String ORG_CD_CEN = "OG02000000";	 // 보건소
    public static final String ORG_CD_WEL = "OG03000000";	 // 복지기관

    // 공통 코드 TOP 레벨 구분
    public static final String CODE_TYPE_OP = "REQS";		// 의견구분
    public static final String CODE_TYPE_ORG = "ORG";		// 기관구분
    public static final String CODE_TYPE_SVR = "SVRS";		// 서비스
    public static final String CODE_TYPE_SVRM = "SVRM";		// 서비스
    public static final String CODE_TYPE_EMS = "EMS";		// 이메일
    public static final String CODE_TYPE_RUN = "RUNS";		// 운영주체
    public static final String CODE_TYPE_AR = "ARS";		// 지역구
    public static final String CODE_TYPE_OTHER = "ORGM";		// 진료과목
    public static final String CODE_TYPE_OG = "ORGS";		// 보건소 기관구분
    public static final String CODE_TYPE_KDB = "ORGB";		// 시설종류

    public static final String CODE_TYPE_TG = "ORGS";		// 복지기관 대상
    public static final String CODE_TYPE_ETS = "ETS";		// 응급실 진료시간

    // 공통코드
    public static final String CODE_PCD_SVR = "SVR01000000";		// 의견구분
    public static final String CODE_PCD_OP = "REQ01000000";		// 의견구분
    public static final String CODE_PCD_EM = "EM01000000";		// 이메일
    public static final String CODE_PCD_RUN = "RUN01000000";		// 운영주체
    public static final String CODE_PCD_AR = "AR01000000";		// 지역구

    public static final String CODE_PCD_HG = "OG01010000";		// 종별

    public static final String CODE_PCD_EG = "OG01020000";		// 응급기관
    public static final String CODE_PCD_SUB = "OG01030000";		// 진료과목

    public static final String CODE_PCD_OTHER = "OG01040000";		// 기타의료자원기관

    public static final String CODE_PCD_OG = "OG02000000";		// 보건소 기관구분

    public static final String CODE_PCD_TG = "OG03000000";		// 복지기관 대상


    public static final String CODE_PCD_ETS = "ET01000000";		// 응급실진료시간

    public static final String CODE_PCD_SUB_GUBUN_1 = "1";		// 진료과목
    public static final String CODE_PCD_SUB_GUBUN_2 = "2";		// 과목별

    public static final String CODE_EM_IN = "EM01060000";  // 이메일 직접입력 코드

    public String tmpStr = "";
    public Constants(){
        tmpStr = "";
    }

    public static final String global_ext = ".do";
    public static final String login_url = "/ssemadmin/login/login.do";
}
