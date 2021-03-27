<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
	<title>Header</title>
	
	
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" scope="application"/>
	
	
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js" crossorigin="anonymous"></script>
   
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Muli:400,400i,800,800i" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    
    <!-- Core theme CSS (includes Bootstrap)-->
   	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
   	
		<!-- sweetalert : alert창을 꾸밀 수 있게 해주는 라이브러리 https://sweetalert.js.org/ -->
  	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
   
   	<style>
   	* {
		font-family: 'Noto Sans KR', sans-serif;
		font-weight: 300;
		/* 굵기 지정(100, 300, 400, 500, 700) */
		font-size: 16px;
		color: #212529;
		margin: 0;
	}
	
	button:focus {
	border : none;
	outline : none;
}
	
	a {
        color: #212529;
    }

    a:hover {
    	text-decoration: none;
    }
		
	/* 메인 색(주황)--------------------------------------- */
    /* 버튼(기본) : 주황 바탕, 흰 글씨 */
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

    /* 폰트 : 주황색, 호버시 더찐한 주황색 */
    .maincolor-font{
        color:#ffaf18;
    }
    .maincolor-font:hover{
        color:#ff8500;
    }
	
	/* 폰트 : 검정글씨, 호버시 주황색 */
    .maincolor-font-bk{
        color:#212529;
    }
    .maincolor-font-bk:hover{
        color:#ff8500;
    }

    /* 별표 주황색 */
    .requiredInput{ color : #ff8500; }
    /* 메인 색(주황)--------------------------------------- */
    
    /* 세컨드 (파랑)--------------------------------------- */
    /* 
      700: #007bff
      600: #008fff
      500: #009eff
    */
    /* 세컨드 (파랑)--------------------------------------- */
	
	/* 글씨 굵기 */
	.textBold300 { font-weight: 300; }
	.textBold400 { font-weight: 400; }
	.textBold500 { font-weight: 500; }
	.textBold700 { font-weight: 700; }
	
	
	
	.navbar {
		
		background-color: #ffaf18; 
		
	}
	
	/* 네비 글씨 */
	.nav-font{
		color: #ffffff !important;
		opacity: .6 !important; /* 투명도 */
	}
	
	.nav-font:hover {
		color:#ffffff !important;
		opacity: 1 !important; /* 투명도 */
	}
	

   	#logo { width: 150px; height: 70px; }

   	</style>
   	
   	
</head>
<body id="page-top">

	<c:if test="${!empty swalTitle}">
		<script>
			swal({icon : "${swalIcon}",
				 title : "${swalTitle}",
				 text : "${swalText}"});
		</script>
	</c:if>
	
	<!--Navbar -->
	<nav class="mb-1 navbar navbar-expand-lg navbar-dark secondary-color lighten-1">
		<a class="navbar-brand" href="${contextPath}"><img id="logo" src="${contextPath}/resources/images/logo.png"></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-555" aria-controls="navbarSupportedContent-555" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent-555">
			<ul class="navbar-nav mr-auto">

				<li class="nav-item"><a class="nav-link textBold500 nav-font" href="${contextPath}/board/list">일상을 말해봐</a></li>
				<li class="nav-item"><a class="nav-link textBold500 nav-font" href="${contextPath}/cafe/list">먹보의 하루</a></li>
				<li class="nav-item"><a class="nav-link textBold500 nav-font" href="${contextPath}/review/list">싱글이의 영수증</a></li>
				<li class="nav-item"><a class="nav-link textBold500 nav-font" href="${contextPath}/findFriend/list">만남의 광장</a></li>
				<li class="nav-item"><a class="nav-link textBold500 nav-font" href="${contextPath}/market/list">벙글장터</a></li>
				<li class="nav-item"><a class="nav-link textBold500 nav-font" href="${contextPath}/admin/noticeList">공지사항</a></li>
				<li class="nav-item"><a class="nav-link textBold500 nav-font" href="${contextPath}/admin/faqView">고객센터</a></li>

			</ul>
			<ul class="navbar-nav ml-auto nav-flex-icons">
			
				<c:choose>
					<%-- 로그인이 되어있지 않은 경우 --%>
					<c:when test="${empty sessionScope.loginMember }">
			     		<a class="nav-link textBold500 nav-font" href="${contextPath}/member/login">로그인</a>
					</c:when>
					
					<%-- 관리자로 로그인할 경우 --%>
					<c:when test="${loginMember.memberGrade == 'G'}">
							 <img class="image" src="${contextPath}/resources/images/gradeG.png" width="40"/>
			     		<a class="nav-link textBold500 nav-font" href="${contextPath}/admin/adminMypage" style="display:inline">${loginMember.memberNickname}</a>
				      	<a class="nav-link textBold500 nav-font" href="${contextPath}/member/logout">로그아웃</a>
					</c:when>
					
					<%-- 회원으로 로그인할 경우 --%>
					<c:otherwise>
							<c:if test="${loginMember.memberGrade == 'F'}">
								<a class="nav-link" href="${contextPath}/message/messageBoxR"><img src="${contextPath}/resources/images/messageBox.png" style="width : 20px; height 20px; margin-bottom : 5px;"></a>
								
							</c:if>
						<span class="nav-link textBold500 " style="display:inline-block; padding-top : 2px;">
							<c:if test="${loginMember.memberGrade=='F' }">
									<img class="userImage" src="${contextPath}/resources/images/grade1.png" width="40"/>
									1등급
							</c:if>
							<c:if test="${loginMember.memberGrade=='S' }">
									<img class="userImage" src="${contextPath}/resources/images/grade2.png" width="40" />
									2등급
							</c:if>
							<c:if test="${loginMember.memberGrade=='T' }">
									<img class="userImage" src="${contextPath}/resources/images/grade3.png" width="40"/>
									3등급
							</c:if>
						    </span>
				      	<a class="nav-link textBold500 nav-font" href="${contextPath}/member/mypage" style="display:inline">${loginMember.memberNickname}</a>
				      	<a class="nav-link textBold500 nav-font" href="${contextPath}/member/logout">로그아웃</a>
					</c:otherwise>
				</c:choose>
			
				<!-- <li class="nav-item"><a class="nav-link waves-effect waves-light">1 <i class="fas fa-envelope"></i>
				</a></li>
				<li class="nav-item avatar dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-55" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <img src="https://mdbootstrap.com/img/Photos/Avatars/avatar-2.jpg" class="rounded-circle z-depth-0" alt="avatar image">
				</a>
					<div class="dropdown-menu dropdown-menu-lg-right dropdown-secondary" aria-labelledby="navbarDropdownMenuLink-55">
						<a class="dropdown-item" href="#">마이페이지</a> <a class="dropdown-item" href="#">쪽지함</a> <a class="dropdown-item" href="#">로그아웃</a>
					</div></li> -->
			</ul>
		</div>
	</nav>
	<!--Navbar -->
	
	<%-- ---------------------- 로그인(임시) ---------------------- --%>
	
	<%-- 	~(˘▾˘~)(~˘▾˘)~ ~(˘▾˘~)(~˘▾˘)~ ~(˘▾˘~)(~˘▾˘)~ --%>
	<br>
	<%-- ---------------------- 로그인(임시) ---------------------- --%>
	
	
	<%-- <a class="nav-link" href="${contextPath}/findFriend/insert">친구찾기 게시글 작성</a>
	<a class="nav-link" href="${contextPath}/findFriend/list">친구찾기 목록 조회</a>
	
	<a class="nav-link" href="${contextPath}/board/list" style="color:navy;">자유게시판 목록 조회</a>
	
	<a class="nav-link" href="${contextPath}/cafe/list" style="color:hotpink;">맛집게시판 목록 조회</a>
	
	<a class="nav-link" href="${contextPath}/market/list" style="color:orange;">사고팔고 목록 조회</a>
	<a class="nav-link" href="${contextPath}/market/mypage" style="color:orange;">사고팔고 마이페이지</a>
	<a class="nav-link" href="${contextPath}/market/modal" style="color:orange;">사고팔고 모달</a>


	<a class="nav-link" href="${contextPath}/review/list" style="color:green;">후기게시판 목록 조회</a>
	<a class="nav-link" href="${contextPath}/message/messageBoxR" style="color:green;"><i class="fas fa-envelope-open-text"></i></a>
	
	
	<a class="nav-link" href="${contextPath}/admin/eventList" style="color:pink;">이벤트 게시판</a>
	<a class="nav-link" href="${contextPath}/admin/noticeList" style="color:pink;">공지사항 게시판</a>
	<a class="nav-link" href="${contextPath}/admin/faqView" style="color:pink;">자주묻는 질문</a>
	<a class="nav-link" href="${contextPath}/admin/inquiryList" style="color:pink;">1:1 문의 목록</a>
	
	<a class="nav-link" href="${contextPath}/member/login">로그인</a>
	<a class="nav-link" href="${contextPath}/member/signUp">회원가입</a>
	<a class="nav-link" href="${contextPath}/member/mypage">마이페이지</a>
	<a class="nav-link" href="${contextPath}/member/mypageFindId1">아이디찾기1</a>
	<a class="nav-link" href="${contextPath}/member/mypageFindId2">아이디찾기2</a>
	<a class="nav-link" href="${contextPath}/member/mypageFindPw1">비밀번호찾기1</a>
	<a class="nav-link" href="${contextPath}/member/mypageFindPw2">비밀번호찾기2</a>
	<a class="nav-link" href="${contextPath}/member/mypageFindPw3">비밀번호찾기3</a>
	<a class="nav-link" href="${contextPath}/member/mypageInfoUpdate">내 정보 수정</a>
	<a class="nav-link" href="${contextPath}/member/mypagePwUpdate">비밀번호 수정</a> --%>
	
	
    
   	<!-- Bootstrap core JS-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
	<!-- Third party plugin JS-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	<!-- Core theme JS-->
	<script src="${contextPath}/resources/js/resume-scripts.js"></script>
	
	
</body>
</html>