<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>

<head>
<meta charset="utf-8">


<title>Collapse Filters Panel - Bootsnipp.com</title>


<style type="text/css">
.container {
	margin-top: 30px;
	margin-left: 50px;

}

.filter-col {
	padding-left: 10px;
	padding-right: 10px;
}
.textareaFontSize{
	font-size: 16px;
}


</style>
<script type="text/javascript">
window.onload = function() {
	getAlltext();
}

function getAlltext() {
	$.ajax({
		url : "NoticeBoardSubmitAllTextController",
		type : "post",
		dataType : "json", // 데이터 타입을 제이슨 꼭해야함, 다른방법도 2가지있음
		cache : false, // 이걸 안쓰거나 true하면 수정해도 값반영이 잘안댐
		data : Text,
		success : function(data) {
			

			
			//confirm(result.NoticeBoard);
			$.each(data.NoticeBoards, function(index, NoticeBoards) { // 이치를 써서 모든 데이터들을 배열에 넣음
				var items = [];
				items.push("<td>" + NoticeBoards.num + "</td>"); // 여기에 id pw addr tel의 값을 배열에 넣은뒤
				items.push("<td>" + NoticeBoards.owner + "</td>");
				items.push("<td>" + NoticeBoards.title + "</td>");
				items.push("<td>" + NoticeBoards.write_date + "</td>");
				items.push('<td><a data-toggle="collapse" data-target="#'+NoticeBoards.num+'" ><span class="glyphicon glyphicon-cog"></span></a></td>');
				
				/* 					confirm(NoticeBoards.num);
				confirm(NoticeBoards.owner);
				confirm(NoticeBoards.title);
				confirm(NoticeBoards.txt);
				confirm(NoticeBoards.write_date); */
				
				$("<tr/>", {
					addClass: "success",
					html : items
				// 티알에 붙임,
				}).appendTo("#table"); // 그리고 그 tr을 테이블에 붙임
				items = [];
				items.push('<td colspan="5" style="border-top: none;"><div id="'+NoticeBoards.num+'" class="collapse filter-panel">'+NoticeBoards.txt+'</div></td>');
				$("<tr/>", {
					addClass: "success",
					html : items
				// 티알에 붙임,
				}).appendTo("#table"); // 그리고 그 tr을 테이블에 붙임
				
			});//each끝

			//updateSuccess1(data.resert);

		},
		error : function(result) {
			confirm("서버 오류");
		}

	});
}

function writeCheckGo(textbox) {
	var textField = document.getElementById("inputTextArea");
	var titleField = document.getElementById("titleGO");

	//confirm(textField.name+":"+textbox.name);
    if((titleField.name == textbox.name) && isEmpty(titleField)){
    	textbox.setCustomValidity('제목을 입력하세요');
    	titleField.focus();
    }
    else if ((textField.name == textbox.name) && isEmpty(textField)) {
        textbox.setCustomValidity('글을 입력하세요');

        textField.focus();
		return false;
    }else {
       textbox.setCustomValidity('');
    }
    
    return true;
}


	function registerNoticeBoard() {

		$.ajax({
			url : "RegisterNoticeBoardController",
			type : "post",
			dataType : "json", // 데이터 타입을 제이슨 꼭해야함, 다른방법도 2가지있음
			cache : false, // 이걸 안쓰거나 true하면 수정해도 값반영이 잘안댐
			data : {
				"textArea" : $("#inputTextArea").val(),
				"titleArea" : $("#titleGO").val()
			},
			beforeSend : function() {

				//유효성 검사 등..
				var textField = document.getElementById("inputTextArea");
				var titleField = document.getElementById("titleGO");

				if (isEmpty(titleField)) {

					return false;
				} else if (isEmpty(textField)) {

					return false;
				}

				return true;

			},
			success : function(data) {
				
				
				var key = Object.keys(data["NoticeBoards"][0]); // id , pw , addr , tel 의 키값을 가져옴
				$("<tr>" , {
					
					html : "<td>" + key[0] + "</td>"+  // 컬럼명들
							"<td>" + key[1] + "</td>"+
							"<td>" + key[2] + "</td>"+
							"<td>" + key[3] + "</td>"+
							"<td>" + key[4] + "</td>"
				}).appendTo("#table") // 이것을 테이블에붙임
				
				//confirm(result.NoticeBoard);
				$.each(data.NoticeBoards, function(index, NoticeBoards) { // 이치를 써서 모든 데이터들을 배열에 넣음
					var items = [];
					items.push("<td>" + NoticeBoards.num + "</td>"); // 여기에 id pw addr tel의 값을 배열에 넣은뒤
					items.push("<td>" + NoticeBoards.owner + "</td>");
					items.push("<td>" + NoticeBoards.title + "</td>");
					items.push("<td>" + NoticeBoards.txt + "</td>");
					items.push("<td>" + NoticeBoards.write_date + "</td>");

/* 					confirm(NoticeBoards.num);
					confirm(NoticeBoards.owner);
					confirm(NoticeBoards.title);
					confirm(NoticeBoards.txt);
					confirm(NoticeBoards.write_date); */
					
					$("<tr/>", {
						html : items
					// 티알에 붙임,
					}).appendTo("#table"); // 그리고 그 tr을 테이블에 붙임
				});//each끝

				updateSuccess1(data.resert);

			},
			error : function(result) {
				confirm("서버 오류");
			}

		});

	}

	function updateSuccess1(result) {
		
			
		 var insertResultUpdate = document.getElementById("returnWrite");
		
		 //기존에 추가된 dom 노드 삭제 
		 if(insertResultUpdate.hasChildNodes()){
		 insertResultUpdate.removeChild(insertResultUpdate.firstChild);
		 }
		
		 var hh2 = document.createElement("h2"); // <h2></h2>
		 hh2.textContent = result; // <h2>ㅎㅎㅎ</h2>

		 //returnid를 가지고있는 테그에 자식 노드를 더한다.
		 document.getElementById("returnWrite").appendChild(hh2);
		
		 //모달창 띄운다
		 $("#noticeBoardWrite").modal({backdrop: 'static'}); 

	}

	
