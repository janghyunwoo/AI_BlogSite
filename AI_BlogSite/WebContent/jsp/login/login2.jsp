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
    
	<script type="text/javascript" src="js/validCheck.js" charset="euc-kr"></script>
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
                <input name="im_id"required="required" oninvalid="loginCheck(this);"  oninput="loginCheck(this);" type="text" id="inputEmail" class="form-control" maxlength="10" placeholder="아이디" required autofocus>
                <input name="im_pw" required="required" oninvalid="loginCheck(this);" oninput="loginCheck(this);"  type="password" id="inputPassword" class="form-control" maxlength="10" placeholder="패스워드" required>
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
				
				<div class="modal-body">
					<input type="text" placeholder="아이디 입력" name="id">
					<input type="password" placeholder="패스워드 입력" name="pw">
					<input type="password" placeholder="패스워드 확인 입력" name="pwck">
					<input type="text" placeholder="이름 입력" name="name">
					       성별 <div data-toggle="buttons">
          						<label class="btn btn-default btn-circle btn-lg active"><input type="radio" name="q1" value="0"><i class="fas fa-female"></i></label>
          						<label class="btn btn-default btn-circle btn-lg">       <input type="radio" name="q1" value="1"><i class="fas fa-male"></i></label>
        					</div>
        			<select class="form-control" name="values1" >
                    	<option value="">Select one</option>
                    	<option value="1">Option 1</option>
                    	<option value="2">Option 2</option>
                    	<option value="3">Option 3</option>
                    	<option value="4">Option 4</option>
                    	
               		 </select>
               		 <div class ="birthday">년</div>
               		 <select class="form-control" name="values2">
                    	<option value="">Select one</option>
                    	<option value="1">Option 1</option>
                    	<option value="2">Option 2</option>
                    	<option value="3">Option 3</option>
                    	<option value="4">Option 4</option>
               		 </select>
               		 <div class ="birthday">월</div>
               		 <select class="form-control" name="values2" >
                    	<option value="">Select one</option>
                    	<option value="1">Option 1</option>
                    	<option value="2">Option 2</option>
                    	<option value="3">Option 3</option>
                    	<option value="4">Option 4</option>
               		 </select>
               		 <div class ="birthday">일</div>
   		 
					<input type="text" placeholder="이메일 입력" name="email">
					               		 <select class="form-control" name="values1" >
                    	<option value="">Select one</option>
                    	<option value="1">Option 1</option>
                    	<option value="2">Option 2</option>
                    	<option value="3">Option 3</option>
                    	<option value="4">Option 4</option>
               		 </select>
               		 <div class ="birthday">-</div>
               		 <select class="form-control" name="values2">
                    	<option value="">Select one</option>
                    	<option value="1">Option 1</option>
                    	<option value="2">Option 2</option>
                    	<option value="3">Option 3</option>
                    	<option value="4">Option 4</option>
               		 </select>
               		 <div class ="birthday">-</div>
               		 <select class="form-control" name="values2" >
                    	<option value="">Select one</option>
                    	<option value="1">Option 1</option>
                    	<option value="2">Option 2</option>
                    	<option value="3">Option 3</option>
                    	<option value="4">Option 4</option>
               		 </select>

				<div style="margin-left: 50px;">사진 </div><input name="im_img" type="file">

				</div>
				<div class="modal-footer">
					<button type="button" class="add-project" data-dismiss="modal">가입</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
