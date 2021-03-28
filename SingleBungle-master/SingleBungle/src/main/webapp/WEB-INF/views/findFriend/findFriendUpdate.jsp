<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만남의 광장 게시판 글수정</title>
<style>
</style>

<!-- summernote 사용 시 필요한 css 파일 추가 -->
<link rel="stylesheet" href="${contextPath}/resources/summernote/css/summernote-lite.css">

</head>
<body>
	<jsp:include page="../common/header.jsp" />
	
	<!-- summernote 사용 시 필요한 js 파일 추가 -->
	<script src="${contextPath}/resources/summernote/js/summernote-lite.js"></script>
	<script src="${contextPath}/resources/summernote/js/summernote-ko-KR.js"></script>
	<script src="${contextPath}/resources/summernote/js/mySummernote.js"></script>

	<div class="container">
		<div class="row">
			<div class="col-md-12">
			
				<div class="row py-5 no-gutters">
						<div class="col-lg-12 mx-auto">
							<div class="text-black banner">
								<h1 class="boardName">만남의 광장</h1>
								<hr>
							</div>
						</div>
				</div>

				<form action="updateAction" method="post" onsubmit="return meetingDateValidate();">

					<div class="form-group row">
						<label for="title" class="input-group-addon col-sm-1 col-form-label">제목</label>
						<div class="col-sm-11">
							<input type="text" class="form-control" id="title" name="friendTitle" size="100%" value="${findFriend.friendTitle}" required>
						</div>
					</div>
					<hr>
					<div class="form-group row">
						<label for="category" class="input-group-addon col-sm-1 col-form-label">카테고리</label>
						<div class="col-sm-4">
							<select class="form-control div small" id="category" name="categoryCd" style="width: 150px; height: 40px;" required>
								<option value="1">맛집</option>
								<option value="2">문화생활</option>
								<option value="3">동네친구</option>
							</select>
						</div>
					</div>
					<hr>
					<div class="form-group row">
						<label for="rocation1" class="input-group-addon col-sm-1 col-form-label">지역</label>
						<div class="col-sm-11">
							<div class="row mb-3 form-row">
								<div class="col-md-4">
									<select class="form-control div small" id="location1" name="location1" style="width: 150px; height: 40px;" required>
										<option value="서울특별시">서울특별시</option>
										<option value="부산광역시">부산광역시</option>
										<option value="대구광역시">대구광역시</option>
										<option value="인천광역시">인천광역시</option>
										<option value="광주광역시">광주광역시</option>
										<option value="대전광역시">대전광역시</option>
										<option value="울산광역시">울산광역시</option>
										<option value="세종특별자치시">세종특별자치시</option>
										<option value="경기도">경기도</option>
										<option value="강원도">강원도</option>
										<option value="충청북도">충청북도</option>
										<option value="충청남도">충청남도</option>
										<option value="전라북도">전라북도</option>
										<option value="전라남도">전라남도</option>
										<option value="경상북도">경상북도</option>
										<option value="경상남도">경상남도</option>
										<option value="제주도">제주도</option>
									</select>
								</div>

								<label for="rocation2" class="input-group-addon col-sm-1 col-form-label">모임장소</label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="location2" name="location2" value="${findFriend.location2}" required>
								</div>
							</div>
						</div>
					</div>
					<hr>
					<div class="form-group row">
						<label for="meetingDate" class="input-group-addon col-sm-1 col-form-label">모임날짜</label>
						<div class="col-sm-11">
							<div class="row mb-3 form-row">
								<div class="col-md-4">
									<input type="date" class="form-control" id="meetingDate" name="meetingDate" value="${findFriend.meetingDate}" style="width: 170px; height: 40px;" required>
								</div>
								<label for="meetingTime" class="input-group-addon col-sm-1 col-form-label">모임시간</label>
								<div class="col-md-4">
									<select class="form-control div smal" id="meetingTime" name="meetingTime" style="width: 90px; height: 40px;" required>
										<option value="6시">6시</option>
										<option value="7시">7시</option>
										<option value="8시">8시</option>
										<option value="9시">9시</option>
										<option value="10시">10시</option>
										<option value="11시">11시</option>
										<option value="12시">12시</option>
										<option value="13시">13시</option>
										<option value="14시">14시</option>
										<option value="15시">15시</option>
										<option value="16시">16시</option>
										<option value="17시">17시</option>
										<option value="18시">18시</option>
										<option value="19시">19시</option>
										<option value="20시">20시</option>
										<option value="21시">21시</option>
										<option value="미정">미정</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<hr>
					<div class="form-group row">
						<label for="capacity" class="input-group-addon col-sm-1 col-form-label">모집인원</label>
						<div class="col-sm-11">
							<div class="row mb-3 form-row">
								<div class="col-sm-4">
									<select class="form-control div smal" id="capacity" name="capacity" style="width: 80px; height: 40px;" required>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
									</select>
								</div>
								<label for="gender" class="input-group-addon col-sm-1 col-form-label">성별</label>
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" name="gender" id="female" value="W"
											<c:if test="${findFriend.gender == 'W'}">checked</c:if> onclick="return(false);">
												<label class="form-check-label" for="female">여자</label>
										</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="gender" id="male" value="M"
												<c:if test="${findFriend.gender == 'M'}">checked</c:if> onclick="return(false);">
												<label class="form-check-label" for="male">남자</label>
											</div>
											<div class="form-check form-check-inline">
												<input class="form-check-input" type="radio" name="gender" id="irrelevant" value="F"
												<c:if test="${findFriend.gender == 'F'}">checked</c:if> onclick="return(false);">
												<label class="form-check-label" for="irrelevant">무관</label>
											</div>
							</div>
						</div>
					</div>
					<hr>
					<div class="form-group">
						<div>
							<label for="content">내용</label>
						</div>
						<textarea class="form-control" id="summernote" name="friendContent" rows="10" style="resize: none;" required>${findFriend.friendContent}</textarea>
					</div>
					<div class="text-center">
						<button type="submit" class="btn maincolor mb-3">수정</button>
						<button type="button" class="btn maincolor-re mb-3" id="cancel">취소</button>
					</div>
				</form>

			</div>
		</div>
	</div>

