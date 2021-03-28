<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>싱글이의 영수증 상세조회</title>


<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.3/css/bootstrap.min.css">

<style>
.boardInfo {
	display: inline-block;
	margin-right: 15px;
}

.image {
	width: 30px;
	height: 30px;
}

/* 좋아요/댓글 */
.viewArea, .replyArea {
	display: inline-block;
	font-size: 11px;
	margin-right: 5px;
}

#likeBtn {
	border: 0px solid #ddd;
	background-color: rgba(255, 255, 255, 0);
}

.likeCnt {
	color: #6c757d;
}

.like {
	background-image: url('${contextPath}/resources/img/like2.png');
	background-repeat: no-repeat;
}


.like2 {
	background-size : 15px;
	background-image: url('${contextPath}/resources/images/like2.png');
	background-repeat: no-repeat;
}
.like3 {
	background-size : 11px;
	background-image: url('${contextPath}/resources/images/like2.png');
	background-repeat: no-repeat;
}

/* TOP3 출력 */
body {
	background: #f4f4f4;
}

.boardName {
	margin-right: 40px;
}

.card-img-top {
	height: 15rem;
}

.categoryArea, .arrayArea {
	display: inline-block;
}

.category, .array {
	text-decoration: none;
	color: black;
	line-height: 54px;
	margin-right: 5px;
}

/* 제목 */
.text-dark {
	display: block;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	font-weight: bold;
}

/* 좋아요/댓글 */
.viewArea, .replyArea {
	display: inline-block;
	font-size: 11px;
	margin-right: 5px;
}

.nickNameArea {
	clear: both;
}

.icon {
	width: 13px;
}

