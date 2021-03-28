<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>

    <!-- 구글 폰트 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
        rel="stylesheet">

    <!-- 부트스트랩 사용을 위한 css 추가 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
        integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

    <!-- 부트스트랩 사용을 위한 라이브러리 추가 (반드시 jQuery가 항상 먼저여야한다. 순서 중요!) -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
        crossorigin="anonymous"></script>
	<!-- sweetalert : alert창을 꾸밀 수 있게 해주는 라이브러리 https://sweetalert.js.org/ -->
  	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
   
    <style>
        * {
            font-family: 'Noto Sans KR', sans-serif;
            font-weight: 500;
            /* 굵기 지정(100, 300, 400, 500, 700) */
            font-size: 16px;
            color: #212529;

            margin: 0;
        }

        a {
            color: #212529;
        }

        a:hover {
            text-decoration: none;
        }
        
        /* ---------------------------------------------------------------------- */
        
        /* 소제목 글씨 굵기 */
		.textBold300 {
			font-weight: 300;
		}

		.textBold400 {
			font-weight: 400;
		}
		
		.textBold500 {
			font-weight: 500;
		}
        
        /* ---------------------------------------------------------------------- */
        /* sns ---------------------------------------------------------------------- */
        #sns_signUp {
            margin-top: 50px;
        }

        .sns_text {
            color: #757575;
            font-weight: 400;
            font-size: 13px;
            margin-bottom: 10px;
        }

        .sns_logo {
            width: 45px;
            margin-left: 5px;
            margin-bottom: 20px;
        }


        /* 전화번호 ---------------------------------------------------------------------- */
        /* .ph-area{
            display: flex;
        } */

        .ph{
            box-sizing: content-box;
            width:30%;
            /* margin: auto; */
            padding-right: 5%;

        } 

        .ph-end{
            padding-right: 0;
        }

        /* 이메일 ---------------------------------------------------------------------- */
        .em{
            box-sizing: content-box;
            width:45%;
            padding-right: 2%;
        }

        .emg{
            box-sizing: content-box;
            width:6%;
            padding-right: 2%;
            text-align: center;
        }

        .em-end{
            padding-right: 0;
        }

        /* ---------------------------------------------------------------------- */
        /* 약관동의 네모박스 */
        .agree {
            border: 1px solid #ced4da;
            padding: 15px;
        }

    </style>

</head>

