<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일상을 말해봐 수정 페이지</title>

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

	.insert-label {
	    display: inline-block;
	    width: 80px;
	    line-height: 40px;
	}
	
	.note-editor{
   	width : 100% !important;
  } 
</style>

	<!-- summernote 사용 시 필요한 css 파일 추가 -->
	<link rel="stylesheet" href="${contextPath}/resources/summernote/css/summernote-lite.css">

</head>
<body>
		<jsp:include page="../common/header.jsp"/>
		
		<!-- summernote 사용 시 필요한 js 파일 추가 -->
		<script src="${contextPath}/resources/summernote/js/summernote-lite.js"></script>
		<script src="${contextPath}/resources/summernote/js/summernote-ko-KR.js"></script>
		<script src="${contextPath}/resources/summernote/js/mySummernote.js"></script>
	
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                
                <h4>자유게시판 수정</h4>

                <form action="updateAction" method="post" enctype="multipart/form-data" name="updateForm" role="form" onsubmit="return validate();">

                    <div class="form-group row">
                        <label for="title" class="input-group-addon col-sm-1 insert-label">제목</label>
                        <div class="col-sm-11">
                        	<input type="text" class="form-control" id="title" name="boardTitle" value="${board.boardTitle}" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="category" class="input-group-addon col-sm-1 insert-label">카테고리</label>
                        <div class="col-sm-4">
	                        <select	class="form-control div small" id="category" name="categoryCode" style="width: 150px; height: 40px;" required>
	                            <option value="13">일상</option>
	                            <option value="11">여행</option>
	                            <option value="12">영화</option>
	                            <option value="14">경제</option>
	                            <option value="15">반려동물</option>
	                            <option value="16">요리레시피</option>
	                        </select>
                        </div>
                    </div>
										<hr>
                    <div class="form-group">
												<div>
													<label>내용</label>
												</div>
                        <textarea class="form-control" id="summernote" name="boardContent" rows="10" style="resize: none;" required>${board.boardContent}</textarea>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn maincolor1 mb-3">수정</button>
                        </div>
                    <div class="text-right">
                    		<button type="button" class="btn maincolor-re1 mb-3" id="insert-list">목록으로</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
		<jsp:include page="../common/footer.jsp"/>
		
		<script>
		// 유효성 검사
		function validate() {
			if ($("#title").val().trim().length == 0) {
				alert("제목을 입력해 주세요.");
				$("#title").focus();
				return false;
			}

			if ($("#summernote").val().trim().length == 0) {
				alert("내용을 입력해 주세요.");
				$("#summernote").focus();
				return false;
			}
		}
		
		// 목록버튼
		$("#insert-list").on("click", function(){
			if(confirm("목록으로 돌아가시겠습니까?")){
		         location.href = "${sessionScope.returnListURL}";
		  }
		});
		
		// 카테고리 선택
		$.each($("#category > option"), function(index, item){
			if($(item).text() == "${board.categoryName}"){
				$(item).prop("selected", "true");
			}
		});
		
		</script>
		
</body>
</html>