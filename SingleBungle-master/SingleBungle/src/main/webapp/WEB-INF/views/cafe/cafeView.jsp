<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>먹보의 하루 상세조회 페이지</title>
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

.updateBtn, .insert-list { background-color: #00c689 !important;
color: #FFFFFF !important; }

#img-list:hover, .cafeTitle:hover {
	cursor: pointer;
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

.text-dark {
  display:block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

#cafeNo, #cafeNo2 {
	display: none;
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

/* 인기 게시글 */
.nickNameArea{ clear: both; }

.icon { width: 13px; }

.viewArea,.replyArea{
  display: inline-block;
  font-size: 11px;
  margin-right:5px;
}

</style>


</head>
<body>
	<jsp:include page="../common/header.jsp"/>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h8>맛집게시판</h8>
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
									<a type="button" class="btn maincolor-re mb-3 btn-sm insert-list" href="${returnListURL }">목록</a>
									<!-- <button type="button" class="btn maincolor-re mb-3 btn-sm insert-list">목록</button> -->
									<c:if test="${loginMember.memberNo != cafe.memberNo }">
									<button type="button" class="btn btn-sm mb-3 report"><img src="${contextPath}/resources/images/siren.png" width="20" height="20" id="siren">신고</button>
									</c:if>
								</div>
								
								<span id="cafeNo2">${cafe.cafeNo}</span>
                <div id="board-area">
                    <!-- 카테고리 -->
                    <h2>
                    <div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='
                    <c:if test="${cafe.categoryCode == '1'}">background-color: #9ea9d7;</c:if>
                    <c:if test="${cafe.categoryCode == '2'}">background-color: #ef8694;</c:if>
                    <c:if test="${cafe.categoryCode == '3'}">background-color: #e1c66d;</c:if> '>${cafe.categoryName}</div>
                    
                    <!-- 제목 -->
                    ${cafe.cafeTitle}</h2>
                    <hr>
                </div>

								<div class="row no">
									<div class="col-md-12">
										<div class="boardInfo" id="writer">
											<c:if test="${cafe.memberGrade == 'F'}"><img class="nickname" src="${contextPath}/resources/images/grade1.png"></c:if>
											<c:if test="${cafe.memberGrade == 'S'}"><img class="nickname" src="${contextPath}/resources/images/grade2.png"></c:if>
											<c:if test="${cafe.memberGrade == 'T'}"><img class="nickname" src="${contextPath}/resources/images/grade3.png"></c:if>
											<c:if test="${cafe.memberGrade == 'G'}"><img class="nickname" src="${contextPath}/resources/images/gradeG.png"></c:if>${cafe.nickname}
										</div>
										<div class="boardInfo" id="createDt" style="color: gray">${cafe.createDate}</div>
										<div class="infoArea float-right">
											<i class="far fa-eye"></i> ${cafe.readCount} <span>
												<!-- 좋아요 버튼 -->
												<button type="button" id="likeBtn" class="likeBtns">
													<img src="${contextPath}/resources/images/like1.png" 
													width="15" height="15" id="heart" class='likeImgs 
														<c:if test="${like == 1}">like2
														</c:if>
														'>
													<span class="likeCnt">${cafe.likeCount}</span>
												</button>
											</span>
											
										</div>
									</div>
								</div>
								
								<br>
								
								<div class="cafeName">
								<img src="${contextPath}/resources/images/placeholder.png" width="20" height="20">
								<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='background-color: #ff4a4a;'>${cafe.cafeName}</div>&nbsp;&nbsp;
								<span>${cafe.cafeAddress}</span>
								</div>
								<br>
								
								<!-- 지도 API 상세보기 구간 -->
								<p style="margin-top:-12px">
						    <em class="link">
						        <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')"></a>
						    </em>
								</p>
								<div id="map" style="width:100%;height:350px;"></div>
								
								<br><br>
								
                <div class="board-content">
                	${cafe.cafeContent}   
                </div>
                
								<br>
								<hr>

                <!-- 댓글(페이지 연결하기) -->
								<jsp:include page="cafeReply.jsp"></jsp:include>

								<!-- 버튼 -->
								<div class="row float-right mt-3">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
												<!-- 로그인된 회원이 글 작성자인 경우 -->
 												<c:if test="${(loginMember != null) && (cafe.memberNo == loginMember.memberNo)}">
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
									
								<a type="button" class="btn maincolor-re1 insert-list" href="${returnListURL }">목록으로</a>
										
									</div>
								</div>
								<!-- <button type="button" class="btn maincolor-re1 insert-list">목록으로</button> -->
                <p></p>
                
                
                
                
		<h7>맛집게시판 인기 게시글</h7>
		<hr>
        <div class="row">
        
        	<c:if test="${!empty cafeList}">
						<c:forEach var="item" items="${cafeList}" varStatus="vs">
				
          <!-- Gallery item -->
	        <div class="col-xl-4 col-lg-4 col-md-6 mb-4">
	          <div class="bg-white rounded shadow-sm cafe-list">
	            <div class="embed-responsive embed-responsive-4by3" id="img-list">
									<c:set var="flag" value="true" />
									<c:forEach var="th" items="${thList}">
										<c:if test="${th.cafeNo == item.cafeNo}">
											<img src="${contextPath}${th.filePath}/${th.fileName}" class="img-fluid card-img-top embed-responsive-item" id="img-list">
											<c:set var="flag" value="false" />
										</c:if>
									</c:forEach>
									<c:if test="${flag == 'true'}">
										<img src="${contextPath}/resources/images/cafeNoImg.jpg" id="img-list2" class="mg-fluid card-img-top embed-responsive-item">
									</c:if>
	            </div>
	            <div class="p-4">
	            <span id="cafeNo">${item.cafeNo}</span>
	              <h5> <a class="text-dark cafeTitle">${item.cafeTitle}</a></h5>
	              <div class="infoArea float-right">
	                <div class="viewArea">
	                  <img class="icon" src="${contextPath}/resources/images/view.png"/> ${item.readCount}
	                </div>
	                <div class="viewArea">
	                  <img class="icon" src="${contextPath}/resources/images/like1.png" /> ${item.likeCount}
	                </div>
	              </div>
	              <div class="nickNameArea d-flex  align-items-center justify-content-between rounded-pill bg-light px-3 py-2 mt-4">
	                <p class="small mb-0"><span class="font-weight-bold price">${item.nickname}</span></p>
	                
									<div class='badge badge-danger px-3 rounded-pill font-weight-normal' style='
									<c:if test="${item.categoryCode == '1'}">background-color: #9ea9d7;</c:if>
                  <c:if test="${item.categoryCode == '2'}">background-color: #ef8694;</c:if>
                  <c:if test="${item.categoryCode == '3'}">background-color: #e1c66d;</c:if> '>${item.categoryName}</div>
	                
	              </div>
	            </div>
	          </div>
	        </div>
	      </c:forEach>
			</c:if>
      <!-- End -->
          
       </div>

            </div>
        </div>
    </div>
	<jsp:include page="../common/footer.jsp"/>
	
	 <script>
	 // 신고
   $(".report").on("click", function(){
	   	window.name = "parentWindow";
       window.open('${contextPath}/cafe/cafeReport/${cafe.cafeNo}', "popup", "width=550, height=650, toolbars=no, scrollbars=no, menubar=no left=1000 top=200");
	 });
   
	// 목록버튼
	$(".insert-list").on("click", function(){
		location.href = "${sessionScope.returnListURL}";
	});
	
	// 수정버튼
	$(".updateBtn").on("click", function(){
		location.href = "${contextPath}/cafe/${cafe.cafeNo}/update";
	});
	
	// 삭제버튼
	$(".deleteBtn").on("click", function(){
		if(confirm("삭제 하시겠습니까?")){
	         location.href = "${contextPath}/cafe/${cafe.cafeNo}/delete";
	  }
	});
	
	// 조회수 top3 게시글 상세보기 기능 (jquery를 통해 작업)
	$(".cafe-list").on("click", function(){
		var cafeNo = $(this).children(".p-4").children().eq(0).text();
									
		// 상대경로
		var cafeViewURL = "${contextPath}/cafe/" + cafeNo;
		
		location.href = cafeViewURL;
		
	});
	
	
	// 좋아요
	
	$(".likeBtns").on("click", function(){
	var cafeNo = $(this).parents('.no').prev().prev("span").text();
	var likeClassArray = $(this).children().attr('class').split(" ");
	var likeClass = "like1";
	var likeImg = $(this).children(".likeImgs");
	var likeCnt = $(this).children(".likeCnt");
	
	if(likeClassArray[1] == "like2") {
		likeClass = "like2"; 
	}
	console.log($(this));
	//if(likeClass == "like1") {
	if(!$(this).children("img").hasClass("like2")) {
		$.ajax({
			url : "increaseLike",
			type : "post",
			data : {"cafeNo" : cafeNo},
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
				data : {"cafeNo" : cafeNo},
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
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f81111cbd23ecc010379fb2b505b51b9&libraries=services"></script>

	<script>
	    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	   	mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			
			// 주소로 좌표를 검색합니다
			// 맛집 주소 가져와서 좌표 찍음
			geocoder.addressSearch('${cafe.cafeAddress}', function(result, status) {
			
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
			
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });
			
			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="font-size: 13px;width:150px;text-align:center;padding:6px 0;">${cafe.cafeName}</div>'
			        // 맛집 이름 마커에 출력되게 함
			});
			        infowindow.open(map, marker);
			
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } else{
			       console.log(result);
			    }
			});    
   </script>
	
</body>
</html>