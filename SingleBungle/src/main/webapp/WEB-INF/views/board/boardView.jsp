<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일상을 말해봐 상세조회 페이지</title>
<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

<!-- Bootstrap core JS -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

<style>
/* 버튼 색상 */
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

#boardNo {
	display: none;
}

.boardInfo {
	display: inline-block;
	margin-right: 15px;
}

.nickname {
	width: 30px;
	height: 30px;
}

#view {
	width: 21px;
	height: 21px;
}
	
/* 좋아요 */
#likeBtn {
  border: 0px solid #ddd;
  background-color: rgba(255, 255, 255, 0);
}

.likeCnt {
   color: #6c757d;
}

.like2 {
	background-size : 15px;
	background-image: url('${contextPath}/resources/images/like2.png');
	background-repeat: no-repeat;
}
	
</style>

</head>
<body>
	<jsp:include page="../common/header.jsp"/>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                
                <h8>자유게시판</h8>
								<div class="float-right">
								
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
									<a type="button" class="btn maincolor-re mb-3 btn-sm insert-list1" href="${returnListURL }">목록</a>
									<!-- <button type="button" class="btn maincolor-re btn-sm mb-3 insert-list1">목록</button> -->
									
									<c:if test="${loginMember.memberNo != board.memberNo }">
									<button type="button" class="btn btn-sm mb-3 report"><img src="${contextPath}/resources/images/siren.png" width="20" height="20" id="siren">신고</button>
									</c:if>
								</div>
								<span id="boardNo">${board.boardNo}</span>
                <div id="board-area">
                    <!-- 카테고리 -->
                    <h2>
                    <div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='
                    <c:if test="${board.categoryCode == '11'}">background-color: #9ea9d7;</c:if>
                    <c:if test="${board.categoryCode == '12'}">background-color: #d2add9;</c:if>
                    <c:if test="${board.categoryCode == '13'}">background-color: #AFD485;</c:if>
                    <c:if test="${board.categoryCode == '14'}">background-color: #e1c66d;</c:if>
                    <c:if test="${board.categoryCode == '15'}">background-color: #ef8694;</c:if>
                    <c:if test="${board.categoryCode == '16'}">background-color: #f6b06b;</c:if>'>${board.categoryName}</div>
                    
                    <!-- 제목 -->
                    	${board.boardTitle}</h2>
                    <hr>
                </div>

								<div class="row no">
									<div class="col-md-12">
										<div class="boardInfo" id="writer">
											<c:if test="${board.memberGrade == 'F'}"><img class="nickname" src="${contextPath}/resources/images/grade1.png"></c:if>
											<c:if test="${board.memberGrade == 'S'}"><img class="nickname" src="${contextPath}/resources/images/grade2.png"></c:if>
											<c:if test="${board.memberGrade == 'T'}"><img class="nickname" src="${contextPath}/resources/images/grade3.png"></c:if>
											<c:if test="${board.memberGrade == 'G'}"><img class="nickname" src="${contextPath}/resources/images/gradeG.png"></c:if>
											<%-- <img class="image" id="nickname" src="${contextPath}/resources/images/profile.png" /> --%>${board.nickname}
										</div>
										<div class="boardInfo" id="createDt" style="color: gray">${board.createDate}</div>
										<div class="infoArea float-right">
											<i class="far fa-eye"></i> ${board.readCount} <span>
												<!-- 좋아요 버튼 -->
												<button type="button" id="likeBtn" class="likeBtns">
													<img src="${contextPath}/resources/images/like1.png" 
													width="15" height="15" id="heart" class='likeImgs 
													<c:if test="${like == 1}">like2</c:if>'>
													<span class="likeCnt">${board.likeCount}</span>
												</button>
											</span>
											
										</div>
									</div>
								</div>
								
								<br><br>

                <div class="board-content">
									${board.boardContent}
                </div>
                
                <br>
                <hr>
                
               	<!-- 댓글(페이지 연결하기) -->
								<jsp:include page="boardReply.jsp"></jsp:include>

								<!-- 버튼 -->
								<div class="row float-right mt-3">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12 float-right">
											
												<!-- 로그인된 회원이 글 작성자인 경우 -->
												<c:if test="${(loginMember != null) && (board.memberNo == loginMember.memberNo)}">
													<button type="button" class="btn maincolor btn-sm updateBtn">수정</button>
													<button type="button" class="btn btn-sm btn-danger deleteBtn">삭제</button>
												</c:if>
											</div>
										</div>
									</div>
								</div>
								<!-- 목록버튼 -->
								<div class="row py-3" style="clear: both;">
									<div class="col-md-12 text-center">
										<a type="button" class="btn maincolor-re1 insert-list2" href="${returnListURL }">목록으로</a>
									</div>
								</div>
										<!-- <button type="button" class="btn maincolor-re1 insert-list2">목록으로</button> -->
								

            </div>
        </div>
    </div>
    
	<jsp:include page="../common/footer.jsp"/>
	
	<script>
	 // 신고
   $(".report").on("click", function(){
	   	window.name = "parentWindow";
       window.open('${contextPath}/board/boardReport/${board.boardNo}', "popup", "width=550, height=650, toolbars=no, scrollbars=no, menubar=no left=1000 top=200");
	 });
   
	// 목록버튼
	$(".insert-list1, .insert-list2").on("click", function(){
		location.href = "${sessionScope.returnListURL}";
	});
	
	// 수정버튼
	$(".updateBtn").on("click", function(){
		location.href = "${contextPath}/board/${board.boardNo}/update";
	});
	
	// 삭제버튼
	$(".deleteBtn").on("click", function(){
		if(confirm("삭제 하시겠습니까?")){
	         location.href = "${contextPath}/board/${board.boardNo}/delete";
	  }
	});
	
	
	// 좋아요

	$(".likeBtns").on("click", function(){
	var boardNo = $(this).parents('.no').prev().prev("span").text();
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
	
	</script>
</body>
</html>