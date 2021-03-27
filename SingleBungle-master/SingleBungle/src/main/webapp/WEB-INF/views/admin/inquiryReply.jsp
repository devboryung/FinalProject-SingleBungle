<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 답변</title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

<!-- Bootstrap core JS -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

<style>
/* 댓글 */
.card {
   position: relative;
   display: flex;
   flex-direction: column;
   min-width: 0;
   word-wrap: break-word;
   background-color: #fff;
   background-clip: border-box;
   border: 1px solid #d2d2dc;
}
 
.media img {
   width: 30px;
   height: 30px;
}

.reReply {
   clear: both;
}

/*  댓글 작성 */
.createReply {
   height: 150px;
   background-color: honeydew;
}

.textArea {
   width: 100%;
   height: 110px;
   resize: none;
   padding: 10px;
}
</style>

</head>
<body>
	
	<!-- 댓글 -->
	<div class="row bg-light" style="margin-top: 15px;">
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-12">
				
					<!-- 댓글 출력 부분 -->
					<div class="replyListArea">
					</div>

				<c:if test="${empty replyList }">
					<!-- 댓글 작성창 -->
					<div class="p-2" id="rInsert">
						<div class="d-flex flex-row align-items-start">
							<img class="rounded-circle" src="${contextPath}/resources/images/profile.png" width="35">
							<textarea class="form-control ml-1 shadow-none textarea" id="replyContent" style="resize: none"> </textarea>
						</div>
						<div class="mt-2 text-right">
							<button class="btn btn-primary btn-sm shadow-none  maincolor1"  id="addReply">등록</button>
							<button class="btn btn-outline-primary btn-sm ml-1 shadow-none maincolor-re1" id="resetReply" type="button">취소</button>
						</div>
					</div>
				</c:if>
					
				</div>
			</div>
		</div>
	</div>
	<!-- 댓글 END -->
					
					

	<script>
	
	var memberNo = "${loginMember.memberNo}";
	var parentBoardNo = "${inquiry.inquiryNo}";
	var nickName = "${loginMember.memberNickname}";
	
	
		$(function(){
			selectReplyList();
		});
		
		
		
		
		// 댓글 목록 불러오기
		function selectReplyList(){
			
			
			$.ajax({
				url : "${contextPath}/adminReply/selectReplyList/" + parentBoardNo,
				type : "post",
				dataType : "json",
				success : function(rList){
					var replyListArea = $(".replyListArea");

					// 기존 정보 초기화
					replyListArea.html("");
					console.log(rList);
					
					if(rList.length!=0 || memberNo != 4){
						var parent = document.getElementById("rInsert");
						parent.style.display = 'none';
					}
					
					// 댓글 List 반복 접근
					$.each(rList, function(index, item){
						
						var media = $("<div>").addClass("media mt-2").css({"border-bottom-color": "lightgray", "border-bottom-style":"solid", "border-bottom-width":"thin"});
						
						var img = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/gradeG.png")
						.css({"width": "30px;","height": "30px;"});
						
						
						// 작성자, 작성일 영역
						var mediaBody = $("<div>").addClass("media-body");
						var row = $("<div>").addClass("row");
						var col8 = $("<div>").addClass("col-8 d-flex");
						var nickname = $("<h6>").css({"margin-right":"5px", "font-weight":"5px"}).html("관리자");
						var createDt = $("<span>").css({"color":"gray", "font-size": "12px"}).html(item.createDt);
						
						
						// 내용 영역
						var replyText = $("<div>").addClass("replyText").css({"margin-bottom":"5px"}).html(item.inquiryContent);
						
						var floatRight2 = $("<div>").addClass("float-right").attr("style", "font-size: 13px;");

						col8.append(nickname).append(createDt);
						row.append(col8);
						mediaBody.append(row);
						mediaBody.append(replyText);
						media.append(img).append(mediaBody);
						replyListArea.append(media);

						
					});
					
				}, error : function(){
						console.log("댓글 목록 조회 실패")
					}

			});
			
		}
		
		
		
		//------------------------------------------------------------------------------------		
		
		
		
		// 댓글 등록
		$("#addReply").on("click",function(){
			
			if(memberNo != 4){
				swal({icon : "info", title : "관리자만 답글을 작성할 수 있습니다."});
			}else{
				var replyContent = $("#replyContent").val();
				
				if(replyContent.trim().length == 0){
					swal({icon:"info", title:"댓글을 작성해 주세요."});
				}else{
					$.ajax({
						url : "${contextPath}/adminReply/insertReplyList/" + parentBoardNo,
						type : "post",
						data : { "replyContent":replyContent},
						success : function(result){
							if(result>0){
								$(".replyContent").val("");
								swal({icon:"success", title:"댓글이 작성되었습니다."});
								selectReplyList();
							}
						}, error : function(){
							console.log("댓글 작성 실패");
						}
					});
				}
				
			}
			
		});
		
		
		// 댓글 등록 취소
		$("#resetReply").on("click",function(){
			$("#replyContent").val("");
		});


	</script>
</body>
</html>