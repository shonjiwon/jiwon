var gMsgs = new Array();

//req : 요청
//msg : 메시지
//info : 정보
//err : 에러.

gMsgs['req.title'] = "제목은 2글자 이상으로 입력하십시오.";
gMsgs['req.content'] = "내용을 입력하십시오.";
gMsgs['req.id'] = "아이디를 입력하십시오.";
gMsgs['req.passwd'] = "패스워드를 입력하십시오.";
gMsgs['req.name'] = "{0} 명을 입력하세요.";
gMsgs['req.nameorno'] = "{0} 명 또는 {1}번호를 입력하세요.";
gMsgs['req.length.check'] = "한글은 {0}자, 영문은 {1}자 이하로 입력해 주십시오.";
gMsgs['req.length.check.exact'] = "[{0}]는(은) {1}자로 입력해 주십시오.";
gMsgs['req.required.check'] = "[{0}]을(를) 입력해 주세요.";
gMsgs['req.required.check.eng'] = "Please enter [{0}].";
gMsgs['req.number.check'] = "숫자만 입력 가능합니다.";
gMsgs['req.dateyyyymmdd.check'] = "날짜는 YYYYMMDD이나 YYYY.MM.DD의 형식으로 입력해주십시오.";
gMsgs['req.date.check'] = "[{0}]는(은) 올바른 날짜 형식이 아닙니다.";
gMsgs['req.fromTo.check'] = "날짜는 시작일보다 종료일이 커야 합니다.";
gMsgs['req.email.check'] = "잘못된 형식의 이메일 주소입니다.";
gMsgs['req.email.check.eng'] = "Invalid email format.";
gMsgs['req.numberMax.check'] = "[{0}]의 값은 [{1}] 이하이어야 합니다.";
gMsgs['req.numberMin.check'] = "[{0}]의 값은 [{1}] 이상이어야 합니다.";
gMsgs['req.numberRange.check'] = "[{0}]의 값은 [{1}]와 [{2}] 사이의 값이어야 합니다.";
gMsgs['req.length.check2'] = "{3}(은)는 최대 한글 {0}자, 영문 {1}자 이하로 입력해 주십시오.";

gMsgs['valide.data.number'] = "{0}(은)는 숫자만 입력 가능합니다.";
gMsgs['valide.agree'] = "{0}에 동의해야 합니다.";
gMsgs['valide.space'] = "{0}에 공백을 사용 할 수 없습니다.";
gMsgs['valide.id'] = "[{0}]의 값은 영문, 숫자 조합으로 입력해 주세요 <br/>(9 ~ 12 자리미만).";
gMsgs['valide.id.eng'] = "Your [{0}] must be 6 to 20 characters in length, and consist of English letters and numbers only.";
gMsgs['valide.id.chu'] = "[{0}]의 값은 영문으로만 입력해 주세요 (4 ~ 15 자리이하).";
gMsgs['valide.data.select'] = "[{0}]를 선택 하세요.";

gMsgs['valide.data.insert'] = "[{0}]를 입력 하십시오.";
gMsgs['info.lawyer.inert'] = "신청이 등록 되었습니다.";

gMsgs['req.save'] = "저장 하시겠습니까?";
gMsgs['req.delete'] = "정말로 삭제 하시겠습니까?\n삭제 시 관련 내용이 모두 삭제 됩니다.";
gMsgs['req.update'] = "수정 하시겠습니까?";
gMsgs['req.insert'] = "등록 하시겠습니까?";
gMsgs['req.subscribe'] = "구독 하시겠습니까?";
gMsgs['req.cancel.subscribe'] = "구독해지 하시겠습니까?";
gMsgs['req.cancel'] = "취소 하시겠습니까?";
gMsgs['req.cancel.request'] = "요청취하 하시겠습니까?";
gMsgs['req.send.newsletter'] = "뉴스레터를 발송 하시겠습니까?";

gMsgs['info.msg'] = "올바르지 않은 함수를 사용했습니다.";
gMsgs['info.wrong.pass'] = "비밀번호가 일치하지 않습니다.";

