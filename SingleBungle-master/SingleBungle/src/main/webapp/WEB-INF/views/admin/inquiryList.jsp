<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
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
        .flex {
     -webkit-box-flex: 1;
     -ms-flex: 1 1 auto;
     flex: 1 1 auto
 }
 
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
/* 
        .padding {
            padding: 5rem
        } */

        .container {
            margin-top: 50px;
        }

        .pagination,
        .jsgrid .jsgrid-pager {
            display: flex;
            padding-left: 0;
            list-style: none;
            border-radius: 0.25rem
        }

        .page-link {
            color: black
        }

        .pagination.pagination-rounded-flat .page-item {
            margin: 0 .25rem
        }

        .pagination-success .page-item.active .page-link{
            background: #00c689;
            border-color: #00c689
        }

        .pagination.pagination-rounded-flat .page-item .page-link,
        a {
            border: none;
            border-radius: 50px
        }



        tr > th, tr > td {
            text-align: center;
        }

        #bTitle{
            font-size: 30px;
        }

        #bTitle, .tab{
            float: left;
        }

        .tab{
            margin-top: 15px;
            margin-left: 3%;
        }

        .tab > a { color: #000; background-color: aliceblue;}
        a:link { color: #000; text-decoration: none; }
        a:visited { color: #000; }
        a:hover{color: gray;}


        .table {
            margin-top: 100px;
        }

        .boardName {
                margin-right: 40px;
            }

            .category{
                text-decoration: none;
                color: black;
                line-height : 54px;
            }

            #inquiry{
                color: orange;
            }
            
            .col-md-4 {
            flex: none !important;
            max-width: none !important;
        } 
        
        #inquiryNo{
	        display:none;
	        }
        
        a:hover{
			cursor: pointer;
		}


html {
            position: relative;
            min-height: 100%;
            margin: 0;
        }

        body {
            min-height: 100%;
        }

        .footer {
            position: absolute;
            left: 0;
            bottom: 0;
            width: 100%;
            /* padding: 15px 0; */
            text-align: center;
        }
    </style>

</head>

<body>
<jsp:include page="../common/header.jsp"/>
    <div class="container">
        <div class="row">

            <div class="col-md-12">
                <div class="px-lg-5">
    
                    <!-- 게시판 이름/카테고리 -->
                    <div class="row py-5">
                      <div class="col-lg-12 mx-auto">
                        <div class="text-black banner">
                            <h1 class="boardName float-left">1 : 1 문의</h1>
                            <a class="category" id="faq" href="faqView">FAQ</a> | 
                            <a class="category" id="inquiry" style="color:rgb(255, 200, 35)">1:1 문의</a> 
                          </div>
                        
                    </div>
                </div>
                    
                </div>
                <table class="table table-striped" id="list-table">
                    <thead>
                        <tr>
                            <th>카테고리</th>
                            <th>제목</th>
                            <th>문의날짜</th>
                            <th>답변여부</th>
                        </tr>
                    </thead>

                    <tbody>
                    <c:if test="${empty inquiryList}">
                   			<tr>
								<td colspan="6">존재하는 게시글이 없습니다.
							</tr>
                   </c:if>
                    <c:if test="${!empty inquiryList || loginMember.memberNo == 4}">
                    	<c:forEach var="board" items="${inquiryList}" varStatus="vs">
                        <tr>
                        	<td id="inquiryNo">${board.inquiryNo}</td>
                            <td>${board.categoryNm }</td>
                            <td class="boardTitle">${board.inquiryTitle }</td>
                            <td>${board.createDate }</td>
                            <td>
                            	<c:if test="${board.inquiryFl == 'N'}">
                            		<i class="far fa-times-circle"></i>
                            	</c:if>
                            	<c:if test="${board.inquiryFl == 'Y'}">
                            		<i class="fas fa-check-circle"></i>
                            	</c:if>
                            </td>
                        </tr>
                        </c:forEach>
					</c:if>
                    </tbody>
                </table>

                <a class="btn btn-success float-right" href="../admin/inquiryInsert">글쓰기</a>

                     <div class="padding">
                    <c:set var="firstPage" value="?cp=1"/>
					<c:set var="lastPage" value="?cp=${pInfo.maxPage}"/>
					
					<fmt:parseNumber var="c1" value="${(pInfo.currentPage - 1) / 10 }"  integerOnly="true" />
					<fmt:parseNumber var="prev" value="${ c1 * 10 }"  integerOnly="true" />
					<c:set var="prevPage" value="?cp=${prev}" />
					
					
					<fmt:parseNumber var="c2" value="${(pInfo.currentPage + 9) / 10 }" integerOnly="true" />
					<fmt:parseNumber var="next" value="${ c2 * 10 + 1 }" integerOnly="true" />
					<c:set var="nextPage" value="?cp=${next}" />
				
					
					
                        <div class="container d-flex justify-content-center">
                            <div class="col-md-4 col-sm-6 grid-margin stretch-card">
                                        <nav>
                                            <ul class="pagination d-flex justify-content-center flex-wrap pagination-rounded-flat pagination-success">
                                            	
	                                            <c:if test="${pInfo.currentPage > pInfo.pageSize}">
	                                                <li class="page-item"><a class="page-link" href="${firstPage }" data-abc="true">&laquo;</a></li>
                                                	<li class="page-item"><a class="page-link" href="${prevPage }" data-abc="true">&lt;</a></li>
	                                            </c:if>
                                            	
                                            	
                        <!-- 페이지 목록 -->
												<c:forEach var="page" begin="${pInfo.startPage}" end="${pInfo.endPage}" >
													<c:choose>
														<c:when test="${pInfo.currentPage == page }">
															<li class="page-item active"><a class="page-link" data-abc="true">${page}</a></li>
														</c:when>
													
														<c:otherwise>
															<li class="page-item"><a class="page-link" href="?cp=${page}" data-abc="true">${page}</a></li>
														</c:otherwise>
													</c:choose>
												</c:forEach>
												
												
												<c:if test="${next <= pInfo.maxPage}">
													<li class="page-item"><a class="page-link" href="${nextPage }" data-abc="true">&gt;</a></li>
													<li class="page-item"><a class="page-link" href="${lastPage }" data-abc="true">&raquo;</a></li>
												</c:if>
                                            </ul>
                                        </nav>

                            </div>
                        </div>
                    </div>


                    
            </div>

        </div>
    </div>
<jsp:include page="../common/footer.jsp"/>
<script>
$("#list-table td").on("click",function(){
	var inquiryNo = $(this).parent().children().eq(0).text();
	// 게시글 목록 : /spring/board/list/1
	// 게시글 상세조회 요청 주소 조합 -> spring/board/1/글번호  (list 빠짐)
	// 절대경로
	// var boardViewURL = "${contextPath}/board/${pInfo.boardType}/"+boardNo; 
  // 상대경로
  var boardViewURL = "${contextPath}/admin/inquiry/"+inquiryNo;
 
	
	location.href = boardViewURL; // 요청 전달

});
</script>
</body>

</html>