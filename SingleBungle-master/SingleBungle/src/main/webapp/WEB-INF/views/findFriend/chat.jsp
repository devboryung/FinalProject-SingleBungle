<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만남의 광장 채팅</title>

<!-- Core theme CSS (includes Bootstrap)-->
<link href="${contextPath}/resources/css/resume-styles.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.nicescroll/3.6.8-fix/jquery.nicescroll.min.js"></script>

<style>
.chat .avatar {
	width: 40px;
	height: 40px;
}

.chat .avatar img {
	display: block;
	border-radius: 20px;
	height: 100%;
}

/*****************CHAT BODY *******************/
.display-chatting{
   width : 100%;
   height : 600px;
   overflow: auto;
}

.chat-body {
	padding-left : 10px;
	padding-right : 10px;
	padding-top : 10px;
	padding-bottom : 20px;
}

.chat-body .answer.left {
	padding: 0 0 0 58px;
	text-align: left;
	float: left;
}

.chat-body .answer {
	position: relative;
	max-width: 600px;
	overflow: hidden;
	clear: both;
}

.chat-body .answer.left .avatar {
	left: 0;
}

.chat-body .answer .avatar {
	bottom: 36px;
}

.chat .avatar {
	width: 40px;
	height: 40px;
	position: absolute;
}

.chat .avatar img {
	display: block;
	border-radius: 20px;
	height: 100%;
}

.chat-body .answer .name {
	font-size: 14px;
	line-height: 36px;
}

.chat-body .answer.left .text {
	background: #ebebeb;
	color: #333333;
	border-radius: 8px 8px 8px 0;
}

.chat-body .answer .text {
	padding: 12px;
	font-size: 16px;
	line-height: 26px;
	position: relative;
}

.chat-body .answer.left .text:before {
	left: -30px;
	border-right-color: #ebebeb;
	border-right-width: 12px;
}

.chat-body .answer .text:before {
	content: '';
	display: block;
	position: absolute;
	bottom: 0;
	border: 18px solid transparent;
	border-bottom-width: 0;
}

.chat-body .answer.left .time {
	padding-left: 12px;
	color: #333333;
	
}

.chat-body .answer .time {
	font-size: 16px;
	line-height: 36px;
	position: relative;
	padding-bottom: 1px;
}
/*RIGHT*/
.chat-body .answer.right {
	padding: 0 58px 0 0;
	text-align: right;
	float: right;
}

.chat-body .answer.right .avatar {
	right: 0;
}

.chat-body .answer.right .text {
	background: #ffc823;
	color: #ffffff;
	border-radius: 8px 8px 0 8px;
}

.chat-body .answer.right .text:before {
	right: -30px;
	border-left-color: #ffc823;
	border-left-width: 12px;
}

.chat-body .answer.right .time {
	padding-right: 12px;
	color: #333333;
}

/**************ADD FORM ***************/
.chat textarea {
	-webkit-appearance: none;
	border-radius: 0;
}

.input-area, #inputChatting{
   width: 100%;
   height: 70px;
   display: flex;
}

