<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만남의 광장 게시판 상세조회</title>
<style>
#board-area {
	margin-bottom: 100px;
}

#board-content {
	padding-bottom: 150px;
}

#date-area {
	font-size: 12px;
	line-height: 12px
}

#date-area>p {
	margin: 0
}

.boardImgArea {
	height: 300px;
}

.boardImg {
	width: 100%;
	height: 100%;
	max-width: 300px;
	max-height: 300px;
	margin: auto;
}

#content-main {
	margin: 100px auto;
}

/* 이미지 화살표 색 조정
	-> fill='%23000' 부분의 000을
	   RGB 16진수 값을 작성하여 변경 가능 
	 */
.carousel-control-prev-icon {
	background-image:
		url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23000' viewBox='0 0 8 8'%3E%3Cpath d='M5.25 0l-4 4 4 4 1.5-1.5-2.5-2.5 2.5-2.5-1.5-1.5z'/%3E%3C/svg%3E")
		!important;
}

.carousel-control-next-icon {
	background-image:
		url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23000' viewBox='0 0 8 8'%3E%3Cpath d='M2.75 0l-1.5 1.5 2.5 2.5-2.5 2.5 1.5 1.5 4-4-4-4z'/%3E%3C/svg%3E")
		!important;
}

.ctgr, .titleArea>span, .chat, .apply, .cancelApply {
	margin-right: 10px;
	margin-bottom: 10px;
}

.image {
	width: 30px;
	height: 30px;
}

.personnel {
	line-height: 35px;
}

.hr {
	clear: both;
}

body {
	background: #eee;
}

.date {
	font-size: 11px;
}

.comment-text {
	font-size: 12px;
}

.fs-12 {
	font-size: 12px;
}

.shadow-none {
	box-shadow: none;
}

.cursor:hover {
	color: blue;
}

.cursor {
	cursor: pointer;
}

.media img {
	width: 30px;
	height: 30px;
}

/* 댓글 등록/취소 버튼  */

.maincolor1{
    color: #ffffff !important; 
    background-color:#4ab34a !important;
    border: 1px solid #4ab34a !important;
}
.maincolor1:hover{
    color: #ffffff !important; 
    background-color:#4ca975 !important;
    border: 1px solid #4ca975 !important;
}

/* 버튼 반대로 : 흰 바탕, 주황 테두리 */
.maincolor-re1{
        color: #4ab34a !important;
        background-color: #ffffff !important;
        border: 1px solid #4ab34a !important;
}
.maincolor-re1:hover{
    color: #ffffff !important; 
    background-color:#4ca975 !important;
    border: 1px solid #4ca975 !important;
}


/* 댓글 수정 삭제 버튼  */
.maincolor2{
    color: #228b22 !important; 
    background-color: !important;
    border: none !important;
}
.maincolor2:hover{
    color: #4ca975 !important; 
    border: none !important;
    cursor : pointer;
}