</script>
</head>

<!-- <div id="filter-panel" class="collapse filter-panel">
</div> -->

<body>

	<form onsubmit="return false;">
		<table class="container col-sm-11">
		<tr>
			<td>
				<input type="text" id="titleGO" name="titleGO" placeholder="제목" required="required" oninvalid="writeCheckGo(this);" oninput="writeCheckGo(this);" >
			</td>
		</tr>
					<tr >
						<td align="center" >
						<textarea id='inputTextArea' name="inputTextArea" class="col-sm-11 textareaFontSize" 
						rows="4" maxlength="150" placeholder="본문" required="required" oninvalid="writeCheckGo(this);" oninput="writeCheckGo(this);"></textarea>
						</td>
						<td >	
				<button onclick="registerNoticeBoard();" class="col-sm-5 btn btn-default" >등록</button>
						</td>
					</tr>
		</table>
	</form>

	<div class="container col-sm-11" >

		<div class="row">
				 


				<div class="panel panel-default">
					<div class="panel-body">
						<form class="form-inline" role="form">
							
							<!-- form group [rows] -->
							<div class="panel-body">
								<div class="table-responsive">
									<table class="table" id="table">
										<thead>
											<tr>
												<th>글번호</th>
												<th>글쓴이</th>
												<th>제목</th>
												<th>날짜</th>
												<th>버튼</th>
											</tr>
										</thead>
										<tbody >
											<!-- <tr class="success">
												<td>1</td>
												<td>Mark</td>
												<td>Otto</td>
												<td>2018</td>
												<td>
														<button type="button"  data-toggle="collapse"
															data-target="#filter-panel"></button>
														<a data-toggle="collapse"
															data-target="#filter-panel" ><span class="glyphicon glyphicon-cog"></span></a>
												</td>
											</tr>
												<tr class="success" >
											<td colspan="5" style="border-top: none;"><div id="filter-panel" class="collapse filter-panel">aaaa<br>aaaa<br>aaaa<br></div></td>
											</tr>
											
											<tr class="info">
												<td>2</td>
												<td>Jacob</td>
												<td>Thornton</td>
												<td>2018</td>
												<td>

												</td>
											</tr>
											<tr class="warning">
												<td>3</td>
												<td>Larry</td>
												<td>the Bird</td>
												<td>2018</td>
												<td>

												</td>
											</tr>
											<tr class="danger">
												<td>4</td>
												<td>John</td>
												<td>Smith</td>
												<td>2018</td>
												<td>

												</td>
											</tr> -->

										</tbody>
									</table>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>

		</div>
		
	<!-- 게시글 등록 모달 -->
    <div id="noticeBoardWrite" class="modal fade" role="dialog" >
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header login-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">게시글 등록 결과</h4>
				</div>

				<div id = "returnWrite" class="modal-body" align="center">
				

				</div>
				<div class="modal-footer">
					<!-- 수정 완료후  -->
					<button onClick="window.location.reload()" class="add-project" data-dismiss="modal" aria-label="Close" >닫기</button>
				</div>

			</div>
		</div>
	</div>



</body>
</html>