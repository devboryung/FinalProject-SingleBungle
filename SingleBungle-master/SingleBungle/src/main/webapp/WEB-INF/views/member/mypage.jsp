<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보</title>


    <!-- 부트스트랩 사용을 위한 css 추가 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
        integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

    <!-- 부트스트랩 사용을 위한 라이브러리 추가 -->
    <!-- 제이쿼리가 항상 먼저여야함 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
        crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/db80de430d.js" crossorigin="anonymous"></script>


    <style>
        @media (max-width:991.98px) {
            .padding {
                padding: 1.5rem
            }
        }

        @media (max-width:767.98px) {
            .padding {
                padding: 1rem
            }
        }


        .pagination,
        .jsgrid .jsgrid-pager {
            display: flex;
            padding-left: 0;
            list-style: none;
            border-radius: 0.25rem
        }
		

        .pagination.pagination-rounded-flat .page-item {
            margin: 0 .25rem
        }

		/* 페이징 글씨 */		
        .page-link {
            color: black !important; 
        }
        
        /* 페이징 선택된 글씨 */
        .page-item.active .page-link{
        	color: white !important;
        }
        
        /* 페이징 선택된 배경색(초록) */
        .pagination-success .page-item.active .page-link {
            background: #00c689;
            border-color: #00c689
        }

        .pagination.pagination-rounded-flat .page-item .page-link,
        a {
            border: none;
            border-radius: 50px
        }

        tr>th, tr>td {
            text-align: center;
        }

        .table {
            margin-top: 30px;
        }

        /* span {
            margin-top: 100px;
        } */
       
        .profile {
            width: 100%;
        }

        .profile td{
            text-align: left;
        }

        .profile-area-left{
            /* text-align: center; */
            color: #ffaf18;
            font-weight: 500;
        }

        .boardTitle>img {
            width: 50px;
            height: 50px;
        }

        .board-list {
            margin: 100px auto;
        }
       
       .col-md-4 {
			flex: none !important;
			max-width: none !important;
		}
		
		.img-thumbnail{
		width:200px;
		}
		
		.hidden {
			display: none;
		}

		/* 게시글 목록 마우스 오버시 손가락 모양 커서  */
		#list-table1,#list-table2,#list-table3 td:hover {
			cursor: pointer;
		}
	
    </style>
</head>

