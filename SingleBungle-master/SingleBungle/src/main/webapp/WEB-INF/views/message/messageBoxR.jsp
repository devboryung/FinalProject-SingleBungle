<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>받은 쪽지함</title>

<!-- 부트스트랩 사용을 위한 css 추가 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<style>
.messageBox {
	width: 100px;
	height: 50px;
	text-align: center;
	line-height: 50px;
		border-radius : 15px;
	margin : 0 0 10px 20px;
}



table tr td{
	overflow: hidden !important;
	text-overflow: ellipsis !important;
	white-space: nowrap !important;
	max-width :120px;
}



/* 검색창 */
.search {
	text-align: center;
}

/******* 페이징 *******/
.flex {
	-webkit-box-flex: 1;
	-ms-flex: 1 1 auto;
	flex: 1 1 auto
}

#page-content {
	margin-top: 20px;
}

.pagination, .jsgrid .jsgrid-pager {
	display: flex;
	padding-left: 0;
	list-style: none;
	border-radius: 0.25rem
}

.page-item > a, .page-item > a:hover { color: black; }

.pagination.pagination-rounded-flat .page-item {
	margin: 0 .25rem
}

.pagination-success .page-item.active .page-link {
	background: #00c689;
	border-color: #00c689
}

.pagination.pagination-rounded-flat .page-item .page-link {
	border: none;
	border-radius: 50px;
}




#messageTable #messageContent, #messageTable #sendNickName:hover {
	cursor: pointer;
}



.modal-header{
	backgound-color : #ffaf18 !important;
}



html{
	position : relative;
	min-height:100%;
	margin : 0;
}

body {
	min-height:100%;
}


.footer{
	position:absolute;
	left : 0;
	bottom : 0;
	width:100%;
	text-align : center;

}


</style>


