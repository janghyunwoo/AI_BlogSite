<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="robots" content="noindex, nofollow">

    <title>AI Blog - 로그인</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<link rel="stylesheet" href="css/login.css">

	<script type="text/javascript" src="js/login.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
    
	<script type="text/javascript" src="js/check.js" charset="euc-kr"></script>
	<script type="text/javascript" src="js/go.js" charset="euc-kr"></script>

</head>
<body>

	<!--
    you can substitue the span of reauth email for a input with the email and
    include the remember me checkbox
    -->
    <div class="container">
        <div class="card card-container">
            <!-- <img class="profile-img-card" src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120" alt="" /> -->
            <img id="profile-img" class="profile-img-card" src="etc/jang.jpg" />
            <p id="profile-name" class="profile-name-card"></p>
            <form class="form-signin" action="MemberLoginController" method="post" 
		name="loginForm" >
                <span id="reauth-email" class="reauth-email"></span>
                <input name="im_id" required="required" oninvalid="loginCheck(this);"  oninput="loginCheck(this);" type="text" id="inputEmail" class="form-control" maxlength="10" placeholder="아이디"  autofocus>
                <input name="im_pw" required="required" oninvalid="loginCheck(this);" oninput="loginCheck(this);"  type="password" id="inputPassword" class="form-control" maxlength="10" placeholder="패스워드" >
                <!-- <input id="email" 
           oninvalid="loginCheck(this);" 
           name="email" oninput="loginCheck(this);"  
           type="text" 
           required="required" /> -->
                <div id="remember" class="checkbox">
                    <label>
                        <input name="im_autologin" type="checkbox">자동 로그인
                    </label>
                </div>
                <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">로그인</button>
            </form><!-- /form -->
                <button class="btn btn-lg btn-primary btn-block btn-signin" data-toggle="modal" data-target="#add_project" >회원 가입</button>
            <a href="#" class="forgot-password">
                	아이디 찾기
            </a>
			/
            <a href="#" class="forgot-password">
               		 패스워드 찾기
            </a>
            <p>
            <div align="center">${r }</div>
        </div><!-- /card-container -->
    </div><!-- /container -->
    

<!-- Modal -->
	<div id="add_project" class="modal fade" role="dialog" >
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header login-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">회원 가입</h4>
				</div>
				<form action="MemberJoinController"
		method="post" enctype="multipart/form-data" 
	name="joinForm">
				<div class="modal-body">
					
			    <input name="id" required="required" oninvalid="joinCheck(this);"  oninput="joinCheck(this);" type="text" id="inputEmail1" class="form-control" maxlength="10" placeholder="아이디"  autofocus>
                <input name="pw" required="required" oninvalid="joinCheck(this);" oninput="joinCheck(this);"  type="password" id="inputEmail2" class="form-control" maxlength="10" placeholder="패스워드" >
					
				<input name="pwck" required="required" oninvalid="joinCheck(this);" oninput="joinCheck(this);" type="password" placeholder="패스워드 확인 입력" id="inputEmail3" class="form-control"  >
				<input name="name" required="required" oninvalid="joinCheck(this);" oninput="joinCheck(this);" type="text"  placeholder="이름 입력" id="inputEmail4" class="form-control"   >
        			<table>
        				<tr>
        					<td style="width:40px; ">성별</td>
        					
        						<td><div data-toggle="buttons"><label class="btn btn-default btn-circle btn-lg active"><input type="radio" name="sex" value="f"><i class="fas fa-female"></i></label>
        						<label class="btn btn-default btn-circle btn-lg"><input type="radio" name="sex" value="m"><i class="fas fa-male"></i></label></div></td>
        				</tr>
        			</table>

					<table>
						<tr>
							<td>
							        			<select class="form-control" name="values1" >
                    	<option value="">Select one</option>
                    	<option value="1">Option 1</option>
                    	<option value="2">Option 2</option>
                    	<option value="3">Option 3</option>
                    	<option value="4">Option 4</option>
                    	
               		 </select>
							</td>

							<td style=" font-size: 14pt; width: 50px;">년</td>
							<td>
							        			<select class="form-control" name="values1" >
                    	<option value="">Select one</option>
                    	<option value="1">Option 1</option>
                    	<option value="2">Option 2</option>
                    	<option value="3">Option 3</option>
                    	<option value="4">Option 4</option>
                    	
               		 </select>
							</td>
							<td style=" font-size: 14pt; width: 50px;">월</td>

							<td>
							        	<select class="form-control" name="values1" >
                    	<option value="">Select one</option>
                    	<option value="1">Option 1</option>
                    	<option value="2">Option 2</option>
                    	<option value="3">Option 3</option>
                    	<option value="4">Option 4</option>
                    	
               		 </select>
							</td>
						<td style=" font-size: 14pt;">
						일
						</td>
						</tr>
					</table>

					<table>
						<tr>
							<td>
							        			<select class="form-control" name="values1" >
                    	<option value="">집 전화번호</option>
                    	<option value="1">02</option>
                    	<option value="2">031</option>
                    	<option value="3">032</option>
                    	
               		 </select>
							</td>

							<td style=" font-size: 30pt;">-</td>
							<td>
							<input type="text" placeholder="중간 번호" name="midnum">
							</td>
							<td style=" font-size: 30pt;">-</td>

							<td>
							<input type="text" placeholder="끝 번호" name="endnum">
							</td>

						</tr>
					</table>


					<table>
        				<tr>
        					<td>사진</td>
        					
        						<td>
        						<input required="required" oninvalid="joinCheck(this);" oninput="joinCheck(this);" name="img" type="file">
        						</td>
        				</tr>
        			</table>
				
				

				</div>
				<div class="modal-footer">
					<button type="submit" class="add-project" >가입</button>
				</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>