<body>

	<jsp:include page="../common/header.jsp"/>
	
	
    <div class="container mt-5 pt-5">
        <div class="row">

            <jsp:include page="sideMenu.jsp" />


            <div class="col-sm-9">

                <div class="myBoard form-group row">
                    <div class="col-sm-3">
                        <%-- <img class="img-thumbnail" src="${contextPath}/resources/images/profile.png"> --%>
                        
                        <c:if test="${loginMember.memberGrade == 'F'}">
                    	    <img class="img-thumbnail" src="${contextPath}/resources/images/g1.png">
                        </c:if>
						<c:if test="${loginMember.memberGrade == 'S'}">
							<img class="img-thumbnail"  src="${contextPath}/resources/images/g2.png">
						</c:if>
						<c:if test="${loginMember.memberGrade == 'T'}">
							<img class="img-thumbnail"  src="${contextPath}/resources/images/g3.png">
						</c:if>
						<c:if test="${loginMember.memberGrade == 'G'}">
							<img class="img-thumbnail"  src="${contextPath}/resources/images/profile.png">
						</c:if>
                    </div>
                    
                    <div class="col-sm-9">
                        <!-- <div style="margin-bottom:10px;">
                            닉네임 : 소리아
                        </div>
                        <div style="margin-bottom:10px;">관심사 : 독서, 어쩌구</div>
                        <div style="margin-bottom:10px;">성별 : 여자</div>
                        <div style="margin-bottom:10px;">동네인증이 되지 않았습니다. <button>인증하기</button></div> -->

                        <table class="profile"  style="padding-left:50px;">
                            
                                    <tr>
                                        <td class="profile-area-left">닉네임</td>
                                        <td class="boardTitle">${loginMember.memberNickname}</td>
                                        <td class="profile-area-left">이메일</td>
                                        <td class="boardTitle">${loginMember.memberEmail}</td>
                                    </tr>
                                    <tr>
                                        <td class="profile-area-left">성별</td>
                                        <td class="boardTitle">${loginMember.memberGender}</td>
                                        <td class="profile-area-left">전화번호</td>
                                        <td class="boardTitle">${loginMember.memberPhone}</td>
                                    </tr>
                                    <%-- <tr>
                                        <td class="profile-area-left">매너온도</td>
                                        <td class="boardTitle">${loginMember.memberRating}</td>
                                        <td class="profile-area-left"></td>
                                        <td class="boardTitle"></td>
                                    </tr> --%> 
                                    <%-- 
                                    <tr>
                                        <td colspan="4">
					                        <c:if test="${loginMember.memberCertifiedFl == 'N'}">
					                                                 동네인증이 되지 않았습니다. 
					                        </c:if>
					                        <c:if test="${loginMember.memberCertifiedFl == 'Y'}">
					                                                 동네인증이 되었습니다.
					                        </c:if>
					                                           
                                            <button type="submit" class="btn btn-primary">동네인증</button>
                                        </td>
                                    </tr>
                                    --%>
                        </table>
                    </div>
                    <!-- <div class="col-sm-4">
                        <div style="margin-bottom:10px;">이메일 : soria@naver.com</div>
                        <div style="margin-bottom:10px;">전화번호 : 010-1111-22222</div>
                        <div style="margin-bottom:10px;">매너온도 : 100C </div>
                    </div> -->
                    
                </div>


                <div class="myReply">
                    <span>
                        <h4>좋아요한 글</h4>
                    </span>


                    <table class="table table-striped" id="list-table1">
                        <thead>
                            <tr>
                                <th>게시판</th>
                                <th>좋아요한 게시글</th>
                                <th>작성일</th>
                            </tr>
                        </thead>

                        <tbody>
                        <c:if test="${empty boardList }">
                   			<tr>
								<td colspan="6">존재하는 게시글이 없습니다.
							</tr>
		                   </c:if>
		                   <c:if test="${!empty boardList }">
		                  	<c:forEach var="board" items="${boardList}" varStatus="vs">

                            <tr>
                            	<td class="hidden">${board.boardNo }</td>
                        		<td class="hidden">${board.boardCode }</td>
                                <td>
                                	<c:choose>
										<c:when test="${board.boardCode == 1}">자유게시판</c:when>
										<c:when test="${board.boardCode == 2}">후기게시판</c:when>
										<c:when test="${board.boardCode == 6}">맛집게시판</c:when>
										<c:when test="${board.boardCode == 7}">친구찾기</c:when>
										<c:when test="${board.boardCode == 8}">사고팔고</c:when>
									</c:choose>
                                </td>
                                <td class="boardTitle">${board.boardTitle }</td>
                                <td>${board.boardCreateDate}</td>
                            </tr>
                            
							</c:forEach>
							</c:if>
                        </tbody>
                    </table>


                    <div class="padding">
					<c:set var="firstPage" value="?cp=1" />
					<c:set var="lastPage" value="?cp=${pInfo.maxPage}" />

					<fmt:parseNumber var="c1" value="${(pInfo.currentPage - 1) / 10 }"
						integerOnly="true" />
					<fmt:parseNumber var="prev" value="${ c1 * 10 }" integerOnly="true" />
					<c:set var="prevPage" value="?cp=${prev}" />


					<fmt:parseNumber var="c2" value="${(pInfo.currentPage + 9) / 10 }"
						integerOnly="true" />
					<fmt:parseNumber var="next" value="${ c2 * 10 + 1 }"
						integerOnly="true" />
					<c:set var="nextPage" value="?cp=${next}" />


					<div class="container d-flex justify-content-center">
						<div class="col-md-4 col-sm-6 grid-margin stretch-card">
							<nav>
								<ul
									class="pagination d-flex justify-content-center flex-wrap pagination-rounded-flat pagination-success">

									<c:if test="${pInfo.currentPage > pInfo.pageSize}">
										<li class="page-item"><a class="page-link"
											href="${firstPage }" data-abc="true">&laquo;</a></li>
										<li class="page-item"><a class="page-link"
											href="${prevPage }" data-abc="true">&lt;</a></li>
									</c:if>


									<!-- 페이지 목록 -->
									<c:forEach var="page" begin="${pInfo.startPage}"
										end="${pInfo.endPage}">
										<c:choose>
											<c:when test="${pInfo.currentPage == page }">
												<li class="page-item active"><a class="page-link"
													data-abc="true">${page}</a></li>
											</c:when>

											<c:otherwise>
												<li class="page-item"><a class="page-link"
													href="?cp=${page}" data-abc="true">${page}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>


									<c:if test="${next <= pInfo.maxPage}">
										<li class="page-item"><a class="page-link"
											href="${nextPage }" data-abc="true">&gt;</a></li>
										<li class="page-item"><a class="page-link"
											href="${lastPage }" data-abc="true">&raquo;</a></li>
									</c:if>
								</ul>
							</nav>

						</div>
					</div>
				</div>
                </div>
                
                <!-- -------------------------------------------------- -->
                
                
                <div class="myReply">
                    <span>
                        <h4>내가 쓴 글</h4>
                    </span>


                    <table class="table table-striped" id="list-table2">
                        <thead>
                            <tr>
                                <th>게시판</th>
                                <th>내가 쓴 게시글</th>
                                <th>작성일</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:if test="${empty myBoardList }">
                   			<tr>
								<td colspan="6">존재하는 게시글이 없습니다.
							</tr>
		                   </c:if>
		                   <c:if test="${!empty myBoardList }">
		                  	<c:forEach var="myBoard" items="${myBoardList}" varStatus="vs">

                            <tr>
                            	<td class="hidden">${myBoard.boardNo }</td>
                        		<td class="hidden">${myBoard.boardCode }</td>
                                <td>
                                	<c:choose>
										<c:when test="${myBoard.boardCode == 1}">자유게시판</c:when>
										<c:when test="${myBoard.boardCode == 2}">후기게시판</c:when>
										<c:when test="${myBoard.boardCode == 6}">맛집게시판</c:when>
										<c:when test="${myBoard.boardCode == 7}">친구찾기</c:when>
										<c:when test="${myBoard.boardCode == 8}">사고팔고</c:when>
									</c:choose>
                                </td>
                                <td class="boardTitle">${myBoard.boardTitle }</td>
                                <td>${myBoard.boardCreateDate}</td>
                            </tr>
                            
							</c:forEach>
							</c:if>
                        </tbody>
                    </table>


                    <div class="padding">
					<c:set var="firstPage2" value="?cp2=1" />
					<c:set var="lastPage2" value="?cp2=${pInfo2.maxPage}" />

					<fmt:parseNumber var="c1" value="${(pInfo2.currentPage - 1) / 10 }"
						integerOnly="true" />
					<fmt:parseNumber var="prev" value="${ c1 * 10 }" integerOnly="true" />
					<c:set var="prevPage2" value="?cp2=${prev}" />


					<fmt:parseNumber var="c2" value="${(pInfo2.currentPage + 9) / 10 }"
						integerOnly="true" />
					<fmt:parseNumber var="next" value="${ c2 * 10 + 1 }"
						integerOnly="true" />
					<c:set var="nextPage2" value="?cp2=${next}" />


					<div class="container d-flex justify-content-center">
						<div class="col-md-4 col-sm-6 grid-margin stretch-card">
							<nav>
								<ul
									class="pagination d-flex justify-content-center flex-wrap pagination-rounded-flat pagination-success">

									<c:if test="${pInfo2.currentPage > pInfo2.pageSize}">
										<li class="page-item"><a class="page-link"
											href="${firstPage2 }" data-abc="true">&laquo;</a></li>
										<li class="page-item"><a class="page-link"
											href="${prevPage2 }" data-abc="true">&lt;</a></li>
									</c:if>


									<!-- 페이지 목록 -->
									<c:forEach var="page" begin="${pInfo2.startPage}"
										end="${pInfo2.endPage}">
										<c:choose>
											<c:when test="${pInfo2.currentPage == page }">
												<li class="page-item active"><a class="page-link"
													data-abc="true">${page}</a></li>
											</c:when>

											<c:otherwise>
												<li class="page-item"><a class="page-link"
													href="?cp2=${page}" data-abc="true">${page}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>


									<c:if test="${next <= pInfo2.maxPage}">
										<li class="page-item"><a class="page-link"
											href="${nextPage2 }" data-abc="true">&gt;</a></li>
										<li class="page-item"><a class="page-link"
											href="${lastPage2 }" data-abc="true">&raquo;</a></li>
									</c:if>
								</ul>
							</nav>

						</div>
					</div>
				</div>
                </div>
                <div class="myReply">
                    <span>
                        <h4>내가 쓴 댓글</h4>
                    </span>


                    <table class="table table-striped" id="list-table3">
                        <thead>
                            <tr>
                                <th>게시판</th>
                                <th>댓글 남긴 게시글</th>
                                <th>작성일</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:if test="${empty myReplyList }">
                   			<tr>
								<td colspan="6">존재하는 댓글이 없습니다.
							</tr>
		                   </c:if>
		                   <c:if test="${!empty myReplyList }">
		                  	<c:forEach var="reply" items="${myReplyList}" varStatus="vs">

                            <tr>
                           		<td class="hidden">${reply.parentBoardNo }</td>
                        		<td class="hidden">${reply.boardCd }</td>
                                <td>
                                	<c:choose>
										<c:when test="${reply.boardCd == 1}">자유게시판</c:when>
										<c:when test="${reply.boardCd == 2}">후기게시판</c:when>
										<c:when test="${reply.boardCd == 6}">맛집게시판</c:when>
										<c:when test="${reply.boardCd == 7}">친구찾기</c:when>
										<c:when test="${reply.boardCd == 8}">사고팔고</c:when>
									</c:choose>
                                </td>
                                <td class="boardTitle">${reply.boardTitle }</td>
                                <td>${reply.createDt}</td>
                            </tr>
                            
							</c:forEach>
							</c:if>
                    </table>


                     <div class="padding">
					<c:set var="firstPage3" value="?cp3=1" />
					<c:set var="lastPage3" value="?cp3=${pInfo3.maxPage}" />

					<fmt:parseNumber var="c1" value="${(pInfo3.currentPage - 1) / 10 }"
						integerOnly="true" />
					<fmt:parseNumber var="prev" value="${ c1 * 10 }" integerOnly="true" />
					<c:set var="prevPage3" value="?cp3=${prev}" />


					<fmt:parseNumber var="c2" value="${(pInfo3.currentPage + 9) / 10 }"
						integerOnly="true" />
					<fmt:parseNumber var="next" value="${ c2 * 10 + 1 }"
						integerOnly="true" />
					<c:set var="nextPage3" value="?cp3=${next}" />


					<div class="container d-flex justify-content-center">
						<div class="col-md-4 col-sm-6 grid-margin stretch-card">
							<nav>
								<ul
									class="pagination d-flex justify-content-center flex-wrap pagination-rounded-flat pagination-success">

									<c:if test="${pInfo3.currentPage > pInfo3.pageSize}">
										<li class="page-item"><a class="page-link"
											href="${firstPage3 }" data-abc="true">&laquo;</a></li>
										<li class="page-item"><a class="page-link"
											href="${prevPage3 }" data-abc="true">&lt;</a></li>
									</c:if>


									<!-- 페이지 목록 -->
									<c:forEach var="page" begin="${pInfo3.startPage}"
										end="${pInfo3.endPage}">
										<c:choose>
											<c:when test="${pInfo3.currentPage == page }">
												<li class="page-item active"><a class="page-link"
													data-abc="true">${page}</a></li>
											</c:when>

											<c:otherwise>
												<li class="page-item"><a class="page-link"
													href="?cp3=${page}" data-abc="true">${page}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>


									<c:if test="${next <= pInfo3.maxPage}">
										<li class="page-item"><a class="page-link"
											href="${nextPage3 }" data-abc="true">&gt;</a></li>
										<li class="page-item"><a class="page-link"
											href="${lastPage3 }" data-abc="true">&raquo;</a></li>
									</c:if>
								</ul>
							</nav>

						</div>
					</div>
				</div>
                </div>

                 <!-- ------------------------------------------------------------------------------ -->
                

        </div>
    </div>
    </div>
    
    <jsp:include page="../common/footer.jsp"/>

    
  
 <script>
 
	/* 내가 선택한 메뉴에 색 고정하기 */
    $(function(){
			$("#myPage").attr('class','nav-link px-4 active text-white shadow-sm rounded-pill maincolor');
	});
	
	/* 테이블 클릭시 해당 게시글로 이동 */
	$("#list-table1 td").on("click",function(){
			var boardNo = $(this).parent().children().eq(0).text();
			
			var boardCode = $(this).parent().children().eq(1).text();
			
		  var boardViewURL = null;
		  if(boardCode == 1) boardViewURL = "${contextPath}/board/"+ boardNo;
		  else if(boardCode == 2) boardViewURL = "${contextPath}/review/"+ boardNo;
		  else if(boardCode == 3) boardViewURL = "${contextPath}/admin/notice/"+ boardNo;
		  else if(boardCode == 4) boardViewURL = "${contextPath}/admin/event/"+ boardNo;
		  else if(boardCode == 6) boardViewURL = "${contextPath}/cafe/"+ boardNo;
		  else if(boardCode == 7) boardViewURL = "${contextPath}/findFriend/"+ boardNo;
		  else if(boardCode == 8) boardViewURL = "${contextPath}/market/"+ boardNo;
			
		location.href = boardViewURL; // 요청 전달
	
	});
	
	$("#list-table2 td").on("click",function(){
			var boardNo = $(this).parent().children().eq(0).text();
			
			var boardCode = $(this).parent().children().eq(1).text();
			
		  var boardViewURL = null;
		  if(boardCode == 1) boardViewURL = "${contextPath}/board/"+ boardNo;
		  else if(boardCode == 2) boardViewURL = "${contextPath}/review/"+ boardNo;
		  else if(boardCode == 3) boardViewURL = "${contextPath}/admin/notice/"+ boardNo;
		  else if(boardCode == 4) boardViewURL = "${contextPath}/admin/event/"+ boardNo;
		  else if(boardCode == 6) boardViewURL = "${contextPath}/cafe/"+ boardNo;
		  else if(boardCode == 7) boardViewURL = "${contextPath}/findFriend/"+ boardNo;
		  else if(boardCode == 8) boardViewURL = "${contextPath}/market/"+ boardNo;
			
		location.href = boardViewURL; // 요청 전달
	
	});
	
	$("#list-table3 td").on("click",function(){
			var boardNo = $(this).parent().children().eq(0).text();
			
			var boardCode = $(this).parent().children().eq(1).text();
			
		  var boardViewURL = null;
		  if(boardCode == 1) boardViewURL = "${contextPath}/board/"+ boardNo;
		  else if(boardCode == 2) boardViewURL = "${contextPath}/review/"+ boardNo;
		  else if(boardCode == 3) boardViewURL = "${contextPath}/admin/notice/"+ boardNo;
		  else if(boardCode == 4) boardViewURL = "${contextPath}/admin/event/"+ boardNo;
		  else if(boardCode == 6) boardViewURL = "${contextPath}/cafe/"+ boardNo;
		  else if(boardCode == 7) boardViewURL = "${contextPath}/findFriend/"+ boardNo;
		  else if(boardCode == 8) boardViewURL = "${contextPath}/market/"+ boardNo;
			
		location.href = boardViewURL; // 요청 전달
	
	});
</script>
</body>

</html>