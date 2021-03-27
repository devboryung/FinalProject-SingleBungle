<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일상을 말해봐</title>
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

.boardName { margin-right: 40px; }

.category {
	color: black;
	line-height : 54px;
}

.category:hover {
	text-decoration: none;
}

#list-table > tbody > tr:hover {
	cursor: pointer;
}

/* 좋아요 이미지 */
#image {
	width: 16px;
	height: 16px;
	margin-top : -5px;
	margin-left : -3px;
}
   
/* 검색창 */
.search { 
	text-align: center; 
	margin-top : 50px;
	margin-bottom: 100px;
}

/* 페이징바 */
.col-md-4 {
  flex: none !important;
  max-width: none !important;
}

.flex {
	-webkit-box-flex: 1;
	-ms-flex: 1 1 auto;
	flex: 1 1 auto;
}

@media (max-width:991.98px) {
	.padding {
	    padding: 1.5rem;
	}
}

@media (max-width:767.98px) {
	.padding {
	    padding: 1rem;
	}
}

.container { margin-top: 100px; }

.pagination, .jsgrid .jsgrid-pager {
	display: flex;
	padding-left: 0;
	list-style: none;
	border-radius: 0.25rem;
}

.page-item > a, .page-item > a:hover { color: black; }

.pagination.pagination-rounded-flat .page-item { margin: 0 .25rem; }

.pagination-success .page-item.active .page-link {
	background: #4ab34a;
	border-color: #00c689;
}

.pagination.pagination-rounded-flat .page-item .page-link {
	border: none;
	border-radius: 50px;
}
</style>

