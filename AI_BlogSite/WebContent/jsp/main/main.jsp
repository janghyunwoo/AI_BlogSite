<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="robots" content="noindex, nofollow">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>AI Blog - 메인</title>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"
	rel="stylesheet"
	integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/main.css">

<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/main.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>

	<script type="text/javascript" src="js/validCheck.js" charset="euc-kr"></script>
	<script type="text/javascript" src="js/check.js" charset="euc-kr"></script>
	<script type="text/javascript" src="js/go.js" charset="euc-kr"></script>
<script type="text/javascript">
var updateMeberRequest = new XMLHttpRequest();
var saveUpdateMeberRequest = new XMLHttpRequest();

function updateMember() {
	updateMeberRequest.open("get", "MemberUpdateController", true);
	/*json요청/post 형식으로 전송 ///UserSearchServlet?userName=~~~인 uri로 지정/인코딩을 한다/userName을 가지는 id의 값을 가져온다.*/
	/* document: 현재 문서 내를 뜻함. */
	updateMeberRequest.onreadystatechange = searchIDProcessing;
	
	//searchRequestID.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	
	/* 정상적으로 받아오면 searchProcess실행 */
	updateMeberRequest.send(null);

}

function searchIDProcessing() {
	
	
	if (updateMeberRequest.readyState == 4 && updateMeberRequest.status == 200) {
		
		//모달창 띄운다
		$("#update").modal();
		
		
	}
}


function uploadFile() {
		
 		var form = $('#updateForm')[0];
        var formData = new FormData(form);
        formData.append("img", $("#img")[0].files[0]); 
        
         $.ajax({
            url: 'MemberUpdateController',
                    processData: false,
                    contentType: false,
                    data: formData,
                    type: 'POST',
                    beforeSend: function() {
                    	
                        //유효성 검사 등..
                    	var pwField = document.updateForm.pw;
                    	var pwChkField = document.updateForm.pwck;
                    	var nameField = document.updateForm.name;
                    	var sexField = document.updateForm.sex;
                    	var imgField = document.updateForm.img;
                    	
                    	if ((isEmpty(pwField) || notEquals(pwField, pwChkField)
                    			|| lessThan(pwField, 4) || notContains(pwField, "1234567890")
                    			|| notContains(pwField, "qwertyuiopasdfghjklzxcvbnm")
                    			|| notContains(pwField, "QWERTYUIOPASDFGHJKLZXCVBNM"))) {


                    		pwField.focus();
                    		return false;
                    	} else if ( isEmpty(nameField)) {

                    		nameField.focus();
                    		return false;
                    	} else if ( isEmpty(sexField)) {

                    		sexField.focus();
                    		return false;
                    	} else if ((isEmpty(imgField)
                    			|| (isNotType(imgField, ".png") && isNotType(imgField, ".gif")
                    					&& isNotType(imgField, ".jpg") && isNotType(imgField,
                    					".bmp")))) {

                    		imgField.focus();
                    		return false;
                    	}
                    	
                    	return true; 
                    
                    },
                     success: function(result){
                    	updateSuccess(result);
                    	
                    	
                    } 
                     
            });
 

	}
	
function updateSuccess(result) {
	
	
		
		var insertResultUpdate = document.getElementById("returnUpdate");
		
		//기존에 추가된 dom 노드 삭제 
		if(insertResultUpdate.hasChildNodes()){
			insertResultUpdate.removeChild(insertResultUpdate.firstChild);
		}
		
		var hh2 = document.createElement("h2"); // <h2></h2>
		hh2.textContent = result; // <h2>ㅎㅎㅎ</h2>

		//returnid를 가지고있는 테그에 자식 노드를 더한다.
		document.getElementById("returnUpdate").appendChild(hh2);
		
		//모달창 띄운다
		$("#resultUpdate").modal({backdrop: 'static'});

}

