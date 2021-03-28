<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>싱글이의 영수증</title>

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

.category:click {
	color: orange;
	text-weight: bold;
}

.viewdetail:hover {
	cursor: pointer;
}

/* 제목 */
.text-dark {
	display: block;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	font-size : 17px;
}


.infoAreaWrapper{

	padding : 24px 24px 5px 24px;
}

/* 좋아요/댓글 */
.viewArea, .replyArea {
	display: inline-block;
	font-size: 11px;
	margin-right: 5px;
}

.nickNameArea {
	clear: both;
	margin-bottom : 3px;
}

.icon {
	width: 13px;
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

.page-item>a, .page-item>a:hover {
	color: black;
}

.pagination.pagination-rounded-flat .page-item {
	margin: 0 .1rem
}

.pagination-success .page-item.active .page-link {
	background: #00c689;
	border-color: #00c689
}

.pagination.pagination-rounded-flat .page-item .page-link {
	border: none;
	border-radius: 50px;
}

.pg {
	flex: none !important;
	max-width: none !important;
}



.like2 {
	background-size : 11px;
	background-image: url('${contextPath}/resources/images/like2.png');
	background-repeat: no-repeat;
}

.maincolor-re1{
    color: #4ab34a !important;
    background-color: #ffffff !important;
    border: none !important;
}

.maincolor-re1:hover{
    color: #ffffff !important; 
    background-color:#4ab34a !important;
    border: 1px solid #4ab34a !important;
}

</style>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 부트스트랩 사용을 위한 css 추가 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">


</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	<!-- 주소 조합 작업  -->
	<c:choose>
		<c:when test="${!empty rSearch }">
		
				<c:if test="${!empty rSearch.ct }">
					<c:set var="category" value="ct=${rSearch.ct}&"/>
					<c:set var="searchStr"  value= "${category}"/>
				</c:if>
			
				<c:if test="${!empty rSearch.sort }">
					<c:set var="sort" value="sort=${rSearch.sort}&"/>
					<c:set var="searchStr" value="${category }${sort }"/>
				</c:if>
			
			
			<c:if test="${!empty rSearch.sv}">
				<c:set var="sk" value="sk=${rSearch.sk}&"/>
				<c:set var="sv" value="sv=${rSearch.sv}"/>
			
				<c:set var="searchStr" value="${category}${sort}sk=${rSearch.sk}&sv=${rSearch.sv}&"/>
			</c:if>
			
			<c:url var="pageUrl" value="search?${searchStr}"/>
			
			<!-- 목록으로 버튼에 사용할 URL저장 변수   session scope에 올리기-->
			<c:set var="returnListURL" value="${contextPath}/review/${pageUrl}cp=${pInfo.currentPage}" scope="session" />
		</c:when>
		
		<c:otherwise>
			<c:url var="pageUrl" value="?"/>
			<!-- 목록으로 버튼에 사용할 URL저장 변수   session scope에 올리기-->
			<c:set var="returnListURL" value="${contextPath}/review/list${pageUrl}cp=${pInfo.currentPage}" scope="session" />
		</c:otherwise>
	</c:choose>

	<div class="container">

		<!-- 게시판 이름/카테고리 -->
		<div class="row py-5">
			<div class="col-lg-12 mx-auto boardTitleBorder">
				<div class="text-black banner">
					<h1 class="boardName float-left">싱글이의 영수증</h1>
					<div class="categoryArea">
						<a class="category" id="0" href="search?ct=0&${sort}${sk}${sv}">전체</a> 
						<a class="category" id="1" href="search?ct=1&${sort}${sk}${sv}">가구</a> 
						<a class="category" id="2" href="search?ct=2&${sort}${sk}${sv}">생활용품</a> 
						<a class="category" id="3" href="search?ct=3&${sort}${sk}${sv}">전자기기</a> 
						<a class="category" id="4" href="search?ct=4&${sort}${sk}${sv}">기타</a>
					</div>
					<div class="arrayArea float-right">
						<a class="array" id="newSort" href="search?${category}sort=new&${sk}${sv}">최신순<img class="icon" src="${contextPath}/resources/images/arrow.png" /></a> 
						<a class="array" id="likeSort" href="search?${category}sort=like&${sk}${sv}">좋아요순<img class="icon" src="${contextPath}/resources/images/arrow.png" /></a>
					</div>
				</div>
			</div>
		</div>
		<!-- End -->



		<div class="row">
			<c:if test="${empty rList }">
				<div class="col-lg-12">
					<h5 style="text-aline: center;">존재하는 게시글이 없습니다.</h5>
				</div>
			</c:if>


			<c:if test="${!empty rList }">
				<c:forEach var="review" items="${rList}" varStatus="vs">
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

							<div class="infoAreaWrapper">
								<h5>
									<a class="text-dark">${review.boardTitle }</a>
								</h5>
								<div class="infoArea ">
									<div class="viewArea float-left">
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
									<div class="viewArea mb-2 float-right">
										<img class="icon" src="${contextPath}/resources/images/view.png" /> ${review.readCount } &nbsp;
										
								<!-- 좋아요  -->
										<span>
													<img src="${contextPath}/resources/images/like1.png" 
													width="11" height="11" id="heart" class='likeImgs 
													<c:forEach var="like" items="${likeInfo}">
													<c:if test="${like.boardNo == review.boardNo}">like2</c:if>
													</c:forEach>'>
													<span class="likeCnt" style="font-size:12px;">${review.likeCount}</span>
												</button>					
											</span>
									</div>

								</div>
								<div class="nickNameArea d-flex  align-items-center justify-content-between rounded-pill bg-light px-3 py-2 " style="clear:both;">
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
			<!-- End -->
		</div>



		<!-- 등록하기 버튼 -->

		<!-- 로그인이 되어있고, 회원 2등급 이상일 경우 !=T -->
		<c:if test="${!empty loginMember && loginMember.memberGrade != 'T' }">
			<div class="row">
				<div class="col-lg-12 mx-auto">
					<button type="button" class="btn btn-success float-right maincolor-re" id="insertBoard">등록하기</button>
				</div>
			</div>
		</c:if>


		<!-- 페이징 -->
		<div class="page-content page-container" id="page-content">
			<div class="padding">
				<div class="row container d-flex justify-content-center">
					<div class="col-md-4 col-sm-6 grid-margin stretch-card pg">
						<nav>
							<ul class="pagination d-flex justify-content-center flex-wrap pagination-rounded-flat pagination-success" style="margin-left:40px">

							
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

		<!-- 검색창 -->

		<!--  -->
		<form action="search" class="row" id="searchForm" style="margin-bottom: 50px;">
			<div class="col-md-12">
				<div class="search">
					<select name="sk" id="searchOption" style="width: 100px; height: 36px; display: inline-block;">
						<option value="title">제목</option>
						<option value="writer">작성자</option>
						<option value="titcont">제목+내용</option>
					</select> <input type="text" name="sv" class="form-control " autocomplete="off" style="width: 25%; display: inline-block;">
					<button class="form-control btn btn-success maincolor " id="searchBtn" type="submit" style="width: 100px; display: inline-block; margin-bottom: 5px;">검색</button>
				</div>
			</div>
			<input type="hidden" name="ct" value="${param.ct }">	<!-- 있으면 값 세팅  -->
			<input type="hidden" name="sort" value="${param.sort }">
		</form>
</div>

	<jsp:include page="../common/footer.jsp" />




	<script>
		// 상세조회
		$(".viewdetail").on("click", function() {
			var boardNo = $(this).children("span#boardNo").text();

			var boardViewURL = "${contextPath}/review/" + boardNo;

			location.href = boardViewURL;
		});

		
		
		// 등록하기 버튼
		$("#insertBoard").on("click", function() {

			location.href = "insert";

		});

		
		// -------------검색 파라미터 유지-------------
		$(function(){
			
			
			// 카테고리
			if(${param.ct == '0'}){
				$("#0").css({"color":"#ffc823", "font-weight":"bold"});
			}else if(${param.ct == '1'}){
				$("#1").css({"color":"#ffc823", "font-weight":"bold"});
			}else if(${param.ct == '2'}){
				$("#2").css({"color":"#ffc823", "font-weight":"bold"});
			}else if(${param.ct == '3'}){
				$("#3").css({"color":"#ffc823", "font-weight":"bold"});
			}else if(${param.ct == '4'}){
				$("#4").css({"color":"#ffc823", "font-weight":"bold"});
			}else{ // 선택 안된 경우,,
				$("#0").css({"color":"#ffc823", "font-weight":"bold"});
			}
			
			// 정렬
			if(${param.sort == 'like'}){
				$("#likeSort").css({"color":"#ffc823", "font-weight":"bold"});
			}else {
				$("#newSort").css({"color":"#ffc823", "font-weight":"bold"});
			}
			
			
			
			// 검색 조건
			$("select[name=sk] > option").each(function(index,item){
				if($(item).val() == "${rSearch.sk}"){
					$(this).prop("selected", true);
				}
			});
			
			
			// 검색 내용
			$("input[name=sv]").val("${rSearch.sv}");
			
		});
		

		
	</script>
</body>
</html>