/* 버튼 반대로 : 흰 바탕, 주황 테두리 */
.maincolor-re2{
        color: #228b22 !important;
        background-color: none !important;
        border: none !important;
}
.maincolor-re2:hover{
    color: #4ca975 !important; 
    border: none !important;
    cursor : pointer;
}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container" id="content-main">
	
		<div>
			<div>
				<h2 style="margin-top: 5px;">
					<%-- 카테고리 스타일 지정 --%>
					<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='
						<c:if test="${findFriend.categoryNm == '맛집'}">background-color: #d2add9;</c:if> 
						<c:if test="${findFriend.categoryNm == '문화생활'}">background-color: #ef8694;</c:if>
						<c:if test="${findFriend.categoryNm == '동네친구'}">background-color: #f6b06b;</c:if> '>${findFriend.categoryNm}</div>
					
					<%-- 성별 스타일 지정 --%>
					<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='background-color: #787878;'>	

						<c:if test="${findFriend.gender == 'W'}">여</c:if>	
						<c:if test="${findFriend.gender == 'M'}">남</c:if>	
						<c:if test="${findFriend.gender == 'F'}">무관</c:if>	
					</div>	

					${findFriend.friendTitle}
				</h2>
			</div>

			<hr class="hr">

			<div class="titleArea row mb-3 form-row">
				<div class="col-md-12">
				
					<div class="boardInfo float-left"> 
						<c:if test="${findFriend.memGrade == 'F'}"><img src="${contextPath}/resources/images/grade1.png" width="30" height="30"></c:if>
						<c:if test="${findFriend.memGrade == 'S'}"><img src="${contextPath}/resources/images/grade2.png" width="30" height="30"></c:if>
						<c:if test="${findFriend.memGrade == 'T'}"><img src="${contextPath}/resources/images/grade3.png" width="30" height="30"></c:if>
						<c:if test="${findFriend.memGrade == 'G'}"><img src="${contextPath}/resources/images/gradeG.png" width="30" height="30"></c:if>
						<span>${findFriend.nickname}</span>&nbsp;
				  </div>
			  	
					<div class="boardInfo float-left" id="createDt" style="color: gray"> 
						<%-- 날짜 출력 모양 지정 --%> 
						<fmt:formatDate var="createDt" value="${findFriend.createDt}" pattern="yyyy-MM-dd" /> 
						<fmt:formatDate var="now" value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" /> 
							<c:choose>
								<c:when test="${createDt != now}">
									${createDt}
								</c:when>
							<c:otherwise>
								<fmt:formatDate value="${findFriend.createDt}" pattern="HH:mm" />
							</c:otherwise>
						</c:choose>
					</div>

					<div class="float-right">
						<i class="far fa-eye"></i> ${findFriend.readCount}
					</div>
				</div>
			</div>

			<div class="titleArea row mb-3 form-row">
				<div class="col-md-12">
					<img src="${contextPath}/resources/images/placeholder.png" width="20" height="20">
					<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='background-color: burlywood;'>${findFriend.location1}</div>&nbsp;
					<span>${findFriend.location2}</span>&nbsp;&nbsp;
					<img src="${contextPath}/resources/images/friendCalendar.png" width="20" height="20">&nbsp;<span>${findFriend.meetingDate}</span>&nbsp;&nbsp;
					<img src="${contextPath}/resources/images/friendClock.png" width="20" height="20">&nbsp;<span>${findFriend.meetingTime}</span>&nbsp;&nbsp;
					<img src="${contextPath}/resources/images/friendCapacity.png" width="25" height="25">&nbsp;<span id="applyCount"></span><span>/${findFriend.capacity}</span>&nbsp;&nbsp;
						<c:if test="${loginMember.memberNo != findFriend.memNo }">
								<!-- 쪽지 보내기 임시   -->
								<div class="text-center" style="display : inline-block">
									<!-- Button HTML (to Trigger Modal) -->
									<button id="send" class="btn" data-toggle="modal" data-backdrop="static" data-target="#sendMessage" style="padding:0px; margin-bottom : 4px;">
										<img src="${contextPath}/resources/images/message1.png" width="25" height="25">&nbsp;<span>쪽지보내기</span>
									</button>
								</div>
							</c:if>		
				</div>
			</div>

			<br>

			<div class="titleArea">
				<c:if test="${findFriend.memNo != loginMember.memberNo}">
					<button type="button" class="btn btn-primary float-right report maincolor-re"><img src="${contextPath}/resources/images/siren.png" width="20" height="20" id="siren">신고</button>
				</c:if>
				
				<c:if test="${findFriend.memNo != loginMember.memberNo}">
					<button type="button" id="applyBtn" class='btn maincolor float-right apply <c:if test="${checkApply == 0}">insertApply</c:if>'>
					<c:if test="${checkApply == 0}">참여신청</c:if>
					<c:if test="${checkApply == 1}">참여취소</c:if>
					</button>
				</c:if>
				
				<c:if test="${findFriend.memNo == loginMember.memberNo}">
					<input type="hidden" class='btn btn-primary float-right apply maincolor'>
				</c:if>
				
				<!-- chat button -->
				<button type="button" class="btn btn-primary float-right chat maincolor">채팅하기</button>
 
			</div>
			<hr class="hr">

			<!-- Content -->
			<div id="board-content">${findFriend.friendContent}</div>

			<hr>

			<jsp:include page="reply.jsp" />

			<div>
				<div class="text-center">

					<%-- 북마크나 주소로 인한 직접 접근 시 목록으로 버튼 경로 지정 --%>
					<c:if test="${empty sessionScope.returnListURL}">
						<c:set var="returnListURL" value="list" scope="session" />
					</c:if>
					
					<!-- 메인에서 게시판 더보기 누른 후 글에서 목록으로 버튼 눌렀을 시 해당 게시판의 list로 가게하기 -->
          <c:set var="referer" value="${header.referer}"/>
          <c:set var="a" value="${fn:indexOf(referer,'/')}"/>
          <c:set var="l" value="${fn:length(referer)}"/>
          <c:set var="referer" value="${fn:substring(referer, a+2, l)}"/>
          
          <c:set var="a" value="${fn:indexOf(referer,'/')}"/>
          <c:set var="l" value="${fn:length(referer)}"/>
          <c:set var="referer" value="${fn:substring(referer, a, l-1)}"/>
          
          <c:if test="${referer == contextPath}">
           <c:set var="returnListURL" value="list"/>
          </c:if>
					
					<br> 
					
					<a class="btn insert-list2 maincolor" href="${returnListURL}">목록으로</a>
					
					<!-- 로그인된 회원이 글 작성자인 경우 -->
					<c:if test="${(loginMember != null) && (findFriend.memNo == loginMember.memberNo)}">
						<c:url var="updateUrl" value="${findFriend.friendNo}/update" />
						<a href="${updateUrl}" class="btn ml-1 mr-1 maincolor">수정</a>
						<button id="deleteBtn" class="btn maincolor-re">삭제</button>
					</c:if>
				</div>
			</div>

		</div>
	</div>
	
	
	
	
