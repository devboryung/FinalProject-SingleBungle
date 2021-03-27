<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib  prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 <%@ page import="java.sql.Timestamp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>벙글장터 - 상세 조회</title>
<link rel='stylesheet' href='https://sachinchoolur.github.io/lightslider/dist/css/lightslider.css'>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link href="${contextPath}/resources/css/resume-styles.css" rel="stylesheet" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

<style>

 .boardName {
   margin-right: 40px;
 }
 
   .boardName:hover {
    color : #ff8500;
  }
 

 .category {
   text-decoration: none;
   color: black;
   line-height: 54px;
 }

 .category:hover{
   text-decoration: none;
   color: rgb(214, 156, 30);
 }
 
	.boardImgArea{
		height: 300px;
	}

	.boardImg{
		width : 100%;
		height: 100%;
		max-width : 100%;
		max-height: 100%;
		
		margin : auto;
	}
	
		.carousel-control-prev-icon {
 		background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23000' viewBox='0 0 8 8'%3E%3Cpath d='M5.25 0l-4 4 4 4 1.5-1.5-2.5-2.5 2.5-2.5-1.5-1.5z'/%3E%3C/svg%3E") !important;
	}
	
	.carousel-control-next-icon {
  		background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23000' viewBox='0 0 8 8'%3E%3Cpath d='M2.75 0l-1.5 1.5 2.5 2.5-2.5 2.5 1.5 1.5 4-4-4-4z'/%3E%3C/svg%3E") !important;
	}
	
		/* 이미지 선택 색 변경*/
	.carousel-indicators > li{
		background-color: #ccc !important;
	}
	
		.btnSoldOut, .btnSoldOut:focus {
		outline : none;
		background : none;
		border : none;
		color : white;
		font-weight: bold;
	}
	
	.btnBadge {
		border : 1px solid #ffc0cb00;
		margin-top : 10px;
		margin-bottom:8px;
	}
	
	.itemTitle{
		margin-bottom: 35px;
	}
	
	.itemPrice{
		margin-right: 30px; 
	}
	
	.smallImages{
    margin-right: 8px;
	}
	
	.cnt, .verticalBar{
    line-height: 1;
    margin-bottom : 40px;
	}
	 
	.verticalBar{
		margin : 0 5px 0 5px;
		color: #d6d6d6;
	}
	
	.itemInfoList{
		clear:both; 
		margin-bottom: 30px;
	}
	
	.itemInfoList ul {
		padding-left: 20px;
	}
	
	
	#report{
		padding : 0 8px 0 8px;
	}

   #report span {
    line-height: 2;
   }
   
   .contentArea{
	    min-height: 400px;
   }
	 
   /* TOP3 출력 */
      body {
      background: #f4f4f4;
    }

    .boardName {
      margin-right: 40px;
    }

    .card-img-top{
      height: 15rem;
    }

    .categoryArea, .arrayArea{
      display: inline-block;
    }

    .category, .array{
      text-decoration: none;
      color: black;
      line-height : 54px;
      /*margin-right:5px;*/
    }
    
    .viewArea,.replyArea{
      display: inline-block;
      font-size: 11px;
      margin-right:5px;
    }

    .nickNameArea{
      clear: both;
    }
    .icon {
      width: 13px;
    }
     
     	/* 좋아요 */
	#likeBtn {
    border: 0px solid #ddd;
    background-color: rgba(255, 255, 255, 0);
  }
  
   .text-dark {
  display:block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
	}
  
  .priceArea {
    clear: both;
  }
  
  .popularItemTitle {
    	margin-top: 60px;
  }
  
  .itemInfoList label{
  	width: 95px;
  }
  
  .searchArea {
  	margin : auto;
  }
  
  #searchBtn{
  	background: burlywood;
  }
  
  #searchInput, #searchBtn {
  	border : 1px solid burlywood;
  }
  
   .banner span {
 			color : #c1c0c1a1;
 		}
 		
 	.boardImgArea{
		height: 300px;
	}

	.boardImg{
		width : 100%;
		height: 100%;
		max-width : 460x;
		max-height: 400px;
		margin : auto;
	}
	
	.btnW{
		width: 145px;
		height: 55px;
	}
	
	.like2 {
	background-size : 20px;
	background-image: url('${contextPath}/resources/images/like2.png');
	background-repeat: no-repeat;
}

.seller a {
	text-decoration: none;
	color : orange;
}
  
  
.viewdetail:hover {
	cursor: pointer;
}

