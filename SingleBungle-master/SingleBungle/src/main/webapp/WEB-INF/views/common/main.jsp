<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>SingleBungle</title>


     <!-- 부트스트랩 사용을 위한 css 추가 -->
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
     integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

 <!-- 부트스트랩 사용을 위한 라이브러리 추가 -->
 <!-- 제이쿼리가 항상 먼저여야함 -->
 <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
     integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
     crossorigin="anonymous"></script>
     
     
<style>
/*    #freeBoard{
      height: 350px;
   }
   
   #findFriend{
      height: 350px;
   }

   #market{
      height : 500px;
   }

   #foodBoard, #review{
      height : 350px;
   } */
   
   #market{
      height : 179.2px;
   }
   
   #cafeNo { display: none; }
   
  .text-dark {
	  display:block;
	  overflow: hidden;
	  text-overflow: ellipsis;
	  white-space: nowrap;
	}


   .images{
      width:40px;
      height: 40px;
   }


   /* 제목 */
  .text-dark{
  display:block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;

 }

.icon { width: 13px; }
      
/* 캐러셀 화살표 바 색 변경 */
		.carousel-control-prev-icon {
 		background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23000' viewBox='0 0 8 8'%3E%3Cpath d='M5.25 0l-4 4 4 4 1.5-1.5-2.5-2.5 2.5-2.5-1.5-1.5z'/%3E%3C/svg%3E") !important;
	}
	
	.carousel-control-next-icon {
  		background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23000' viewBox='0 0 8 8'%3E%3Cpath d='M2.75 0l-1.5 1.5 2.5 2.5-2.5 2.5 1.5 1.5 4-4-4-4z'/%3E%3C/svg%3E") !important;
	}
	

 	.col-md-4 { height: 300px; } 
	
	.more:hover { color: black; }
	
	.board-table{
    table-layout: fixed;
    width: 300px;
	}
	
	.board-table > tbody > tr > td:nth-child(1){
		width: 50px;
	}
	.board-table > tbody > tr > td:nth-child(2){
		word-break: break-all;
    width: 100px;
	}
	
	.nickNameArea{ clear: both; }
	
	/* 좋아요/댓글 */
.viewArea,.replyArea{
  display: inline-block;
  font-size: 11px;
  margin-right: 5px;
}

</style>
<!-- Custom styles for this template -->
<link href="resources/css/carousel.css" rel="stylesheet">
</head>
<body>
	<!-- jsp 액션 태그를 이용한 동적 include -->
	<jsp:include page="header.jsp" />

	<main role="main">

	    <div class="container">
   			<div class="row">
				<div class="col-md-12">
					<!-- 이벤트 배너 -->
					<div class="carousel slide" id="carousel-32703">
						<!-- 배너(이미지) 아래부분에 흰색으로 "ㅡ ㅡ ㅡ" 로 클릭해서 넘어가는 부분 없애기 -->
						<!--             <ol class="carousel-indicators">
               <li data-slide-to="0" data-target="#carousel-32703" class="active">
               </li>
               <li data-slide-to="1" data-target="#carousel-32703">
               </li>
               <li data-slide-to="2" data-target="#carousel-32703">
               </li>
            </ol> -->
						<div class="carousel-inner" style="height: 200px; margin-top: 10px;">
							<div class="carousel-item active">
								<img class="d-block w-100" src="${contextPath}/resources/images/mainImg1.png" />
							</div>
							<div class="carousel-item">
								<img class="d-block w-100" src="${contextPath}/resources/images/mainImg2.jpg" />
							</div>
							<div class="carousel-item">
								<img class="d-block w-100" src="${contextPath}/resources/images/mainImg3.jpg" />
							</div>
							<div class="carousel-item">
								<img class="d-block w-100" src="${contextPath}/resources/images/mainImg4.png" />
							</div>
						</div>
						<a class="carousel-control-prev" href="#carousel-32703" data-slide="prev"><span class="carousel-control-prev-icon"></span> <span class="sr-only">Previous</span></a> <a class="carousel-control-next" href="#carousel-32703" data-slide="next"><span class="carousel-control-next-icon"></span> <span class="sr-only">Next</span></a>
					</div>
			</div>
	</div>