</head>
<body>

	<jsp:include page="../common/header.jsp" />

	<div class="container">
		<div class="row">
			<div class="col-md-12" style="padding-left : 26px">

				<div class="messageBox" style="display: inline-block; background-color :#ffaf18 ;">
					<span>받은 쪽지</span>
				</div>
				<div class="messageBox" style="display: inline-block; color: #ffaf18;	border:1px solid #ffaf18; ">
					<a href="${contextPath}/message/messageBoxS">보낸 쪽지</a>
				</div>
				<div class="float-right" id="deleteBtn" style="display: inline-block; margin-top: 10px; margin-right:10px;">
					<button class="maincolor-re" id="deleteBtn" onClick="deleteBtn()">삭제</button>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<table class="table table-stripped" id="messageTable" style="text-align : center;">
					<thead>
						<tr>
							<th><input type="checkbox" id="checkAll"/></th>
							<th>보낸 사람</th>
							<th>내용</th>
							<th>보낸 시간</th>
							<th>상태</th>

						</tr>
					</thead>
					<tbody>
						<c:if test="${empty mList }">
							<tr>
								<td colspan="5"> 받은 쪽지가 없습니다.</td>
							</tr>
						</c:if>
						
						<c:if test="${!empty mList }">
							<c:forEach var="message" items="${mList}" varStatus="vs">
								<tr>
									<td><input type="checkbox" name="chk" value="${message.messageNo}"></td>
									<td ><span id="sendNickName">${message.sendNickName}</span></td>
									<td id="messageContent">${message.messageContent}</td>
									<td>
									<%-- 날짜 출력 모양 지정 --%>
									<fmt:formatDate var="createDate" value="${message.createDt }" pattern="yyyy-MM-dd"/>
									<fmt:formatDate var="now" value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd"/> 
									<c:choose>
										<c:when test="${createDate != now}">
											${createDate }
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${message.createDt }" pattern="HH:mm"/>
										</c:otherwise>
									</c:choose>									
									</td>
									<td id="readStatus">
									<c:choose>
										<c:when test="${message.readMessage == 'N' }">
										 <i class="far fa-envelope"></i>읽지않음
										</c:when>
										<c:otherwise>
											<i class="far fa-envelope-open"></i>읽음
										</c:otherwise>
									</c:choose>
									</td>
									<!-- 쪽지 보낸 회원 no를 받아놨다가 답장할때 가져간다  -->

									<input type="hidden" id="sendMemberNo" value="${message.sendMember }">
								</tr>					
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
		
		
<!-- 페이징  시작-->
		<div class="page-content page-container" id="page-content">
			<div class="padding">
				<div class="row container d-flex justify-content-center">
					<div class="col-md-4 col-sm-6 grid-margin stretch-card">
						<nav>
							<ul class="pagination d-flex justify-content-center flex-wrap pagination-rounded-flat pagination-success">
								<c:url var="pageUrl" value="?"/>
								<c:set var="firstPage" value="${pageUrl}cp=1" />
								<c:set var="lastPage" value="${pageUrl}cp=${pInfo.maxPage }" />

								<fmt:parseNumber var="c1" value="${(pInfo.currentPage - 1) / 10 }" integerOnly="true" />
								<fmt:parseNumber var="prev" value="${ c1 * 10 }" integerOnly="true" />
								<c:set var="prevPage" value="${pageUrl}cp=${prev}" />


								<fmt:parseNumber var="c2" value="${(pInfo.currentPage + 9) / 10 }" integerOnly="true" />
								<fmt:parseNumber var="next" value="${ c2 * 10 + 1 }" integerOnly="true" />
								<c:set var="nextPage" value="${pageUrl}cp=${next}" />

								<c:if test="${pInfo.currentPage > pInfo.pageSize}">
									<li class="page-item"><a class="page-link maincolor-re1" href="${firstPage }" data-abc="true"><i class="fas fa-angle-double-left"></i></a></li>
									<li class="page-item"><a class="page-link maincolor-re1" href="${prevPage }" data-abc="true"><i class="fa fa-angle-left"></i></a></li>
								</c:if>

								<c:forEach var="page" begin="${pInfo.startPage }" end="${pInfo.endPage }">
									<c:choose>
										<c:when test="${pInfo.currentPage == page }">
											<li class="page-item active">
												<a class="page-link">${page}</a> <!-- 같은 페이지일때는 클릭이 안 된다.  -->
											</li>
										</c:when>

										<c:otherwise>
											<li class="page-item">
												<a class="page-link maincolor-re1" href="${pageUrl}cp=${page}">${page}</a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:forEach>


								<c:if test="${next <=pInfo.maxPage }">
										<li class="page-item"><a class="page-link maincolor-re1" href="${nextPage }" data-abc="true"><i class="fa fa-angle-right"></i></a></li>
										<li class="page-item"><a class="page-link maincolor-re1" href="${lastPage }" data-abc="true"><i class="fas fa-angle-double-right"></i></a></li>
								</c:if>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- 페이징 끝 -->	
	
	
	


<!-- 쪽지 읽기  -->		
<div id="readMessage" class="modal fade">
	<div class="modal-dialog modal-confirm">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">보낸사람 : <span id="sender" style="font-size:19px;"></span></h5>	
			</div>
			<div class="modal-body" >
				<div class="messageArea" style="border: 1px solid black;height: 150px; padding:10px;" id="viewMessage"></div>
			</div>
			<div class="modal-footer" >
				 <div class="col"><button id="send" class="btn maincolor btn-block" data-toggle="modal" data-backdrop="static" data-target="#sendMessage" >답장하기</button></div>
        <div class="col"><button type="button" class="btn maincolor-re btn-block" data-dismiss="modal" id="closeMessage"><span class="plan">닫기</span></button></div>
			</div>
		</div>
	</div>
</div>
<!-- 쪽지 읽기 -->		





<!-- 답장 쓰기  -->
<form  method="POST" action="${contextPath}/message/sendMessage" onsubmit="return messageValidate();">
	<div id="sendMessage" class="modal fade">
		<div class="modal-dialog modal-confirm">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">받는사람 : <span id="receiver" style="font-size:19px;"></span>  </h5> 
						<input type="hidden" name="memberNo" id="hiddenMemberNo">
					</div>
					<div class="modal-body" style="padding-bottom : 1px;">
						<textarea class="messageText" id="writeMessage" name="content" style="border: 1px solid black; height: 150px; width: 100%; resize: none;"></textarea>
						<div id="messageCnt" class="float-right" style="font-size:13px;">(0/100)</div>
					</div>
					<div class="modal-footer">
						<div class="col">
							<button type="submit" class="btn maincolor btn-block">
								<span class="plan">전송</span>
							</button>
						</div>
						<div class="col">
							<button type="button" class="btn maincolor-re btn-block" data-dismiss="modal">
								<span class="plan">닫기</span>
							</button>
						</div>
					</div>
				</div>
			</div>
	</div>  
