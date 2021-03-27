<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>탈퇴</title>

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

/* -------------------------------------------------------------- */

/* 탈퇴약관 박스 */
.agree {
    border: 1px solid #ced4da;
    background-color: #fcfcfc;
    padding: 15px;
}

.title {
    font-weight: 600;
}

.text, .text li{
	font-size: 14px;
}


/* 글씨 굵기 */
.textBold {
	font-weight: 500;
}

</style>

</head>

<body>

	<jsp:include page="../common/header.jsp"/>

	<div class="container mt-5 pt-5">
		<div class="row">

			<jsp:include page="sideMenu.jsp" />


			<!-- 관리자 마이페이지는 9였음, , , ,   -->
			<div class="col-sm-4">

				<form action="mypageSecessionAction" method="post" onsubmit="return validate();">

					<h3 class="text-center">회원 탈퇴</h3>
					<hr>

					<div class="form-group">
						<label for="userId" class="textBold">아이디</label>
						<div>${loginMember.memberId}</div>
					</div>

					<div class="form-group">
						<label for="pw" class="textBold">비밀번호</label>
						<input type="password" class="form-control"
							id="currentPwd" name="memberPwd" placeholder="비밀번호를 입력하세요." required>
					</div>
					<br>
					<div>
						<h5>회원 탈퇴 약관</h5>
					</div>

					<!-- <div>
                        회원탈퇴 신청에 앞서 아래 내용을 반드시 확인해 주세요.
                        <br><br>
                    </div> -->

					<div class="form-group agree">
						<!-- id, for끼리는 이름이 같으면 안된다! -->
						<div class="title">개인정보보호에 대한 안내</div>
						<div class="text">
							고객님께 개인정보보호에 대한 안내드립니다. <br>
							싱글벙글 고객 여러분의 개인 정보를 개인정보보호 방침에 따라 안전하게 관리하고 있습니다. <br>
						</div>
						<br>

						<div class="title">회원탈퇴 시 처리내용</div>
						<div class="text">
							1. 싱글벙글의 매너온도 및 등급이 삭제됩니다.<br>
							2. 소비자보호에 관한 법률 제6조에 의거,계약 또는 청약철회 등에 관한 기록은 5년, 대금결제 및 재화등의 공급에 관한 기록은 5년, 소비자의 불만 또는 분쟁처리에 관한 기록은 3년 동안 보관됩니다. 동 개인정보는 법률에 의한 보유 목적 외에 다른 목적으로는 이용되지 않습니다.
						</div>
						<br>

						<div class="title">회원탈퇴 시 게시물 관리</div>
						<div class="text">회원탈퇴 후 싱글벙글 서비스에 입력한 게시물 및 댓글은 삭제되지 않으며, 회원정보 삭제로 인해 작성자 본인을 확인할 수 없으므로 게시물 편집 및 삭제 처리가 원천적으로 불가능 합니다. 게시물 삭제를 원하시는 경우에는 먼저 해당 게시물을 삭제 하신 후, 탈퇴를 신청하시기 바랍니다.</div>
					</div>

					<div class="custom-control custom-checkbox mb-3">
						<!-- <label for="agree"><span class="requiredInput">*</span> 약관동의</label> -->
						<input type="checkbox" class="custom-control-input ck_box"
							id="agree" name="agree" required>
						<label class="custom-control-label textBold" for="agree">
							위 내용을 모두 확인하였습니다. <small class="requiredInput">(필수)</small>
						</label>
					</div>

					<hr>

					<button type="submit" class="btn btn-block maincolor">탈퇴</button>
				</form>
			</div>

		</div>

		<div class="col-md-4"></div>
	</div>

	<jsp:include page="../common/footer.jsp" />
</body>



<script>

	/* 사이드메뉴를 내가 선택한 메뉴에 색 고정하기 */
	$(function() {
		$("#mypageSecession")
				.attr('class',
						'nav-link px-4 active text-white shadow-sm rounded-pill maincolor');
	});
	
	
	// submit 동작
	function validate() {
		
		// 비밀번호 입력 유효성 검사
		if($("#currentPwd").val().trim().length == 0){
			alert("비밀번호를 입력해주세요.");
			$("#currentPwd").focus();
			return false;
		}
			
		// 약관동의 체크 유효성 검사 
		if(!$("#agree").prop("checked")){
			alert("약관에 동의해 주세요.");
			return false;
		}else{
			return confirm("정말로 탈퇴하시겠습니까?");
		}
	}
</script>
</html>