gMsgs['info.passwd.type'] = "Enter more than 8 digits including English and special characters";
gMsgs['info.passwd.type2'] = "연속성을 갖는 문자는 비밀번호로 사용하실 수 없습니다.\n(12345, abcde, edcba 등 연속성을 갖는 문자)";
gMsgs['info.passwd.type3'] = "동일한 문자 4자리 사용하실 수 없습니다.";
gMsgs['info.passwd.type4'] = "비밀번호에 아이디를 사용할 수 없습니다.";
gMsgs['info.passwd.missmech'] = "비밀번호가 일치 하지 않습니다.";
gMsgs['info.spc.word'] = "[{0}]는 특수문자를 입력 할 수 없습니다.";

gMsgs['err.no.attachseq'] = "첨부파일의 시퀀스번호가 없습니다.";
gMsgs['err.realname.auth'] = "실명인증 처리 에러입니다.";
gMsgs['err.insert'] = "등록하는 중 오류가 발생하였습니다.";

gMsgs['msg.delete'] = "삭제할 데이터가 없습니다.";
gMsgs['msg.attach'] = "첨부 파일이 없습니다.";
gMsgs['msg.noattach.transfer'] = "첨부 파일이 없습니다."; //이관된 첨부 파일이 없습니다.
gMsgs['file.error'] = "파일업로드 하는 도중 에러가 발생했습니다.";
gMsgs['file.no.upload'] = "등록된 파일이 없습니다.\n 파일을 등록해주세요.";
gMsgs['file.select'] = "파일을 선택하여 주십시오.";

// 포커싱을 위한 obj
let $this;

function modalMsg(msg, type, callback) {
    var modal = new tingle.modal({
        closeMethods: [],
        footer: true,
        stickyFooter: true
    });

    var html = '<h2>' + msg + '</h2>';
    modal.setContent(html);

    if(type === 'notice') {
        modal.addFooterBtn('확인', 'tingle-btn tingle-btn--default tingle-btn--pull-right', function () {
            modal.close();
        });
    } else if (type === 'focus') {
        modal.addFooterBtn('확인', 'tingle-btn tingle-btn--danger tingle-btn--pull-right', function () {
            modal.close();
            if(typeof $this.tagName === 'undefined') {

            } else {
                $this.focus();
            }
        });
    } else if (type === 'yesorno') {
        modal.addFooterBtn('확인', 'tingle-btn tingle-btn--danger tingle-btn--pull-right', function () {
            modal.close();
            if (callback !== '') {
                callback();
            }
            return true;
        });
        modal.addFooterBtn('취소', 'tingle-btn tingle-btn--default tingle-btn--pull-right', function(){
            modal.close();
            return false;
        });
    } else if (type === 'back') {
        modal.addFooterBtn('확인', 'tingle-btn tingle-btn--default tingle-btn--pull-right', function () {
            modal.close();
            history.back();
        });
    } else if (type === 'locurl') {
        modal.addFooterBtn('확인', 'tingle-btn tingle-btn--danger tingle-btn--pull-right', function () {
            modal.close();
            location.href = callback;
        });
    }
    modal.open();
}

function fnIsValidRequired(obj, validObjName) {
    if (fnIsEmpty(obj)) {
        $this = obj;
        modalMsg(fnGetMsg("req.required.check", validObjName), 'focus', '');
        return false;
    }
    return true;
}

function fnIsEmpty(obj) {
    if (obj.value == null || obj.value.replace(/ /gi, "") == "") {
        return true;
    } // end if
    return false;
}

function fnGetMsg() {
    var len = arguments.length;
    if (len < 1) {
        alert("Usage : fnGetMsg('msg.id','param1',...);");
        return "";
    }
    try {
        var msg = gMsgs[arguments[0]];

        for (var i = 1; i < arguments.length; i++) {
            msg = msg.replace("{" + (i - 1) + "}", arguments[i]);
        }
        return msg;
    } catch (e) {
        alert("js error:" + e);
    }
    return "";
}

function fnIdCheck(obj){
    // 9자리 ~ 12자리
    var vId 	 	= "";
    var vPassType   =  /^[A-Za-z0-9]{9,11}$/;
    vId				= obj.value;
    if(!vPassType.test(vId)){
        $this = obj;
        modalMsg(fnGetMsg("valide.id", "ID"), 'focus', '');
        return false;
    }
    return true;
}

function fnIsEmailAddr(obj) {
    var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
    return isValidFormat(obj, format);
}

function isValidFormat(obj, format) {
    var val = "";
    if ((typeof obj) == "string") {
        val = obj;
    } else {
        val = obj.value;
    }

    if (val.search(format) != -1) {
        return true;
    } else {
        return false;
    }
}

