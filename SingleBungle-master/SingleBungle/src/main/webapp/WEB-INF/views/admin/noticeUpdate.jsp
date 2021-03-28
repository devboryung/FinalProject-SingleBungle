<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 작성</title>

    
    <!-- 부트스트랩 사용을 위한 css 추가 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
    integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    
    <!-- 부트스트랩 사용을 위한 라이브러리 추가 -->
    <!-- 제이쿼리가 항상 먼저여야함 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
    crossorigin="anonymous"></script>
    
    

   <!-- summernote 사용 시 필요한 css 파일 추가  -->
    <link rel="stylesheet" href="${contextPath}/resources/summernote/css/summernote-lite.css">
        
    <style>
        form{
            margin-top: 50px;
        }
        
      
      .note-editor{
         width : 100% !important;
      } 
      
      
   </style>
    </head>
<body>
<jsp:include page="../common/header.jsp"/>

   <!-- summernote 사용 시 필요한 js 파일 추가  -->
   <script src="${contextPath }/resources/summernote/js/summernote-lite.js"></script> <!-- 이 코드가 있어야 섬머노트 사용 가능  -->
   <script src="${contextPath }/resources/summernote/js/summernote-ko-KR.js"></script> <!-- 한글 패치  -->
   <script src="${contextPath }/resources/summernote/js/mySummernote.js"></script> <!-- 개인이 만든 js  -->

    <div class="container">
        <div class="row">

            <div class="col-md-12">
                <h4>공지사항 작성</h4>
                <hr>

                <form action="../../updateAction" enctype="multipart/form-data" method="post" role="form" onsubmit="return validate();">

                    <div class="form-inline mb-2">
                        <label class="input-group-addon mr-3 insert-label">제목</label>
                        <input type="text" class="form-control" id="title" name="boardTitle" size="100%" required autocomplete="off" value="${board.boardTitle }">
                    	<input type="hidden" name="boardNo" value="${board.boardNo }"> 
                    	<input type="hidden" name="boardCode" value="${board.boardCode }"> 
                    </div>

                    <div id="fileArea">
						<input type="file" id="img0" name="images" onchange="LoadImg(this,0)"> 
					</div>
                    <div class="form-group">
                    
                        <div>
                            <label for="content">내용</label>
                        </div>
                        <textarea class="form-control" id="summernote" name="boardContent"
                              required>${board.boardContent }</textarea>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-secondary mb-3 btn-warning">등록</button>
                        <a class="btn btn-success float-right" href="${contextPath}/admin/noticeList">취소</a>
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

		if ($("#content").val().trim().length == 0) {
			alert("내용을 입력해 주세요.");
			$("#content").focus();
			return false;
		}
	}
 
 
	
	
 
    </script>
</body>
</html>