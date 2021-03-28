<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 페이지</title>

    
    <!-- 부트스트랩 사용을 위한 css 추가 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
        integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

    <!-- 부트스트랩 사용을 위한 라이브러리 추가 -->
    <!-- 제이쿼리가 항상 먼저여야함 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
        crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/db80de430d.js" crossorigin="anonymous"></script>

        <style>
@media ( max-width :991.98px) {
	.padding {
		padding: 1.5rem
	}
}

@media ( max-width :767.98px) {
	.padding {
		padding: 1rem
	}
}

.pagination, .jsgrid .jsgrid-pager {
	display: flex;
	padding-left: 0;
	list-style: none;
	border-radius: 0.25rem
}


.pagination.pagination-rounded-flat .page-item {
	margin: 0 .25rem
}

/* 페이징 글씨 */		
.page-link {
    color: black !important; 
}

/* 페이징 선택된 글씨 */
.page-item.active .page-link{
	color: white !important;
}

.pagination-success .page-item.active .page-link {
	background: #00c689;
	border-color: #00c689
}

.pagination.pagination-rounded-flat .page-item .page-link, a {
	border: none;
	border-radius: 50px
}

tr>th, tr>td {
	text-align: center;
}

.table {
	margin-top: 30px;
}

/* span {
	margin-top: 100px;
} */

#sideMenu {
	margin-top: 50px !important;
	position: relative;
	transition: margin-top 1s ease-in-out 0s, right .5s;
}

#sideTitle, #sideText {
	text-align: center;
}

/* .nav-link:hover {
	background: #f5f5f5;
} */

.hidden {
	display: none;
}

.container1{
min-height : 1050px;
}

.col-md-4 {
	flex: none !important;
	max-width: none !important;
}
</style>

