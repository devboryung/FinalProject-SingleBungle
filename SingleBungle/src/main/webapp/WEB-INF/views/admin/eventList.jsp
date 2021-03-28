<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 리스트</title>


<!-- Core theme CSS (includes Bootstrap)-->
<link href="${contextPath}/resources/css/resume-styles.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<style>
.boardName {
	margin-right: 40px;
}

.boardTitleBorder {
	border-bottom: gray 1px solid;
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

.viewdetail:hover {
	cursor: pointer;
}

.likeImg {
	width: 10px;
}

a:link {
	color: #000;
	text-decoration: none;
}

a:visited {
	color: #000;
}

a:hover {
	color: gray;
}

/*  페이징바 css */
body {
	background-color: #f9f9fa
}

.flex {
	-webkit-box-flex: 1;
	-ms-flex: 1 1 auto;
	flex: 1 1 auto
}

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

.padding {
	padding: 5rem
}

.container {
	margin-top: 100px
}

.pagination, .jsgrid .jsgrid-pager {
	display: flex;
	padding-left: 0;
	list-style: none;
	border-radius: 0.25rem
}

/* 페이징 글씨 */		
.page-link {
    color: black !important; 
}

/* 페이징 선택된 글씨 */
.page-item.active .page-link{
	color: white !important;
}

/* 페이징 선택된 배경색(초록) */
.pagination-success .page-item.active .page-link {
    background: #00c689;
    border-color: #00c689
}

.pagination.pagination-rounded-flat .page-item {
	margin: 0 .25rem
}

.pagination.pagination-rounded-flat .page-item .page-link, a {
	border: none;
	border-radius: 50px
}

.col-md-4 {
	flex: none !important;
	max-width: none !important;
}

.boardTitle>img {
	width: 50px;
	height: 50px;
}

#boardNo {
	display: none;
}

.img-fluid {
	width: 318px;
	height: 212px;
}

a:hover{
	cursor: pointer;
}s
</style>

<!-- summernote 사용 시 필요한 css 파일 추가 -->
<link rel="stylesheet"
	href="${contextPath}/resources/summernote/css/summernote-lite.css">

</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<div class="px-lg-5">

			<!-- 게시판 이름/카테고리 -->
			<div class="row py-5">
				<div class="col-lg-12 mx-auto">
					<div class="text-black banner">
						<h1 class="boardName float-left">이벤트</h1>
						<a class="category" href="noticeList">공지사항</a> | <a class="category" style="color:rgb(255, 200, 35)">이벤트</a>
					</div>
					<hr>
				</div>
			</div>



			<c:if test="${empty eventList }">
				<tr>
					<td colspan="6">존재하는 게시글이 없습니다.
				</tr>
			</c:if>
			<!-- End -->
			
			<%-- <c:set var="flag" value="true"/>
                               <c:forEach var="thumbnail" items="${fList }">
                              <c:if test="${hospital.hospNo == thumbnail.hospNo }">
                                    현재 출력하려는 게시글 번호와 썸네일 목록 중 부모게시글번호가 일치하는 썸네일 정보가 있다면 
                                    <img class="hospital_img"  src="${contextPath }/resources/image/uploadHospitalImages/${thumbnail.fileName}">
                                    <c:set var="flag" value="false"/>
                              </c:if>
                           </c:forEach>
                                  
                                  <c:if test="${flag == 'true'}">
                              <img class="hospital_img"  src="${contextPath }/resources/image/icon/nonImage.png">
                                  </c:if>
			 --%>

			<div class="row">
				<c:if test="${!empty eventList }">
					<c:forEach var="board" items="${eventList}" varStatus="vs">
						<!-- Gallery item -->
						<div class="col-xl-4 col-lg-4 col-md-6 mb-4 eventList">
							<div class="bg-white rounded shadow-sm">
								<span id="boardNo">${board.boardNo}</span>
								
								
								
								
									<c:set var="flag" value="true"/>
									<c:forEach items="${thList }" var="th">
										<c:if test="${th.parentBoardNo == board.boardNo }">
											<img src="${contextPath }${th.filePath}/${th.fileName}"
												class="mg-fluid card-img-top embed-responsive-item">
												<c:set var="flag" value="false"/>
										</c:if>
									</c:forEach>
									<c:if test="${flag == 'true'}">
                             			 <img src="${contextPath}/resources/images/eventImage.jpg" alt="" class="mg-fluid card-img-top embed-responsive-item">
                                  	</c:if>
								

								<div class="p-4">
									<h5>
										<a href="#" class="text-dark">${board.boardTitle}</a>
									</h5>
									<div class="categoryDetail">
										<p class="small text-muted mb-0">${board.boardCreateDate }</p>
									</div>
									<div class="categoryDetail">
										<p class="small text-muted mb-0">조회수 : ${board.readCount}</p>
									</div>
								</div>
							</div>
						</div>
						<!-- End -->
					</c:forEach>
				</c:if>



			</div>
			<c:if test="${loginMember.memberNo == 4 }">
			<a class="btn btn-success float-right" href="../admin/eventInsert">글쓰기</a>
			</c:if>

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


	</div>
	<jsp:include page="../common/footer.jsp" />

	<script>
		$(".eventList").on("click", function() {
			var boardNo = $(this).children().children().eq(0).text();
			// 게시글 목록 : /spring/board/list/1
			// 게시글 상세조회 요청 주소 조합 -> spring/board/1/글번호  (list 빠짐)
			// 절대경로
			// var boardViewURL = "${contextPath}/board/${pInfo.boardType}/"+boardNo; 
			// 상대경로
			var boardViewURL = "${contextPath}/admin/event/" + boardNo;

			console.log(boardNo);
			location.href = boardViewURL; // 요청 전달

		});
	</script>
</body>
</html>