#inputChatting{
   width : 80%;
   resize : none;
   margin-left: 20px;
}
</style>
</head>
<body>

	<div>
		<div class="row no-gutters">
			<div class="content col-sm-12">
				<div class="chat">
					<div class="display-chatting">
						<div class="chat-body">
							<!-- <h5>참여인원</h5> -->
							<%-- <div class="answer left">
								<div class="avatar">
									<img src="${contextPath}/resources/images/profile.png" alt="User name">
									<div class="status offline"></div>
								</div>
								<div class="name">며네</div>
								<div class="text">몇 시에 만나요?</div>
								<div class="time">5분전</div>
							</div>
							<div class="answer right">
								<div class="avatar">
									<img src="${contextPath}/resources/images/profile.png" alt="User name">
									<div class="status offline"></div>
								</div>
								<div class="name">달마고</div>
								<div class="text">저녁 어때요?</div>
								<div class="time">5분전</div>
							</div>
							<div class="answer left">
								<div class="avatar">
									<img src="${contextPath}/resources/images/profile.png" alt="User name">
									<div class="status online"></div>
								</div>
								<div class="name">크리스탈</div>
								<div class="text">저녁 좋아요</div>
								<div class="time">5분전</div>
							</div>
							<div class="answer right">
								<div class="avatar">
									<img src="${contextPath}/resources/images/profile.png" alt="User name">
									<div class="status busy"></div>
								</div>
								<div class="name">달마고</div>
								<div class="text">8시에 만나요</div>
								<div class="time">3분 전</div>
							</div>
							<div class="answer right">
								<div class="avatar">
									<img src="${contextPath}/resources/images/profile.png" alt="User name">
									<div class="status off"></div>
								</div>
								<div class="name">달마고</div>
								<div class="text">아니다 8시 30분에 만나요</div>
								<div class="time">3분 전</div>
							</div>
							<div class="answer left">
								<div class="avatar">
									<img src="${contextPath}/resources/images/profile.png" alt="User name">
									<div class="status offline"></div>
								</div>
								<div class="name">며네</div>
								<div class="text">좋아요</div>
								<div class="time">2분 전</div>
							</div> --%>


						</div>
					</div>
						<div class="col-lg-8">
							<div class="answer-add">
								<div class="input-area">
									<textarea id="inputChatting" rows="3" placeholder="메세지를 입력해주세요."></textarea>
									<button id="send" class="btn btn-warning">전송</button>
								</div>
							</div>
						</div>
				</div>
			</div>
		</div>
	</div>
	
	<!--------------------------------------- sockjs를 이용한 WebSocket 구현을 위해 라이브러리 추가 ---------------------------------------------->
  <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>	

	<script>
		// ------------------------------------ WebSocket ------------------------------------
		
		var chattingSock; // SockJS를 이용한 WebSoket객체 저장 변수 선언
		
		// 로그인이 되어 있을때만
		// 서버측 /chat 이라는 주소로 통신을 할 수 있는 WebSocket
		<c:if test="${!empty loginMember}">
			chattingSock = new SockJS("${contextPath}/chat");
			//chattingSock.onclose = onClose;
			//chattingSock.onopen = onOpen;
		</c:if>
		
		// 로그인한 회원이 채팅 입력 후 보내기 버튼을 클릭한 경우 채팅 내용이 서버로 전달됨
		// (전달할 내용 : 게시글 번호 + 로그인한 회원의 닉네임 + 입력한 채팅 + 채팅 시간 )
		var nickname = "${loginMember.memberNickname}";
		var loginMemberNo = "${loginMember.memberNo}";
		var loginMemberGrade = "${loginMember.memberGrade}";
		var friendNo = "${friendNo}";
		
		$("#inputChatting").keyup(function(e){
			if(e.keyCode == 13){
				if(e.shiftKey === false){
					$("#send").click();
				}
			}
		});
		
		$("#send").on("click", function(){
			
			if(nickname == ""){
				alert("로그인 후 이용해주세요");
			}else{
				
				var chat = $("#inputChatting").val();
				
				if(chat.trim().length == 0){
					alert("채팅을 입력해 주세요.");
					
				}else{
					
					var obj = {};
					obj.friendNo = friendNo;
					obj.memberNo = loginMemberNo;
					obj.nickname = nickname;
					obj.memberGrade = loginMemberGrade;
					obj.chat = chat.replace(/\n/g, "<br>");
					
					var date = new Date();
					
					var year = date.getFullYear();
			    var month = date.getMonth()+1;
			    var day = date.getDate(); 
			    var hours = date.getHours(); 
			    var minutes = date.getMinutes();
			    var seconds = date.getSeconds();
			    
			    if ((month+"").length < 2) month = "0" + month;
			    if ((day+"").length < 2) day = "0" + day;
			    if ((hours+"").length < 2) hours = "0" + hours;
			    if ((minutes+"").length < 2) minutes = "0" + minutes;
			    if ((seconds+"").length < 2) seconds = "0" + seconds;
					
					var time = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
					obj.time = time;
					
					
					// 작성자와 채팅 내용이 담긴 obj 객체를 JSON 형태로 변환하여 웹소켓 핸들러로 보내기
					chattingSock.send( JSON.stringify(obj) );
					
					$("#inputChatting").val("");
					
				}
				
			}
			
		});
		
		// 채팅에서 나갔을 때
		/* function onClose(event){
			
			var str = nickname + "님 퇴장.";
			
			$(".display-chatting").append(str);
			
		} */
		
		// 채팅에 들어왔을 때
		/* function onOpen(event){
			
			var str = nickname + "님 등장!";
			
			$(".display-chatting").append(str);
			
		} */
		
		// WebSocket 객체 chattingSock이 서버로부터 받은 메세지가 있을 경우 수행되는 콜백 함수
		chattingSock.onmessage = function(event){
			
			var obj = JSON.parse(event.data);
			
			var chatBody = $("<div>").addClass("chat-body");
			
			var answerRight = $("<div>").addClass("answer right");
			
			var answerLeft = $("<div>").addClass("answer left");
			
			var avatar = $("<div>").addClass("avatar");
			
		  var image = null;
             
		  if(obj.memberGrade == 'F'){
    	  image = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/grade1.png").css({"width": "30px;","height": "30px;"});
      }else if(obj.memberGrade == 'S'){
    	  image = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/grade2.png").css({"width": "30px;","height": "30px;"});                   
      }else if(obj.memberGrade == 'T'){
    	  image = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/grade3.png").css({"width": "30px;","height": "30px;"});                   
      }else{ㄴ
    	  image = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/gradeG.png").css({"width": "30px;","height": "30px;"});                      
      }
			
			avatar.append(image);
			
			// -> 자바스크립트에는 replaceAll() 메소드가 없으므로 정규 표현식을 이용하여 변경
			var chat = obj.chat.replace(/\n/g, "<br>");
			var time = obj.time;
			var nickname = obj.nickname;
			
			var name = $("<div>").addClass("name").text(nickname);
			var text = $("<div>").addClass("text").html(chat);
			var time = $("<div>").addClass("time").text(time);
			
			
			if(obj.memberNo == loginMemberNo){
				answerRight.append(avatar).append(name).append(text).append(time);
				chatBody.append(answerRight);
			}else{
				answerLeft.append(avatar).append(name).append(text).append(time);
				chatBody.append(answerLeft);
			}
			
			$(".display-chatting").append(chatBody);
			
			// 채팅 입력 시 스크롤을 가장 아래로 내리기
			$(".display-chatting").scrollTop($(".display-chatting")[0].scrollHeight);		
			
		};
		
		// ------------------------------------------------------------------------
		
		// 페이지 로딩 완료 시 채팅 목록 호출
		$(function(){
			selectChatList();
		});
		
		function selectChatList(){
			
			$.ajax({
				url : "${contextPath}/findFriendChat/selectChatList/" + friendNo,
				type : "post",
				dataType : "json",
				success : function(cList){
					
					console.log(cList);
					
					$.each(cList, function(index, item){
						
						var chatBody = $("<div>").addClass("chat-body");
						
						var answerRight = $("<div>").addClass("answer right");
						
						var answerLeft = $("<div>").addClass("answer left");
						
						var avatar = $("<div>").addClass("avatar");
						
						var image = null;
			             
			      if(item.memGrade == 'F'){
			    	  image = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/grade1.png").css({"width": "30px;","height": "30px;"});
			      }else if(item.memGrade == 'S'){
			    	  image = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/grade2.png").css({"width": "30px;","height": "30px;"});                   
			      }else if(item.memGrade == 'T'){
			    	  image = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/grade3.png").css({"width": "30px;","height": "30px;"});                   
			      }else{
			    	  image = $("<img>").addClass("mr-3 rounded-circle").attr("src", "${contextPath}/resources/images/gradeG.png").css({"width": "30px;","height": "30px;"});                      
			      }
						
						avatar.append(image);
						
						var chat = item.message;
						var time = item.createDate;
						var nickname = item.nickname;
						
						var name = $("<div>").addClass("name").text(nickname);
						var text = $("<div>").addClass("text").html(chat);
						var time = $("<div>").addClass("time").text(time);
						
						if(item.memNo == loginMemberNo){
							answerRight.append(avatar).append(name).append(text).append(time);
							chatBody.append(answerRight);
						}else{
							answerLeft.append(avatar).append(name).append(text).append(time);
							chatBody.append(answerLeft);
						}
						
						$(".display-chatting").append(chatBody);
						
						// 채팅 입력 시 스크롤을 가장 아래로 내리기
						$(".display-chatting").scrollTop($(".display-chatting")[0].scrollHeight);		
					
					});
					
				}, error : function(){
					console.log("채팅 목록 조회 실패")
				}
				
			});
			
		}
		
	</script>
</body>
</html>