</head>
<body>
    
    <jsp:include page="../common/header.jsp" />
    
     <div class="container container1 mt-5 pt-5">
        <div class="row">
           <jsp:include page="sideMenu.jsp" />
            <div class="col-sm-9">
                
                <div class="myBoard">
                    <span><h4>내가 쓴 글</h4></span>

                
                <table class="table table-striped" id="list-table">
                    <thead>
                        <tr>
                            <th>게시판</th>
                            <th>제목</th>
                            <th>작성일</th>
                        </tr>
                    </thead>

                    <tbody>
                    <c:if test="${empty boardList }">
							<tr>
								<td colspan="6">존재하는 게시글이 없습니다.
							</tr>
						</c:if>
						<c:if test="${!empty boardList }">
							<c:forEach var="board" items="${boardList}" varStatus="vs">
                        <tr>
                        <td class="hidden">${board.boardNo }</td>
                        <td class="hidden">${board.boardCode }</td>
                        
                            <td>
								<c:choose>
									<c:when test="${board.boardCode == 1}">자유게시판</c:when>
									<c:when test="${board.boardCode == 2}">후기게시판</c:when>
									<c:when test="${board.boardCode == 3}">고객센터</c:when>
									<c:when test="${board.boardCode == 4}">이벤트</c:when>
									<c:when test="${board.boardCode == 6}">맛집게시판</c:when>
									<c:when test="${board.boardCode == 7}">친구찾기</c:when>
									<c:when test="${board.boardCode == 8}">사고팔고</c:when>
								</c:choose>
							</td>
                            <td class="boardTitle">${board.boardTitle}</td>
                            <td>${board.boardCreateDate }</td>
                        </tr>
                        </c:forEach>
                        </c:if>
                    </tbody>
                </table>

                
                   
                         <div class="padding">
					<c:set var="firstPage" value="?cp=1" />
					<c:set var="lastPage" value="?cp=${pInfo.maxPage}" />

					<fmt:parseNumber var="c1" value="${(pInfo.currentPage - 1) / 10 }"
						integerOnly="true" />
					<fmt:parseNumber var="prev" value="${ c1 * 10 }" integerOnly="true" />
					<c:set var="prevPage" value="?cp=${prev}" />


					<fmt:parseNumber var="c2" value="${(pInfo.currentPage + 9) / 10 }"
						integerOnly="true" />
					<fmt:parseNumber var="next" value="${ c2 * 10 + 1 }"
						integerOnly="true" />
					<c:set var="nextPage" value="?cp=${next}" />


					<div class="container d-flex justify-content-center">
						<div class="col-md-4 col-sm-6 grid-margin stretch-card">
							<nav>
								<ul
									class="pagination d-flex justify-content-center flex-wrap pagination-rounded-flat pagination-success">

									<c:if test="${pInfo.currentPage > pInfo.pageSize}">
										<li class="page-item"><a class="page-link"
											href="${firstPage }" data-abc="true">&laquo;</a></li>
										<li class="page-item"><a class="page-link"
											href="${prevPage }" data-abc="true">&lt;</a></li>
									</c:if>


									<!-- 페이지 목록 -->
									<c:forEach var="page" begin="${pInfo.startPage}"
										end="${pInfo.endPage}">
										<c:choose>
											<c:when test="${pInfo.currentPage == page }">
												<li class="page-item active"><a class="page-link"
													data-abc="true">${page}</a></li>
											</c:when>

											<c:otherwise>
												<li class="page-item"><a class="page-link"
													href="?cp=${page}" data-abc="true">${page}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>


									<c:if test="${next <= pInfo.maxPage}">
										<li class="page-item"><a class="page-link"
											href="${nextPage }" data-abc="true">&gt;</a></li>
										<li class="page-item"><a class="page-link"
											href="${lastPage }" data-abc="true">&raquo;</a></li>
									</c:if>
								</ul>
							</nav>

						</div>
					</div>
				</div>
                    
                </div>


                <div class="myReply">
                    <span><h4>내가 쓴 댓글</h4></span>

                
                <table class="table table-striped" id="list-table2">
                    <thead>
                        <tr>
                            <th>게시판</th>
                            <th>댓글 남긴 게시글</th>
                            <th>작성일</th>
                        </tr>
                    </thead>

                    <tbody>
                    
                    <c:if test="${empty replyList }">
							<tr>
								<td colspan="6">존재하는 게시글이 없습니다.
							</tr>
						</c:if>
						<c:if test="${!empty replyList }">
							<c:forEach var="reply" items="${replyList}" varStatus="vs">
                        <tr>
                        <td class="hidden">${reply.parentBoardNo }</td>
                        <td class="hidden">${reply.boardCd }</td>
                            <td>
                            	<c:choose>
									<c:when test="${reply.boardCd == 1}">자유게시판</c:when>
									<c:when test="${reply.boardCd == 2}">후기게시판</c:when>
									<c:when test="${reply.boardCd == 3}">고객센터</c:when>
									<c:when test="${reply.boardCd == 4}">이벤트</c:when>
									<c:when test="${reply.boardCd == 6}">맛집게시판</c:when>
									<c:when test="${reply.boardCd == 7}">친구찾기</c:when>
									<c:when test="${reply.boardCd == 8}">사고팔고</c:when>
								</c:choose>
                            </td>
                            <td class="boardTitle">${reply.replyContent }</td>
                            <td>${reply.createDt }</td>
                        </tr>
                        </c:forEach>
                        </c:if>
                    </tbody>
                </table>

                
                     <div class="padding">
					<c:set var="firstPage2" value="?cp2=1" />
					<c:set var="lastPage2" value="?cp2=${pInfo2.maxPage}" />

					<fmt:parseNumber var="c1" value="${(pInfo2.currentPage - 1) / 10 }"
						integerOnly="true" />
					<fmt:parseNumber var="prev" value="${ c1 * 10 }" integerOnly="true" />
					<c:set var="prevPage2" value="?cp2=${prev}" />


					<fmt:parseNumber var="c2" value="${(pInfo2.currentPage + 9) / 10 }"
						integerOnly="true" />
					<fmt:parseNumber var="next" value="${ c2 * 10 + 1 }"
						integerOnly="true" />
					<c:set var="nextPage2" value="?cp2=${next}" />


					<div class="container d-flex justify-content-center">
						<div class="col-md-4 col-sm-6 grid-margin stretch-card">
							<nav>
								<ul
									class="pagination d-flex justify-content-center flex-wrap pagination-rounded-flat pagination-success">

									<c:if test="${pInfo2.currentPage > pInfo2.pageSize}">
										<li class="page-item"><a class="page-link"
											href="${firstPage2 }" data-abc="true">&laquo;</a></li>
										<li class="page-item"><a class="page-link"
											href="${prevPage2 }" data-abc="true">&lt;</a></li>
									</c:if>


									<!-- 페이지 목록 -->
									<c:forEach var="page" begin="${pInfo2.startPage}"
										end="${pInfo2.endPage}">
										<c:choose>
											<c:when test="${pInfo2.currentPage == page }">
												<li class="page-item active"><a class="page-link"
													data-abc="true">${page}</a></li>
											</c:when>

											<c:otherwise>
												<li class="page-item"><a class="page-link"
													href="?cp2=${page}" data-abc="true">${page}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>


									<c:if test="${next <= pInfo2.maxPage}">
										<li class="page-item"><a class="page-link"
											href="${nextPage2 }" data-abc="true">&gt;</a></li>
										<li class="page-item"><a class="page-link"
											href="${lastPage2 }" data-abc="true">&raquo;</a></li>
									</c:if>
								</ul>
							</nav>

						</div>
					</div>
				</div>
                </div>
            </div>
            
           
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
</body>
 <script>
    $(function(){
			$("#myPage").attr('class','nav-link px-4 active bg-primary text-white shadow-sm rounded-pill');
	});
    

	$("#list-table td").on("click",function(){
			var boardNo = $(this).parent().children().eq(0).text();
			
			var boardCode = $(this).parent().children().eq(1).text();
			
		  var boardViewURL = null;
		  if(boardCode == 1) boardViewURL = "${contextPath}/board/"+ boardNo;
		  else if(boardCode == 2) boardViewURL = "${contextPath}/review/view/"+ boardNo;
		  else if(boardCode == 3) boardViewURL = "${contextPath}/admin/notice/"+ boardNo;
		  else if(boardCode == 4) boardViewURL = "${contextPath}/admin/event/"+ boardNo;
		  else if(boardCode == 6) boardViewURL = "${contextPath}/cafe/"+ boardNo;
		  else if(boardCode == 7) boardViewURL = "${contextPath}/findFriend/"+ boardNo;
		  else if(boardCode == 8) boardViewURL = "${contextPath}/market/"+ boardNo;
		  
			
		location.href = boardViewURL; // 요청 전달
	
	});
	
	
	
	$("#list-table2 td").on("click",function(){
		var boardNo = $(this).parent().children().eq(0).text();
		
		var boardCode = $(this).parent().children().eq(1).text();
		
	  var boardViewURL2 = null;
	  if(boardCode == 1) boardViewURL2 = "${contextPath}/board/"+ boardNo;
	  else if(boardCode == 2) boardViewURL2 = "${contextPath}/review/view/"+ boardNo;
	  else if(boardCode == 3) boardViewURL2 = "${contextPath}/admin/notice/"+ boardNo;
	  else if(boardCode == 4) boardViewURL2 = "${contextPath}/admin/event/"+ boardNo;
	  else if(boardCode == 6) boardViewURL2 = "${contextPath}/cafe/"+ boardNo;
	  else if(boardCode == 7) boardViewURL2 = "${contextPath}/findFriend/"+ boardNo;
	  else if(boardCode == 8) boardViewURL2 = "${contextPath}/market/"+ boardNo;

	location.href = boardViewURL2; // 요청 전달

});
</script>

</html>