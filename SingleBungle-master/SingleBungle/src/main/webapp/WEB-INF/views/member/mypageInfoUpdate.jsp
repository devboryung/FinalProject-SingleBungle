<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 정보 수정</title>

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

/* 전화번호 ---------------------------------------------------------------------- */
/* .ph-area{
            display: flex;
        } */
.ph {
	box-sizing: content-box;
	width: 30%;
	/* margin: auto; */
	padding-right: 5%;
}

.ph-end {
	padding-right: 0;
}

/* 이메일 ---------------------------------------------------------------------- */
.em {
	box-sizing: content-box;
	width: 45%;
	padding-right: 2%;
}

.emg {
	box-sizing: content-box;
	width: 6%;
	padding-right: 2%;
	text-align: center;
}

.em-end {
	padding-right: 0;
}

/* 글씨 굵기 */
.textBold {
	font-weight: 500;
}

/* 동네 인증 */
/* .town-1 {
            padding-left: 0px;
            padding-right: 0px;
        }


        .town-area-1 {
            float: left;
            padding-left: 0px;
            padding-right: 0px;
        }

        .town-area-2 {
            float: right;
            padding-right: 0px;
        } */
</style>

</head>

<body>

	<jsp:include page="../common/header.jsp"/>

	<div class="container mt-5 pt-5">
		<div class="row">

			<%-- 이메일 전화번호 -> 구분자를 이용하여 분리된 배열 형태로 저장 --%>
			<c:set var="phone" value="${fn:split(loginMember.memberPhone, '-') }" />

			<jsp:include page="sideMenu.jsp" />


			<div class="col-md-4">

				<div class="text-center">

					<h3>내 정보 수정</h3>

					<hr>
				</div>
				
				
				
				<form action="mypageInfoUpdateAction" method="post" name="mypageInfoUpdateForm" onsubmit="return updateValidate();">
				
					<div class="form-group">
						<div>
							<label for="id" class="textBold">아이디</label>
							 <br> ${loginMember.memberId} <br> <br>
						</div>

						<div>
							<label for="name" class="textBold">이름</label>
							 <br> ${loginMember.memberName} <br> <br>
						</div>

						<div>
							<label for="mail" class="textBold">이메일</label>
							 <br> ${loginMember.memberEmail} <br> <br>
						</div>

						<label for="nickname" class="textBold">닉네임</label>
						 <input type="text" class="form-control" id="nickname" name="memberNickname" value="${loginMember.memberNickname}"
						 	placeholder="닉네임을 입력하세요." autocomplete='off' required>
						 <input type="hidden" name="nnDup" id="nnDup" value="false">
						<div>
							<!-- userName을 Nickname으로 바꾸기 -->
							<span id="checkNickname">&nbsp;</span>
						</div>
					</div>

					<div class="form-group">
						<label for="phone" class="textBold">전화번호</label>
						<div class="input-group">
							<!-- ph-area -->
							<div class="ph">
								<!-- 전화번호 앞자리 불러오기 ㄱ- -->
								<select class="form-control phone" id="phone1" name="phone1" value="${phone[0]}">
									<option <c:if test="${phone[0] == '010'}"> selected </c:if> >010</option> <!-- 010이었으면..여길선택해라.. -->
									<option <c:if test="${phone[0] == '011'}"> selected </c:if> >011</option>
									<option <c:if test="${phone[0] == '016'}"> selected </c:if> >016</option>
									<option <c:if test="${phone[0] == '017'}"> selected </c:if> >017</option>
									<option <c:if test="${phone[0] == '019'}"> selected </c:if> >019</option>
								</select>
							</div>
							<div class="ph">
								<input type="text" class="form-control phone" id="phone2" name="phone2" value="${phone[1]}"
									maxlength="4" size="4" autocomplete='off' required>
							</div>
							<div class="ph ph-end">
								<input type="text" class="form-control phone" id="phone3" name="phone3" value="${phone[2]}"
									maxlength="4" size="4" autocomplete='off' required>
							</div>
						</div>
						<div>
							<!-- 전화번호 유효성 검사 -->
							<span id="checkPhone">&nbsp;</span>
						</div>
					</div>

					<!-- <div class="form-group">
                            <label for="town">* 동네 인증하기</label>
                            <div class="form-row">
                                <div class="col-md-8 town-area-1">
                                    <input type="nickname" class="form-control town-1">
                                </div>
                                <div class="col-md-4 town-area-2">
                                    <button type="submit" class="btn btn-primary btn-block">인증하기</button>
                                </div>
                            </div>
                        </div> -->

					<hr>
					<br>

					<button type="submit" class="btn btn-block maincolor">정보 수정 완료</button>

					<br> <br> <br> <br> <br> <br>
				</form>
			</div>
		</div>

		<div class="col-md-4"></div>
	</div>

	<jsp:include page="../common/footer.jsp" />

