<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보낸 쪽지함</title>

<!-- 부트스트랩 사용을 위한 css 추가 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<style>
.messageBox {
	width: 100px;
	height: 50px;
	text-align: center;
	line-height: 50px;
}


table tr td{
	overflow: hidden !important;
	text-overflow: ellipsis !important;
	white-space: nowrap !important;
	max-width :120px;
}


/* 검색창 */
.search {
	text-align: center;
}

/******* 페이징 *******/
.flex {
	-webkit-box-flex: 1;
	-ms-flex: 1 1 auto;
	flex: 1 1 auto
}

#page-content {
	margin-top: 20px;
}

.pagination, .jsgrid .jsgrid-pager {
	display: flex;
	padding-left: 0;
	list-style: none;
	border-radius: 0.25rem
}

.page-item > a, .page-item > a:hover { color: black; }

.pagination.pagination-rounded-flat .page-item {
	margin: 0 .25rem
}

.pagination-success .page-item.active .page-link {
	background: #00c689;
	border-color: #00c689
}

.pagination.pagination-rounded-flat .page-item .page-link {
	border: none;
	border-radius: 50px;
}

.messageBox{
	border-radius : 15px;
	margin : 0 0 10px 20px;
}


html{
	position : relative;
	min-height:100%;
	margin : 0;
}

body {
	min-height:100%;
}


.footer{
	position:absolute;
	left : 0;
	bottom : 0;
	width:100%;
	text-align : center;

}




#messageTable #messageContent, #messageTable #nickName:hover {
	cursor: pointer;
}


</style>


</head>
<body>

	<jsp:include page="../common/header.jsp" />

	<div class="container">
		<div class="row">
			<div class="col-md-12" style="padding-left : 26px">

				<div class="messageBox" style="display: inline-block; color: #ffaf18;	border:1px solid #ffaf18; ">
					<a href="${contextPath}/message/messageBoxR">받은 쪽지</a>
				</div>
				<div class="messageBox" style="display: inline-block; background-color :#ffaf18 ; ">
					<span>보낸 쪽지</span>
				</div>
				<div class="float-right" id="deleteBtn" style="display: inline-block; margin-top: 10px;">
					<button class="maincolor-re" id="deleteBtn" onClick="deleteBtn();">삭제</button>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<table class="table table-stripped" id="messageTable" style="text-align : center;" >
					<thead>
						<tr>
							<th><input type="checkbox" id="checkAll"/></th>
							<th>받는 사람</th>
							<th>내용</th>
							<th>보낸 시간</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty mList }">
							<tr>
								<td colspan="4"> 보낸 쪽지가 없습니다.</td>
							</tr>
						</c:if>
						
						<c:if test="${!empty mList }">
							<c:forEach var="message" items="${mList}" varStatus="vs">
								<tr>
									<td><input type="checkbox" name="chk" value="${message.messageNo}"></td>
									<td><span id="nickName">${message.receiveNickName}</span></td>
									<td id="messageContent">${message.messageContent}</td>
									<td>
									<%-- 날짜 출력 모양 지정 --%>
									<fmt:formatDate var="createDate" value="${message.createDt }" pattern="yyyy-MM-dd"/>
									<fmt:formatDate var="now" value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd"/> 
									<c:choose>
										<c:when test="${createDate != now}">
											${createDate }
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${message.createDt }" pattern="HH:mm"/>
										</c:otherwise>
									</c:choose>									
									</td>
									<input type="hidden" id="sendMemberNo" value="${message.receiveMember }">
								</tr>							
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
		
		
				<!-- 페이징 -->
		<div class="page-content page-container" id="page-content">
			<div class="padding">
				<div class="row container d-flex justify-content-center">
					<div class="col-md-4 col-sm-6 grid-margin stretch-card">
						<nav>
							<ul class="pagination d-flex justify-content-center flex-wrap pagination-rounded-flat pagination-success">
								<c:url var="pageUrl" value="?"/>
								<c:set var="firstPage" value="${pageUrl}cp=1" />
								<c:set var="lastPage" value="${pageUrl}cp=${pInfo.maxPage }" />

								<fmt:parseNumber var="c1" value="${(pInfo.currentPage - 1) / 10 }" integerOnly="true" />
								<fmt:parseNumber var="prev" value="${ c1 * 10 }" integerOnly="true" />
								<c:set var="prevPage" value="${pageUrl}cp=${prev}" />


								<fmt:parseNumber var="c2" value="${(pInfo.currentPage + 9) / 10 }" integerOnly="true" />
								<fmt:parseNumber var="next" value="${ c2 * 10 + 1 }" integerOnly="true" />
								<c:set var="nextPage" value="${pageUrl}cp=${next}" />

								<c:if test="${pInfo.currentPage > pInfo.pageSize}">
									<li class="page-item"><a class="page-link maincolor-re1" href="${firstPage }" data-abc="true"><i class="fas fa-angle-double-left"></i></a></li>
									<li class="page-item"><a class="page-link maincolor-re1" href="${prevPage }" data-abc="true"><i class="fa fa-angle-left"></i></a></li>
								</c:if>

								<c:forEach var="page" begin="${pInfo.startPage }" end="${pInfo.endPage }">
									<c:choose>
										<c:when test="${pInfo.currentPage == page }">
											<li class="page-item active">
												<a class="page-link">${page}</a> <!-- 같은 페이지일때는 클릭이 안 된다.  -->
											</li>
										</c:when>

										<c:otherwise>
											<li class="page-item">
												<a class="page-link maincolor-re1" href="${pageUrl}cp=${page}">${page}</a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:forEach>


								<c:if test="${next <=pInfo.maxPage }">
										<li class="page-item"><a class="page-link maincolor-re1" href="${nextPage }" data-abc="true"><i class="fa fa-angle-right"></i></a></li>
										<li class="page-item"><a class="page-link maincolor-re1" href="${lastPage }" data-abc="true"><i class="fas fa-angle-double-right"></i></a></li>
								</c:if>
								

							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
