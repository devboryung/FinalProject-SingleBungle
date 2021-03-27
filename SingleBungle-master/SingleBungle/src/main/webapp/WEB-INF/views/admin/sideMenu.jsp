<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
/* 	.footer{
		position: absolute;
	    bottom: 0;
	} */

.nav-color:hover {
    background: #f5f5f5 !important;
}

.nav-color:active {
    background: #f5f5f5 !important;
}

</style>


<div class="col-sm-3 mt-5" id="sideMenu">

	<!-- Vertical Menu-->
	<nav class="nav flex-column bg-white shadow-sm font-italic rounded p-3">
		<a href="${contextPath}/admin/adminMypage" class="nav-link nav-color px-4 rounded-pill" id="myPage"> 내가 쓴 글 / 댓글 </a>
		<a href="${contextPath}/admin/memberList" class="nav-link nav-color px-4 rounded-pill" id="memberList"> 회원관리 </a>
		<a href="${contextPath}/admin/levelList" class="nav-link nav-color px-4 rounded-pill" id="levelList"> 등업관리 </a>
		<a href="${contextPath}/admin/boardManage" class="nav-link nav-color px-4 rounded-pill" id="boardManage"> 게시글관리 </a> 
		<a href="${contextPath}/admin/replyManage" class="nav-link nav-color px-4 rounded-pill" id="replyManage"> 댓글관리 </a> 
		<a href="${contextPath}/admin/boardReport" class="nav-link nav-color px-4 rounded-pill" id="boardReport"> 신고게시글 </a> 
		<a href="${contextPath}/admin/replyReport" class="nav-link nav-color px-4 rounded-pill" id="replyReport"> 신고댓글 </a>
	</nav>
	<!-- End -->
</div>
