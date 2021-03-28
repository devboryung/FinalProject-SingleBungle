<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>싱글이의 영수증 수정하기</title>

<!-- summernote 사용 시 필요한 css 파일 추가  -->
<link rel="stylesheet" href="${contextPath }/resources/summernote/css/summernote-lite.css">
<!-- 부트스트랩 사용을 위한 css 추가 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<style>
.container {
	border: 1px solid;
	padding: 19px 27px 15px;
	box-sizing: border-box;
	border-radius: 2px;
	border-color: #efefef;
}

/* 셀렉트 박스 */

/* 제목 입력 */
.titleArea {
	width: 100%;
	font-size: 23px;
	border: none;
}

.titleArea:focus {
	outline: none;
}

.note-editor {
	width: 100% !important;
}
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

	<!-- summernote 사용 시 필요한 js 파일 추가  -->
	<script src="${contextPath }/resources/summernote/js/summernote-lite.js"></script>
	<!-- 이 코드가 있어야 섬머노트 사용 가능  -->
	<script src="${contextPath }/resources/summernote/js/summernote-ko-KR.js"></script>
	<!-- 한글 패치  -->
	<script src="${contextPath }/resources/summernote/js/mySummernote.js"></script>
	<!-- 개인이 만든 js  -->



	<div class="container" style="margin-bottom: 5px;">
		<div class="row ">

			<div class="col-md-12">
				<form action="updateAction" enctype="multipart/form-data" method="post" role="form" onsubmit="return validate();">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-4">
								<select class="form-control div small" id="category" name="categoryCode" style="width: 150px;">
									<option value="21">가구</option>
									<option value="22">생활용품</option>
									<option value="23">전자기기</option>
									<option value="24">기타</option>
								</select>
							</div>
							<div class="col-md-12 py-2">
								<input class="titleArea" name="boardTitle" placeholder="제목을 적어주세요." autocomplete="off" value="${review.boardTitle }">
								<hr>
							</div>
						</div>

						<!-- 내용 -->
						<div class="form-group">
							<textarea class="form-control" name="boardContent" id="summernote"  rows="10" style="resize: none;">${review.boardContent }</textarea>
						</div>


						<div class="text-center" style="margin-bottom: 10px;">
							<button type="submit" class="btn btn-success">수정</button>
							<a class="btn btn-success" href="${header.referer}">취소</a>
						</div>
					</div>

				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />


	<script>
	// 카테고리 선택
	$.each($("#category > option"), function(index, item){
		if($(item).text() == "${review.categoryName}"){
			$(item).prop("selected", "true");
		}
	});
	
	
		// 유효성 검사
		function validate(){
			if($(".titleArea").val().trim().length ==0){
				alert("제목을 입력해 주세요.");
				$(".titleArea").focus();
				return false;
			}
			
			
			if($("#summernote").val().trim().length ==0){
				alert("내용을 입력해 주세요.");
				$(".summernote").focus();
				return false;
			}
		}
		
		</script>
</body>
</html>