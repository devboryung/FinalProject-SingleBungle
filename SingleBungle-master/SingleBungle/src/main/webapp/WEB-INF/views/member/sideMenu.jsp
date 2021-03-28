<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
/* 	.footer{
		position: absolute;
	    bottom: 0;
	} */

.nav-color:hover {
    background: #f5f5f5;
}

#sideMenu{
margin-bottom:50px;
}
</style>


<div class="col-sm-3 mt-5" id="sideMenu">

	<!-- Vertical Menu-->
	<nav class="nav flex-column bg-white shadow-sm font-italic rounded p-3">
		<a href="${contextPath}/member/mypage" class="maincolor-font-bk nav-link nav-color px-4 rounded-pill" id="myPage">
			내 정보 조회 
		</a> 
		<a href="${contextPath}/member/mypageInfoUpdate" class="maincolor-font-bk nav-link nav-color px-4 rounded-pill" id="mypageInfoUpdate">
		 	내 정보 수정 
		 </a> 
		<a href="${contextPath}/member/mypagePwUpdate" class="maincolor-font-bk nav-link nav-color px-4 rounded-pill" id="mypagePwUpdate"> 
			비밀번호 수정
		 </a> 
		<!-- <a href="#" class="maincolor-font-bk nav-link nav-color px-4 rounded-pill" id=""> 
			한줄평 확인
		 </a>  -->
		<a href="${contextPath}/member/mypageSecession" class="maincolor-font-bk nav-link nav-color px-4 rounded-pill" id="mypageSecession">
		 	탈퇴 
		</a> 

	</nav>
	<!-- End -->
</div>