</div>



		    <div class="container" style="margin-top : 80px;">
							<!-- 자유게시판 -->
							<div class="row">
								<div class="col-md-4">
									<h4>일상을 말해봐</h4>
									<div class="wrapper p-1" id="freeBoard">
										<table class="table-hover board-table">
											<c:if test="${empty bList }">
												<tr>
													<td style="text-align: center;">존재하는 게시글이 없습니다.</td>
												</tr>
											</c:if>
											<c:if test="${!empty bList }">
												<c:forEach var="board" items="${bList}" varStatus="vs">
													<tr>
														<td>
															<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='
					                    <c:if test="${board.categoryCode == '11'}">background-color: #9ea9d7;</c:if>
					                    <c:if test="${board.categoryCode == '12'}">background-color: #d2add9;</c:if>
					                    <c:if test="${board.categoryCode == '13'}">background-color: #AFD485;</c:if>
					                    <c:if test="${board.categoryCode == '14'}">background-color: #e1c66d;</c:if>
					                    <c:if test="${board.categoryCode == '15'}">background-color: #ef8694;</c:if>
					                    <c:if test="${board.categoryCode == '16'}">background-color: #f6b06b;</c:if> '>${board.categoryName}</div>
														</td>
														<td><h7><a href="board/${board.boardNo}" class="text-dark">${board.boardTitle}</a></h7></td>
													</tr>
												</c:forEach>
											</c:if>
										</table>
										<div><a href="board/list" class="float-right more">더보기</a></div>
									</div>
								</div>


							<!-- 친구찾기 -->
								<div class="col-md-4">
									<h4>만남의 광장</h4>

									<div class="wrapper p-1" id="findFriend">
										<table class="table-hover board-table">
											<c:choose>
												<c:when test="${empty fList}">
													<tr>
														<td>작성된 글이 없습니다.</td>
													</tr>
												</c:when>

												<c:otherwise>
													<%-- 조회된 게시글 목록이 있을 때 --%>
													<c:forEach var="friend" items="${fList}">

														<tr>
															<td>
																<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='	
																<c:if test="${friend.categoryNm == '맛집'}">background-color: burlywood;</c:if>	
																<c:if test="${friend.categoryNm == '문화생활'}">background-color: skyblue;</c:if>	
																<c:if test="${friend.categoryNm == '동네친구'}">background-color: coral;</c:if> '>${friend.categoryNm}</div>
															</td>
															<td><h7> <a href="findFriend/${friend.friendNo}" class="text-dark">${friend.friendTitle}</a></h7></td>
														</tr>

													</c:forEach>
												</c:otherwise>
											</c:choose>
										</table>
										<div><a href="findFriend/list" class="float-right more">더보기</a></div>
									</div>
								</div>
								
								<div class="col-md-4">
									<h4>벙글장터</h4>
									<div class="wrapper p-1" id="market">
										<table class="table-hover">
											<c:if test="${empty mList }">
												<tr>
													<td style="text-align: center;">존재하는 게시글이 없습니다.</td>
												</tr>
											</c:if>
											<c:if test="${!empty mList }">
												<c:forEach var="market" items="${mList}" varStatus="vs">
													<tr>
														<td>
