<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<table id="msgTbl">
		<tr>
			<td align="center" style="font-size:25pt; color:white; font-weight: 900;height:65px;" valign="top">내 쪽지</td>
		</tr>
		<tr>
			<td valign="top">
				<c:forEach var="msg" items="${msgs }">
					<table class="msg">
						<tr>
							<td class="msgFrom">${msg.im_from }</td>
							<td class="msgFrom" align="right" onclick="deleteMsg(${msg.im_no});">X</td> 
						</tr>
						<tr>
							<td class="msgDate" align="right" colspan="2"><fmt:formatDate value="${msg.im_date }" type="both" dateStyle="short" timeStyle="short"/> </td>
						</tr>
						<tr>
							<td colspan="2" onclick="sendMsg('${msg.im_from}')"><br>${msg.im_txt }</td>
						</tr>
					</table>
				</c:forEach>
			</td>
		</tr>
	</table>
	<table id="memberArea">
		<tr>
			<td><c:forEach var="m" items="${members }">
					<table class="memberTable" onclick="sendMsg('${m.im_id}')">
						<tr>
							<td rowspan="4" class="memberImgTd" align="center"><img
								class="memberImg" src="etc/${m.im_img }"></td>
							<td class="memberIDTd">&nbsp;${m.im_id }</td>
						</tr>
						<tr>
							<td>&nbsp;${m.im_name }</td>
						</tr>
						<tr>
							<td align="right"><fmt:formatDate value="${m.im_birthday }"
									dateStyle="short" />&nbsp;</td>
						</tr>
						<tr>
							<td align="right" style="font-size:8pt;">${m.im_addr }&nbsp;</td>
						</tr> 
					</table>
				</c:forEach></td>
		</tr>
	</table>
</body>
</html>