</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	
	<!-- 주소 조합 작업  -->
	<c:choose>
		<c:when test="${!empty bSearch }">
		
				<c:if test="${!empty bSearch.ct }">
					<c:set var="category" value="ct=${bSearch.ct}&"/>
					<c:set var="searchStr" value="${category}"/>
				</c:if>
			
				<c:if test="${!empty bSearch.sort }">
					<c:set var="sort" value="sort=${bSearch.sort}&"/>
					<c:set var="searchStr" value="${category}${sort}"/>
				</c:if>
			
			
			<c:if test="${!empty bSearch.sv}">
				<c:set var="sk" value="sk=${bSearch.sk}&"/>
				<c:set var="sv" value="sv=${bSearch.sv}"/>
			
				<c:set var="searchStr" value="${category}${sort}sk=${bSearch.sk}&sv=${bSearch.sv}&"/>
			</c:if>
			
			
			
			<c:url var="pageUrl" value="search?${searchStr}"/>
			
			<!-- 목록으로 버튼에 사용할 URL저장 변수   session scope에 올리기-->
			<c:set var="returnListURL" value="${contextPath}/board/${pageUrl}cp=${bpInfo.currentPage}" scope="session" />
		</c:when>
		
		<c:otherwise>
			<c:url var="pageUrl" value="?"/>
			<!-- 목록으로 버튼에 사용할 URL저장 변수   session scope에 올리기-->
			<c:set var="returnListURL" value="${contextPath}/board/list${pageUrl}cp=${bpInfo.currentPage}" scope="session" />
		</c:otherwise>
	</c:choose>
	
	
	
	
	
	
    <div class="container">
        <div class="row">
            <div class="col-md-12">
				      <!-- 게시판 이름/카테고리 -->
				      <div class="row py-5">
				        <div class="col-lg-12 mx-auto">
				          <div class="text-black banner">
				            <h1 class="boardName float-left">일상을 말해봐</h1>
				                  <a class="category maincolor-font-bk" id="0" href="search?ct=0&${sort}${sk}${sv}">전체</a> | 
				                  <a class="category maincolor-font-bk" id="1" href="search?ct=1&${sort}${sk}${sv}">여행</a> | 
				                  <a class="category maincolor-font-bk" id="2" href="search?ct=2&${sort}${sk}${sv}">영화</a> | 
				                  <a class="category maincolor-font-bk" id="3" href="search?ct=3&${sort}${sk}${sv}">일상</a> | 
				                  <a class="category maincolor-font-bk" id="4" href="search?ct=4&${sort}${sk}${sv}">경제</a> | 
				                  <a class="category maincolor-font-bk" id="5" href="search?ct=5&${sort}${sk}${sv}">반려동물</a> | 
				                  <a class="category maincolor-font-bk" id="6" href="search?ct=6&${sort}${sk}${sv}">요리레시피</a>
				
				            <div class="listTest float-right">
				              <a class="category maincolor-font-bk" id="newSort" href="search?${category}sort=new&${sk}${sv}">최신순</a> |
				              <a class="category maincolor-font-bk" id="likeSort" href="search?${category}sort=like&${sk}${sv}">좋아요순</a>
				            </div>
				            <hr>
				          </div>
				        </div>
				      </div>
				      <!-- End -->

                <table class="table table-hover table-sm" id="list-table">
                    <thead>
                      <tr>
                        <th>글번호</th>
                        <th>카테고리</th>
                        <th>제목</th>
                        <th>닉네임</th>
                        <th>조회수</th>
                        <th>작성일</th>
                        <th><img id="image" src="${contextPath}/resources/images/like2.png"></th>
                      </tr>
                    </thead>
                    <tbody>
											<c:if test="${empty bList }">
												<tr>
													<td colspan="7" style="text-align : center;">존재하는 게시글이 없습니다.</td>
												</tr>
											</c:if>
											<c:if test="${!empty bList }">
												<c:forEach var="board" items="${bList}" varStatus="vs">
						
													<tr>
														<td>${board.boardNo}</td>
														<td>
														<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='
				                    <c:if test="${board.categoryCode == '11'}">background-color: #9ea9d7;</c:if>
				                    <c:if test="${board.categoryCode == '12'}">background-color: #d2add9;</c:if>
				                    <c:if test="${board.categoryCode == '13'}">background-color: #AFD485;</c:if>
				                    <c:if test="${board.categoryCode == '14'}">background-color: #e1c66d;</c:if>
				                    <c:if test="${board.categoryCode == '15'}">background-color: #ef8694;</c:if>
				                    <c:if test="${board.categoryCode == '16'}">background-color: #f6b06b;</c:if> '>${board.categoryName}</div>
														</td>
														<td>${board.boardTitle}</td>
														<td>${board.nickname}</td>
														<td>${board.readCount}</td>
														<td>
															<%-- 날짜 출력 모양 지정 --%>
															<fmt:formatDate var="createDate" value="${board.createDate}" pattern="yyyy-MM-dd"/>
															<fmt:formatDate var="now" value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd"/> 
															<c:choose>
																<c:when test="${createDate != now}">
																	${createDate}
																</c:when>
																<c:otherwise>
																	<fmt:formatDate value="${board.createDate}" pattern="HH:mm"/>
																</c:otherwise>
															</c:choose>
														</td>
														<td>${board.likeCount}</td>
													</tr>
												</c:forEach>
											</c:if>
										</tbody>
                  </table>
									<%-- 로그인이 되어있는 경우 --%>
									<%-- <c:if test="${!empty loginMember }"> --%>
										<a class="btn float-right maincolor" href="${contextPath}/board/insert">글쓰기</a>
									<%-- </c:if> --%>
									
                  <!--------------------------------- pagination  ---------------------------------->
                  
