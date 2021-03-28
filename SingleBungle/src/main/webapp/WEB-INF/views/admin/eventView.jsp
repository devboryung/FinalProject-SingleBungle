<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이벤트 보기</title>

    <!-- 부트스트랩 사용을 위한 css 추가 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
        integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

    <!-- 부트스트랩 사용을 위한 라이브러리 추가 -->
    <!-- 제이쿼리가 항상 먼저여야함 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
        crossorigin="anonymous"></script>


        <style>
            /* div {
                border: 1px solid;
            } */
            #bTitle{
                font-size: 30px;
            }

            .boardArea{
                margin-top: 30px;
            }

            #boardTitle{
                font-size: 30px;
            }

            #boardInfo {
                float: right;
                margin-top: 3%;
            }

            .blist{
                width: 100%;
            }


			.container{
				min-height : 1050px;
			}
			
			#boardContent{
				min-height : 800px;
			}
             
            
        </style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
    <div class="container">
        <div class="row">

            <div class="col-md-12">
                <p id="bTitle">이벤트</p>
                <hr>
                <div class="boardArea">
                        <div class="row">
                            <div class="col-md-8">
                                <span id="boardTitle">${board.boardTitle }</span>
                            </div>
                            <div class="col-md-4">
                                <div id="boardInfo">
                                    <span>${board.boardCreateDate}</span><br>
                                    <span>조회수 : ${board.readCount }</span>
                                </div>
                            </div>
                        </div>
                </div>
                <hr>

                <div id="boardContent">
                    <%-- ${board.boardContent} --%>
					<%-- JSTL을 이용한 개행문자 처리 --%>
					
					
					
					<% pageContext.setAttribute("newLine", "\n"); %>
					${fn:replace(board.boardContent, newLine , "<br>") }
                </div>

                <hr>
                <div>
					<c:url var="updateUrl" value="../${board.boardNo}/${board.boardCode }/update"/>	
					<div class="float-right">
						<c:if test="${empty sessionScope.returnListURL }">
							<c:set var="returnListURL" value="../eventList" scope="session" />
						</c:if>
				<button type="button" class="btn btn-success returnBtn maincolor" style="width: 100px; height: 40px;">목록으로</button>
						<c:if test="${loginMember.memberNo == 4 }">
	                		<a href="${updateUrl }" class="btn btn-success ml-1 mr-1">수정</a>
							<a href="../${board.boardNo}/${board.boardCode}/delete" class="btn btn-success ml-1 mr-1">삭제</a>
						</c:if>
					</div>
				</div>
            </div>

        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
    
    <script>
    $(".returnBtn").on("click", function(){
		location.href = "../eventList"
	});
    </script>
</body>
</html>