<%-- 															<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='
					                    <c:if test="${market.transactionCategory == 1}">background-color: #9ea9d7;</c:if>
					                    <c:if test="${market.transactionCategory == 2}">background-color: coral;</c:if> '>팝니다</div> --%>
					                    	
					                    	<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style="background-color : #ffaf18;">
					                    	<c:if test="${market.transactionCategory == 1}">삽니다</c:if>
																<c:if test="${market.transactionCategory == 2}">팝니다</c:if></div>
					                    
														</td>
														<tr style="height:60px;">
														<td>
														<span style='display : none;'>${market.marketNo}</span>
														<div class="embed-responsive embed-responsive-4by3">
													
															<c:forEach items="${thumbnailList2}" var="th">
															<c:if test="${th.parentMarketNo == market.marketNo}">
															<a href="market/${market.marketNo}"><img src="${contextPath}${th.filePath}/${th.fileName}" 
																class="img-fluid card-img-top embed-responsive-item marketNo"
																<c:if test="${market.transactionStatus != 1}"> style="opacity: 0.5;" </c:if>></a>
															</c:if>
															</c:forEach>
														</div>
														</td>
														<td style="padding-left: 10px;">
														<h7> <a href="market/${market.marketNo}" class="text-dark">${market.marketTitle}</a></h7></td>
													</tr>
												</c:forEach>
											</c:if>
										</table>
									</div>
									<div><a href="market/list" class="float-right more">더보기</a></div>
								</div>
								
							</div> <!-- 자유게시판 row 닫는 div -->
						</div> <!-- 자유게시판 컨테이너 닫는 div -->

						<!-- 맛집게시판 -->
						<div class="container">
							<div class="row py-4">
								<div class="col-md-12" id="cafe">
									<h4>먹보의 하루</h4>
									<div class="row">
										<c:if test="${empty cList }">
						         		존재하는 게시글이 없습니다.
						      	</c:if>
										<c:if test="${!empty cList }">
											<c:forEach var="cafe" items="${cList}" varStatus="vs">
												<div class="col-xl-4 col-lg-4 col-md-6 mb-4">
													<div class="bg-white rounded shadow-sm cafe-list">
														<div class="embed-responsive embed-responsive-4by3">
															<c:set var="flag" value="true" />
															<c:forEach var="th" items="${thumbnailList3}">
																<c:if test="${th.cafeNo == cafe.cafeNo}">
																	<a href="cafe/${cafe.cafeNo}"><img src="${contextPath}${th.filePath}/${th.fileName}" class="img-fluid card-img-top embed-responsive-item" id="img-list"></a>
																	<c:set var="flag" value="false" />
																</c:if>
															</c:forEach>
															<c:if test="${flag == 'true'}">
																<a href="cafe/${cafe.cafeNo}"><img src="${contextPath}/resources/images/cafeNoImg.jpg" id="img-list2" class="mg-fluid card-img-top embed-responsive-item"></a>
															</c:if>
														</div>

														<div class="p-4">
															<span id="cafeNo">${cafe.cafeNo}</span>
															<h5>
																<a href="cafe/${cafe.cafeNo}" class="text-dark cafeTitle">${cafe.cafeTitle}</a>
															</h5>

															<div class="infoArea float-right">
																<div class="viewArea">
																	<img class="icon" src="${contextPath}/resources/images/view.png" /> ${cafe.readCount}
																</div>
																<div class="viewArea">
																	<img class="icon" src="${contextPath}/resources/images/like1.png" /> ${cafe.likeCount}
																</div>
															</div>
															<div class="nickNameArea d-flex  align-items-center justify-content-between rounded-pill bg-light px-3 py-2 mt-4">
																<p class="small mb-0">
																	<span class="font-weight-bold price">${cafe.nickname}</span>
																</p>
																<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='
																	<c:if test="${cafe.categoryCode == '1'}">background-color: #9ea9d7;</c:if>
						                    	<c:if test="${cafe.categoryCode == '2'}">background-color: #ef8694;</c:if>
						                    	<c:if test="${cafe.categoryCode == '3'}">background-color: #e1c66d;</c:if> '>${cafe.categoryName}</div>
															</div>
														</div>
													</div>
												</div>
											</c:forEach>
										</c:if>
										<div style="width: 100%; text-align: right;"><a href="cafe/list" class="more">더보기</a></div>
									</div>
								</div>
							</div>
						</div>

						<!-- 후기게시판 -->
						<div class="container">
							<div class="row py-4">
								<div class="col-md-12" id="review">
									<h4>싱글이의 영수증</h4>
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
															<c:forEach var="thumbnail" items="${thumbnailList}">
																<c:if test="${review.boardNo == thumbnail.parentBoardNo }">
																	<a href="review/${review.boardNo}"><img src="${contextPath}${thumbnail.filePath}/${thumbnail.fileName}" class="img-fluid card-img-top embed-responsive-item"></a>
																	<c:set var="flag" value="false" />
																</c:if>
															</c:forEach>

															<c:if test="${flag=='true'}">
																<a href="review/${review.boardNo}"><img src="${contextPath}/resources/images/ReviewNonImages.png" class="img-fluid card-img-top embed-responsive-item"></a>
															</c:if>
														</div>

														<div class="infoAreaWrapper" style="padding : 24px; padding-bottom:0px;">
															<h5>
																<a href="review/${review.boardNo}" class="text-dark">${review.boardTitle }</a>
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
																	<span> <img src="${contextPath}/resources/images/like1.png" width="11" height="11" id="heart" class='likeImgs 
																					<c:forEach var="like" items="${likeInfo}">
																					<c:if test="${like.boardNo == review.boardNo}">like2</c:if>
																					</c:forEach>'> <span class="likeCnt" style="font-size: 12px;">${review.likeCount}</span>
																		</button>
																	</span>
																</div>

															</div>
															<div class="nickNameArea d-flex  align-items-center justify-content-between rounded-pill bg-light px-3 py-2" style="clear: both;">
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
										<div style="width: 100%; text-align: right;"><a href="review/list" class="more">더보기</a></div>
										<!-- End -->
									</div>
								</div>
							</div>
						</div>

	</main>
	
	<jsp:include page="footer.jsp" />

	<script>
	
	</script>

</body>
</html>