function fnIsValidNumPwd(obj) {
    if (!fnIsNumber(obj)) {
        $this = obj;
        modalMsg(fnGetMsg("req.number.check"), 'focus', '');
        obj.value = obj.value.substr(0, obj.value.length -1)
        return false;
    }

    if(obj.value.length > 4) {
        modalMsg("비밀번호는 4자리까지 가능합니다.", 'focus', '');
        obj.value = obj.value.substr(0, obj.value.length -1)
        return false;
    }
    return true;
}

function fnIsValidNum(obj) {
    if (!fnIsNumber(obj)) {
        $this = obj;
        modalMsg(fnGetMsg("req.number.check"), 'focus', '');
        obj.value = obj.value.substr(0, obj.value.length -1)
        return false;
    }
    return true;
}

function fnIsNumber(obj) {
    var chars = "0123456789";
    return containsCharsOnly(obj, chars);
}

function containsCharsOnly(obj, chars) {
    for (var inx = 0; inx < obj.value.length; inx++) {
        if (chars.indexOf(obj.value.charAt(inx)) == -1) {
            return false;
        }
    }
    return true;
}

function fnPasswdCheck(obj){
    var vPasswd 	= "";
    vPasswd 		= obj.value;
    /*var vPasswd 	= "";
    var vId 	 	= "";
    var charStr1 	= "";
    var charStr2 	= "";
    var charStr3 	= "";
    var vPassType   = /^[A-Za-z0-9]{6,15}$/i;

    var samePass1 	= 0; //동일문자 카운트
    var samePass2 	= 0; //연속성(+) 카운드
    var samePass3 	= 0; //연속성(-) 카운드

    vPasswd 		= regForm.admin_pw.value;
    if(flag == 'I'){
        vId				= regForm.admin_email.value;
    }
    vConfPasswd     = $("#admin_pw_chk").val();*/

    //if (!isEngNum(regForm.admin_pw,"비밀번호")) {return false;}
    /*if(!vPassType.test(vPasswd)){
        fnAlert(fnGetMsg("info.passwd.type"));
        regForm.admin_pw.focus();
        return false;
    } */
    $this = obj;

    if (!vPasswd.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)) {
        modalMsg("비밀번호는 영문, 숫자, 특수문자를 혼용하여 8~15자를 입력해 주세요.", 'focus', '');
        return false;
    }
    if(vPasswd.length <= 7 || vPasswd.length >= 15) {
        modalMsg("비밀번호는 영문, 숫자, 특수문자를 혼용하여 8~15자를 입력해 주세요.", 'focus', '');
        return false;
    }
    /*if(typeof(regForm.admin_pw_chk) !== "undefined" && vPasswd !== vConfPasswd){
        //비밀번호가 일치 하지 않습니다.
        fnAlert(fnGetMsg("info.passwd.missmech"));
        regForm.admin_pw_chk.focus();
        return false;
    }
    if(flag == 'I'){
        if (vId.indexOf(vPasswd) > -1) {
            fnAlert(fnGetMsg("info.passwd.type4"));
            return false;
        }
    }
    for ( var i = 0; i < vPasswd.length; i++) {
        charStr1 = vPasswd.charAt(i);
        charStr2 = vPasswd.charAt(i + 1);

        //동일문자 카운트
        if (charStr1 == charStr2) {
            samePass1 = samePass1 + 1;
        }

        charStr3 = vPasswd.charAt(i + 2);
        //연속성(+) 카운드
        if (charStr1.charCodeAt(0) - charStr2.charCodeAt(0) == 1 &&
            charStr2.charCodeAt(0) - charStr3.charCodeAt(0) == 1) {
            samePass2 = samePass2 + 1;
        }

        //연속성(-) 카운드
        if (charStr1.charCodeAt(0) - charStr2.charCodeAt(0) == -1 &&
            charStr2.charCodeAt(0) - charStr3.charCodeAt(0) == -1) {
            samePass3 = samePass3 + 1;
        }
    }
    if(samePass1 > 3){
        fnAlert(fnGetMsg("info.passwd.type3"));
        return false;
    }
    if(samePass2 > 2 || samePass3 > 2){
        fnAlert(fnGetMsg("info.passwd.type2"));
        return false;
    }*/
    return true;
}
