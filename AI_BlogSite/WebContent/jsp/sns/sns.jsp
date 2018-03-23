<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form action="SNSWriteController" name="snsWriteForm" onsubmit="return snsWriteCheck();">
		<table id="snsWriteTbl">
			<c:choose>
				<c:when test="${sessionScope.loginMember != null }">
					<tr>
						<td id="snsWriteTATd" align="center"><textarea name="is_txt"
								autofocus="autofocus" id="snsWriteTA" placeholder="말"
								maxlength="150"></textarea></td>
						<td><input id="snsWriteBtn" type="submit" value="쓰기">
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td align="center" id="snsBlankTitleTd">SNS</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</form>
	<c:if test="${curPageNo != 1 }">
	<a class="snsL" href="SNSPageController?p=${curPageNo-1 }">◀</a>
	</c:if>
	<c:if test="${curPageNo != pageCount }">
	<a class="snsR" href="SNSPageController?p=${curPageNo+1 }">▶</a>
	</c:if>
	<table id="snsArea">
		<tr>
			<td class="snsLR">&nbsp;</td> 
			<td class="snsCenter" align="right" style="padding-right:40px;">
				<form action="SNSSearchController" name="snsSearchForm" onsubmit="return snsSearchCheck();" method="post">
					<input id="snsSearchInput" name="is_txt" placeholder="내용으로 검색" maxlength="10">
					<input id="snsSearchBtn" type="submit" value="검색">
				</form>
			</td>
			<td class="snsLR">&nbsp;</td>
		</tr>
		<tr>
			<td align="center"></td>
			<td align="center">
				<c:forEach var="s" items="${msgs }">
					<table class="snsMsg">
						<tr>
							<td rowspan="5" class="snsImgTd" valign="top" align="center">
								<img onclick="searchSNS('${s.is_owner}');"  class="snsImg" src="etc/${s.im_img }">
							</td>
							<td class="snsOwner">${s.is_owner }</td>
						</tr>
						<tr>
							<td align="right" style="font-weight:900;">
								<fmt:formatDate value="${s.is_date }" type="both" dateStyle="long" timeStyle="short"/>
							&nbsp;&nbsp;</td> 
						</tr>
						<tr>
							<td class="snsTxt">${s.is_txt }</td>
						</tr>
						<tr>
							<td class="snsCmtArea">
								<c:forEach var="r" items="${s.is_repls }">
									<span class="snsCmtOwner">${r.isr_owner }</span> 
									- ${r.isr_txt }<br>
								</c:forEach>
								<c:if test="${sessionScope.loginMember != null }">
								<!-- this로 해두는 것은 이중 반복문이기 때문에 내부에 있는 반복문은 id가 중복 되기 때문이다.
										그래서 자바스크립트에서 id로 dom객체를 찾는 것이 아니라 this로 호출한 dom객체로 찾는 거이
									 -->
									<form onsubmit="return writeReplCheck(this);" action="SNSReplWriteController"> 
										<span class="snsCmtOwner">${sessionScope.loginMember.im_id }</span>&nbsp;
										<input type="hidden" name="isr_is_no" value="${s.is_no }">
										<input class="writeReplInput" name="isr_txt" maxlength="100" placeholder="리플 내용">
										<input class="writeReplBtn" type="submit" value="쓰기">
									</form>
								</c:if>
							</td>
						</tr>
						<tr>
							<td align="right">
								<c:if test="${s.is_owner == sessionScope.loginMember.im_id }">
									<button onclick="updateSNS(${s.is_no});" class="snsBtn">수정</button>
									<button onclick="deleteSNS(${s.is_no});" class="snsBtn">삭제</button>
								</c:if>
								&nbsp;
							</td>
						</tr>
					</table> 
				</c:forEach>
			</td>
			<td align="center"></td>
		</tr>
	</table>


</body>
</html>