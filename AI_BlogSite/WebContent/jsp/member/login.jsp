<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body> 
	<table id="loginTbl">
		<form action="MemberLoginController" method="post" 
		name="loginForm" onsubmit="return loginCheck();">
		<tr><td style="height:10px;"></td></tr>
		<tr>
			<td class="loginTd1" align="center">id</td>
			<td><input name="im_id" value="${cookie.lastLoginID.value }" maxlength="10" class="loginInput" autocomplete="off"></td>
		</tr>
		<tr>
			<td class="loginTd1" align="center">pw</td>
			<td><input name="im_pw" type="password" maxlength="10"
				class="loginInput"></td>
		</tr>
		<tr>
			<td class="loginTd1"></td>
			<td>
				<input name="im_autologin" type="checkbox">로그인 상태 유지</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<input type="submit" value="로그인" class="loginBtn">
		</form>
			<button onclick="goJoin();" class="loginBtn">회원가입</button></td>
		</tr>
		<tr>
			<td colspan="2" align="right" style="color:yellow;">${r }&nbsp;&nbsp;</td> 
		</tr>
	</table>
</body>
</html>




