<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>벙글장터 - 댓글 신고</title>

<!-- Core theme CSS (includes Bootstrap)-->
<link href="${contextPath}/resources/css/resume-styles.css" rel="stylesheet" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

<!-- sweetalert : alert창을 꾸밀 수 있게 해주는 라이브러리 https://sweetalert.js.org/ -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
	    .maincolor{
        color: #ffffff !important; 
        background-color:#ffaf18 !important;
        border: 1px solid #ffaf18 !important;
    }
    .maincolor:hover{
        color: #ffffff !important; 
        background-color:#ff8500 !important;
        border: 1px solid #ffc823 !important;
    }

    /* 버튼 반대로 : 흰 바탕, 주황 테두리 */
    .maincolor-re{
            color: #ff8500 !important;
            background-color: #ffffff !important;
            border: 1px solid #ffaf18 !important;
    }
    .maincolor-re:hover{
        color: #ffffff !important; 
        background-color:#ff8500 !important;
        border: 1px solid #ffc823 !important;
    }
</style>
</head>
<body>
<c:if test="${swalIcon == 'success' }">
	<script>
		swal({icon : "${swalIcon}",
		 title : "${swalTitle}",
		 text : "${swalText}"}).then(function(){close()});
	</script>
</c:if>
<c:if test="${swalIcon == 'error' }">
	<script>
		swal({icon : "${swalIcon}",
		 title : "${swalTitle}",
		 text : "${swalText}"});
	</script>
</c:if>
   <div class="container my-5" style="padding-left: 40px; padding-right: 40px;">
     <form method="POST" action="../marketReplyReportAction" class="needs-validation" name="report">
     <input type="hidden" name="replyNo" value="${replyNo }">
     <input type="hidden" name="marketNo" value="${param.marketNo}">
     <div class="form-group row">
      <label for="recipient-name" class="col-sm-3 col-form-label">신고 제목</label>
       <div class="col-sm-9">
             <input type="text" class="form-control" id="recipient-name" name="reportTitle" placeholder="신고 제목을 입력해 주세요." required>
          </div>
     </div>

         <div class="form-group row">
             <label class="input-group-addon col-sm-3 insert-label">신고 사유</label>
             <div class="col-sm-9">
             <select class="form-control div small" id="category" name="categoryCode" required>
                 <option value="1">욕설, 비방, 차별, 혐오</option>
                 <option value="2">홍보, 영리목적</option>
                 <option value="3">불법 정보</option>
                 <option value="4">음란, 청소년 유해</option>
                 <option value="5">개인 정보 노출, 유포, 거래</option>
                 <option value="6">도배, 스팸</option>
                 <option value="7">기타</option>
             </select>
             </div>
         </div>


         <div class="form-group row">
             <label for="content" class="col-sm-3 col-form-label">신고 내용</label>
             <div class="col-sm-9">
             <textarea class="form-control" id="reportReply" name="reportContent" rows="10" style="resize: none;" required></textarea>
             </div>
         </div>
         <div class="form-group row">
               <div class="col-sm-12" style="text-align:center; margin-top:30px;">
                <button type="submit" class="btn maincolor">신고</button>
                <button type="button" class="btn maincolor-re" id="cancelBtn" onclick="window.close();">취소</button>
             </div>
         </div>
     </form>
    </div>
</body>

</body>
</html>
