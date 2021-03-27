<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>벙글장터 - 게시글 수정</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<style>
	body{
		min-width: 1200px;
	}
	.container{
    min-width: 1080px;
	}
	
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

 .searchArea {
 	margin : auto;
 }
 
 #searchBtn{
 	background: burlywood;
 }
 
 #searchInput, #searchBtn {
 	border : 1px solid burlywood;
 }
 
 #requiredText{
 	color : red;
 	font-size : 16px;
 	margin-left : 30px;
 }
 
 .star{
 	color : red;
 }
 
 .formContent *{
 	list-style: none; 
 }
 
 .formContent{
    padding-left: 20px;
 }
 
 .insertForm {
    padding-left: 0px;
 }
 
 .borderTop {
 	border-top : 1px solid black;
 }
 
 .itemImages {
    padding-left: 0px;
 }
 
 .itemImageInsert{
 		width: 202px;
 		height: 202px;
 		position: relative;
 		border : 1px solid rgb(230, 229, 239);
 		display: flex;
 		align-items : center;
 		justify-content: center;
 		flex-direction: column;
 		color : rgb(155, 153, 169);
 		font-size : 1rem;
 		margin-right: 12px;
 		box-sizing: border-box;
 }
 
 
 .itemImageInsert label {
 		width: 100%; 
 		height:100%;
 		cursor: pointer;
 		text-align : center;
 		line-height: 16;
 		background-image: url("${contextPath}/resources/images/camera.png");
 		background-size: auto;
 		background-position: center center;
 		background-repeat : no-repeat;
 		opacity: 0.5;
 }
 
 .banner span {
 	color : #c1c0c1a1;
 }
 
 .formRow{
 	border-bottom : 1px solid rgb(220, 219, 228);
 	padding : 32px 0 32px 0;
 }
 
 .formList{
 	width : 10.5rem;
 	font-size : 18px;
 	padding-top : 14px;
 }
 
 .titleFlex{
 	flex : 1 1 0%;
 }
 
 .titleArea{
 	display: flex;
 	width : 80%;
 	align-items: center;
 }
 
 .titleInput{
 	width: 100%;
 	padding : 0px 1rem;
 	border : 1px solid rgb(195, 194, 204);
 	height : 3rem;
 }
 
 .titleCnt{
 	width: 10%;
 	margin-left : 20px;
 }
 
 
 /* 취소 버튼  */
 #cancelBtn{
 	position : absolute;
 	right : 27%;
 	background-position: center center;
 	background-repeat: no-repeat;
 	background-size : 22px 22px;
 	width : 2rem;
 	height: 2rem;
 	background-image: url("${contextPath}/resources/images/cancel.png");
 	background-color: transparent;
 	outline : none;
 	border : 0;
 }
 
 .errorMsg{
 	color : #e67d10;
 	font-size : 14px;
 	display: block;
 	margin-top : 5px;
 }
 
 
 #locationInput{
 	width : 100%; 
 	margin-top : 1rem;
 	height : 3rem;
 	padding : 0px 1rem;
 	border : 1px solid rgb(195, 194, 204);
 }

	.custom-control-label{
		width: 80px;
		margin-top: 10px;
	}
	
	.itemInputs{
		height : 3rem;
		padding : 0px 1rem;
		border : 1px solid rgb(195, 194, 204);
	}
	
	.itemInfoText{
		padding: 1rem;
		resize: none;
		line-height: 1.35;
		border : 1px solid rgb(195, 194, 204);		
		width: 100%;
	}
	
	.itemImages{
		display: flex;
		width : 856px;
		flex-wrap:  wrap;
		overflow-x : hidden;
	}
	
	.itemImage{
		margin-bottom : 8px;
		width: 202px;
		height: 202px;
		border: 1px solid rgb(230, 229, 239);
		margin-right: 12px;
		list-style-type: none;
		position : relative;
		display: flex;
	}
	
	.image{
		width: 100%;
		height: 100%;
	}
	
	.deleteBtn{
		width : 1.5rem;
		height : 1.5rem;
		background-position : center center;
		background-repeat : no-repeat;
		background-size : 12px 12px;
		background-image: url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxMiIgdmlld0JveD0iMCAwIDEyIDEyIj4KICAgIDxwYXRoIGZpbGw9IiNGRkYiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZD0iTTYuODQ4IDZsMy43NzYtMy43NzZhLjYuNiAwIDEgMC0uODQ4LS44NDhMNiA1LjE1IDIuMjI0IDEuMzc2YS42LjYgMCAwIDAtLjg0OC44NDhMNS4xNTIgNiAxLjM3NiA5Ljc3NWEuNi42IDAgMSAwIC44NDguODQ5TDYgNi44NDhsMy43NzYgMy43NzZhLjU5OC41OTggMCAwIDAgMS4wMjQtLjQyNS42LjYgMCAwIDAtLjE3Ni0uNDI0TDYuODQ4IDZ6IiBvcGFjaXR5PSIuNjQiLz4KPC9zdmc+Cg==");
		background-color :  rgba(30, 29, 41, 0.32);
		border-radius: 50%;
		position: absolute;
		top : 0.5rem;
		right : 0.5rem;
		outline : none;
		border: none;
	}

	.sumbitArea{
		width: auto;
	}
	
	#submitBtn, #listBtn{
		width : 20%;
		margin : 40px 20px 137px 0;
		outline: none;
		float: right;
	}
	
	.radioM{
		margin-right : 35px;
	}
	
	input:focus, textarea:focus {
		outline : 1px solid black;
	}
	
	input:checked{
		outline : none;
	}
	
	.radioArea{
		padding-top : 17px;
	}
	
	.priceArea label {
		margin-top : 8px;
	}

	.itemImage img {
		width : 100%;
		height: 100%;
	}
	
	.maincolor{
		margin-right: 8px;
	}

