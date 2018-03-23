function writeReplCheck(writeForm){
	// submit을 수행한 form속의 isr_txt
	var txtField = writeForm.isr_txt;
	
	if(isEmpty(txtField)){
		alert("내용 확인");
		txtField.focus();
		return false;
	}
	return true;
}
function snsSearchCheck(){
	// 이 문서에서 이름이 snsSearchForm인 form속의 is_txt
	var txtField = document.snsSearchForm.is_txt;
	if (isEmpty(txtField)) {
		alert("입력 확인");
		txtField.value = "";
		txtField.focus();
		return false;
	}
	return true;
}
function snsWriteCheck() {
	var txtField = document.snsWriteForm.is_txt;
	if (isEmpty(txtField)) {
		alert("입력 확인");
		txtField.value = "";
		txtField.focus();
		return false;
	}
	return true;
} 
function updateCheck() {
	var idField = document.updateForm.im_id;
	var pwField = document.updateForm.im_pw;
	var pwChkField = document.updateForm.im_pwChk;
	var nameField = document.updateForm.im_name;
	var addrField = document.updateForm.im_addr;
	var imgField = document.updateForm.im_img;

	if (isEmpty(idField) || containsHangul(idField)) {
		alert("id 확인");
		idField.value = "";
		idField.focus();
		return false;
	} else if (isEmpty(pwField) || notEquals(pwField, pwChkField)
			|| lessThan(pwField, 4) || notContains(pwField, "1234567890")
			|| notContains(pwField, "qwertyuiopasdfghjklzxcvbnm")
			|| notContains(pwField, "QWERTYUIOPASDFGHJKLZXCVBNM")) {
		alert("pw 확인");
		pwField.value = "";
		pwChkField.value = "";
		pwField.focus();
		return false;
	} else if (isEmpty(nameField)) {
		alert("이름 확인");
		nameField.value = "";
		nameField.focus();
		return false;
	} else if (isEmpty(addrField)) {
		alert("거주지 확인");
		addrField.value = "";
		addrField.focus();
		return false;
	} else if (isEmpty(imgField)) {
		return true;
	} else if (isNotType(imgField, ".png") && isNotType(imgField, ".gif")
			&& isNotType(imgField, ".jpg") && isNotType(imgField, ".bmp")) {
		alert("사진 똑바로");
		imgField.value = "";
		imgField.focus();
		return false;
	}
	return true;
}
function joinCheck() {
	var idField = document.joinForm.im_id;
	var pwField = document.joinForm.im_pw;
	var pwChkField = document.joinForm.im_pwChk;
	var nameField = document.joinForm.im_name;
	var addrField = document.joinForm.im_addr;
	var imgField = document.joinForm.im_img;

	if (isEmpty(idField) || containsHangul(idField)) {
		alert("id 확인");
		idField.value = "";
		idField.focus();
		return false;
	} else if (isEmpty(pwField) || notEquals(pwField, pwChkField)
			|| lessThan(pwField, 4) || notContains(pwField, "1234567890")
			|| notContains(pwField, "qwertyuiopasdfghjklzxcvbnm")
			|| notContains(pwField, "QWERTYUIOPASDFGHJKLZXCVBNM")) {
		alert("pw 확인");
		pwField.value = "";
		pwChkField.value = "";
		pwField.focus();
		return false;
	} else if (isEmpty(nameField)) {
		alert("이름 확인");
		nameField.value = "";
		nameField.focus();
		return false;
	} else if (isEmpty(addrField)) {
		alert("거주지 확인");
		addrField.value = "";
		addrField.focus();
		return false;
	} else if (isEmpty(imgField)
			|| (isNotType(imgField, ".png") && isNotType(imgField, ".gif")
					&& isNotType(imgField, ".jpg") && isNotType(imgField,
					".bmp"))) {
		alert("사진 똑바로");
		imgField.value = "";
		imgField.focus();
		return false;
	}
	return true;
}

function loginCheck(textbox) {

	var idField = document.loginForm.im_id;
	var pwField = document.loginForm.im_pw;

	
    if ((idField.name == textbox.name) && isEmpty(idField)) {
        textbox.setCustomValidity('아이디를 입력하세요.');
        idField.value = "";
		idField.focus();
		return false;
    }
    else if ((pwField.name == textbox.name) &&isEmpty(pwField)){
        textbox.setCustomValidity('패스워드를 입력하세요.');
        pwField.value = "";
		pwField.focus();
		return false;
    }
    else {
       textbox.setCustomValidity('');
    }
    return true;
}