<body>

	<c:if test="${!empty swalTitle}">
		<script>
			swal({icon : "${swalIcon}",
				 title : "${swalTitle}",
				 text : "${swalText}"});
		</script>
	</c:if>
	
	<jsp:include page="../common/header.jsp"/>
	
    <div class="container">
        <div class="row">
            <div class="col-md-4">
            </div>

            <div class="col-md-4">

                <div class="text-center">

                    <!-- <h3 style="margin-bottom:50px;">로고,,ㄱ-</h3> -->

                    <h3>회원가입</h3>

                    <!-- <div class="text-center" id="sns_signUp">
                        <div class="sns_text">
                            SNS계정 간편 로그인/회원가입
                        </div>
                        <a href="#"><img class="sns_logo" src="img/sns_naver.jpg"></a>
                        <a href="#"><img class="sns_logo" src="img/sns_kakao.jpg"></a>
                    </div> -->

                    <hr>
                </div>



                <form action="signUpAction" method="post" name="signUpForm" onsubmit="return memberJoinvalidate();">
                    <!-- required : 필수 입력 속성 -->
                    <div class="form-group">
                        <label for="userId" class="textBold500"><span class="requiredInput">*</span> 아이디</label>
                        <div>
                            <small>첫 글자는 영어 소문자, 나머지 글자는 영어 대, 소문자 + 숫자 (총 6~12글자)</small>
                        </div>
                        <input type="text" class="form-control" id="userId" name="memberId" autocomplete="off" placeholder="아이디를 입력하세요." required>
                        <input type="hidden" name="idDup" id="idDup" value="false">
                        <div><!-- 아이디 유효성 검사 -->
                            <small id="checkId">&nbsp;</small>
                        </div> 
                    </div>

                    <div class="form-group">
                        <label for="pwd1" class="textBold500"><span class="requiredInput">*</span> 비밀번호</label>
                        <div>
                            <small>영어 대, 소문자 + 숫자 (총 6~12글자)</small>
                        </div>
                        <input type="password" class="form-control" id="pwd1" name="memberPwd" placeholder="비밀번호를 입력하세요." required>
                        <div><!-- 비밀번호 유효성 검사 -->
                            <small id="checkPwd1" >&nbsp;</small>
                        </div> 
                    </div>

                    <div class="form-group">
                        <label for="pwd2" class="textBold500"><span class="requiredInput">*</span> 비밀번호 확인</label>
                        <input type="password" class="form-control" id="pwd2" name="pwd2" placeholder="비밀번호를 한번 더 입력하세요." required>
                        <div> <!-- 비밀번호 확인 유효성 검사 -->
                            <small id="checkPwd2" >&nbsp;</small>
                        </div>
                    </div>
					
					<!-- 이름 -->
                    <div class="form-group">
                        <label for="name" class="textBold500"><span class="requiredInput">*</span> 이름</label>
                        <div>
                            <small>한글 입력 (2자 이상)</small>
                        </div>
                        <input type="text" class="form-control" id="name" name="memberName" placeholder="이름을 입력하세요." required>
                        <div> <!-- 이름 유효성 검사 -->
                            <span id="checkName" >&nbsp;</span>
                        </div> 
                    </div>
					
					<!-- 닉네임 -->
                    <div class="form-group">
                        <label for="nickname" class="textBold500"><span class="requiredInput">*</span> 닉네임</label>
                        <div>
                            <small>한글 또는 영문 입력 (총 2~8글자)</small>
                        </div>
                        <input type="text" class="form-control" id="nickname" name="memberNickname" placeholder="닉네임을 입력하세요." required>
                        <input type="hidden" name="nnDup" id="nnDup" value="false">
                        <div>
                            <!-- userName을 Nickname으로 바꾸기 -->
                            <span id="checkNickname" >&nbsp;</span>
                        </div> 
                    </div>

                    <div class="form-group">
                        <label for="phone" class="textBold500"><span class="requiredInput">*</span> 전화번호</label>
                        <div class="input-group"><!-- ph-area -->
                            <div class="ph">
                                <select class="form-control phone" id="phone1" name="phone1">
                                    <option>010</option>
                                    <option>011</option>
                                    <option>016</option>
                                    <option>017</option>
                                    <option>019</option>
                                </select>
                            </div>
                            <div class="ph">
                                <input type="text" class="form-control phone" id="phone2" name="phone2" maxlength="4" size="4" required>
                            </div>
                            <div class="ph ph-end">
                                <input type="text" class="form-control phone" id="phone3" name="phone3" maxlength="4" size="4" required>
                            </div>
                        </div>
                        <div> <!-- 전화번호 유효성 검사 -->
                            <span id="checkPhone" >&nbsp;</span>
                        </div> 
                    </div>

                    <div class="form-group">
                        <label for="email" class="textBold500"><span class="requiredInput">*</span> 이메일</label>
                        <div class="input-group">
                            <div class="em email-1">
                                <input type="text" class="form-control email" id="email1" name="email1" placeholder="이메일" required>
                            </div>

                            <div class="emg email-2">@</div>
                            <div class="em email-3 em-end">
                                <select class="form-control email" id="email2" name="email2">
                                    <option>이메일 선택</option>
                                    <option>naver.com</option>
                                    <option>daum.net</option>
                                    <option>hanmail.net</option>
                                    <option>gmail.com</option>
                                    <option>nate.com</option>
                                </select>
                            </div>
                            <div>
                            <!-- 이메일 유효성 검사 -->
                               <span id="checkEmail" ></span>
                            </div>

                        </div>

                        <br>

                        <div class="form-row">
                            <div class="col-md-5 verifyBtn">
                                <button type="button" class="btn btn-primary form-control maincolor" id="sendMailBtn" name="sendMailBtn">인증번호 전송</button>
                            </div>
                            <div class="col-md-7">
                                <input type="text" class="form-control email" id="verifyEmail" placeholder="인증번호 입력" required>
                            </div>
                            <!-- 인증 확인 체크 -->
                            <div id="checkFl">
                                <span id="checkKey">&nbsp;</span>
                            </div>
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="gender" class="textBold500"><span class="requiredInput">*</span> 성별</label>
                        <br>

                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="m" name="memberGender" value="M" class="custom-control-input" required>
                            <label class="custom-control-label textBold400" for="m">남자</label>
                          </div>
                          <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" id="w" name="memberGender" value="W" class="custom-control-input">
                            <label class="custom-control-label textBold400" for="w">여자</label>
                          </div>
                    </div>

                    <hr>

                    <label for="agree" class="textBold500"><span class="requiredInput">*</span> 약관동의</label>
                    <div class="form-group agree">
                            <!-- id, for끼리는 이름이 같으면 안된다! -->
                            <div class="custom-control custom-checkbox mb-3">
                                <input type="checkbox" class="custom-control-input" id="ck_all">
                                <label class="custom-control-label" for="ck_all" style="font-weight: 700;">전체동의</label>
                            </div>

                            <hr>

                            <div class="custom-control custom-checkbox mb-3">
                                <input type="checkbox" class="custom-control-input ck_box" id="customCheck1" required>
                                <label class="custom-control-label textBold400" for="customCheck1">만 14세 이상입니다. <small class="requiredInput">(필수)</small></label>
                            </div>
                            <div class="custom-control custom-checkbox mb-3">
                                <input type="checkbox" class="custom-control-input ck_box" id="customCheck2" required>
                                <label class="custom-control-label textBold400" for="customCheck2">이용약관 <small class="requiredInput">(필수)</small></label>
                            </div>
                            <div class="custom-control custom-checkbox mb-3">
                                <input type="checkbox" class="custom-control-input ck_box" id="customCheck3" required>
                                <label class="custom-control-label textBold400" for="customCheck3">개인정보처리방침 <small class="requiredInput">(필수)</small></label>
                            </div>
                            <div class="custom-control custom-checkbox mb-3">
                                <input type="checkbox" class="custom-control-input ck_box" id="customCheck4">
                                <label class="custom-control-label textBold400" for="customCheck4">
                                    이벤트,프로모션 알림 메일 및 SMS 수신 <small>(선택)</small>
                                </label>
                            </div>
                    </div>
                    
                    <div class="submit">
                    	<button id="nextBtn" type="submit" class="btn btn-primary btn-block maincolor">회원가입 완료</button>
                    </div>
		

                    <br>
                    <div class="text-center">
                        <span style="font-weight: 400;">
                            이미 아이디가 있으신가요?
                        </span>
                        	<a href="${contextPath}/member/login" style="font-weight: 700;" class="maincolor-font">로그인</a>
                    </div>
                    <br><br><br><br><br><br>
                </form>
            </div>
        </div>

        <div class="col-md-4">

        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
    

    <script>
        // 입력값들이 유효성 검사가 진행되었는지 확인하기 위한 객체 생성
        var validateCheck = {
            "userId" : false,
            "name" : false,
            "pwd1" : false,
            "pwd2" : false,
            "phone2" : false,
            "email" : false,
            "nickname" : false
        }

        // 아이디 유효성 검사
        // 첫 글자는 영어 소문자, 나머지 글자는 영어 대,소문자 + 숫자, 총 6~12글자
        $("#userId").on("input",function(){
            var regExp = /^[a-z][a-zA-Z\d]{5,11}$/;

            var value = $("#userId").val();
            if(!regExp.test(value)){
                $("#checkId").text("아이디 형식이 유효하지 않습니다.")
                                .css("color", "red");
                validateCheck.userId = false;   

            }else{
                // $("#checkId").text("유효한 아이디 형식입니다.")
                //                 .css("color", "green");


                // ajax를 이용한 실시간 아이디 중복 검사 ----------------------------------------------------
                $.ajax({
                    url : "idDupCheck",
                    data : {"memberId" : value},
                    type : "POST",
                    success : function(result){
                    // $("#checkId").text("유효한 아이디 형식입니다.").css("color", "green");
                    
                    if(result == 0){    // 중복되지 않은 경우
                        $("#checkId").text("사용 가능한 아이디 입니다.")
                        .css("color", "green");
                        validateCheck.userId = true;
                    }else{
                        $("#checkId").text("이미 사용중인 아이디입니다.")
                        .css("color", "red");
                        validateCheck.userId = false;
                    }

                    },
                    error : function(){
                        console.log("아이디 중복검사 실패")
                    }
                });
            }

            // 아이디가 입력되는 경우 hidden 태그의 값을 false로 변경
            // $("#idDup").val("false");
        });


        // 비밀번호 유효성 검사
        // 영어 대,소문자 + 숫자, 총 6~12글자
        // + 비밀번호, 비밀번호 확인의 일치 여부
        // + 비밀번호를 입력하지 않거나 유효하지 않은 상태로
        //   비밀번호 확인을 작성하는 경우

        $("#pwd1, #pwd2").on("input", function () {

            // 비밀번호 유효성 검사 
            var regExp = /^[A-Za-z\d]{6,12}$/;
            var v1 = $("#pwd1").val();
            var v2 = $("#pwd2").val();

            if (!regExp.test(v1)) {
                $("#checkPwd1").text("비밀번호 형식이 유효하지 않습니다.").css("color", "red");
                validateCheck.pwd1 = false;
            } else {
                $("#checkPwd1").text("유효한 비밀번호 형식입니다.").css("color", "green");
                validateCheck.pwd1 = true;
            }
            // 비밀번호가 유효하지 않은 상태에서 비밀번호 확인 작성 시
            if (!validateCheck.pwd1 && v2.length > 0) {
                alert("유효한 비밀번호를 먼저 작성해주세요.");
                $("#pwd2").val(""); // 비밀번호 확인에 입력한 값 삭제
                $("#pwd1").focus();
            } else {
                // 비밀번호, 비밀번호 확인의 일치 여부
                if (v1.length == 0 || v2.length == 0) {
                    $("#checkPwd2").html("&nbsp;");
                
                } else if(v1 == v2){
                    $("#checkPwd2").text("비밀번호 일치").css("color", "green");
                    validateCheck.pwd2 = true;
            

                } else {
                    $("#checkPwd2").text("비밀번호 불일치").css("color", "red");
                    validateCheck.pwd2 = false;
                }
            }
        });
        
        // 이름 유효성 검사(한글 2글자 이상)
        $("#name").on("input", function(){
            var regExp = /^[가-힣]{2,}$/;

            var v1 = $("#name").val();

            if(!regExp.test(v1)){
                $("#checkName").text("이름 형식이 유효하지 않습니다.").css("color", "red");
                validateCheck.name = false;
            } else {
                $("#checkName").text("유효한 이름 형식입니다.").css("color", "green");
                validateCheck.name = true;
            }
        });


        // 닉네임 유효성 검사
        $("#nickname").on("input", function(){
            var regExp = /^[a-zA-Z가-힣\d]{2,8}$/;

            var value = $("#nickname").val();

            if(!regExp.test(value)){
                $("#checkNickname").text("닉네임 형식이 유효하지 않습니다.").css("color", "red");
                validateCheck.nickname = false;
            } else{
                // ajax를 이용한 실시간 닉네임 중복 검사 ----------------------------------------------------
                $.ajax({
                    url : "nnDupCheck",
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
                        console.log("닉네임 중복검사 실패")
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
        

        // 이메일 유효성 검사
         $("#email1").on("input", function(){
            var e1 = $("#email1").val();
            var regExp = /^[a-zA-Z\d_]{4,10}$/;
                if(!regExp.test(e1)){
                    $("#checkEmail").text("이메일 형식이 유효하지 않습니다.")
                    .css("color", "red");
                    validateCheck.email = false;
                }else{
                    $("#checkEmail").text("유효한 이메일 형식입니다.")
                    .css("color", "green");
                    validateCheck.email = true;
                }
        }); 

        /* ------------------------------------------------------------- */

        // ----------------메일 인증 AJAX(잔산) -------------------------
        var key;
        
        $("#sendMailBtn").click(function() {// 메일 입력 유효성 검사
         var mail = $("#email1").val() + "@" + $("#email2").val(); //사용자의 이메일 입력값. 
			
         var mailId =$("#email1").val();
         
         console.log(mail);
         
         if (mailId == "") { // 아이디가 입력되지 않았다면
            alert("메일 주소가 입력되지 않았습니다.");
         } else {
            $.ajax({
               type : 'post',
               url : 'SignUpMail',
               data : {
                  mail:mail
                  },
               
               success : function(result){
                 key = result;
		         alert("인증번호가 전송되었습니다.");
		         validateCheck.email = true;
                  
               },error : function(){
            	   validateCheck.email = false; 
               }
            });
         }
      });
      
         $("#verifyEmail").on("propertychange change keyup paste input", function() {
            if ($("#verifyEmail").val() == key) {   //인증 키 값을 비교를 위해 텍스트인풋과 벨류를 비교
               $("#checkKey").text("인증 성공!").css("color", "green");
               $("#verifyEmail").css("border", "1px solid #5fcf80");
               isCertification = true;  //인증 성공여부 check
            } else {
               $("#checkKey").text("불일치!").css("color", "red");
               $("#verifyEmail").css("border", "1px solid red");
               isCertification = false; //인증 실패
            }
         });
         
         
         $("#nextBtn").click(function memberJoinvalidate(){
            if(isCertification==false){
               alert("메일 인증이 완료되지 않았습니다.");
               return false;
            }
         }); 
        
        
        
        
        
        /* var key;
 	
        $("#sendMail").click(function() {// 메일 입력 유효성 검사
            var mail = $("#email1").val() + "@" + $("#email2").val(); //사용자의 이메일 입력값. 
            
            if (mail == "") {
                alert("메일 주소가 입력되지 않았습니다.");
            } else {
                $.ajax({
                    type : 'post',
                    url : '${contextPath}/member/normalSignUpMail',
                    data : {
                        mail:mail
                        },
                    
                    success : function(result){
                        key = result;
                        
                    }
                });
            alert("인증번호가 전송되었습니다.");
            }
        });
 	
 		$("#verifyEmail").on("propertychange change keyup paste input", function() {
 			if ($("#verifyEmail").val() == key) {   //인증 키 값을 비교를 위해 텍스트인풋과 벨류를 비교
 				$("#checkFl").text("인증 성공!").css("color", "green");
 				isCertification = true;  //인증 성공여부 check
 			} else {
 				$("#checkFl").text("불일치!").css("color", "red");
 				isCertification = false; //인증 실패
 			}
 		});
 		
 		
 		$("#nextBtn").click(function memberJoinvalidate(){
 			if(isCertification==false){
 				alert("메일 인증이 완료되지 않았습니다.");
 				return false;
 			}
 		});  */

        /* ------------------------------------------------------------- */
        
        function memberJoinvalidate(){

            // 아이디 중복검사 여부 확인
        /*     if($("#idDup").val() != "true"){
                swal("아이디 중복 검사를 진행해 주세요.");
                $("#idDupCheck").focus();

                return false;
            }
        */

            // 유효성 검사 여부 확인
            for(var key in validateCheck){
                if(!validateCheck[key]){
                    var msg;
                    switch(key){
                        case "userId" : msg="아이디가"; break;
                        case "pwd1" : 
                        case "pwd2" : msg="비밀번호가"; break;
                        case "name" : msg="이름이"; break;
                        case "nickname" : msg="닉네임이"; break;
                        case "phone2" : msg="전화번호가"; break;
                        case "email" : msg="이메일이"; break;
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
			
			$memberEmail = $("<input>", {type : "hidden", name : "memberEmail",
					value : $("#email1").val() + "@" + $("#email2").val()
			});


			$("form[name='signUpForm']").append($memberPhone).append($memberEmail);
			 
			
        }

        // ------------------------------------- 약관동의 ------------------------------------- 

        // 약관동의 체크박스 전체 선택&해제
        $('#ck_all').click(function(){
             if($("#ck_all").prop("checked")){
                $("input[type=checkbox]").prop("checked",true); 
            }else{
                $("input[type=checkbox]").prop("checked",false); 
            }
        });
        
        // .ck_box 4개 모두가 체크되었을 때 #ck_all(전체동의)도 체크되게 하는 구문
        $('.ck_box').on('change',function(){
            var count=$('.ck_box:checked').length;

            if(count==4){
                $('#ck_all').prop("checked",true);
            }
        });
    </script>
</body>

</html>