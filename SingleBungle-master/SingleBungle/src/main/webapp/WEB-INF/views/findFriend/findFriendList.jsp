<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만남의 광장 게시판 목록조회</title>
<style>
.boardName {
	margin-right: 10px;
}

.category {
	text-decoration: none;
	color: black;
	line-height: 54px;
}

.pagination {
	justify-content: center;
}

.board-category, .ml-auto {
	margin: 20px;
}

.boardName {
	margin-right: 40px;
}

.banner a:click {
	color: orange;
	text-weight: bold;
}

.category, .array {
	text-decoration: none;
	color: black;
	line-height: 54px;
	margin-right: 5px;
}

.icon {
	width: 13px;
}

/* 검색창 */
.search {
	text-align: center;
	margin-top: 50px;
	margin-bottom: 100px;
}

/* 페이징바 */
.flex {
	-webkit-box-flex: 1;
	-ms-flex: 1 1 auto;
	flex: 1 1 auto;
}

@media ( max-width :991.98px) {
	.padding {
		padding: 1.5rem;
	}
}

@media ( max-width :767.98px) {
	.padding {
		padding: 1rem;
	}
}

.container {
	margin-top: 100px;
}

.pagination, .jsgrid .jsgrid-pager {
	display: flex;
	padding-left: 0;
	list-style: none;
	border-radius: 0.25rem;
}

.page-item>a, .page-item>a:hover {
	color: black;
}

.pagination.pagination-rounded-flat .page-item {
	margin: 0 .25rem;
}

.pagination-success .page-item.active .page-link {
	background: #00c689;
	border-color: #00c689;
}

.pagination.pagination-rounded-flat .page-item .page-link {
	border: none;
	border-radius: 50px;
}

.col-md-4 {
	flex: none !important;
	max-width: none !important;
}

#searchForm {
	position: relative;
}

#searchForm>* {
	top: 0;
}

#list-table th {
	text-align: center;
}

#list-table td:not(:nth-of-type(3)) {
	text-align: center;
}

#list-table td {
	text-align: center;
}

.list-wrapper {
	min-height: 540px;
}

#list-table td:hover {
	cursor: pointer;
}