<jsp:include page="../common/footer.jsp" />

<script>
	//날짜 유효성 검사
	function meetingDateValidate(){
	
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	
	if ((month+"").length < 2) month = "0" + month;
	if ((day+"").length < 2) day = "0" + day;
	
	var getToday = year + "-" + month + "-" + day;
	
	if(getToday > $("#meetingDate").val()){
		swal("모임 날짜는 오늘 이후만 가능합니다.");
		$("#meetingDate").focus();
		return false;
	}
	
};

 
 (function(){
	// 카테고리 선택
	 $("#category > option").each(function(index, item){
		 if($(item).text() == "${findFriend.categoryNm}"){
			 $(item).prop("selected", true);
		 }
	 })
 
	 // 시/도 선택
	 $("#location1 > option").each(function(index, item){
		 if($(item).val() == "${findFriend.location1}"){
			 $(item).prop("selected", true);
		 }
	 });
 
 	// 모임 시간 선택
	$("#meetingTime > option").each(function(index, item){
		if($(item).text() == "${findFriend.meetingTime}"){
			$(item).prop("selected", true);
		}
	}); 
	
 	// 모집 인원 선택
	 $("#capacity > option").each(function(index, item){
		 if($(item).text() == "${findFriend.capacity}"){
			 $(item).prop("selected", true);
		 }
	 });
 
 })();
 
 // 수정 취소
 $("#cancel").on("click", function(){
	if(confirm("게시글 작성을 취소하시겠습니까?"))	{
		location.href = "../${friendNo}";
	}
});
 
</script>
</body>
</html>