</form> 
<!-- 답장 쓰기  -->






		<jsp:include page="../common/footer.jsp" />
		
		<script>
	
		// 페이지 새로고침
		function refreshFunction(){  
 	 		location.reload();
		}
		
		
		
		// 한 행을 클릭하면 해당 메세지 읽기
			$("#messageTable > tbody #messageContent").on("click",function(){
				
				var messageNo = $(this).parent().children().eq(0).children("input").val();
				var sender = $(this).parent().children().eq(1).text();
				var senderNo = $(this).parent().children("input").eq(0).val();
				var viewMessage = $(this).parent().children().eq(2).text();
				
				//var readTag= $("<i>").addClass("far fa-envelope-open");
				//var readText = $("<span>").text("읽음");
				///console.log("readStatus : " + readStatus);
				// $("#readStatus").addClass("page-item active");
				
				$("#sender").text(sender);
				$("#viewMessage").text(viewMessage);

				$.ajax({
					url : "${contextPath}/message/updateReadStatus/" + messageNo,
					type : "post",
					data : {"messageNo":messageNo},
					success : function(result){
						
						$("#readMessage").modal("show");
						
						$("#receiver").text(sender);
						$("#hiddenMemberNo").val(senderNo);
						
					},error :function(){
						console.log("메세지 읽기 실패");
					}
				
				});
				
				
			});		
		
		
		// 메세지 읽고 닫기 누르면 페이지 새로고침
		$("#closeMessage").on("click",function(){
			refreshFunction();
		})
		
		
		
		// 답장버튼을 누르면,,답장한다?
		$("#send").on("click", function(){
			
			$("#readMessage").modal("hide");
			
/* 			var memberNo = $("").parent()children().eq(5).val();
			var receiver = sender;
			
			console.log(memberNo);
			console.log(receiver);
			
				$("#receiver").text(receiver);
				$("#hiddenMemberNo").val(memberNo); */
			
				$("#sendMessage").modal("show");
		});

		

		
		
		
		// 닉네임 누르면 쪽지보내기
		$("#messageTable > tbody #sendNickName").on("click",function(){
			
			var memberNo = $(this).parent().parent().children().eq(5).val();
			var receiver = $(this).parent().parent().children().eq(1).text();
			
			$("#receiver").text(receiver);
			$("#hiddenMemberNo").val(memberNo);
		
			$("#sendMessage").modal("show");
			
		});
		
		
		
		// 메세지 유효성 검사
		function messageValidate(){
			
			if($(".messageText").val().trim().length ==0){
				swal("내용을 입력해 주세요");
				$(".messageText").focus();
				return false;
			}
		}		
		
		
		// 메세지 쓰기 글자수 제한
		$(document).ready(function(){
			$("#writeMessage").on('input',function(){
					$("#messageCnt").html("("+$(this).val().length+" / 100)");
					if($(this).val().length>100){
						$(this).val($(this).val().substring(0,100));
						$("#messageCnt").html("(100/100)");
					}
			});
		});
		
		
		
		
		
		// 체크박스 전체 선택
		$(document).ready(function(){
			$("#checkAll").click(function(){
				
				if($("#checkAll").prop("checked")){
					$("input[name=chk]").prop("checked",true);
				}else{
					$("input[name=chk]").prop("checked",false);
				}
			});
		});
		
		
		
		// 체크된 메세지 삭제
			function deleteBtn(){
				
			var messageNo = [];
			$("input[name=chk]:checked").each(function(){
				messageNo.push($(this).val());
			});
			
			
			if(confirm("정말로 삭제하시겠습니까?")){
				$.ajax({
					url : "${contextPath}/message/deleteReceiveMessage",
					type : "post",
					data : {"messageNo":messageNo},
					success : function(result){
						if(result>0){
							
							refreshFunction();
						}
					},
					error : function(){
						console.log("쪽지 삭제 실패");
					}
				});
			}
		}	
		
		


		
		

		
		</script>
		
</body>
</html>