/* 인기게시글 */
.viewdetail:hover {
	cursor: pointer;
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

.page-item>a, .page-item>a:hover {
	color: black;
}

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


</style>

</head>


<body>
	<jsp:include page="../common/header.jsp" />


	<div class="container">
		<div class="row py-3">
			<div class="col-md-12">
				<h8> 싱글이의 영수증 </h8>
				<div class="float-right">

					<c:set var="referer" value="${header.referer}" />
					<c:set var="a" value="${fn:indexOf(referer,'/')}" />
					<c:set var="l" value="${fn:length(referer)}" />
					<c:set var="referer" value="${fn:substring(referer, a+2, l)}" />

					<c:set var="a" value="${fn:indexOf(referer,'/')}" />
					<c:set var="l" value="${fn:length(referer)}" />
					<c:set var="referer" value="${fn:substring(referer, a, l-1)}" />

					<c:if test="${referer == contextPath}">
						<c:set var="returnListURL" value="list" />


					</c:if>
					<span class="bn" style="visibility: hidden">${review.boardNo}</span>
					<a type="button" class="btn btn-primary ml-2 returnBtn maincolor" href="${returnListURL }" >목록</a>
					<c:if test="${loginMember.memberNo != review.memberNo }">
						<button type="button" class="btn btn-primary ml-2 report maincolor">신고</button>
					</c:if>
				</div>

				<h2 style="margin-top: 5px;">
					<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='
                                <c:if test="${review.categoryCode == '21'}">background-color: burlywood;</c:if>
                                <c:if test="${review.categoryCode == '22'}">background-color: #8dbe88;</c:if>
                                <c:if test="${review.categoryCode == '23'}">background-color: #5d8eb6d5;</c:if>
                                <c:if test="${review.categoryCode == '24'}">background-color: #d48a9a;</c:if> '>${review.categoryName }</div>
					${review.boardTitle }
				</h2>
			</div>
		</div>

		<div class="row no">
			<div class="col-md-12">
				<div class="boardInfo" id="writer" >
					<c:if test="${review.memeberGrade=='F' }">
							<img class="image" src="${contextPath}/resources/images/grade1.png"/>
					</c:if>
					<c:if test="${review.memeberGrade=='S' }">
							<img class="image" src="${contextPath}/resources/images/grade2.png" />
					</c:if>
					<c:if test="${review.memeberGrade=='T' }">
							<img class="image" src="${contextPath}/resources/images/grade3.png" />
					</c:if>
					 ${review.nickName }
				</div>
				<div class="boardInfo" id="createDt" style="color: gray">

					<jsp:useBean id="now" class="java.util.Date" />
					<fmt:formatDate var="createDate" value="${review.createDate }" pattern="yyyy-MM-dd" />
					<fmt:formatDate var="today" value="${now }" pattern="yyyy-MM-dd" />
					<c:choose>
						<c:when test="${createDate != today }">
								${createDate }
							</c:when>
						<c:otherwise>
							<fmt:formatDate value="${review.createDate}" pattern="HH:mm" />
						</c:otherwise>
					</c:choose>
				</div>

				<div class="infoArea float-right">
					<i class="far fa-eye"></i> ${review.readCount }
						
					<!-- 좋아요  -->
					<span>
						<button type="button" id="likeBtn" class="likeBtns" >
							<img src="${contextPath}/resources/images/like1.png" 
							width="15" height="15" id="heart" class='likeImgs 
							<c:if test="${like == 1}">like2</c:if>'>
							<span class="likeCnt">${review.likeCount}</span>
						</button>					</span>
				</div>

			</div>
		</div>

		<hr>

		<!-- 게시글 내용 -->
		<div class="row">
			<div class="col-md-12 contentArea">${review.boardContent }</div>
		</div>

		<!-- 댓글(페이지 연결하기) -->
		<jsp:include page="reviewReply.jsp"></jsp:include>


		<!-- 버튼 -->



		<c:if test="${loginMember.memberNo == review.memberNo }">
			<div class="row float-right mt-3">
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-12">
							<button type="button" id="updateBtn" class="btn btn-success maincolor-re">수정</a>
							<button type="button" id="deleteBtn" class="btn btn-danger maincolor-re">삭제</button>
						</div>
					</div>
				</div>
			</div>
		</c:if>

		<!-- 목록버튼 -->
		<div class="row  py-3" style="clear: both;">
			<div class="col-md-12 text-center ">
				<c:if test="${empty sessionScope.returnListURL }">
					<c:set var="returnListURL" value="../" scope="session" />
				</c:if>
				

				
				<a type="button" class="btn btn-success returnBtn maincolor" href="${returnListURL }" style="width: 100px; height: 40px;" >목록으로</a>

			</div>
		</div>







		<h7 style="font-weight:bold;">싱글이의 영수증 인기 게시글</h7>
		<hr>
		<div class="row" style="margin-bottom: 25px;">

			<c:if test="${!empty reviewList }">
				<c:forEach var="review" items="${reviewList}" varStatus="vs">

					<!-- Gallery item -->
					<div class="col-xl-4 col-lg-4 col-md-6 mb-4">
						<div class="bg-white rounded shadow-sm viewdetail">
							<!-- 썸네일 영역 -->
							<div class="embed-responsive embed-responsive-4by3">
								<c:set var="flag" value="true" />
								<c:forEach var="thumbnail" items="${thList}">
									<c:if test="${review.boardNo == thumbnail.parentBoardNo }">
										<img src="${contextPath}${thumbnail.filePath}/${thumbnail.fileName}" class="img-fluid card-img-top embed-responsive-item">
										<c:set var="flag" value="false" />
									</c:if>
								</c:forEach>

								<c:if test="${flag=='true'}">
									<img src="${contextPath}/resources/images/ReviewNonImages.png" class="img-fluid card-img-top embed-responsive-item">
								</c:if>
							</div>

							<div class="p-4">
								<h5>
									<a class="text-dark">${review.boardTitle }</a>
								</h5>
								<div class="infoArea">
									<div class="viewArea float-left">
										<jsp:useBean id="now2" class="java.util.Date" />
											<fmt:formatDate var="createDate" value="${review.createDate }" pattern="yyyy-MM-dd" />
											<fmt:formatDate var="today" value="${now2 }" pattern="yyyy-MM-dd" />
											<c:choose>
												<c:when test="${createDate != today }">
														${createDate }
													</c:when>
												<c:otherwise>
													<fmt:formatDate value="${review.createDate}" pattern="HH:mm" />
												</c:otherwise>
											</c:choose>
									</div>								
									<div class="viewArea mb-2 float-right">
										<img class="icon" src="${contextPath}/resources/images/view.png" /> ${review.readCount }
											<span>
													<img src="${contextPath}/resources/images/like1.png" 
													width="11" height="11" id="heart" class='likeImgs 
													<c:forEach var="like" items="${likeInfo}">
													<c:if test="${like.boardNo == review.boardNo}">like3</c:if>
													</c:forEach>'>
													<span class="likeCnt" style="font-size:12px;">${review.likeCount}</span>
												</button>					
											</span>
									</div>

								</div>
								<div class="nickNameArea d-flex  align-items-center justify-content-between rounded-pill bg-light px-3 py-2 mt-4">
									<p class="small mb-0">
										<span class="font-weight-bold price">${review.nickName }</span>
									</p>
									<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='
                            <c:if test="${review.categoryCode == '21'}">background-color: burlywood;</c:if>
                            <c:if test="${review.categoryCode == '22'}">background-color: #8dbe88;</c:if>
                            <c:if test="${review.categoryCode == '23'}">background-color: #5d8eb6d5;</c:if>
                            <c:if test="${review.categoryCode == '24'}">background-color: #d48a9a;</c:if> '>${review.categoryName }</div>
								</div>
							</div>
							<span id="boardNo" style="visibility: hidden">${review.boardNo }</span>
						</div>
					</div>

				</c:forEach>
			</c:if>

		</div>

	</div>

<%-- <c:if test="${loginMember.memberNo != review.memberNo }">
<!-- 쪽지 보내기 임시   -->
<div class="text-center">
	<!-- Button HTML (to Trigger Modal) -->
	<button id="send" class="btn" data-toggle="modal" data-backdrop="static" data-target="#sendMessage" >쪽지 보내기</button>
</div>
<!-- Modal HTML -->

			<form  method="POST" action="${contextPath}/message/sendMessage" onsubmit="return messageValidate();">
	<div id="sendMessage" class="modal fade">
		<div class="modal-dialog modal-confirm">
			
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">받는사람 :  ${review.nickName } </h5> 
						<input type="hidden" name="memberNo" value="${review.memberNo}">
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
</c:if>
 --%>



	<jsp:include page="../common/footer.jsp" />


	<script>
	// 상세조회
	$(".viewdetail").on("click",function(){
		var boardNo = $(this).children("span#boardNo").text();
		
		var boardViewURL = "${contextPath}/review/"+boardNo;
		
		location.href = boardViewURL;
	});
	
	
	// 게시글 신고
   $(".report").on("click", function(){
	   	window.name = "parentWindow";
       window.open('${contextPath}/review/reviewReport/${review.boardNo}', "popup", "width=550, height=650, toolbars=no, scrollbars=no, menubar=no left=1000 top=200");
	 });

	// 목록으로 버튼
	$(".returnBtn").on("click", function(){
		location.href = "${sessionScope.returnListURL}"
	});

	
	// 삭제 버튼
	$("#deleteBtn").on("click", function(){
		if(confirm("삭제 하시겠습니까?")){
			
			location.href = "${contextPath}/review/${review.boardNo}/delete";
		}
	});
	
	// 수정 버튼
	$("#updateBtn").on("click",function(){
		location.href= "${contextPath}/review/${review.boardNo}/update";
	});
	
	// 좋아요
		$(".likeBtns").on("click", function(){
		var boardNo = Number($(this).parents('.no').prev().find("span.bn").text());
		var likeClassArray = $(this).children().attr('class').split(" ");
		var likeClass = "like1";
		var likeImg = $(this).children(".likeImgs");
		var likeCnt = $(this).children(".likeCnt");
	
		if(likeClassArray[1] == "like2") {
			likeClass = "like2"; 
		}
		
		if(!$(this).children("img").hasClass("like2")) {
			$.ajax({
				url : "increaseLike",
				type : "post",
				data : {"boardNo" : boardNo},
				success : function(result){
					if(result > 0) {
						likeCnt.text(Number(likeCnt.text()) + 1);
						likeImg.toggleClass("like2");
					}
				}, 
				error : function(result){
					console.log("ajax 통신 오류 발생");
				}
			});
		} else{
			$.ajax({
				url : "decreaseLike",
				type : "post", 
				data : {"boardNo" : boardNo},
				success : function(result){
					if(result > 0){ // 삭제 성공
						likeCnt.text(Number(likeCnt.text()) - 1);
						likeImg.removeClass("like2");
					}
				},
				error : function(result){
					console.log("ajax 통신 오류 발생");
				}
			});
		}
	});
	
	
	
	
	
	//----------------------------------------------------------------------------
	// 메세지 유효성 검사
/* 	function messageValidate(){
		
		if($(".messageText").val().trim().length ==0){
			swal("내용을 입력해 주세요");
			$(".messageText").focus();
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
	 */
	

	</script>



</body>
</html>