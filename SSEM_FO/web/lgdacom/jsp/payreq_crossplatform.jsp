<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.util.*" %>
<%@ page import="lgdacom.XPayClient.XPayClient"%>

<%
	request.setCharacterEncoding("utf-8");
    /*
     * [���� ������û ������(STEP2-1)]
     *
     * ���������������� �⺻ �Ķ���͸� ���õǾ� ������, ������ �ʿ��Ͻ� �Ķ���ʹ� �����޴����� �����Ͻþ� �߰� �Ͻñ� �ٶ��ϴ�.
     */

     /* �� �߿�
 	* ȯ�漳�� ������ ��� �ݵ�� �ܺο��� ������ ������ ��ο� �νø� �ȵ˴ϴ�.
 	* �ش� ȯ�������� �ܺο� ������ �Ǵ� ��� ��ŷ�� ������ �����ϹǷ� �ݵ�� �ܺο��� ������ �Ұ����� ��ο� �νñ� �ٶ��ϴ�.
 	* ��) [Window �迭] C:\inetpub\wwwroot\lgdacom ==> ����Ұ�(�� ���丮)
 	*/
 	String configPath = "F:/lgdacom";  //�佺���̸������� ������ ȯ������("/conf/lgdacom.conf,/conf/mall.conf") ��ġ ����.

    /*
     * 1. �⺻���� ������û ���� ����
     *
     * �⺻������ �����Ͽ� �ֽñ� �ٶ��ϴ�.(�Ķ���� ���޽� POST�� ����ϼ���)
     */

    // ���� ��� ���Ľ�
    String CST_PLATFORM         = request.getParameter("CST_PLATFORM");                 //�佺���̸��� �������� ����(test:�׽�Ʈ, service:����)
    String CST_MID              = request.getParameter("CST_MID");                      //�佺���̸����� ���� �߱޹����� �������̵� �Է��ϼ���.
    String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //�׽�Ʈ ���̵�� 't'�� �����ϰ� �Է��ϼ���.
    //�������̵�(�ڵ�����)
    String LGD_OID              = request.getParameter("LGD_OID");                      //�ֹ���ȣ(�������� ����ũ�� �ֹ���ȣ�� �Է��ϼ���)
    String LGD_AMOUNT           = request.getParameter("LGD_AMOUNT");                   //�����ݾ�("," �� ������ �����ݾ��� �Է��ϼ���)
    String LGD_BUYER            = request.getParameter("LGD_BUYER");                    //�����ڸ�
    String LGD_PRODUCTINFO      = request.getParameter("LGD_PRODUCTINFO");              //��ǰ��
    String LGD_BUYEREMAIL       = request.getParameter("LGD_BUYEREMAIL");               //������ �̸���
    String LGD_TIMESTAMP        = request.getParameter("LGD_TIMESTAMP");                //Ÿ�ӽ�����
    String LGD_CUSTOM_USABLEPAY = request.getParameter("LGD_CUSTOM_USABLEPAY");        	//�������� �ʱ��������
    String LGD_CUSTOM_SKIN      = "red";                                                //�������� ����â ��Ų(red)
    String LGD_CUSTOM_PROCESSTYPE = "TWOTR";

    String LGD_CUSTOM_SWITCHINGTYPE = request.getParameter("LGD_CUSTOM_SWITCHINGTYPE"); //�ſ�ī�� ī��� ���� ������ ���� ��� (�����Ұ�)
    String LGD_WINDOW_VER		= "2.5";												//����â ��������
    String LGD_WINDOW_TYPE      = request.getParameter("LGD_WINDOW_TYPE");              //����â ȣ�� ��� (�����Ұ�)

    String LGD_OSTYPE_CHECK     = "P";                                                  //�� P: XPay ����(PC ���� ���): PC��� ����Ͽ� ����� �Ķ���� �� ���μ����� �ٸ��Ƿ� PC���� PC ������������ ���� �ʿ�.
    //"P", "M" ���� ����(Null, "" ����)�� ����� �Ǵ� PC ���θ� üũ���� ����
    //String LGD_ACTIVEXYN		= "N";													//������ü ������ ���, ActiveX ��� ���η� "N" �̿��� ��: ActiveX ȯ�濡�� ������ü ���� ����(IE)

    /*
     * �������(������) ���� ������ �Ͻô� ��� �Ʒ� LGD_CASNOTEURL �� �����Ͽ� �ֽñ� �ٶ��ϴ�.
     */
    //String LGD_CASNOTEURL		= "https://����URL/cas_noteurl.jsp";
    String LGD_CASNOTEURL		= "http://127.0.0.1:8081/ssem/lgdacom/jsp/cas_noteurl.jsp";

    /*
     * LGD_RETURNURL �� �����Ͽ� �ֽñ� �ٶ��ϴ�. �ݵ�� ���� �������� ������ ����Ʈ�� ��  ȣ��Ʈ�̾�� �մϴ�. �Ʒ� �κ��� �ݵ�� �����Ͻʽÿ�.
     */
    //String LGD_RETURNURL		= "https://����URL/returnurl.jsp";
    String LGD_RETURNURL		= "http://127.0.0.1:8081/ssem/lgdacom/jsp/returnurl.jsp";


    /*
     *************************************************
     * 2. MD5 �ؽ���ȣȭ (�������� ������) - BEGIN
     *
     * MD5 �ؽ���ȣȭ�� �ŷ� �������� �������� ����Դϴ�.
     *************************************************
     *
     * �ؽ� ��ȣȭ ����( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP )
     * LGD_MID          : �������̵�
     * LGD_OID          : �ֹ���ȣ
     * LGD_AMOUNT       : �ݾ�
     * LGD_TIMESTAMP    : Ÿ�ӽ�����
     *
     * MD5 �ؽ������� ��ȣȭ ������ ����
     * �佺���̸������� �߱��� ����Ű(MertKey)�� ȯ�漳�� ����(lgdacom/conf/mall.conf)�� �ݵ�� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.
     */
     String LGD_HASHDATA = "";
     XPayClient xpay = null;
     try {

    	 xpay = new XPayClient();
    	 xpay.Init(configPath, CST_PLATFORM);

    	 if(LGD_TIMESTAMP == null || "".equals(LGD_TIMESTAMP)) {
    		 LGD_TIMESTAMP = xpay.GetTimeStamp();
    	 }
    	 LGD_HASHDATA = xpay.GetHashData(LGD_MID, LGD_OID, LGD_AMOUNT, LGD_TIMESTAMP);

     } catch(Exception e) {
    	 e.printStackTrace();
    	out.println("�佺���̸��� ���� API�� ����� �� �����ϴ�. ȯ������ ������ Ȯ���� �ֽñ� �ٶ��ϴ�. ");
 		out.println(""+e.getMessage());
 		return;
     } finally {
    	 xpay = null;
     }
    /*
     *************************************************
     * 2. MD5 �ؽ���ȣȭ (�������� ������) - END
     *************************************************
     */


  	 Map<String, Object> payReqMap = new HashMap<String, Object>();

     payReqMap.put("CST_PLATFORM"                , CST_PLATFORM);                   	// �׽�Ʈ, ���� ����
     payReqMap.put("CST_MID"                     , CST_MID );                        	// �������̵�
     payReqMap.put("LGD_WINDOW_TYPE"             , LGD_WINDOW_TYPE );                   // ����âȣ�� ���(�����Ұ�)
     payReqMap.put("LGD_MID"                     , LGD_MID );                        	// �������̵�
     payReqMap.put("LGD_OID"                     , LGD_OID );                        	// �ֹ���ȣ
     payReqMap.put("LGD_BUYER"                   , LGD_BUYER );                      	// ������
     payReqMap.put("LGD_PRODUCTINFO"             , LGD_PRODUCTINFO );                	// ��ǰ����
     payReqMap.put("LGD_AMOUNT"                  , LGD_AMOUNT );                     	// �����ݾ�
     payReqMap.put("LGD_BUYEREMAIL"              , LGD_BUYEREMAIL );                 	// ������ �̸���
     payReqMap.put("LGD_CUSTOM_SKIN"             , LGD_CUSTOM_SKIN );                	// ����â SKIN
     payReqMap.put("LGD_CUSTOM_PROCESSTYPE"      , LGD_CUSTOM_PROCESSTYPE );         	// Ʈ����� ó�����
     payReqMap.put("LGD_TIMESTAMP"               , LGD_TIMESTAMP );                  	// Ÿ�ӽ�����
     payReqMap.put("LGD_HASHDATA"                , LGD_HASHDATA );      	           	// MD5 �ؽ���ȣ��
     payReqMap.put("LGD_RETURNURL"   			, LGD_RETURNURL );      			   	// �������������
     payReqMap.put("LGD_CUSTOM_USABLEPAY"  		, LGD_CUSTOM_USABLEPAY );				// ����Ʈ �������� (�ش� �ʵ带 ������ ������ �������� ���� UI �� ���̰� �˴ϴ�.)
     payReqMap.put("LGD_CUSTOM_SWITCHINGTYPE"  	, LGD_CUSTOM_SWITCHINGTYPE );			// �ſ�ī�� ī��� ���� ������ ���� ���
     payReqMap.put("LGD_WINDOW_VER"  			, LGD_WINDOW_VER );						// ����â ��������
     payReqMap.put("LGD_OSTYPE_CHECK"           , LGD_OSTYPE_CHECK);                    // �� P: XPay ����(PC�� ���� ���), PC, ����� ���� ���������� ��������
	 //payReqMap.put("LGD_ACTIVEXYN"			, LGD_ACTIVEXYN);						// ������ü ������ ���, ActiveX ��� ����
	 payReqMap.put("LGD_VERSION"         		, "JSP_Non-ActiveX_Standard");			// ���Ÿ�� ����(���� �� ���� ����): �� ������ �ٰŷ� � ���񽺸� ����ϴ��� �Ǵ��� �� �ֽ��ϴ�.
	 payReqMap.put("LGD_DOMAIN_URL"           , "xpayvvip");							// TLS1.2 �������� ������

     // �������(������) ���������� �Ͻô� ���  �Ҵ�/�Ա� ����� �뺸�ޱ� ���� �ݵ�� LGD_CASNOTEURL ������ �佺���̸����� �����ؾ� �մϴ� .
     payReqMap.put("LGD_CASNOTEURL"          , LGD_CASNOTEURL );               // ������� NOTEURL



    /*Return URL���� ���� ��� ���� �� ���õ� �Ķ���� �Դϴ�.*/
	 payReqMap.put("LGD_RESPCODE"  		 , "" );
	 payReqMap.put("LGD_RESPMSG"  		 , "" );
	 payReqMap.put("LGD_PAYKEY"  		 , "" );

	 session.setAttribute("PAYREQ_MAP", payReqMap);

 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�����佺���̸��� ���ڰἭ�� �����׽�Ʈ</title>