<!-- 쪽지 읽기  -->
<div id="readMessage" class="modal fade">
	<div class="modal-dialog modal-confirm">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">받는사람 : <span id="receiver" style="font-size:19px;"></span></h5>	
			</div>
			<div class="modal-body">
				<div class="messageArea" id="viewMessage" style="border: 1px solid black;height: 150px; padding:10px;"></div>
			</div>
			<div class="modal-footer" >
                
        <div class="col"><button type="button" class="btn maincolor-re btn-block" data-dismiss="modal"><span class="plan">닫기</span></button></div>
			</div>
		</div>
	</div>
</div>
<!-- 쪽지 읽기 -->		


<!-- 쪽지 보내기  -->
<form  method="POST" action="${contextPath}/message/sendMessage" onsubmit="return messageValidate();">
	<div id="sendMessage" class="modal fade">
		<div class="modal-dialog modal-confirm">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">받는사람 : <span id="receiver2" style="font-size:19px;"></span>  </h5> 
						<input type="hidden" name="memberNo" id="hiddenMemberNo">
					</div>
					<div class="modal-body" style="padding-bottom : 1px;">
						<textarea class="messageText" id="writeMessage" name="content" style="border: 1px solid black; height: 130px; width: 100%; resize: none;"></textarea>
						<div id="messageCnt" class="float-right" style="font-size:13px;">(0/100)</div>
					</div>
					<div class="modal-footer">
						<div class="col">
							<button type="submit" class="btn maincolor btn-block">
								<span class="plan">전송</span>
							</button>
						</div>
						<div class="col">
							<button type="button" class="btn maincolor-re btn-block" data-dismiss="modal">
								<span class="plan">닫기</span>
							</button>
						</div>
					</div>
				</div>
			</div>
	</div>  
</form> 
<!-- 쪽지 보내기  -->
	
	<div id="footer">
		<jsp:include page="../common/footer.jsp" />
	</div>
		
		<script>
		
		// 쪽지 읽기
			$("#messageTable > tbody #messageContent").on("click",function(){
				
				var receiver = $(this).parent().children().eq(1).text();
				var viewMessage = $(this).parent().children().eq(2).text();
				
				
				$("#receiver").text(receiver);
				$("#viewMessage").text(viewMessage);
				
				$("#readMessage").modal("show");
			
			});		
		
		
		
			// 닉네임 누르면 쪽지 보내기
			$("#messageTable > tbody #nickName").on("click",function(){
				
				var memberNo =  $(this).parent().parent().children().eq(4).val();
				var receiver =  $(this).parent().parent().children().eq(1).text();
				
				
				$("#receiver2").text(receiver);
				$("#hiddenMemberNo").val(memberNo);
				
				$("#sendMessage").modal("show");
			
			});		
			
			
			// 메세지 유효성 검사
			function messageValidate(){
				
				if($(".messageText").val().trim().length ==0){
					swal("내용을 입력해 주세요");
					$(".messageText").focus();
					return false;
				}
			}		
		

			// 메세지 쓰기 글자수 제한
			$(document).ready(function(){
				$("#writeMessage").on('input',function(){
						$("#messageCnt").html("("+$(this).val().length+" / 100)");
						if($(this).val().length>100){
							$(this).val($(this).val().substring(0,100));
							$("#messageCnt").html("(100/100)");
						}
				});
			});
		
		
		// 새로고침
		
		function refreshFunction(){  
 	 		location.reload();
		}
			
			
			// 체크박스 전체선택
		$(document).ready(function(){
			$("#checkAll").click(function(){
				
				if($("#checkAll").prop("checked")){
					$("input[name=chk]").prop("checked",true);
				}else{
					$("input[name=chk]").prop("checked",false);
				}
			});
		});
			
			

			

			// 보낸 체크된 메세지 삭제하기
			function deleteBtn(){
				
				// 선택된 메세지 번호 담을 배열
				var messageNo = [];
				
				// 하나씩 돌면서 배열에 넣어줌
				$("input[name=chk]:checked").each(function(){
					messageNo.push($(this).val());
				});
				
				
				if(confirm("정말로 삭제하시겠습니까?")){
					
					$.ajax({
					 url : "${contextPath}/message/deleteSendMessage",	
					 type :"post",
					 data : {"messageNo":messageNo},
					 success : function(result){
						 if(result>0){
								refreshFunction();
						 }
					 },
					 error : function(){
						 console.log("쪽지 삭제 실패");
					 }
					});
				}
				
			}
			
			

		
		</script>

</body>
</html>