</script>
</head>
<body>
<body class="home">
	<div class="container-fluid display-table">
		<div class="row display-table-row">
			<div
				class="col-md-2 col-sm-1 hidden-xs display-table-cell v-align box "
				id="navigation">

				<div class="card">
					<canvas class="header-bg" width="250" height="70" id="header-blur"></canvas>
					<div class="avatar">
						<img src="" alt="" />
					</div>
					<div class="content">
						<p>
							${sessionScope.loginMember.im_name  }<br>
						</p>
						<p>
							<button type="button" onclick= "updateMember();"class="btn btn-default" >회원수정</button>
							<button type="button" onclick="logout();" class="btn btn-default">로그아웃</button>
						</p>
					</div>
				</div>



				<img class="src-image" src="etc/${sessionScope.loginMember.im_img  }" />



				<div class="navi">
					<ul>
						<li><a href="HomeController"><i class="fa fa-home"
								aria-hidden="true"></i><span class="hidden-xs hidden-sm"> 홈</span></a></li>
						<li><a href="noticeBoardController"><i class="fa fa-tasks" aria-hidden="true"></i><span
								class="hidden-xs hidden-sm"> 게시판</span></a></li>
						<li><a href="#"><i class="fa fa-bar-chart"
								aria-hidden="true"></i><span class="hidden-xs hidden-sm">Statistics</span></a></li>
						<li><a href="#"><i class="fa fa-user" aria-hidden="true"></i><span
								class="hidden-xs hidden-sm">Calender</span></a></li>
						<li><a href="#"><i class="fa fa-calendar"
								aria-hidden="true"></i><span class="hidden-xs hidden-sm">Users</span></a></li>
						<li><a href="#"><i class="fa fa-cog" aria-hidden="true"></i><span
								class="hidden-xs hidden-sm">Setting</span></a></li>
					</ul>
				</div>
			</div>
			<div class="col-md-10 col-sm-11 display-table-cell v-align">
				<!--<button type="button" class="slide-toggle">Slide Toggle</button> -->
				<div class="row" >
					<header>
						<div class="col-md-7">
							<nav class="navbar-default pull-left">
								<div class="navbar-header">
									<button type="button" class="navbar-toggle collapsed"
										data-toggle="offcanvas" data-target="#side-menu"
										aria-expanded="false">
										<span class="sr-only">Toggle navigation</span> <span
											class="icon-bar"></span> <span class="icon-bar"></span> <span
											class="icon-bar"></span>
									</button>
								</div>
							</nav>
							<div class="search hidden-xs hidden-sm">
								<input type="text" placeholder="Search" id="search">
							</div>
						</div>
						<div class="col-md-5">
							<div class="header-rightside">
								<ul class="list-inline header-top pull-right">
									<li class="hidden-xs"><a href="#" class="add-project"
										data-toggle="modal" data-target="#add_project"><i class="fas fa-plus"></i>&nbsp;&nbsp;Add Project</a></li>
									<li><a href="#"><i class="fa fa-envelope"
											aria-hidden="true"></i></a></li>
									<li><a href="#" class="icon-info"> <i
											class="fa fa-bell" aria-hidden="true"></i> <span
											class="label label-primary">3</span>
									</a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown">
										<i class="fa fa-user" aria-hidden="true"></i>
										<b class="caret"></b>
										</a>
										<ul class="dropdown-menu">
											<li>
												<div class="navbar-content">
													<span>JS Krishna</span>
													<p class="text-muted small">me@jskrishna.com</p>
													<div class="divider"></div>
													<a href="#" class="view btn-sm active">View Profile</a>
												</div>
											</li>
										</ul></li>
								</ul>
							</div>
						</div>
					</header>
				<!-- 페이지 삽입 부분 -->
					<div >
						<jsp:include page="${contentPage }"></jsp:include>
					</div>
				</div>
					
				
				
					<!-- <h1>Hello, JS</h1>
					<div class="row">
						<div class="col-md-5 col-sm-5 col-xs-12 gutter">

							<div class="sales">
								<h2>Your Sale</h2>

								<div class="btn-group">
									<button class="btn btn-secondary btn-lg dropdown-toggle"
										type="button" data-toggle="dropdown" aria-haspopup="true"
										aria-expanded="false">
										<span>Period:</span> Last Year
									</button>
									<div class="dropdown-menu">
										<a href="#">2012</a> <a href="#">2014</a> <a href="#">2015</a>
										<a href="#">2016</a>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-7 col-sm-7 col-xs-12 gutter">

							<div class="sales report">
								<h2>Report</h2>
								<div class="btn-group">
									<button class="btn btn-secondary btn-lg dropdown-toggle"
										type="button" data-toggle="dropdown" aria-haspopup="true"
										aria-expanded="false">
										<span>Period:</span> Last Year
									</button>
									<div class="dropdown-menu">
										<a href="#">2012</a> <a href="#">2014</a> <a href="#">2015</a>
										<a href="#">2016</a>
									</div>
								</div>
							</div>
						</div>
					</div> -->
			</div>
		</div>

	</div>



	<!-- Modal -->
	<div id="add_project" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header login-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Add Project</h4>
				</div>
				<div class="modal-body">
					<input type="text" placeholder="Project Title" name="name">
					<input type="text" placeholder="Post of Post" name="mail">
					<input type="text" placeholder="Author" name="passsword">
					<textarea placeholder="Desicrption"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="cancel" data-dismiss="modal">Close</button>
					<button type="button" class="add-project" data-dismiss="modal">Save</button>
				</div>
			</div>

		</div>
	</div>
	
	<!-- 회원정보 수정Modal -->
	<div id="update" class="modal fade" role="dialog" >
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header login-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">회원정보 수정</h4>
				</div>
				 <form onsubmit="return false;"
		method="post" enctype="multipart/form-data" 
	id="updateForm" name="updateForm"> 
				<div class="modal-body">
					
                <input name="pw" value="${sessionScope.loginMember.im_pw }" required="required" oninvalid="updateCheck(this);" oninput="updateCheck(this);"  type="password" id="inputEmail2" class="form-control" maxlength="10" placeholder="패스워드 수정" >
					
				<input name="pwck" value="${sessionScope.loginMember.im_pw }" required="required" oninvalid="updateCheck(this);" oninput="updateCheck(this);" type="password" placeholder="패스워드 수정 확인" id="inputEmail3" class="form-control"  >
				<input name="name" value="${sessionScope.loginMember.im_name }" required="required" oninvalid="updateCheck(this);" oninput="updateCheck(this);" type="text"  placeholder="이름 수정 입력" id="name" class="form-control"   >
        			<table>
        				<tr>
        					<td style="width:40px; ">성별</td>
        					
        						<td><div data-toggle="buttons">
        						<!-- active로 선택되어 보이는 것은 value값 정해졌다는게 아니라 ui적으로 보여주는 것 뿐이다. -->
        						<!-- 그래서 input radio에서 따로 checked 설정을 해주어야 한다. -->
        						<label class="btn btn-default btn-circle btn-lg ${sessionScope.loginMember.im_addr == '여'? 'active':''}" >
        						<input type="radio" name="sex" value="f" required="required" checked="${sessionScope.loginMember.im_addr == '여'? 'checked':''}" ><i class="fas fa-female"></i></label>
        						<label class="btn btn-default btn-circle btn-lg ${sessionScope.loginMember.im_addr == '남'? 'active':''}" >
        						<input type="radio" name="sex" value="m" required="required" checked="${sessionScope.loginMember.im_addr == '남'? 'checked':''}" ><i class="fas fa-male"></i></label></div></td>
        				</tr>
        			</table>
					
					<table>
						<tr>
							<td>
							   <select name="im_y" class="form-control">
							   <option>
							<fmt:formatDate pattern="yyyy"
								value="${sessionScope.loginMember.im_birthday }" />
						</option>
						<c:forEach var="y" begin="${curYear - 50 }" end="${curYear }">
							<option>${y }</option>
						</c:forEach>
					</select>
							</td>

							<td style=" font-size: 14pt; width: 50px;">년</td>
							<td>
							<select class="form-control" name="im_m" >
							<option>
							<fmt:formatDate pattern="M"
								value="${sessionScope.loginMember.im_birthday }" />
						</option>
                    	<c:forEach var="m" begin="1" end="12">
							<option>${m }</option>
						</c:forEach>
                    	
               		 </select>
							</td>
							<td style=" font-size: 14pt; width: 50px;">월</td>

							<td>
							        	<select class="form-control" name="im_d" >
                    	<option>
							<fmt:formatDate pattern="d"
								value="${sessionScope.loginMember.im_birthday }" />
						</option>
                    	<c:forEach var="d" begin="1" end="31">
							<option>${d }</option>
						</c:forEach>
                    	
               		 </select>
							</td>
						<td style=" font-size: 14pt;">
						일
						</td>
						</tr>
					</table>

					<table>
        				<tr>
        					<td>사진</td>
        					
        						<td>
        						<img width="100" height="100" class="loginOKImg" src="etc/${sessionScope.loginMember.im_img }">
        						<input required="required" oninvalid="updateCheck(this);" oninput="updateCheck(this);" id="img" name="img" type="file">
        						</td>
        				</tr>
        			</table>
				
				

				</div>
				<div class="modal-footer">
					<!-- <a class="ui-shadow ui-btn ui-corner-all" href="javascript:uploadFile();">전송</a> -->
					<button onclick="uploadFile()"  class="add-project" >수정</button> 
				</div>
				 </form> 
			</div>
		</div>
	</div>
	
		<!-- 회원 정보 수정 결과 -->
    <div id="resultUpdate" class="modal fade" role="dialog" >
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header login-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">회원 정보 수정</h4>
				</div>

				<div id = "returnUpdate" class="modal-body" align="center">
				

				</div>
				<div class="modal-footer">
					<!-- 수정 완료후  -->
					<button onClick="window.location.reload()" class="add-project" data-dismiss="modal" aria-label="Close" >닫기</button>
				</div>

			</div>
		</div>
	</div>

</body>
</body>
</html>
