<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>댓글 관리</title>

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
                margin-top: 10px;
            }

			.hidden{
            	display:none;
            }


        </style>
            
        <script>
        $(document).ready(function(){
            //최상단 체크박스 클릭
            $("#checkall").click(function(){
                //클릭되었으면
                if($("#checkall").prop("checked")){
                    //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
                    $("input[name=chk]").prop("checked",true);
                    //클릭이 안되있으면
                }else{
                    //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
                    $("input[name=chk]").prop("checked",false);
                }
            })
        });
        </script>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
    <div class="container">
        <div class="row">
  <jsp:include page="sideMenu.jsp" />
            <div class="col-sm-9">
                <div class="px-lg-5">
    
                    <!-- 게시판 이름/카테고리 -->
                    <div class="row py-5">
                          <h1 class="boardName float-left">삭제 댓글 관리</h1>
                </div>     
                </div>

                <div>
                    <select class="form-control" id= "categorySearch"  style="width: 100px; display: inline-block;">
                        <option value="0">전체</option>
                        <option value="1">자유</option>
                        <option value="2">후기</option>
                        <option value="6">맛집</option>
                        <option value="7">친구찾기</option>
                        <option value="8">사고팔고</option>
                    </select>
                </div>
                
                
                <table class="table table-striped" id="list-table">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkall"></th>
                            <th>번호</th>
                            <th>게시판명</th>
                            <th>내용</th>
                            
                        </tr>
                    </thead>

                    <tbody>
                    <c:if test="${empty replyList }">
                   			<tr>
								<td colspan="6">존재하는 게시글이 없습니다.
							</tr>
                   </c:if>
                   <c:if test="${!empty replyList }">
                  	<c:forEach var="reply" items="${replyList}" varStatus="vs">
                        <tr>
                            <td><input type="checkbox" name="chk"></td>
                            <td>${reply.replyNo }</td>
                            <td class="hidden">${reply.boardCode }</td>
                            <td class="hidden">${reply.parentBoardNo }</td>
                            <td>
                            	<c:choose>
									<c:when test="${reply.boardCode == 1}">자유게시판</c:when>
									<c:when test="${reply.boardCode == 2}">후기게시판</c:when>
									<c:when test="${reply.boardCode == 3}">고객센터</c:when>
									<c:when test="${reply.boardCode == 4}">이벤트</c:when>
									<c:when test="${reply.boardCode == 6}">맛집게시판</c:when>
									<c:when test="${reply.boardCode == 7}">친구찾기</c:when>
									<c:when test="${reply.boardCode == 8}">사고팔고</c:when>
								</c:choose>
                            </td>
                            <td class="boardTitle">${reply.replyContent }</td>
                        </tr>

                    </c:forEach>
                    </c:if>
                    </tbody>
                </table>

                <div class="float-right">
                    <button id="recoverBtn" class="btn btn-success">복구</button> 
                </div>
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

        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
     <script>
    $(function(){
			$("#replyManage").attr('class','nav-link px-4 active bg-primary text-white shadow-sm rounded-pill');
	});
    
    
    
    $("#recoverBtn").on("click", function(){
    	var replyNoList = [];
    	var boardCodeList = [];
    	
            $("input:checkbox[name=chk]").each(function(){
				if(this.checked){
					replyNoList.push($(this).parent().siblings().eq(0).text());
					 boardCodeList.push($(this).parent().siblings().eq(1).text());
				}
        });
            
            

    	
           $.ajax({
				url : "${contextPath}/admin/recoverReply",
				data : {"replyNoList" : replyNoList, "boardCodeList" : boardCodeList},
				
				type : "post",
				
				success : function(flag){
					 if(flag){ 
						swal({
							icon : "success" , 
				        	title : "복구 성공", 
				        	buttons : {confirm : true}
						}).then(function() {
				        	location.href = "${contextPath}/admin/replyManage";
						});
						
					} 
				},
				error : function(){
					console.log("복구 실패");
				}
			}); 
        	
    });
    
    
    $("#categorySearch").change(function(){
 	   var ct = $(this).val();
 	    
 	    
 	    //console.log("search?ct=" + ct);
 	    location.href = "replySearch?ct=" + ct;
 	});
 	
 	
 	$(function(){
 		$("#categorySearch > option").each(function(index,item){
 				if($(item).val() == "${ct}"){
 				//$(this).prop("selected", true);
 				$("#categorySearch > option[value="+$(item).val()+"]").attr("selected","selected");
 				}
 		});
 	});

 	
/*  	
 	$("#list-table td:not(:first-child)").on("click",function(){
		var boardNo = $(this).parent().children().eq(3).text();
		var boardCode = $(this).parent().children().eq(2).text();
		
	  var boardViewURL = null;
	  if(boardCode == 1) boardViewURL = "${contextPath}/board/"+ boardNo;
	  else if(boardCode == 2) boardViewURL = "${contextPath}/review/view/"+ boardNo;
	  else if(boardCode == 3) boardViewURL = "${contextPath}/admin/notice/"+ boardNo;
	  else if(boardCode == 4) boardViewURL = "${contextPath}/admin/event/"+ boardNo;
	  else if(boardCode == 6) boardViewURL = "${contextPath}/cafe/"+ boardNo;
	  else if(boardCode == 7) boardViewURL = "${contextPath}/findFriend/"+ boardNo;
	  else if(boardCode == 8) boardViewURL = "${contextPath}/market/"+ boardNo;
	  
		console.log(boardNo);
		console.log(boardCode);
		
	location.href = boardViewURL; // 요청 전달

}); */
</script>
</body>
</html>