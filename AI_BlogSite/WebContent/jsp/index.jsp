<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�繰���ͳݱ�� ���̺긮�� ���� ������ �缺 ���� ī��</title>
<link rel="stylesheet" href="css/index.css">
<link rel="stylesheet" href="css/member.css">
<link rel="stylesheet" href="css/sns.css">
<link rel="stylesheet" href="css/community.css">
<script type="text/javascript" src="js/validCheck.js" charset="euc-kr"></script>
<script type="text/javascript" src="js/check.js" charset="euc-kr"></script>
<script type="text/javascript" src="js/go.js" charset="euc-kr"></script>
</head>
<body>
	<table id="siteTitleArea">
		<tr>
			<td align="center">
				<table id="siteTitleArea2">
					<tr>
						<td id="siteTitleTd"><a id="siteTitle" href="HomeController">�繰���ͳݱ�� ���̺긮��
								���� ������ �缺 ���� ī��</a></td>
					</tr>
					<tr>
						<td id="siteMenuArea">
							<a href="SNSController" class="siteMenu">SNS</a>
							<a href="" class="siteMenu">�޴�2</a>
							<c:if test="${sessionScope.loginMember != null }">
							<a href="CommunityController" class="siteMenu">Ŀ�´�Ƽ</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<td align="right"><jsp:include page="${loginPage }"></jsp:include>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table id="siteContentArea">
		<tr>
			<td align="center">
				<table id="siteContentArea2">
					<tr>
						<td align="center"><jsp:include page="${contentPage }"></jsp:include>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>