<!-- 쪽지!!!!!!!!!!!!!!  -->	
<!-- Modal HTML -->

			<form  method="POST" action="${contextPath}/message/sendMessage" onsubmit="return messageValidate();">
				<div id="sendMessage" class="modal fade">
					<div class="modal-dialog modal-confirm">
						
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">받는사람 :  ${findFriend.nickname} </h5> 
									<input type="hidden" name="memberNo" value="${findFriend.memNo}">
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

	
	
	
	
	
	
	<jsp:include page="../common/footer.jsp" />

	<script>
		var friendNo = ${findFriend.friendNo};
		var capacity = ${findFriend.capacity};
		var friendGender = "${findFriend.gender}";
		var loginMemberGender = "${loginMember.memberGender}";
		
		// 페이지 로딩 완료 시 참여인원 카운트
		$(function(){
			selectApplyCount();			
		});
		
		function selectApplyCount(){
			
			$.ajax({
				url : "${contextPath}/findFriend/selectApplyCount/" + friendNo,
				success : function(result){
					
					console.log(result)
					
					$("#applyCount").text(result);
					
					if(result == capacity){
						$("#applyBtn").text("모집마감");
						$("#applyBtn").prop("disabled", true);
					}
					
				}, error : function(){
					console.log("참여인원 카운트 실패");
				}
				
			});
			
		};
		
	
		// 참여신청 시
		$("#applyBtn").on("click", function(){
			
			var applyArray = $(".apply").attr("class").split(" ");
			
			console.log(friendGender);
			console.log(loginMemberGender);
			
			if(friendGender == "W"){
				if(loginMemberGender != "W"){
					swal({icon : "info", title : "여자 회원만 참여 신청할 수 있습니다."});
				}else{
					if(applyArray[4] == "insertApply"){
						
						$.ajax({
							url : "${contextPath}/findFriend/insertApply/" + friendNo,
							success : function(result){
								
								if(result > 0){
									swal({icon : "success", title : "참여 신청 성공!"});
									
									selectApplyCount();	
									
									$("#applyBtn").text("참여취소");
									$(".apply").toggleClass("insertApply");
								}
								
							}, error : function(){
								console.log("참여 신청 실패");
							}
							
						});
						
					}else{
						
						$.ajax({
							url : "${contextPath}/findFriend/deleteApply/" + friendNo,
							success : function(result){
								
								if(result > 0){
									swal({icon : "success", title : "참여가 취소되었습니다."});
									
									selectApplyCount();	
									
									$("#applyBtn").text("참여신청");
									$(".apply").toggleClass("insertApply");
								}
								
							}, error : function(){
								console.log("참여 취소 실패");
							}
							
						});
						
					}
				}
			}
			
			if(friendGender == "M"){
				if(loginMemberGender != "M"){
					swal({icon : "info", title : "남자 회원만 참여 신청할 수 있습니다."});
				}else{
					if(applyArray[4] == "insertApply"){
						
						$.ajax({
							url : "${contextPath}/findFriend/insertApply/" + friendNo,
							success : function(result){
								
								if(result > 0){
									swal({icon : "success", title : "참여 신청 성공!"});
									
									selectApplyCount();	
									
									$("#applyBtn").text("참여취소");
									$(".apply").toggleClass("insertApply");
								}
								
							}, error : function(){
								console.log("참여 신청 실패");
							}
							
						});
						
					}else{
						
						$.ajax({
							url : "${contextPath}/findFriend/deleteApply/" + friendNo,
							success : function(result){
								
								if(result > 0){
									swal({icon : "success", title : "참여가 취소되었습니다."});
									
									selectApplyCount();	
									
									$("#applyBtn").text("참여신청");
									$(".apply").toggleClass("insertApply");
								}
								
							}, error : function(){
								console.log("참여 취소 실패");
							}
							
						});
						
					}
				}
			}
			
			if(friendGender == "F"){
				
				if(applyArray[4] == "insertApply"){
					
					$.ajax({
						url : "${contextPath}/findFriend/insertApply/" + friendNo,
						success : function(result){
							
							if(result > 0){
								swal({icon : "success", title : "참여 신청 성공!"});
								
								selectApplyCount();	
								
								$("#applyBtn").text("참여취소");
								$(".apply").toggleClass("insertApply");
							}
							
						}, error : function(){
							console.log("참여 신청 실패");
						}
						
					});
					
				}else{
					
					$.ajax({
						url : "${contextPath}/findFriend/deleteApply/" + friendNo,
						success : function(result){
							
							if(result > 0){
								swal({icon : "success", title : "참여가 취소되었습니다."});
								
								selectApplyCount();	
								
								$("#applyBtn").text("참여신청");
								$(".apply").toggleClass("insertApply");
							}
							
						}, error : function(){
							console.log("참여 취소 실패");
						}
						
					});
					
				}
			
			}
			
		});

		// -------------------------------------------------------------------------------------------------------------------
		// 게시글 신고창 열기
		$(".report").on("click", function() {
			
			window.open(
							'${contextPath}/findFriend/findFriendreport/${findFriend.friendNo}',
							"popup",
							"width=550, height=650, toolbars=no, scrollbars=no, menubar=no left=1000 top=200");
		
		});

		// 채팅창 열기
		$(".chat").on("click", function() {
			
			var applyArray = $(".apply").attr("class").split(" ");
			//console.log(applyArray);
			
			if(applyArray[4] == "insertApply"){
					
					swal({icon : "info", title : "참여 신청을 해주세요."});
				
			}else{
					
							window.open(
											'${contextPath}/findFriendChat/chatView/${findFriend.friendNo}',
											"popup",
											"width=600, height=700, toolbars=no, scrollbars=no, menubar=no left=1000 top=200");
							
			}
		
		});
		
		// -------------------------------------------------------------------------------------------------------------------
		
		// 게시글 삭제
		$("#deleteBtn").on("click", function(){
			
			if(confirm("삭제 하시겠습니까?")){
				
				location.href = "${findFriend.friendNo}/updateStatus";
				
			}
			
		});
		
		
		
		//----------------------------------------------------------------------------
		// 메세지 유효성 검사
		function messageValidate(){
			
			if($("#messageText").val().trim().length ==0){
				swal("내용을 입력해 주세요");
				$("#messageText").focus();
				return false;
			}
		}
		
		// 메세지 글자수 제한
		$(document).ready(function(){
				$("#writeMessage").on('input',function(){
						$("#messageCnt").html("("+$(this).val().length+" / 100)");
						if($(this).val().length>100){
							$(this).val($(this).val().substring(0,100));
							$("#messageCnt").html("(100/100)");
						}
				});
			});
		
		
	</script>

</body>
</html>