<!-- test�� ��� -->
<script language="javascript" src="https://pretest.tosspayments.com:9443/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<!--
  service�� ��� �Ʒ� URL�� ���
<script language="javascript" src="https://xpayvvip.tosspayments.com/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
 -->
<script type="text/javascript">
/*
* �����Ұ�.
*/
    var LGD_window_type = '<%=LGD_WINDOW_TYPE%>';
/*
* �����Ұ�
*/
function launchCrossPlatform(){
	lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type, null, "", "");
}
/*
* FORM ��  ���� ����
*/
function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}

/*
 * ������� ó��
 */
function payment_return() {
	var fDoc;
    fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
	if (fDoc.document.getElementById('LGD_RESPCODE').value === "0000") {

			/*document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
			document.getElementById("LGD_PAYINFO").target = "_self";
			document.getElementById("LGD_PAYINFO").action = "payres.jsp";
			document.getElementById("LGD_PAYINFO").submit();*/

			location.href="/ssem/youth/program/lecture_pay_ok.do";
	} else {
		alert("LGD_RESPCODE (����ڵ�) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (����޽���): " + fDoc.document.getElementById('LGD_RESPMSG').value);
		closeIframe();
	}
}
</script>
</head>
<body>
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="payres.jsp">
<table>
    <tr>
        <td>������ �̸� </td>
        <td><%= LGD_BUYER %></td>
    </tr>
    <tr>
        <td>��ǰ���� </td>
        <td><%= LGD_PRODUCTINFO %></td>
    </tr>
    <tr>
        <td>�����ݾ� </td>
        <td><%= LGD_AMOUNT %></td>
    </tr>
    <%--<tr>
        <td>������ �̸��� </td>
        <td><%= LGD_BUYEREMAIL %></td>
    </tr>--%>
    <tr>
        <td>�ֹ���ȣ </td>
        <td><%= LGD_OID %></td>
    </tr>
    <tr>
        <td colspan="2">* �߰� �� ������û �Ķ���ʹ� �޴����� �����Ͻñ� �ٶ��ϴ�.</td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>
    <tr>
        <td colspan="2">
		<input type="button" value="������û" onclick="launchCrossPlatform();"/>
        </td>
    </tr>
</table>
<%
	for(Iterator<?> i = payReqMap.keySet().iterator(); i.hasNext();){
		Object key = i.next();
		out.println("<input type='hidden' name='" + key + "' id='"+key+"' value='" + payReqMap.get(key) + "'>" );
	}
%>
</form>

</body>

</html>
