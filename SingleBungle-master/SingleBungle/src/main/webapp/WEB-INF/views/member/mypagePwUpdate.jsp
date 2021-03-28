<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 수정</title>

<!-- 구글 폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

<!-- 부트스트랩 사용을 위한 css 추가 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<!-- 부트스트랩 사용을 위한 라이브러리 추가 (반드시 jQuery가 항상 먼저여야한다. 순서 중요!) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

<style>

a:hover {
	text-decoration: none;
}

/* 글씨 굵기 */
.textBold {
	font-weight: 500;
}
</style>

</head>

<body>

	<jsp:include page="../common/header.jsp"/>

	<div class="container mt-5 pt-5">
		<div class="row">

			<jsp:include page="sideMenu.jsp" />
			
			
			<!-- 관리자 마이페이지는 9였음, , , ,   -->
			<div class="col-sm-4">

				<div class="text-center">

					<h3>비밀번호 수정</h3>

					<hr>
				</div>



				<form action="mypagePwUpdateAction" method="post" name="mypagePwUpdateForm" onsubmit="return updateValidate();">
				
					<div class="form-group">
						<div>
							<label for="id" class="textBold">아이디</label>
							 <br> ${loginMember.memberId} <br> <br>
						</div>
						
						<div class="form-group">
							<label for="pw" class="textBold">현재 비밀번호</label>
							<input type="password" class="form-control" id="memberPwd" name="memberPwd"
								placeholder="현재 비밀번호를 입력하세요." required>
						</div>
						
						<div class="form-group">
							<label for="newPw1" class="textBold">새 비밀번호</label>
							<input type="password" class="form-control" id="newPwd1" name="newPwd1"
								placeholder="새로운 비밀번호를 입력하세요." required>
						</div>		
										
						<div class="form-group" >
							<label for="newPw2" class="textBold">새 비밀번호 확인</label>
							<input type="password" class="form-control" id="newPwd2" name="newPwd2"
								placeholder="새로운 비밀번호를 한번 더 입력하세요." required>
						</div>
						
					</div>

					<br>
					<hr>
					<br>

					<button type="submit" class="btn btn-block maincolor">비밀번호 수정</button>
					
	
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>

				</form>
			</div>

		</div>

		<div class="col-md-4"></div>
	</div>
	
	<jsp:include page="../common/footer.jsp"/>
</body>

 <script>
 	/* 사이드메뉴를 내가 선택한 메뉴에 색 고정하기 */
    $(function(){
			$("#mypagePwUpdate").attr('class','nav-link px-4 active text-white shadow-sm rounded-pill maincolor');
	});
 	
 	
 	// submit 동작
	function updateValidate() {
		// 비밀번호  유효성 검사
		//영어 대,소문자 + 숫자, 총 6~12글자
		var regExp = /^[A-Za-z0-9]{6,12}$/;
		if(!regExp.test($("#newPwd1").val())){ 
			alert("유효하지 않은 비밀번호 입니다.");
			$("#newPwd1").focus();
			
			return false;
        }
		
		if($("#newPwd1").val() != $("#newPwd2").val()){
			alert("새 비밀번호가 일치하지 않습니다.");
			$("#newPwd2").focus();
			
			return false;
		}
	}
</script>

</html>