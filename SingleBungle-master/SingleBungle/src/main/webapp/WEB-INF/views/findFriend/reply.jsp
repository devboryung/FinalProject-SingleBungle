<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만남의 광장 게시판 댓글</title>
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

/* 답글 */
.childReply{
	padding-left: 50px;  
}

.childReplyArea{
	padding-top : 30px;
	width : 100%;
  text-align: right;
}

.childReplyContent{
	resize: none;  
	width : 100%; 
}

.replyUpdateContent {
	resize: none;
	width: 100%;
}

/* 댓글, 답글 신고 부분 색상 변경 */
.replyReport, .replyReport:hover {
	text-decoration: none;
	color: #212529;
}
</style>

<!-- 부트스트랩 사용을 위한 css 추가 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
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
		
					<!-- 댓글 작성창 -->
					<div class="p-2">
						<div class="d-flex flex-row align-items-start">
							<c:if test="${loginMember.memberGrade == 'F'}"><img class="rounded-circle" src="${contextPath}/resources/images/grade1.png" width="35"></c:if>
							<c:if test="${loginMember.memberGrade == 'S'}"><img class="rounded-circle" src="${contextPath}/resources/images/grade2.png" width="35"></c:if>
							<c:if test="${loginMember.memberGrade == 'T'}"><img class="rounded-circle" src="${contextPath}/resources/images/grade3.png" width="35"></c:if>
							<c:if test="${loginMember.memberGrade == 'G'}"><img class="rounded-circle" src="${contextPath}/resources/images/gradeG.png" width="35"></c:if>
							<textarea class="form-control ml-1 shadow-none textarea" id="replyContent" style="resize: none"> </textarea>
						</div>
						<div class="mt-2 text-right">
							<button class="btn btn-primary btn-sm shadow-none maincolor1" id="addReply">등록</button>
							<button class="btn btn-outline-primary btn-sm ml-1 shadow-none maincolor-re1" id="cancelBtn" type="button">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 댓글 END -->
	
	<script>
	var memNo = "${loginMember.memberNo}";
	var parentFriendNo = "${findFriend.friendNo}";
	
	// 페이지 로딩 완료 시 댓글 목록 호출
	$(function(){
		selectReplyList();
	});
	
	// 댓글 목록 불러오기
	function selectReplyList(){
		
		$.ajax({
			url : "${contextPath}/findFriendReply/selectReplyList/" + parentFriendNo,
			type : "post",
			dataType : "json",
			success : function(rList){
				
			console.log(rList)
				
			var replyListArea = $(".replyListArea");

			// 기존 정보 초기화
			replyListArea.html("");
			
			// 댓글 List 반복 접근
			$.each(rList, function(index, item){
				
				var media = $("<div>").addClass("media mt-2 replyBorder");
				
				// 이미지
				var memberGrade = item.memGrade;

        var img = null;
       
        if(memberGrade == 'F'){
           img = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/grade1.png").css({"width": "30px;","height": "30px;"});
        }else if(memberGrade=='S'){
           img = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/grade2.png").css({"width": "30px;","height": "30px;"});                   
        }else if(memberGrade=="T"){
           img = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/grade3.png").css({"width": "30px;","height": "30px;"});                   
        }else{
           img = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/gradeG.png").css({"width": "30px;","height": "30px;"});                      
        }

					
				// 작성자, 작성일 영역
				var mediaBody = $("<div>").addClass("media-body");
				var row = $("<div>").addClass("row");
				var col8 = $("<div>").addClass("col-8 d-flex");
				var nickname = $("<h5>").html(item.nickname).css({"margin-right":"5px"});
				var createDt = $("<span>").css({"color" : "gray", "font-size" : "12px"}).html(item.replyCreateDt);
				
				// 답글, 신고 버튼 영역
				var col4 = $("<div>").addClass("col-4");
				var floatRight = $("<div>").addClass("reply float-right");
				var reply2 = $("<a>").addClass("childReply maincolor2").attr("onclick", "addChildReplyArea(this, "+ item.parentReplyNo + ")").text("답글").css({"margin-right":"5px"});
				var report = $("<a class='replyReport maincolor2'>").attr("href", "javascript:void(0)").attr("onclick", "openReport(" + item.replyNo + ")").text("신고");
				
				// 내용 영역
				var replyText = $("<div>").addClass("replyText").html(item.replyContent);
				
				var floatRight2 = $("<div>").addClass("float-right").attr("style", "font-size: 13px;");
				var replyUpdate = $("<a>").addClass("replyUpdate maincolor2").css({"margin-right":"5px"}).attr("onclick", "showUpdateReply(" + item.replyNo + ", this)").text("수정");
				var replyDelete = $("<a>").addClass("replyDelete maincolor-re2").attr("onclick", "deleteReply(" + item.replyNo + ")").text("삭제");
			
				// 밑줄
				var hr = $("<hr>");
				
				// 댓글의 깊이가 1인 요소는 별도의 스타일을 지정할 수 있도록 클래스 추가
				if(item.replyDepth == 1){
					media.addClass("childReply");
				}
				
				// 댓글의 깊이가 0인 요소 답글 버튼 추가
				if(item.replyDepth == 0){
					floatRight.append(reply2);
				}
				
				// 로그인이 되어 있고, 자신의 글이 아닐 경우에 신고 버튼 추가
				if(memNo != "" && item.memNo != memNo){
					col8.append(nickname).append(createDt);
					floatRight.append(report);
					col4.append(floatRight);
					row.append(col8).append(col4);
					mediaBody.append(row);
					mediaBody.append(replyText);
					media.append(img).append(mediaBody);
					replyListArea.append(media).append(hr);
			
				// 현재 댓글의 작성자와 로그인한 멤버의 아이디가 같을 때 수정/삭제 버튼 추가
				}else if(item.memNo == memNo){
					col8.append(nickname).append(createDt);
					row.append(col8);
					mediaBody.append(row);
					mediaBody.append(replyText);
					floatRight2.append(replyUpdate).append(replyDelete);
					mediaBody.append(floatRight2);
					media.append(img).append(mediaBody);
					replyListArea.append(media).append(hr);

				}
				
			});
				
			}, error : function(){
				console.log("댓글 목록 조회 실패")
			}
			
		});
		
	}
	
	//-----------------------------------------------------------------------------------------
	
	// 댓글 입력 취소
	$("#cancelBtn").on("click", function(){
		$("#replyContent").val("");
	});
	
	//-----------------------------------------------------------------------------------------
	
	// 댓글 등록
	$("#addReply").on("click", function(){
		
		console.log();
		
		if(memNo == 0){
			swal({icon : "info", title : "로그인 후 이용해 주세요."});
		}else{
			
			var replyContent = $("#replyContent").val();
			
			if(replyContent.trim().length == 0){
				swal({icon : "info", title : "댓글을 작성해 주세요."});
			}else{
				
				$.ajax({
					url : "${contextPath}/findFriendReply/insertReplyList/" + parentFriendNo,
					type : "post",
					data : {"memNo" : memNo, "replyContent" : replyContent },
					success : function(result){
						
						if(result > 0){
							
							$("#replyContent").val("");
							swal({icon : "success", title : "댓글이 작성되었습니다."});
							selectReplyList();
						}
						
					}, error : function(){
						console.log("댓글 작성 실패");
					}
					
					
				});
				
			}
			
		}
		
	});
	
	//-----------------------------------------------------------------------------------------
	
	// 댓글 수정 폼
	
	var beforeReplyRow;
	
	function showUpdateReply(replyNo, el){
		
		// 이미 열려있는 댓글 수정 창이 있을 경우 닫아주기
		if($(".replyUpdateContent").length > 0){
			$(".replyUpdateContent").eq(0).parent().html(beforeReplyRow);
		}
		
		// 댓글 수정화면 출력 전 요소 저장
		beforeReplyRow = $(el).parent().parent().html();
		
		// 작성되어있던 내용
		var beforeContent = $(el).parent().prev().html();
		
		// 이전 댓글 내용의 크로스사이트 스크립트 처리 해제, 개행문자 변경
	  // -> 자바스크립트에는 replaceAll() 메소드가 없으므로 정규 표현식을 이용하여 변경
	  beforeContent = beforeContent.replace(/&amp;/g, "&");   
	  beforeContent = beforeContent.replace(/&lt;/g, "<");   
	  beforeContent = beforeContent.replace(/&gt;/g, ">");   
	  beforeContent = beforeContent.replace(/&quot;/g, "\"");   
	  
	  beforeContent = beforeContent.replace(/<br>/g, "\n");   
	  
	  // 기존 댓글 영역을 삭제하고 textarea를 추가
	  $(el).parent().prev().remove();
	  var textarea = $("<textarea>").addClass("replyUpdateContent").attr("rows", "3").val(beforeContent);
	  $(el).parent().before(textarea);
	  
		// 수정 버튼
	  var updateReply = $("<button>").addClass("btn btn-success btn-sm ml-1 mb-4 maincolor1").text("댓글 수정").attr("onclick", "updateReply(" + replyNo + ", this)");
	  
	  // 취소 버튼
	  var cancelBtn = $("<button>").addClass("btn btn-success btn-sm ml-1 mb-4 maincolor-re1").text("취소").attr("onclick", "updateCancel(this)");
	  
	  var replyBtnArea = $(el).parent();
	  
	  $(replyBtnArea).empty(); 
	  $(replyBtnArea).append(updateReply); 
	  $(replyBtnArea).append(cancelBtn); 
		
	}
	
	//-----------------------------------------------------------------------------------------

	// 댓글 수정
	function updateReply(replyNo, el){
		
		var replyContent = $(el).parent().prev().val();
		
		if(replyContent.trim().length == 0){
			swal({icon : "info", title : "댓글을 입력해주세요."});
		}else{
			$.ajax({
				url : "${contextPath}/findFriendReply/updateReply/" + replyNo,
				type : "post",
				data : {"replyContent" : replyContent},
				success : function(result){
					
					if(result > 0){
						swal({icon : "success", title : "댓글 수정 성공"});
						selectReplyList();
					}
					
				}, error : function(){
					console.log("댓글 수정 실패");
				}
				
			});
		}
		
	}
	
	//-----------------------------------------------------------------------------------------

	// 댓글 수정 취소 시 원래대로 돌아가기
	function updateCancel(el){
		$(el).parent().parent().html(beforeReplyRow);
	}
	
	//-----------------------------------------------------------------------------------------

	// 댓글 삭제
	function deleteReply(replyNo){
		
		if(confirm("정말로 삭제하시겠습니까?")){
			
			$.ajax({
				url : "${contextPath}/findFriendReply/deleteReply/" + replyNo,
				success : function(result){
					
					if(result > 0){
						swal({icon : "success", title : "댓글 삭제 성공"});		
						selectReplyList();
					}
					
				}, error : function(){
					console.log("댓글 삭제 실패");
				}
			
			});
		}
	}
	
	//-----------------------------------------------------------------------------------------

	// 답글 버튼 동작 (대댓글 작성 영역 생성)
	function addChildReplyArea(el, parentReplyNo){
		
		// 생성되어 있는 모든 답글 작성 영역을 화면에서 제거
		var check = cancelChildReply();
		
		// 이전에 생성된 대댓글 영역이 모두 삭제된 경우에만 새로운 대댓글 영역 생성
		if(check){
			
			// 댓글 작성자 닉네임 얻어오기
			var writer = $(el).parent().parent().prev().children("h5").text();
			
			// 답글 작성 영역에 필요한 요소(textarea, button 2개) 생성
			
			var div = $("<div>").addClass("childReplyArea"); // 대댓글 작성 영역 전체를 감쌀 div
			var textarea = $("<textarea rows='3'>").addClass("childReplyContent")
											.attr("placeholder", writer + "님께 답글 작성하기");
			
			var btnArea = $("<div>").addClass("btnArea");
			var insertBtn = $("<button>").addClass("btn btn-sm btn-success ml-1 maincolor1").text("등록")
			.attr("onclick", "addChildReply(this, " + parentReplyNo + ")");
			
			var cancelBtn = $("<button>").addClass("btn btn-sm btn-secondary ml-1 reply-cancel maincolor-re1").text("취소")
			.attr("onclick", "cancelChildReply()");
			
			btnArea.append(insertBtn).append(cancelBtn); // 버튼 영역에 등록, 취소 버튼 추가
			div.append(textarea).append(btnArea); // 대댓글 영역에 textarea, 버튼 영역 추가
			
			$(el).parent().parent().parent().parent().parent().after().after(div); // 답글 버튼 부모 요소 다음(이후)에 대댓글 영역 추가
			
			// 추가된 대댓글 영역으로 포커스 이동
			$(".childReplyContent").focus();
			
		}
		
	}
	
	//-----------------------------------------------------------------------------------------
	
	// 답글(대댓글) 취소
	// 내용이 작성되어 있으면 취소버튼 클릭 시 confirm 창 띄우기
	function cancelChildReply(){
		
		// 대댓글 영역에 작성된 내용 얻어오기
		var tmp = $(".childReplyContent").val();
		
		// 대댓글 textarea에 아무것도 작성되지 않았거나, 대댓글 textarea가 없을 경우
		// == 아무것도 작성되지 않으면 confirm창으로 확인하는 과정 없이 바로 닫히게 만듦.
		if(tmp == "" || tmp == undefined){
			// 대댓글 작성 영역 childReplyArea을 모두 제거
			$(".childReplyArea").remove();
		return true;
		}
		
		else{ // 답글 textarea에 무언가 작성되어 있을 경우
			
			var cancelConfirm = confirm("작성된 댓글 내용이 사라집니다. 작성 취소 하시겠습니까?");
		
			if(cancelConfirm){
				$(".childReplyArea").remove();
			}
			
			return cancelConfirm;
			
		}
		
	}
	
	//-----------------------------------------------------------------------------------------

	// 답글(대댓글) 등록
	function addChildReply(el, parentReplyNo){
		
		var replyContent =	$(el).parent().prev().val();
		
		if(replyContent.trim().length == 0){ // 대댓글 미작성 시
			swal({icon : "info", title : "댓글 작성 후 클릭해주세요"});
		}
		
		else{
			$.ajax({
				url : "${contextPath}/findFriendReply/insertChildReply/" + parentFriendNo,
				data : {"parentReplyNo" : parentReplyNo,
								"replyContent" : replyContent,
								"memNo" : memNo},
				
								type : "post",
				success : function(result){
					
					if(result > 0){
						swal({icon : "success", title : "답글 등록 성공"});
						selectReplyList();
					}
					
				}, error : function(){
					console.log("답글 등록 실패");
				}
				
			});		
			
		}
		
	}
	
	// 댓글 신고창 열기
	function openReport(replyNo){
		event.preventDefault(); // a태그 기본 이벤트 제거
		
		window.name = "parentWindow";
		window.open('${contextPath}/findFriendReply/friendReplyReport/' + replyNo + '?friendNo=${findFriend.friendNo}', "popup", "width=550, height=650, toolbars=no, scrollbars=no, menubar=no left=1000 top=200");
	}
	
	</script>

</body>
</html>