</style>


</head>
<body>
<jsp:include page="../common/header.jsp"/>
<div class="container">

      <!-- 게시판 이름/카테고리 -->
      <div class="row py-5 no-gutters">
							<div class="col-md-12">
							
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
									<a type="button" class="btn maincolor float-right returnBtn" href="${returnListURL }">목록</a>
							
							
			<!-- <button type="button" class="btn btn-success float-right returnBtn">목록</button> -->
		</div>
        <div class="col-lg-12 mx-auto">
        	      
          <div class="text-black  banner">
								<a class="ListGo" href="../market/list" style="text-decoration: none"><h1 class="boardName">벙글장터</h1></a>
								<hr>
          </div>
        </div>
      </div>
      <!-- End -->
      

			<div class="row">
				<div class="col-md-6">
						
			<!-- 이미지 출력 -->
            <c:if test="${!empty at}"> 
            <div class="carousel slide boardImgArea" id="board-image">
               
               <!-- 출력되는 이미지 -->
               <div class="carousel-inner">
                  <c:forEach var="at" items="${at}" varStatus="vs">
                  	<c:set var="src" value="${contextPath}${at.filePath}/${at.fileName}"/>
                  	
                     <div class="carousel-item <c:if test="${vs.index == 0}"> active</c:if>">
                        <img class="d-block w-100 boardImg" id="200" 
                          src="${src}" /><input type="hidden" value="${at.fileNo}">
                     </div>
                  </c:forEach>
               </div> 
               
               <!-- 좌우 화살표 -->
               <a class="carousel-control-prev" href="#board-image" data-slide="prev"><span class="carousel-control-prev-icon"></span> <span class="sr-only">Previous</span></a> 
               <a class="carousel-control-next" href="#board-image" data-slide="next"><span class="carousel-control-next-icon"></span> <span class="sr-only">Next</span></a>
            </div>
            </c:if>
            
            
            
				</div>
				
				
				
				<div class="col-md-6 no">
				<span style='visibility: hidden;'>${market.marketNo}</span>
					<div> <h3>[${market.categoryNm}]</h3> </div> 
					<div> <h3 class="itemTitle">${market.marketTitle}</h3> </div>
					<div> <h1 class="itemPrice float-left"><fmt:formatNumber value="${market.price}" pattern="###,###,###,###"/>원</h1> 
						
						 <!-- 본인의 글이면 버튼 나타나게 -->
						 <c:if test="${market.memNo == loginMember.memberNo}"> 
							<div class="badge badge-danger px-1 rounded-pill font-weight-normal btnBadge " <c:if test='${market.transactionStatus == 3}'>style='visibility: hidden;'</c:if>>
								<button class="btnSoldOut reservationBtn " >
									<c:if test="${market.transactionStatus == 1}">예약중으로 변경</c:if>
									<c:if test="${market.transactionStatus == 2}">예약 취소</c:if>
								</button></div>
							<div class="badge badge-info px-1 rounded-pill font-weight-normal btnBadge">
								<button class="btnSoldOut soldOutBtn" <c:if test="${market.transactionStatus == 3}">style='cursor: unset;'</c:if>>
									<c:if test="${market.transactionStatus != 3}">거래완료로 변경</c:if>
									<c:if test="${market.transactionStatus == 3}">거래완료</c:if>
								</button></div>	
						</c:if>				
						<hr> 
					</div>
					
					
						<div>
						 <img class='float-left likeImg smallImages 
						 		<c:forEach var="like" items="${likeInfo}"><c:if test="${like.marketNo == market.marketNo}">like2</c:if></c:forEach>'
						 			 width="20" height="20" src="${contextPath}/resources/images/like1.png"> 
						 <h5 class="likeCnt float-left cnt likes">${market.likes}</h5>
							<h5 class="verticalBar float-left"> | </h5>
						 </div> 
						 
							<div>
						 <img class="float-left readCntImg smallImages" width="20" height="20" src="${contextPath}/resources/images/view.png"> 
						 
						 <h5 class="readCnt float-left cnt">${market.readCount}</h5> 
						 <h5 class="verticalBar float-left"> | </h5>
						 </div>
						  
						<div>

		        
		        <jsp:useBean id="today" class="java.util.Date" /> 
		        <c:set var="now" value="<%=new java.util.Date()%>"/>
	       
		        <fmt:formatDate var="createDt" value="${market.createDt}" pattern="yyyy-MM-dd HH:mm:ss.S" />  
		        <c:set var="createDt2" value="${createDt}"/>
		        <fmt:parseDate var="createDt3" value="${createDt2 }" pattern="yyyy-MM-dd HH:mm:ss.S" />
        
	        	<fmt:parseNumber value="${createDt3.time / (1000*60*60*24)}" integerOnly="true" var="end" scope="request" />
						<fmt:parseNumber value="${now.time / (1000*60*60*24)}" integerOnly="true" var="str" scope="request" />  
						
						<c:set var="day" value="${str - end}"/>
						

					
						 <img class="float-left clockImg smallImages" width="20" height="20" src="${contextPath}/resources/images/clock.png"> 
						 <h5 class="clock float-left cnt"> 
						 <c:choose>
							<c:when test="${day == 0 }">
								오늘
							</c:when>
							<c:otherwise>
								${day}일 전
							</c:otherwise>
						</c:choose>
						 </h5> 
						 </div> 
						 
						 
						 
						
						<c:if test="${market.memNo != loginMember.memberNo}"> 
							<button  type="button" class="btn float-right btn-sm mb-3 report" id="report" role="button" aria-pressed="true">
								<img src="${contextPath}/resources/images/siren.png" width="20" height="20" id="siren">
								신고하기
							</button>
						</c:if>
						 
			
					
						<div class="itemInfoList">
							<ul >
								<li class="seller">
										<label>판매자</label> <a href='${contextPath}/market/mypage/${market.memNo}/${market.marketNo}'>${market.nickname}</a>
										
								</li>
								
								<li class="itemStatus">
									<label>상태</label> 
									<span>
										<c:if test="${market.status == 'U'}">중고</c:if>
										<c:if test="${market.status == 'N'}">새상품</c:if>
									</span>
								</li>
								
								<li class="itemDelivery">
									<label>배송비</label> 
									<span>
										<c:if test="${market.deliveryCharge == 'F'}">배송비 포함</c:if>
										<c:if test="${market.deliveryCharge == 'N'}">배송비 별도</c:if>
									</span>
								</li>
								
								<li class="sellerLocation ">
									<label>거래지역</label> <span>${market.address}</span> 
									<c:if test='${market.certifiedFl == "Y"}'><i class="fas fa-map-marker-alt" title="동네인증한 회원입니다!"></i></c:if>
								</li>

							</ul>
						</div>
						
						
						<!-- 좋아요(찜하기) -->
 						<div>
							<a  class="btn maincolor btn-lg btnW likeBtn active " role="button" aria-pressed="true" >
								<img src="${contextPath}/resources/images/like1.png" width="20" height="20" id="heart"
									class='likeImgs <c:if test="${likeCheck == 1}">like2</c:if>'>
								<span class="likeCnt cnt" style="color:white; font-size : 16px; font-weight: 400;">
									<c:if test="${likeCheck == 1}">찜하기 취소</c:if>
									<c:if test="${likeCheck != 1}">찜하기</c:if>
								</span>
							</a>
							
							
							<a data-toggle="modal" <c:if test="${loginMember.memberNo != market.memNo && loginMember.memberGrade !='S' }">href='#sendMessage'</c:if> class="btn maincolor btn-lg btnW active" role="button" aria-pressed="true"
							<c:if test="${loginMember.memberNo == market.memNo }">style="cursor: no-drop;" title="본인 게시글에는 쪽지를 보낼 수 없습니다!" </c:if>
							<c:if test="${loginMember.memberGrade == 'S'}"> style="cursor: no-drop;" title="2등급은 쪽지를 보낼 수 없습니다!"</c:if>
							>
							
								<img src="${contextPath}/resources/images/message.png" width="20" height="20" id="message"> 
								<span class="messageText" style="color:white; font-size : 16px; font-weight: 400;">쪽지</span>
							</a>
	

						</div>
						
						<c:if test="${market.memNo == loginMember.memberNo}"> 
						<div style="margin-top : 10px;">
							<a class="btn maincolor btn-lg btnW active" role="button" aria-pressed="true"
								 href="${contextPath}/market/update/${market.marketNo}">
								<span style="color:white; font-size : 16px; font-weight: 400;">수정</span>
							</a>
							
							<a  class="btn maincolor btn-lg btnW active MdeleteBtn" role="button" aria-pressed="true">
								<span style="color:white; font-size : 16px; font-weight: 400;">삭제</span>
							</a>
						</div>
						</c:if>
				</div> 
				
		</div>
		
		<hr>
		
		<!-- 게시글 내용 -->
		<div class="row">
			<div class="col-md-12 contentArea">
			<% pageContext.setAttribute("newLine", "\n"); %>
				${fn:replace(market.marketContent , newLine, "<br>")}
			</div>
		</div>

		<!-- 댓글(페이지 연결하기) -->
		<jsp:include page="marketReply.jsp"></jsp:include>
		
				<!-- 버튼 -->
		<div class="row float-right mt-3">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-12">
					<c:if test="${market.memNo == loginMember.memberNo}"> 
						<button type="button" class="btn maincolor-re updateBtn">수정</button>
						<button type="button" class="btn maincolor MdeleteBtn">삭제</button>
					</c:if>
					</div>
				</div>
			</div>
		</div>

		<!-- 목록버튼 -->
		<div class="row  py-3" style="clear: both;">
			<div class="col-md-12 text-center ">
				<c:if test="${empty sessionScope.returnListURL}"> 
					<c:set var="returnListURL" value="/list" scope="session"/>
				</c:if>   
				<a type="button" class="btn maincolor returnBtn" href="${returnListURL }">목록</a>
				<!-- <button type="button" class="btn btn-success returnBtn">목록으로</button> -->
				
			</div>
		</div>
		
		
		
		<h5 class="popularItemTitle">벙글장터 인기 게시글</h5>
		<hr>


			<div class="row itemArea">
				<!-- Gallery item -->

				<c:if test="${empty marketList}">존재하는 게시글이 없습니다!</c:if>
				<c:if test="${!empty marketList}">
					<c:forEach var="market" items="${marketList}" varStatus="vs">
						<div class="col-xl-4 col-lg-4 col-md-6 mb-4">
							<div class="bg-white rounded shadow-sm viewdetail">
								<span style='visibility: hidden;'>${market.marketNo}</span>
								<div class="embed-responsive embed-responsive-4by3">
							
									<c:forEach items="${thList}" var="th">
									<c:if test="${th.parentMarketNo == market.marketNo}">
									<img src="${contextPath}/${th.filePath}/${th.fileName}" 
										class="img-fluid card-img-top embed-responsive-item marketNo"
										<c:if test="${market.transactionStatus != 1}"> style="opacity: 0.5;" </c:if>>
									</c:if>
									</c:forEach>
								</div>
								<div class="p-4">
									<h5>
										<a class="text-dark marketNo">${market.marketTitle}</a>
									</h5>
									<div class="categoryDetail float-left row_2">
										<p class="small text-muted mb-0">
											<c:if test="${market.transactionCategory == 1}">삽니다</c:if>
											<c:if test="${market.transactionCategory == 2}">팝니다</c:if>
										</p>
										<p class="small text-muted mb-0">${market.categoryNm}</p>
									</div>

										

									<!-- 좋아요 버튼 -->
									<span class="float-right">
								
											<img src="${contextPath}/resources/images/like1.png"
												width="20" height="20" id="heart" class='likeImgs <c:forEach var="like" items="${likeInfo}"><c:if test="${like.marketNo == market.marketNo}">like2</c:if></c:forEach>'>
											<span class="likeCnt">${market.likes}</span>
					
									</span>
									
									
									
									

									<div
										class="d-flex align-items-center justify-content-between rounded-pill bg-light px-3 py-2 mt-4 priceArea">
										<p class="small mb-0">
											<i class="mr-2"></i><span class="font-weight-bold price"> <fmt:formatNumber value="${market.price}" pattern="###,###,###,###"/>
												원</span>
										</p>
										<c:if test="${market.transactionStatus == 1}">
											<div
												class="badge badge-info px-3 rounded-pill font-weight-normal"
												style="background-color: #deb887;">거래중</div>
										</c:if>
										<c:if test="${market.transactionStatus == 2}">
											<div
												class="badge badge-info px-3 rounded-pill font-weight-normal"
												style="background-color: #e01515ad;">예약중</div>
										</c:if>
										<c:if test="${market.transactionStatus == 3}">
											<div
												class="badge badge-info px-3 rounded-pill font-weight-normal"
												style="background-color: #3596ead6;">거래완료</div>
										</c:if>

									</div>
								</div>
								<span id="marketNo"  style="visibility: hidden">${market.marketNo}</span>
							</div>
						</div>
					</c:forEach>
				</c:if>
				<!-- End -->
			</div>
		</div>
	
	
	
	