/* 세로 가운데 정렬*/
#list-table td {
	vertical-align: middle;
	/* vertical-align : inline, inline-block 요소에만 적용 가능(td는 inline-block)*/
}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />

	<!-- 주소 조합 작업 -->
	<c:choose>
		<c:when test="${!empty fSearch}">

			<c:if test="${!empty fSearch.ct}">
				<c:set var="category" value="ct=${fSearch.ct}&" />
				<c:set var="searchStr" value="${category}" />
			</c:if>

			<c:if test="${!empty fSearch.sort}">
				<c:set var="sort" value="sort=${fSearch.sort}&" />
				<c:set var="searchStr" value="${category}${sort}" />
			</c:if>

			<c:if test="${!empty fSearch.sv}">
				<c:set var="sk" value="sk=${fSearch.sk}&" />
				<c:set var="sv" value="sk=${fSearch.sv}" />

				<c:set var="searchStr" value="${category}${sort}sk=${fSearch.sk}&sv=${fSearch.sv}&" />
			</c:if>

			<c:url var="pageUrl" value="search?${searchStr}" />

			<!-- 목록으로 버튼에 사용할 URL 저장 변수 session scope에 올리기 -->
			<c:set var="returnListURL" value="${contextPath}/findFriend/${pageUrl}cp=${pInfo.currentPage}" scope="session" />
		</c:when>

		<c:otherwise>
			<c:url var="pageUrl" value="?" />
			<!-- 목록으로 버튼에 사용할 URL 저장 변수 session scope에 올리기 -->
			<c:set var="returnURL" value="${contextPath}/findFriend/list${pageUrl}cp=${pInfo.currentPage}" scope="session" />
		</c:otherwise>
	</c:choose>


	<div class="container my-5">

		<!-- 게시판 이름/카테고리 -->
		<div class="row py-5">
			<div class="col-lg-12 mx-auto">
				<div class="text-black banner">
					<h1 class="boardName float-left">만남의 광장</h1>
					<a class="category" id="0" href="search?ct=0&${sort}${sk}${sv}">전체</a>  |&nbsp;
					<a class="category" id="1" href="search?ct=1&${sort}${sk}${sv}">맛집</a>  |&nbsp;
					<a class="category" id="2" href="search?ct=2&${sort}${sk}${sv}">문화생활</a>  |&nbsp;
					<a class="category" id="3" href="search?ct=3&${sort}${sk}${sv}">동네친구</a>

					<%-- <div class="listTest float-right">
						<a class="array" id="newSort" href="search?${category}sort=new&${sk}${sv}">최신순<img class="icon" src="${contextPath}/resources/images/arrow.png" /></a>
						<a class="array" id="likeSort" href="search?${category}sort=like&${sk}${sv}">좋아요순<img class="icon" src="${contextPath}/resources/images/arrow.png" /></a>
					</div> --%>
					<hr>
				</div>
			</div>
		</div>
		<!-- End -->

		<div class="list-wrapper">
			<table class="table table-hover table-striped my-5" id="list-table">
				<thead>
					<tr>
						<th>게시글 번호</th>
						<th>지역</th>
						<th>카테고리</th>
						<th>모집성별</th>
						<th>제목</th>
						<th>모집인원</th>
						<th>닉네임</th>
						<th>작성일</th>
					</tr>
				</thead>

				<%-- 게시글 목록 출력 --%>
				<tbody>
					<c:choose>
						<c:when test="${empty fList}">
							<tr>
								<td colspan="7">작성된 글이 없습니다.</td>
							</tr>
						</c:when>

						<c:otherwise>
							<%-- 조회된 게시글 목록이 있을 때 --%>
							<c:forEach var="friend" items="${fList}">
								<tr>
									<%-- 게시글 번호 --%>
									<td>${friend.friendNo}</td>
									<%-- 지역 --%>
									<td>${friend.location1}</td>
									<%-- 카테고리 --%>
									<td>
										<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='	
											<c:if test="${friend.categoryNm == '맛집'}">background-color: #d2add9;</c:if>	
											<c:if test="${friend.categoryNm == '문화생활'}">background-color: #ef8694;</c:if>	
											<c:if test="${friend.categoryNm == '동네친구'}">background-color: #f6b06b;</c:if> '>${friend.categoryNm}</div>
									</td>
									<%-- 성별 --%>
									<td>
										<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='background-color: #787878;'>	
											<c:if test="${friend.gender == 'W'}">여</c:if>	
											<c:if test="${friend.gender == 'M'}">남</c:if>	
											<c:if test="${friend.gender == 'F'}">무관</c:if>	
										</div>
									</td>
									<%-- 제목 --%>
									<td>${friend.friendTitle}</td>
									<%-- 모집인원 --%>
									<td>${friend.apply}/${friend.capacity}</td>
									<%-- 닉네임 --%>
									<td>${friend.nickname}</td>
									<%-- 작성일 --%>
									<td>
										<%-- 날짜 출력 모양 지정 --%> <fmt:formatDate var="createDt" value="${friend.createDt}" pattern="yyyy-MM-dd" /> <fmt:formatDate var="now" value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" /> <c:choose>
											<c:when test="${createDt != now}">
													${createDt}
												</c:when>
											<c:otherwise>
												<fmt:formatDate value="${friend.createDt}" pattern="HH:mm" />
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

		<%-- 로그인이 되어있고 회원등급이 1등급일 경우 --%>
		<c:if test="${!empty loginMember && loginMember.memberGrade == 'F'}">
			<div class="text-right">
				<a class="btn float-right maincolor" href="${contextPath}/findFriend/insert">글쓰기</a>
			</div>
		</c:if>

		<%-- --------------------------------------------- pagination --------------------------------------------- --%>

		<div class="padding">
			<%-- 화살표에 들어갈 주소를 변수로 생성 --%>
			<c:set var="firstPage" value="${pageUrl}cp=1" />
			<c:set var="lastPage" value="${pageUrl}cp=${pInfo.maxPage}" />

			<fmt:parseNumber var="c1" value="${(pInfo.currentPage - 1) / 10 }" integerOnly="true" />
			<fmt:parseNumber var="prev" value="${ c1 * 10 }" integerOnly="true" />
			<c:set var="prevPage" value="${pageUrl}cp=${prev}" />


			<fmt:parseNumber var="c2" value="${(pInfo.currentPage + 9) / 10 }" integerOnly="true" />
			<fmt:parseNumber var="next" value="${ c2 * 10 + 1 }" integerOnly="true" />
			<c:set var="nextPage" value="${pageUrl}cp=${next}" />



			<div class="container d-flex justify-content-center">
				<div class="col-md-4 col-sm-6 grid-margin stretch-card">
					<nav>
						<ul class="pagination d-flex justify-content-center flex-wrap pagination-rounded-flat pagination-success">

							<c:if test="${pInfo.currentPage > pInfo.pageSize}">
								<li class="page-item"><a class="page-link" href="${firstPage}" data-abc="true"><i class="fas fa-angle-double-left"></i></a></li>
								<li class="page-item"><a class="page-link" href="${prevPage}" data-abc="true"><i class="fa fa-angle-left"></i></a></li>
							</c:if>


							<!-- 페이지 목록 -->
							<c:forEach var="page" begin="${pInfo.startPage}" end="${pInfo.endPage}">
								<c:choose>
									<c:when test="${pInfo.currentPage == page}">
										<li class="page-item active">
											<a class="page-link" data-abc="true">${page}</a>
										</li>
									</c:when>

									<c:otherwise>
										<li class="page-item">
											<a class="page-link" href="${pageUrl}cp=${page}" data-abc="true">${page}</a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>

							<c:if test="${next <= pInfo.maxPage}">
								<li class="page-item"><a class="page-link" href="${nextPage}" data-abc="true"><i class="fa fa-angle-right"></i></a></li>
								<li class="page-item"><a class="page-link" href="${lastPage}" data-abc="true"><i class="fas fa-angle-double-right"></i></a></li>
							</c:if>
						</ul>
					</nav>

				</div>
			</div>
		</div>

		<%-- ----------------------------------------------- search ----------------------------------------------- --%>
		<div class="search">
			<form action="${contextPath}/findFriend/search" method="GET">
				<select name="sk" id="searchOption" style="width: 100px; height: 36px; display: inline-block;">
					<option value="title">제목</option>
					<option value="writer">작성자</option>
					<option value="titcont">제목+내용</option>
					<option value="writer">닉네임</option>
				</select> <input type="text" name="sv" class="form-control" style="width: 25%; display: inline-block;">
				<button class="form-control btn btn-success" id="searchBtn" type="submit" style="width: 100px; display: inline-block; margin-bottom: 5px;">검색</button>
				
				<!-- 있으면 값 세팅 -->
				<input type="hidden" name="ct" value="${param.ct}">
				<input type="hidden" name="sort" value="${param.ct}">
				
			</form>
		</div>
	</div>

	<jsp:include page="../common/footer.jsp" />

	<script>
		// 게시글 상세보기 기능(jquery를 통해 작업)
		$("#list-table td").on("click", function() {

			var friendViewURL = $(this).parent().children().eq(0).text();

			location.href = friendViewURL;

		});
		
		// 검색 파라미터 유지
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
			$("select[name=sk] > option").each(function(index, item){
				if($(item).val() == "${fSearch.sk}"){
					$(this).prop("selected", true);
				}
			});
			
			// 검색 내용
			$("input[name=sv]").val("${fSearch.sv}");
			
		});
	</script>

</body>
</html>
