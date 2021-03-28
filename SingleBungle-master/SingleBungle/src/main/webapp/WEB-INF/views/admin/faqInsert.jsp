<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ 작성</title>

    
    <!-- 부트스트랩 사용을 위한 css 추가 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
    integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    
    <!-- 부트스트랩 사용을 위한 라이브러리 추가 -->
    <!-- 제이쿼리가 항상 먼저여야함 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
    crossorigin="anonymous"></script>

    <link rel="stylesheet" href="${contextPath}/resources/summernote/css/summernote-lite.css">
        
    <style>
        form{
            margin-top: 50px;
        }
 
    </style>
<body>
<jsp:include page="../common/header.jsp"/>
<script src="${contextPath }/resources/summernote/js/summernote-lite.js"></script> <!-- 이 코드가 있어야 섬머노트 사용 가능  -->
   <script src="${contextPath }/resources/summernote/js/summernote-ko-KR.js"></script> <!-- 한글 패치  -->

    <div class="container">
        <div class="row">

            <div class="col-md-12">
                <h4>FAQ 작성</h4>
                <hr>

                <form action="insertFaqAction" method="post" role="form" onsubmit="return validate();">

                    <div class="form-inline mb-2">
                        <label class="input-group-addon mr-3 insert-label">질문</label>
                        <input type="text" class="form-control" id="title" name="boardTitle" size="100%" required>
                    </div><br>

                    <div class="mb-2">
                        <label class="input-group-addon mr-3 insert-label">카테고리</label>
                        <select   class="form-select" id="category" name="categoryCode" style="width: 150px; height: 30px;">
                            <option value="51">이용문의</option>
                            <option value="52">게시판문의</option>
                            <option value="53">회원서비스</option>
                        </select>
                    </div>


                    <div class="form-group">
                        <div>
                            <label for="content">답변</label>
                        </div>
                        <textarea class="form-control" id="summernote" name="boardContent"
                            rows="10" style="resize: none;" required></textarea>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-secondary mb-3 btn-warning">등록</button>
                        <a class="btn btn-success float-right" id="cancel">취소</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
    
    <script>
    $('#summernote').summernote({
        height: 600,          // 기본 높이값
		width : 1110,

        focus: true,          // 페이지가 열릴때 포커스를 지정함

        lang: 'ko-KR'  ,       // 한국어 지정(기본값은 en-US)

        toolbar: [
            // [groupName, [list of button]]
            ['style', ['bold', 'italic', 'underline', 'clear']],
            ['fontsize', ['fontsize']],
            ['color', ['color']],
          ]


      });

    
    function validate() {
		if ($("#title").val().trim().length == 0) {
			alert("제목을 입력해 주세요.");
			$("#title").focus();
			return false;
		}

		if ($("#content").val().trim().length == 0) {
			alert("내용을 입력해 주세요.");
			$("#content").focus();
			return false;
		}
	}

 // 취소버튼
	$("#cancel").on("click", function(){
		if(confirm("목록으로 돌아가시겠습니까?")){
	         location.href = "faqView";
	  }
	});

    </script>
</body>
</html>