<!-- 쪽지 보내기~!!!!!!!   -->	

<!-- Modal HTML -->

			<form  method="POST" action="${contextPath}/message/sendMessage" onsubmit="return messageValidate();">
	<div id="sendMessage" class="modal fade">
		<div class="modal-dialog modal-confirm">
			
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">받는사람 :  ${market.nickname}</h5> 
						<input type="hidden" name="memberNo" value="${market.memNo}">
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
	
	// 인기 게시글 상세 조회
		$(".viewdetail").on("click",function(){
		var marketNo = $(this).children("span#marketNo").text();
		
		var marketViewURL = marketNo;
		
		location.href = marketViewURL;
	});
	
	
	
	// 목록으로 버튼
	$(".returnBtn").on("click", function(){
		location.href = "${sessionScope.returnListURL}"
	});
	
	// 수정 버튼
	$(".updateBtn").on("click", function(){
		location.href = "${contextPath}/market/update/${market.marketNo}"
	});
	
	// 삭제버튼
	$(".MdeleteBtn").on("click", function(){
		if(confirm("삭제 하시겠습니까?")){
			location.href = "${contextPath}/market/delete/${market.marketNo}";
		}
	});
	
	$(".likeBtn").on("click", function(){
		var marketNo = $(this).closest('.no').children().eq(0).text();
		var likeClassArray = $(this).children().attr('class').split(" ");
		var likeClass = "like1";
		var likeImg = $(this).children(".likeImgs");
		var likeCnt = $(".likes");
		var likedelete = $(this).children(".cnt");
		
	
		if(likeClassArray[1] == "like2") {
			likeClass = "like2"; 
		}
		
		if(likeClass == "like1") {
			$.ajax({
				url : "increaseLike",
				type : "post",
				data : {"marketNo" : marketNo},
				success : function(result){
					if(result > 0) {
						likeCnt.text(Number(likeCnt.text()) + 1);
						likedelete.text("찜하기 취소");
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
				data : {"marketNo" : marketNo},
				success : function(result){
					if(result > 0){ // 삭제 성공
						likeCnt.text(Number(likeCnt.text()) - 1);
						likeImg.removeClass("like2");
						likedelete.text("찜하기");
					}
				},
				error : function(result){
					console.log("ajax 통신 오류 발생");
				}
			});
		}
	});
	
	console.log("");
	var status = ${market.transactionStatus};
	// 예약중으로 변경
	$(".reservationBtn").on("click", function(){
		var marketNo = ${market.marketNo};
		
		if(status == 1){
		$.ajax({
			url : "reservation/2",
			data : {"marketNo" : marketNo},
			type : "post",
			success : function(result){
				if(result > 0) {
					$(".reservationBtn").text("예약 취소");
					status = 2;
				} 
			}, error : function(result){
				console.log("ajax 통신 실패");
			}
		});
		}
		
		
		if(status == 2){
			$.ajax({
				url : "reservation/1",
				data : {"marketNo" : marketNo},
				type : "post",
				success : function(result){
					if(result > 0) {
						$(".reservationBtn").text("예약중으로 변경");
						status = 1;
					}
				}, error : function(result){
					console.log("ajax 통신 실패");
				}
			});
			}
	});

		$(".soldOutBtn").on("click", function(){
			var marketNo = ${market.marketNo};
			
			if(status == 1 || status == 2){
				$.ajax({
					url : "reservation/3",
					data : {"marketNo" : marketNo},
					type : "post",
					success : function(result){
						if(result > 0) {
							//$(".reservationBtn").attr("disabled");
							$(".reservationBtn").parent().remove();
							$(".soldOutBtn").text("거래완료").css("cursor", "unset");
							status = 3;
						}
					}, error : function(result){
						console.log("ajax 통신 실패");
					}
				});
				}
		});
	
		
		
		// 신고하기
		$(".report").on("click", function(){
			window.name = "parentWindow";
			 window.open('${contextPath}/market/marketReport/${market.marketNo}', "popup", "width=550, height=650, toolbars=no, scrollbars=no, menubar=no left=1000 top=200");
		});

		
		
		//----------------------------------------------------------------------------
		// 메세지 유효성 검사
		function messageValidate(){
			
			if($("#writeMessage").val().trim().length ==0){
				swal("내용을 입력해 주세요");
				$("#writeMessage").focus();
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