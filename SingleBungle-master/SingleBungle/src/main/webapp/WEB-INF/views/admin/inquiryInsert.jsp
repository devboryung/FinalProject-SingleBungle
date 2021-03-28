<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1:1 문의 작성</title>

    
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

   <!-- summernote 사용 시 필요한 js 파일 추가  -->
   <script src="${contextPath }/resources/summernote/js/summernote-lite.js"></script> <!-- 이 코드가 있어야 섬머노트 사용 가능  -->
   <script src="${contextPath }/resources/summernote/js/summernote-ko-KR.js"></script> <!-- 한글 패치  -->
   <script src="${contextPath }/resources/summernote/js/mySummernote.js"></script> <!-- 개인이 만든 js  -->

    <div class="container">
        <div class="row">

            <div class="col-md-12">
                <h4>1:1 문의 작성</h4>
                <hr>

                <form action="insertinquiryAction" enctype="multipart/form-data" method="post" role="form" onsubmit="return validate();">
                    <div class="mb-2">
                        <label class="input-group-addon mr-3 insert-label">문의유형</label>
                        <select   class="form-select" id="category" name="categoryCode" style="width: 150px; height: 30px;">
                            <option value="1">이용문의</option>
                            <option value="2">게시판문의</option>
                            <option value="3">회원서비스</option>
                        </select>
                    </div>

                    <div class="form-inline mb-2">
                        <label class="input-group-addon mr-3 insert-label">제목</label>
                        <input type="text" class="form-control" id="title" name="inquiryTitle" size="100%" required>
                    </div>

                    <div class="form-group">
                        <div>
                            <label for="content">내용</label>
                        </div>
                        <textarea class="form-control" id="summernote" name="inquiryContent"
                            rows="10" style="resize: none;" placeholder="문의내용을 자세하게 작성해주세요" required></textarea>
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
 
 
	// 이미지 영역을 클릭할 때 파일 첨부 창이 뜨도록 설정하는 함수
	$(function(){
		$("#fileArea").hide(); // #fileArea 요소를 숨김.		
		
		$(".boardImg").on("click", function(){ // 이미지 영역이 클릭 되었을 때
			
			// 클릭한 이미지 영역 인덱스 얻어오기
			var index = $(".boardImg").index(this);
					// -> 클릭된 요소가 .boardImg 중 몇번째 인덱스인지 반환
					
			//console.log(index);
			
			// 클릭된 영역 인덱스에 맞는 input file 태그 클릭
			$("#img" + index).click();
		});
		
	});
	 
	
	
  // 각각의 영역에 파일을 첨부 했을 경우 미리 보기가 가능하도록 하는 함수
  function LoadImg(value, num) {
	  // value.files : 파일이 업로드되어 있으면 true
	  // value.files[0] : 여러 파일 중 첫번째 파일이 업로드 되어 있으면 true
	  
		if(value.files && value.files[0]){ // 해당 요소에 업로드된 파일이 있을 경우
			
			var reader = new FileReader();
   	// 자바스크립트 FileReader
  	// 웹 애플리케이션이 비동기적으로 데이터를 읽기 위하여 
  	// 읽을 파일을 가리키는 File 혹은 Blob객체를 이용해 
  	// 파일의 내용을 읽고 사용자의 컴퓨터에 저장하는 것을 가능하게 해주는 객체
  	
  	reader.readAsDataURL(value.files[0]);
    // FileReader.readAsDataURL()
  	// 지정된의 내용을 읽기 시작합니다. 
  	// Blob완료되면 result속성 data:에 파일 데이터를 나타내는 URL이 포함 됩니다.	
  	
  	reader.onload = function(e){
    	// FileReader.onload
				// load 이벤트의 핸들러. 
				// 이 이벤트는 읽기 동작이 성공적으로 완료 되었을 때마다 발생합니다.	
  		
				// 읽어들인 내용(이미지 파일)을 화면에 출력
				
				$(".boardImg").eq(num).children("img").attr("src", e.target.result);
				// e.target.result : 파일 읽기 동작을 성공한 요소가 읽어들인 파일 내용
				
  	}
		}
	}
  
  
  // 취소버튼
	$("#cancel").on("click", function(){
		if(confirm("목록으로 돌아가시겠습니까?")){
	         location.href = "inquiryList";
	  }
	});
    </script>
</body>
</html>