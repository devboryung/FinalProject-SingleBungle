<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

            .clear-both{
                clear: both;
            }

            #boardNo{
            	display : none;
            }
          
            .container{
				min-height : 1050px;
			} 
			
			#boardContent{
				min-height : 600px;
			}
        </style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
    <div class="container">
        <div class="row">

            <div class="col-md-12">
                <p>1 : 1 문의사항</p>
                <hr>
                <div class="boardArea">
                        <div class="row">
                            <div class="col-md-8">
                                <span id="boardNo">${inquiry.inquiryNo}</span>
                            	<span>[${inquiry.categoryNm}]</span>
                                <span id="bTitle">${inquiry.inquiryTitle }</span>
                            </div>
                            <div class="col-md-4">
                                <div id="boardInfo">
                                    <span><span>${inquiry.createDate}</span><br></span><br>
                                </div>
                            </div>
                        </div>
                </div>
                <hr>

                <div id="boardContent">
                    <% pageContext.setAttribute("newLine", "\n"); %>
					${fn:replace(inquiry.inquiryContent, newLine , "<br>") }

                </div>

                <hr>
                <div>
					<!-- 댓글(페이지 연결하기) -->
								<jsp:include page="inquiryReply.jsp"></jsp:include>

								<!-- 버튼 -->
								<div class="row float-right mt-3">
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12">
											<c:if test="${loginMember.memberNo == inquiry.memberNo}">
												<a href="#" class="btn btn-success ml-1 mr-1">수정</a>
												<a href="../${inquiry.inquiryNo}/inquiryDelete" class="btn btn-success ml-1 mr-1">삭제</a>
											</c:if>
											</div>
										</div>
									</div>
								</div>
						
								<!-- 목록버튼 -->
								<div class="row  py-3" style="clear: both;">
									<div class="col-md-12 text-center">
										<c:if test="${empty sessionScope.returnListURL }">
											<c:set var="returnListURL" value="../inquiryList" scope="session" />
										</c:if>
								<button type="button" class="btn btn-success returnBtn maincolor" style="width: 100px; height: 40px;">목록으로</button>
									</div>
								</div>
				</div>
                <!-- <hr class="clear-both"> -->

                

            </div>

        </div>
    </div>
    <jsp:include page="../common/footer.jsp"/>
    
     <script>
    $(".returnBtn").on("click", function(){
		location.href = "../inquiryList"
	});
    </script>
</body>
</html>