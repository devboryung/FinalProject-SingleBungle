<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" scope="application" />
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/floating-labels/">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<title>로그인</title>

<!-- 구글 폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

<!-- 부트스트랩 사용을 위한 css 추가 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<!-- 부트스트랩 사용을 위한 라이브러리 추가 (반드시 jQuery가 항상 먼저여야한다. 순서 중요!) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

<style>

html {
    position: relative; 
    min-height: 100%;
    margin: 0;
    padding: 0;
    /* background: yellow; */
}

body {
    min-height: 100%;
}

#footer { /* 푸터 바닥에 고정시키기 !!! hmtl에 어쩌고도 해줘야함 */
    position: absolute;
    left: 0;
    bottom: 0;
    width: 100%;
    /* padding: 15px 0; */
    text-align: center;
    color: white;
}

/* #login-container {
    margin: 150px 0 171px 0;
} */

/* ---------------------------------------------------------------- */

a:hover {
	text-decoration: none;
}

#memberId, #memberPwd {
	margin-bottom: 10px;
}

/* 아이디 찾기, 비밀번호 찾기 왼쪽 정렬 */
.idpw-left {
	float: left;
}

/* 회원가입 오른쪽 정렬 */
.idpw-right {
	float: right;
}

/* 글씨 굵기 */
.textBold400 {
	font-weight: 400;
}

.textBold500 {
	font-weight: 500;
}





/* sns */
/* # sns_signUp { margin-top:50px; }

.sns_text {
	color: #757575;
	font-weight: 400;
	font-size: 13px;
	margin-bottom: 10px;
}

.sns_logo {
	width: 45px;
	margin-left: 5px;
} */
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<!-- Third party plugin JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<!-- Custom styles for this template -->
<link href="${contextPath}/resources/css/floating-labels.css" rel="stylesheet">

<!-- sweetalert : alert창을 꾸밀 수 있게 해주는 라이브러리 https://sweetalert.js.org/ -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


</head>

<body>

	<c:if test="${!empty swalTitle}">
		<script>
			swal({
				icon : "${swalIcon}",
				title : "${swalTitle}",
				text : "${swalText}"
			});
		</script>
	</c:if>

	<div style="margin-right:0px;">
		<jsp:include page="../common/header.jsp" />
	</div>

	<div class="container">
		<div class="row">
			<div class="col-md-4"></div>

			<div class="col-md-4" id="login-container">
				<!-- <h3 class="login-heading mb-4 text-center">로고,,ㄱ-</h3> -->
				<form action="loginAction" method="post" class="form-signin">
					
					<br><br>
                    
                    <h3 class="text-center">로그인</h3>
					<hr>
					
					
					
					<div class="form-label-group">
						<input type="text" id="memberId" name="memberId" placeholder="아이디" class="form-control" value="${cookie.saveId.value}" required autofocus>
						<!-- 아이디 저장을 누르면, 쿠키 얻어오기 -->
					</div>

					<div class="form-label-group">
						<input type="password" id="memberPwd" name="memberPwd" class="form-control" placeholder="비밀번호" required>
					</div>

					<div class="checkbox mb-3">
						<label class="textBold500"> 
							<input type="checkbox" name="saveId"
							
							 <c:if test="${!empty cookie.saveId.value}"> checked </c:if>
								<%-- 아이디저장 체크박스에 체크를 하면 저장을 하겠다... --%>
							> 아이디 저장
						</label>
					</div>
					
					<button class="btn btn-block btn-login text-uppercase mb-2 maincolor textBold500" type="submit">로그인</button>
					<div>
						<div class="idpw-left">
							<a class="id maincolor-font-bk textBold500" href="${contextPath}/member/findIdForm">아이디 찾기</a>
							<a class="pw maincolor-font-bk textBold500" href="${contextPath}/member/findPwForm">비밀번호 찾기</a>
						</div>
						<div class="idpw-right">
							<a class="signup maincolor-font-bk textBold500" href="${contextPath}/member/signUp">회원가입</a>
						</div>

						<br>

						<!-- <div class="text-center" id="sns_signUp">
							<div class="sns_text">SNS계정 간편 로그인/회원가입</div>
							<a href="#"><img class="sns_logo" src="img/sns_naver.jpg"></a>
							<a href="#"><img class="sns_logo" src="img/sns_kakao.jpg"></a>
						</div> -->
					</div>
				</form>

			</div>

			<div class="col-md-4"></div>
		</div>
	</div>
	
	<div id="footer">
		<jsp:include page="../common/footer.jsp" />
	</div>

</body>

</html>