<%-- 	                <c:choose>
										<c:when test="${!empty param.sk && !empty param.sv}">
											<c:url var="pageUrl" value="/search"/>
											
											<c:set var="searchStr" value="&sk=${param.sk}&sv=${param.sv}"/>
										</c:when>
										
										<c:otherwise>
											<c:url var="pageUrl" value="/list"/>
										</c:otherwise>
									</c:choose> --%>

									<div class="padding">
									
										<c:set var="firstPage" value="${pageUrl}cp=1" />
										<c:set var="lastPage" value="${pageUrl}cp=${bpInfo.maxPage }" />
					
										<fmt:parseNumber var="c1" value="${(bpInfo.currentPage - 1) / 10 }" integerOnly="true" />
										<fmt:parseNumber var="prev" value="${ c1 * 10 }" integerOnly="true" />
										<c:set var="prevPage" value="${pageUrl}cp=${prev}" />
					
					
										<fmt:parseNumber var="c2" value="${(bpInfo.currentPage + 9) / 10 }" integerOnly="true" />
										<fmt:parseNumber var="next" value="${ c2 * 10 + 1 }" integerOnly="true" />
										<c:set var="nextPage" value="${pageUrl}cp=${next}" />
					
										<div class="container d-flex justify-content-center">
											<div class="col-md-4 col-sm-6 grid-margin stretch-card">
												<nav>
													<ul class="pagination d-flex justify-content-center flex-wrap pagination-rounded-flat pagination-success">
														<c:if test="${bpInfo.currentPage > bpInfo.pageSize}">
															<!-- 첫 페이지로 이동(<<) -->
															<li class="page-item"><a class="page-link" href="${firstPage }" data-abc="true"><i class="fas fa-angle-double-left"></i></a></li>
															<!-- 이전 페이지로 이동 (<) -->
															<li class="page-item"><a class="page-link" href="${prevPage }" data-abc="true"><i class="fa fa-angle-left"></i></a></li>
														</c:if>
														
														<!-- 페이지 목록 -->
														<c:forEach var="page" begin="${bpInfo.startPage}" end="${bpInfo.endPage}">
															<c:choose>
																<c:when test="${bpInfo.currentPage == page }">
																	<li class="page-item active"><a class="page-link" data-abc="true">${page}</a></li>
																</c:when>
					
																<c:otherwise>
																	<li class="page-item"><a class="page-link" href="${pageUrl}cp=${page}" data-abc="true">${page}</a></li>
																</c:otherwise>
															</c:choose>
														</c:forEach>
														
														<%-- 다음 페이지가 마지막 페이지 이하인 경우 --%>
														<c:if test="${next <= bpInfo.maxPage}">
															<!-- 다음 페이지로 이동 (>) -->
															<li class="page-item"><a class="page-link" href="${nextPage }" data-abc="true"><i class="fa fa-angle-right"></i></a></li>
															<!-- 마지막 페이지로 이동(>>) -->
															<li class="page-item"><a class="page-link" href="${lastPage }" data-abc="true"><i class="fas fa-angle-double-right"></i></a></li>
														</c:if>
													</ul>
												</nav>
					
											</div>
										</div>
									</div>
									
									
                  
                  <!-- 검색창 -->
									<form action="search" class="row" id="searchForm" style="margin-bottom: 50px;">
										<div class="col-md-12">
											<div class="search">
												<select name="sk" id="searchOption" style="width: 100px; height: 36px; display: inline-block;">
													<option value="title">제목</option>
													<option value="writer">작성자</option>
													<option value="titcont">제목+내용</option>
												</select> <input type="text" name="sv" class="form-control " autocomplete="off" style="width: 25%; display: inline-block;">
												<button class="form-control btn maincolor1" id="searchBtn" type="submit" style="width: 100px; display: inline-block; margin-bottom: 5px;">검색</button>
											</div>
										</div>
										<input type="hidden" name="ct" value="${param.ct }">	<!-- 있으면 값 세팅  -->
										<input type="hidden" name="sort" value="${param.sort }">
									</form>
                    
                  </div>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
    
    <%-- 목록으로 버튼에 사용할 URL 저장 변수 선언 --%>
<%-- 		<c:set var="returnListURL" value="${contextPath}/board/list/?cp=${bpInfo.currentPage}" scope="session" /> --%>
    
    <script>
		// 게시글 상세보기 기능 (jquery를 통해 작업)
		
		$("#list-table td").on("click", function(){
			var boardNo = $(this).parent().children().eq(0).text();

			var boardViewURL = "${contextPath}/board/" + boardNo;
			
			location.href = boardViewURL;
			
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
			}else if(${param.ct == '5'}){
				$("#5").css({"color":"#ffc823", "font-weight":"bold"});
			}else if(${param.ct == '6'}){
				$("#6").css({"color":"#ffc823", "font-weight":"bold"});
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
				if($(item).val() == "${bSearch.sk}"){
					$(this).prop("selected", true);
				}
			});
			
			
			// 검색 내용
			$("input[name=sv]").val("${bSearch.sv}");
			
			
			
		});
		
		
		
		
		
		
		
		
		// 검색 내용이 있을 경우 검색창에 해당 내용을 작성해두는 기능
 		(function(){
			var sk = "${param.sk}";
			var sv = "${param.sv}";
			$("select[name=sk] > option").each(function(index, item){
				if( $(item).val() == sk ){
					$(item).prop("selected", true);
				}
			});
			$("input[name=sv]").val(sv);
		})();
		
		
		

		
		
		
    </script>
</body>
</html>