<script>
/* 사이드 메뉴를 내가 선택한 메뉴에 색 고정하기 */
$(function() {
	$("#mypageInfoUpdate")
			.attr('class',
					'nav-link px-4 active text-white shadow-sm rounded-pill maincolor');
});


/* 전화번호 앞 부분 지정 */
(function(){
		// #phone1의 자식 중 option 태그들을 반복 접근
	$("#phone1 > option").each(function(index, item){
		// index : 현재 접근중인 인덱스
		// item : 현재 접근중인 요소
		
			// 현재 접근한 요소에 써져있는 값과 전화번호 배열의 첫번째 값이 같다면
		if( $(item).text() == "${phone[0]}"){
			// 현재 접근한 요소에 seleted라는 옵션을 추가
			$(item).prop("selected",true);
		}
	});
})();

/* ------------------------------------------------------------- */

// 입력값들이 유효성 검사가 진행되었는지 확인하기 위한 객체 생성
var validateCheck = {
    "phone2" : false,
    "nickname" : false
}

//닉네임 유효성 검사
$("#nickname").on("input", function(){
    var regExp = /^[a-zA-Z가-힣\d]{2,8}$/;

    var value = $("#nickname").val();
	console.log(value);
    if(!regExp.test(value)){
        $("#checkNickname").text("닉네임 형식이 유효하지 않습니다.").css("color", "red");
        validateCheck.nickname = false;
    } else{
        // ajax를 이용한 실시간 닉네임 중복 검사 ----------------------------------------------------
        $.ajax({
            url : "nnDupCheckUpdate",
            data : {"memberNickname" : value},
            type : "POST",
            success : function(result){
            if(result == 0){    // 중복되지 않은 경우
                $("#checkNickname").text("사용 가능한 닉네임 입니다.")
                .css("color", "green");
                validateCheck.nickname = true;
            }else{
                $("#checkNickname").text("이미 사용중인 닉네임입니다.")
                .css("color", "red");
                validateCheck.nickname = false;
            }

            },
            error : function(){
                console.log("닉네임 중복검사 실패");
            }
        });
    }
});


// 전화번호 유효성 검사
$(".phone").on("input", function(){

    // 전화번호 input 태그에 4글자 초과 입력하지 못하게 하는 이벤트
    if ($(this).val().length > 4) {
        $(this).val( $(this).val().slice(0, 4));
    }
    
    var regExp1 = /^\d{3,4}$/;
    var regExp2 = /^\d{4}$/;

    var v1 = $("#phone2").val();
    var v2 = $("#phone3").val();

    if(!regExp1.test(v1) || !regExp2.test(v2)){
        $("#checkPhone").text("전화번호가 유효하지 않습니다.")
            .css("color", "red");
        validateCheck.phone2 = false;
    }else{
        $("#checkPhone").text("유효한 형식의 전화번호 입니다.")
            .css("color", "green");
        validateCheck.phone2 = true;
    }
});

/* ------------------------------------------------------------- */
        
// submit 동작
function updateValidate(){

	
       // 유효성 검사 여부 확인
       for(var key in validateCheck){
           if(!validateCheck[key]){
               var msg;
               switch(key){
                   case "nickname" : msg="닉네임이"; break;
                   case "phone2" : msg="전화번호가"; break;
               }

               swal({icon:"warning", title:msg+" 형식이 유효하지 않습니다."})
		.then(function(){ // swal 창이 닫힌 후 동작을 지정
			var id = "#" + key;
			$(id).focus();
		});
		
		        return false;
		    } 
		}
		     
		// 입력된 전화번호, 주소 조합하여 form태그에 hidden으로 추가 하기
		// 왜? -> 커맨드 객체를 이용하여 파라미터를 한번에 받기 쉽게 하기 위하여
		 $memberPhone = $("<input>", {type : "hidden", name : "memberPhone",
				value : $("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val()
		});
		
		
		$("form[name='mypageInfoUpdateForm']").append($memberPhone);
}



	
</script>


</body>

</html>