</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>

	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="px-lg-5">
				


					<!-- 게시판 이름/카테고리 -->
					<div class="row py-5 no-gutters">
						<div class="col-lg-12 mx-auto">
							<div class="text-black banner">
								<a class="ListGo" href="../list"><h1 class="boardName">벙글장터</h1></a>
								<hr>
							</div>
						</div>
							
					</div>
					<!-- End -->
					
					
					<h2>기본정보  <span id="requiredText">*필수정보</span> </h2> 
				
					
					<form action="../updateAction/${market.marketNo}" name="updateForm" method="POST" enctype="multipart/form-data" role="form" onsubmit= "return validate();">
					<ul class="insertForm">
					<!-- 이미지 -->
						<li class="formRow row borderTop">
							<div class="formList">
								<span>상품이미지<span class="star">*</span> (<span id="imgCnt">${fn:length(at) }

								</span>/10) </span>
							</div>
							
							<div class="formContent">
								<ul class="itemImages"> 
									<li class="itemImageInsert" id="imgInput">
										<label for="images0" class="imgLabel"   <c:if test="${!vs.last}"> style="display:none;"  </c:if>     >
											<span>이미지 등록</span>
										</label>
										<input type="file" id="images0" name="images"  style="display: none;" onchange="LoadImg(this);">
	
										<c:forEach items="${at}" var="image" varStatus="vs">
											<label for="images${vs.count}" class="imgLabel"   <c:if test="${!vs.last}"> style="display:none;"  </c:if>     >
												<span>이미지 등록</span>
											</label>
											<input type="file" id="images${vs.count}" name="images"  style="display: none;" onchange="LoadImg(this);">
										</c:forEach>								
									</li>
									
									<c:forEach items="${at}" var="image" varStatus="vs">
										<li class="itemImage">
											<img id="images${vs.count}" name="test1" src="${contextPath}${image.filePath}/${image.fileName}">
											<button type="button" class="deleteBtn" onclick="deleteImg(this, ${vs.count}, ${image.fileNo});"></button>
										</li>
									</c:forEach>
									
								</ul>
							</div>
						</li>
						
						<!-- 상태 -->
						<li class="formRow row">
							<div class="formList">
								<span>분류<span class="star">*</span></span>
							</div>
							<div class="formContent radioArea">
								<div class="itemStatusArea form-check">
									<input  type="radio" name="transactionCategory" value="1" class="itemRadio form-check-input" id="buy"> 
										<label for="buy" class="radioM">삽니다</label>
									<input type="radio" name="transactionCategory" value="2" class="itemRadio form-check-input" id="sell"> <label for="sell" class="radioM">팝니다</label>
								</div>
							</div>
						</li>
						
						<!-- 제목 -->
						<li class="formRow row">
							<div class="formList">
								<span>제목<span class="star">*</span></span>
							</div>
							
							<div class="formContent titleFlex">
								<div class="titleArea ">
									<input type="text" placeholder="상품 제목을 입력해주세요." class="titleInput" id="title" name="marketTitle" required maxlength="40" minlength="2" value="${market.marketTitle }"required>
									<button id="cancelBtn" type="button"></button>
									<div class="titleCnt">
									<span id="currCnt">0</span>
									<span id="maxCnt">/ 40</span>
								</div>
								</div>
							</div>
						</li>
						
						
						<!-- 카테고리 -->
						<li class="formRow row">
							<div class="formList">
								<span>카테고리<span class="star">*</span></span>
							</div>			
							
							<div class="formContent">
								<select id="SelectCategory" name="categoryCd" class="form-control div large" style="height: 40px">
									<option value="1">디지털/가전</option>
									<option value="2">가구/인테리어</option>
									<option value="3">유아동/유아도서</option>
									<option value="4">생활/가공식품</option>
									<option value="5">스포츠/레저</option>
									<option value="6">여성패션/잡화</option>
									<option value="7">남성패션/잡화</option>
									<option value="8">게임/취미</option>
									<option value="9">뷰티/미용</option>
									<option value="10">반려동물용품</option>
									<option value="11">도서/티켓/음반</option>
									<option value="12">식물</option>
									<option value="13">기타 중고물품</option>
								</select>
							</div>
						</li>
						
						
						
						
						
						
						
						<!------------------------------------------------------------------ 거래지역  ---------------------------------------------------------------------->
						<!-- 거래지역 -->
						<li class="formRow row">
							<div class="formList">
								<span>거래지역<span class="star">*</span></span>
							</div>
							
							<div class="formContent titleFlex">
								<div class="locationBtnArea mb-20">
									
									
										<button type="button" id="currLocation" class="LBtn btn maincolor" >내 위치</button>
									
										<c:if test="${loginMember.memberCertifiedFl != 'Y'}">
										<button type="button" id="searchLocation" class="LBtn btn maincolor">주소 검색</button>
										<button type="button" id="researchLocation" class="LBtn btn maincolor" onclick="research();">재 검색</button>
									</c:if>
								</div>
								<input type="text" placeholder="선호 거래 지역을 입력해주세요.(읍/면/동)" id="locationInput"  name="address" class="location" required
								<c:if test="${loginMember.address != null}">value="${loginMember.address}" readonly style="background-color : #f1f1f0bd; cursor : not-allowed"</c:if>
								>
								<span class="errorMsg" id="locationMsg"></span>
								<ul id="searchAddr" style="padding : 0px;">
									
								</ul>
							</div>
						</li>
						
						
						
						
						
						
						
						
						<!-- 상태 -->
						<li class="formRow row">
							<div class="formList">
								<span>상태<span class="star">*</span></span>
							</div>

							<div class="formContent radioArea">
								<div class="itemStatusArea form-check">
									<input type="radio" name="status" value="U" class="itemRadio form-check-input" id="usedStatus" > <label for="usedStatus" class="radioM">중고</label>
									
									
									<input type="radio" name="status" value="N" class="itemRadio form-check-input" id="newStatus"> <label for="newStatus" class="radioM">새상품</label>
								</div>
							</div>
						</li>
						
						<!-- 가격 -->
						<li class="formRow row">
							<div class="formList">
								<span>가격<span class="star">*</span></span>
							</div>

							<div class="formContent">
								<div class="priceArea">
									<input type="text" name="price" id="itemPrice" class="priceInput itemInputs" placeholder="숫자만 입력해주세요." value="${market.price}" required> 원
									
										<span class="errorMsg" id="priceMsg"></span>
									<input type="radio" name="deliveryCharge" value="F" class="itemRadio" id="including" checked> <label for="including" class="radioM" >택배비 포함</label>
									<input type="radio" name="deliveryCharge" value="N" class="itemRadio" id="noincluding"> <label for="noincluding" class="radioM">택배비 미포함</label>
								</div>
							</div>
						</li>
						
						
						<!-- 설명 -->
						<li class="formRow row">
							<div class="formList">
								<span>설명<span class="star">*</span></span>
							</div>
							
							<div class="formContent titleFlex">
								<textarea rows="6" name="marketContent" placeholder="상품 설명을 입력해주세요.(최소 5글자)" class="itemInfoText" maxlength="2000" minlength="5" required >${market.marketContent }</textarea>
									<div class="titleCnt float-right">
									<span id="ContentCurrCnt">0</span>
									<span id="ContentMaxCnt">/ 2000</span>
								</div>
							</div>
						</li>
						
					<!-- 수량 -->
						<li class="formRow row">
							<div class="formList">
								<span>수량<span class="star">*</span></span>
							</div>

							<div class="formContent">
								<div class="priceArea">
									<input type="text" name="itemCount" id="itemCount" class="countInput itemInputs" value="${market.itemCount}" required /> 개
									<span class="errorMsg" id="countMsgq"></span>
								</div>
							</div>
						</li>
						</ul>
						<div id="btnArea">
								<button id="submitBtn" type="submit" class="btn-lg maincolor">등록하기</button>
								<button id="listBtn" type="button" class="btn-lg maincolor-re ">등록취소</button>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp"/>
	

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8fab5ca51af8a6a11814c512e4f78d74&libraries=services,clusterer"></script>
	<script>
    var locationCheck = false;
	
	// 취소
	$("#listBtn").on("click", function(){
		if(confirm("목록으로 돌아가시겠습니까?")){
	         location.href = "${sessionScope.returnListURL}";
	  }
	});
	
	
	// 이전 이미지의 fileNo를 하나의 배열에 모아둠
	var beforeImages = [];
	<c:forEach items="${at}" var="image">
		beforeImages.push(${image.fileNo});
	</c:forEach>
	
	
	
	(function() {
        if("${market.transactionCategory}" == '1')
           $("#buy").prop("checked", true);
        else 
           $("#sell").prop("checked", true);
     })();
	
	(function() {
        if("${market.status}" == 'U')
           $("#usedStatus").prop("checked", true);
        else 
           $("#newStatus").prop("checked", true);
     })();
	
	(function() {
        if("${market.deliveryCharge}" == 'N')
           $("#noincluding").prop("checked", true);
        else 
           $("#including").prop("checked", true);
     })();
	
	// 카테고리
	$.each($("#SelectCategory > option"), function(index, item){
		if($(item).text() == "${market.categoryNm}"){
			$(item).prop("selected", "true");
		}
	});
	
	var imgCnt = ${fn:length(at)};
	var imgId = ${fn:length(at)};
	
	if(imgCnt <= 10) {
		function LoadImg(value) {
			if (value.files && value.files[0]) {
				var reader = new FileReader();
				reader.readAsDataURL(value.files[0]);
				imgId++;
				
				reader.onload = function(e) {
					var img = '<li class="itemImage"> <img id="images' + imgId + '" class="image" name="test1" src="' + e.target.result + '">' +
						'<button type="button" class="deleteBtn" onclick="deleteImg(this,'+imgId+');"></button>' + '</li>';
					$(".itemImages").append(img);
					$("#imgCnt").text(++imgCnt); 
					addImgInput();
				}
			}
		}
	}
	
	function addImgInput(){
		var input = '<label for="images' + imgId +'" class="imgLabel">' +
								'<span>이미지 등록</span></label>'+
								'<input type="file" id="images' + imgId + '" name="images" style="display:none;" onchange="LoadImg(this);">';
		$(".itemImageInsert label").css("display", "none");
		$('.itemImageInsert').append(input);
	}
	
    function deleteImg(value, num, fileNo) {
    	console.log("파일 번호 : " + num);
    	
    	if(fileNo != undefined){ // 전달된 파일 번호가 있다면
    		var idx = beforeImages.indexOf(fileNo);
    		if (idx > -1) beforeImages.splice(idx, 1)
    	}
    	
    	
   		$("#imgCnt").text(--imgCnt);  
        $(value).parent().remove();
        
        var id = "images" + num;
        $("label[for="+id+"]").remove();
        $("input[id="+id+"]").remove();
        
        $(".imgLabel").eq($(".imgLabel").length - 1).show();
     }
    
    
    $("#title").on("input", function(){
    	var cnt = $(this).val();
    	$("#currCnt").text(cnt.length);
    	
    	if(cnt.length == 40){
    		$("#currCnt").css("color", "red");
    	}
    });
    
    $("#cancelBtn").on("click", function(){
    	$("#title").val("");
    });
    
    $("#itemPrice").on("input", function(){
    	var regexp = /^[0-9]*$/;
    	if($("#itemPrice").val() < 100) {
    			$("#priceMsg").text("100원 이상 입력해주세요.");
    	} else if(!regexp.test($("#itemPrice").val())){
    		alert("숫자만 입력해주세요.");
    		$("#priceMsg").text("숫자만 입력해주세요.");
    		$("#priceMsg").text("숫자만 입력해주세요.");
    	} else{
    		$("#priceMsg").text("");
    	}
    });
    $(".itemInfoText").on("input", function() {
        var cnt = $(this).val();
        $("#ContentCurrCnt").text(cnt.length);
        if (cnt.length >= 2000) {
           $("#ContentCurrCnt").css("color", "red");
        }
     });
     
     
     $("#itemCount").on("input", function(){
     	var regexp = /^[0-9]*$/;
     	if($("#itemCount").val() <= 0) {
     			$("#countMsgq").text("1개 이상 입력해주세요.");
     	} else if(!regexp.test($("#itemCount").val())){
     		alert("숫자만 입력해주세요.");
     		$("#countMsgq").text("숫자만 입력해주세요.");
     		$("#countMsgq").text("숫자만 입력해주세요.");
     	} else{
     		$("#countMsgq").text("");
     	}
     });
     
     
      function validate(){
        if(imgCnt == 0){
           alert("1장 이상의 사진을 등록해주세요.");
           $("#images").focus();
           return false;
        }
        
        if($("#title").val().trim().length == 0){
           alert("제목을 입력해주세요.");
           $("#title").focus();
           return false;
        }
        
        if($("#locationInput").val().trim().length == 0){
           alert("거래지역을 입력해주세요.");
           $("#locationInput").focus();
           return false;
        }
        
        if($("#itemPrice").val().trim().length == 0){
           alert("가격을 입력해주세요.");
           $("#itemPrice").focus();
           return false;
        }
        
        if($(".itemInfoText").val().trim().length == 0){
           alert("상품 설명을 입력해주세요.");
           $(".itemInfoText").focus();
           return false;
        }
        
        if($("#itemCount").val().trim().length == 0){
           alert("상품 개수를 입력해주세요.");
           $(".itemCount").focus();
           return false;
        }
      
		// 유효성 검사에서 문제가 없을 경우 서버에 제출 전
      // beforeImages배열의 내용을 hidden 타입으로 하여 form태그 마지막에 추가하여 파라미터로 전달
      for(var i=0 ; i<beforeImages.length ; i++){
         $beforeImages = $("<input>", {type : "hidden", name : "beforeImages", value : beforeImages[i]});
         $("form[name=updateForm]").append($beforeImages);
      }
	
     }
      
		
      
		//----------------------------------------------------------------------------
		
		  var locate="";
     	var inputLocate = "none";
    
        
     function getLocation(getLoc) {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(function(pos) {
					var latitude = pos.coords.latitude;
					var longitude = pos.coords.longitude;
					var geocoder = new kakao.maps.services.Geocoder();

					var callback = function(result, status){
					    if (status === kakao.maps.services.Status.OK) {
									//locate = result[0].address_name;
									getLoc(result[0].address_name);
					        console.log('지역 명칭 : ' + locate);
					    
					    }
					} 

					geocoder.coord2RegionCode( longitude, latitude, callback);
					
					
				}, function(error) {
					alert(error);
				})
			} else {
				alert("이 브라우저에서는 위치 정보를 얻어올 수 없습니다.");
			}
		}
  
      

		$("#currLocation").on("click", function() {
			
			getLocation(function(loc){
       	console.log(loc);
       	locate = loc;
      	
				$.ajax({
					url : "updateLocateCertification",
					type : "post",
					data : {
						"locate" : locate
					},
					success : function(result) {
							if(result != null){
								swal({ icon : "success", title : "위치 인증이 완료되었습니다." });
								console.log("테스트2" + locate);
								$("#locationInput").val(locate).attr("readonly", "readonly").css("backgroundColor", "#f1f1f0bd").css("cursor", "not-allowed");
								$("#searchLocation, #researchLocation").css("display", "none");
							  locationCheck = true;
							} else{
								swal({ icon : "error", title : "위치 인증이 정상적으로 이루어지지 않았습니다." });
							}
					},
					error : function(result) {
						console.log("ajax 통신 오류 발생!");
					}
				});
      });
		});
		

	

		$("#searchLocation").on("click", function(){
	
		
		if($("#locationInput").val()==""){
			alert("검색어를 입력해주세요.");
		}
		console.log($("#locationInput").val());
		$.ajax({
			url : "https://dapi.kakao.com/v2/local/search/address.json",
			dataType : "json",
			headers : { 'Authorization' : 'KakaoAK d8940af8d4ab80783457f43b81159f84'},
			async : false,
			type : "get",
			data : {'query' : $("#locationInput").val()},
			success : function(r) {
				
				if(r.documents.length != 0 ){ // 값이 있으면

					$("#searchAddr").empty();
					for(var i= 0; i<r.documents.length; i++){
						
						 console.log(r.documents[i].address_name);
						 
						 var li = '<li class="valAddr"><button type="button" class="btn addr" onclick="addrBtnClick(\''+r.documents[i].address_name+'\');">' + r.documents[i].address_name + '</button></li>'
							
						 $("#searchAddr").append(li);
						}
				}
			}, error : function(request, status, error){
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

			}
		})
	});
	
	
	
	function addrBtnClick(temp){
		
		console.log(temp);
		$("#locationInput").val(temp);
		console.log("테스트1 :" + $("#locationInput").val());
		$("#searchAddr").empty();
		
		$.ajax({
			url : "updateLocateNoCertification",
			type : "get",
			data : {"locate" : temp},
			success : function(r){
				if(r != null){
					console.log("테스트 3 : " + r);
					$("#locationInput").val(r).attr("readonly", "readonly").css("backgroundColor", "#f1f1f0bd").css("cursor", "not-allowed");
				    locationCheck = true;
				} else{
					$("#locationInput").remove("readonly, backgroundColor");
				}
			}, error : function(){
				console.log("ajax 통신 오류 발생!");
			}
		});
	}; 
	
	function research() {
		$("#locationInput").removeAttr('readonly').css('backgroundColor', '').css('cursor', 'auto').val('');
		if (${loginMember.memberCertifiedFl != null}) {
			locationCheck = true;
		} else {
			locationCheck = false;
		}
	} 
      
	</script>


</body>
</html>