package com.gaji.SingleBungle.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gaji.SingleBungle.admin.vo.ABoard;
import com.gaji.SingleBungle.admin.vo.APageInfo;
import com.gaji.SingleBungle.admin.vo.reportBoard;
import com.gaji.SingleBungle.member.model.service.MemberService;
import com.gaji.SingleBungle.member.model.vo.MReply;
import com.gaji.SingleBungle.member.model.vo.Member;

@Controller
@RequestMapping("/member/*")
@SessionAttributes({"loginMember"}) // Model에 추가된 데이터 중 key 값이 해당 어노테이션에 적혀있는 값과 일치하는 데이터를 session scope로 이동.
public class memberController {

	// sweet alert 메세지 전달용 변수 선언
	private String swalIcon = null;
	private String swalTitle = null;
	private String swalText = null;

	@Autowired
	private MemberService service;

	@Autowired
	private JavaMailSender mailSender;

	
	

	
	// 로그인 화면 전환용 Controller
	@RequestMapping("login")
	public String loginView() {
		return "member/login";
	}

	// 로그인 동작 Controller
	@RequestMapping("loginAction")
	public String loginAction(Member inputMember, @RequestParam(value = "saveId", required = false) String saveId,
			HttpServletResponse response, RedirectAttributes ra, Model model /* HttpSession session */ ) {

		// inputMember -> memberId, memberPwd
		System.out.println("inputMember : "+inputMember);
		/*
		 * Member [memberNo=0, memberId=user01, memberPwd=pass01, memberName=null,
		 * memberPhone=null, memberEmail=null, memberAddress=null, memberInterest=null,
		 * memberEnrollDate=null, memberStatus=null, memberGrade=null]
		 */

		// 비즈니스 로직 수행 후 결과 반환받기
		Member loginMember = service.loginAction(inputMember);
		System.out.println("loginMember : "+ loginMember); // 결과 확인용

		// session.setAttribute("loginMember", loginMember);

		// Model : 전달하고자 하는 데이터를 맵 형식 (K : V)형태로 담아서 전달하는 용도의 객체
		// Model 객체는 기본적으로 request scope 이지만
		// 클래스 위쪽에 작성된 @SessionAttributes를 이용하면 session scope로 변경됨.

		String url = null; // 로그인 성공 또는 실패 시의 요청 경로를 저장할 변수

		if (loginMember != null) { // 로그인 성공 시
			model.addAttribute("loginMember", loginMember);

			// 쿠키 생성
			// javax.servlet.http.Cookie 로 import
			Cookie cookie = new Cookie("saveId", loginMember.getMemberId());

			// 쿠키 유지 시간 지정
			if (saveId != null) { // 아이디 저장이 체크 되었을 경우
				// 한달 동안 유지되는 쿠키 생성
				cookie.setMaxAge(60 * 60 * 24 * 30); // 초 단위로 지정

			} else { // 아이디 저장이 체크 되어있지 않은 경우

				cookie.setMaxAge(0);
				// - 쿠키를 생성하지 않겠다.
				// - 기존에 있던 쿠키도 없애겠다.
			}

			// 생성된 쿠키 객체를 응답 객체에 담아서 내보냄
			response.addCookie(cookie);

			url = "/"; // 성공 시 메인페이지

			// cookie와 session의 차이점?!
			// 공통점 : 둘 다 어디서든 꺼내와 쓸 수 있다.
			// 각자 데이터를 어느쪽에서 관리하느냐에 따라 차이가 있음.
			// cookie는 client쪽 파일의 형식으로 저장 / session은 server쪽에서 관리를 하고 저장.
			// cookie는 오래 저장되어 직접 삭제를 해야함 / session은 브라우저가 종료되거나 시간이 지나면 사라짐.

		} else { // 로그인 실패 시
			ra.addFlashAttribute("swalIcon", "error");
			ra.addFlashAttribute("swalTitle", "로그인 실패");
			ra.addFlashAttribute("swalText", "아이디 또는 비밀번호가 일치하지 않습니다.");

			url = "login"; // 로그인 실패 시 로그인 전환 화면으로 재요청하는 주소를 작성.
		}

		return "redirect:" + url;
	}

	// 로그아웃 Controller
	@RequestMapping("logout")
	public String logout(SessionStatus status) {
		status.setComplete();

		return "redirect:/"; // 메인 화면으로 재요청
	}

	
	// 회원가입 화면 전환 Controller 
	@RequestMapping("signUp")
	public String signUp() {
		return "member/signUpView";
	}
	
	// ---------------------------------------------------
	// 아이디 중복 체크 Controller (AJAX)
	// ---------------------------------------------------
	@RequestMapping("idDupCheck")
	@ResponseBody
	public int idDupCheck(@RequestParam("memberId") String memberId) {

		// System.out.println(memberId);

		// 아이디 중복 검사 서비스 호출
		int result = service.idDupCheck(memberId);

		// 컨트롤러에서 반환되는 값은 forward 또는 redirect를 위한 경로/주소가 작성되는 게 일반적
		// -> 컨트롤러에서 반환 시 Dispatcher Servlet으로 이동되어
		// View Resolver 또는 Handler Mapping으로 연결됨.

		// AJAX에서 반환값이 주소/경로가 아닌 값 자체로 인식해서
		// 요청 부분으로 돌아가게 하는 별도 방법이 존재
		// == @ResponseBody

		return result;
	}
	
	// ---------------------------------------------------
	// 닉네임 중복 체크 Controller (AJAX)
	// nnDupCheck:회원가입용(로그인필터O), nnDupCheckUpdate:내정보수정(로그인필터X)
	// ---------------------------------------------------
	@RequestMapping(value={"nnDupCheck","nnDupCheckUpdate"})
	@ResponseBody
	public int nnDupCheck(@RequestParam("memberNickname") String memberNickname) {
		// System.out.println(memberId);
		int result = service.nnDupCheck(memberNickname);
		
		//System.out.println(result);
		//System.out.println(memberNickname);
		return result;
	}
	

	// 회원가입 Controller
	@RequestMapping("signUpAction")
	public String signUpAction(@ModelAttribute Member signUpMember, RedirectAttributes ra // redirect시 데이터 전달용 객체
	/* ,String memberInterest */ ) {

		// signUpMember : 회원 가입 시 입력한 값들이 저장된 커맨드 객체
		// System.out.println(signupMember);

		// 값이 넘어오는 지 확인(배열로 확인) : String[] memberInterest
		// System.out.println(Arrays.toString(memberInterest));
		// [운동, 영화, 요리]

		// 동일한 name 속성을 가진 input 태그 값은
		// String[]에 저장할 경우, 배열 요소로 저장되며
		// String으로 저장할 경우 ","로 구분된 한 줄의 문자열이 된다.
		// System.out.println(memberInterest);
		// 운동, 영화, 요리

		// 회원가입 서비스 호출(성공 시 1, 실패 시 0이 반환됨 (mybatis-insert))
		
		System.out.println(signUpMember);
		
		int result = service.signUp(signUpMember);
		
		System.out.println(signUpMember);
		
		// 회원 가입 성공 여부에 따른 메세지 지정
		if (result > 0) { // 성공
			swalIcon = "success";
			swalTitle = "회원 가입 성공";
			swalText = "회원가입을 환영합니다.";

		} else { // 실패
			swalIcon = "error";
			swalTitle = "회원 가입 실패";
			swalText = "회원가입 과정에서 문제가 발생했습니다.";
		}

		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		ra.addFlashAttribute("swalText", swalText);

		return "redirect:/"; // 메인화면으로 돌아가게 재요청
	}

	
	// ---------------------------------------------------
	// 회원가입 이메일 발송 Controller (AJAX)
	// ---------------------------------------------------
	@RequestMapping("SignUpMail")
	@ResponseBody
	public String SignUpMail(HttpServletRequest request) {

		String setfrom = "singlebungle.dev@gmail.com";
		String tomail = request.getParameter("mail"); // 받는 사람 이메일
		String title = "[싱글벙글] 회원 가입에 필요한 이메일 인증 키값 전송"; // 제목
		String content = "키 값을 인증번호 확인영역에 입력해주세요."; // 내용
		String key = "";
		
		//String mailId = request.getParameter("mailId"); // 받는 사람 이메일
		
		//System.out.println("tomail :" + tomail);
		//System.out.println("mailId : " + mailId);

		try {
			Random random = new Random();

			for (int i = 0; i < 3; i++) {
				int index = random.nextInt(25) + 65; // A~Z까지 랜덤 알파벳 생성
				key += (char) index;
			}
			int numIndex = random.nextInt(8999) + 1000; // 4자리 정수를 생성
			key += numIndex;

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content + key); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}

		return key;
	}
	
	
	// 아이디 찾기 ------------------------------------------------------------------------

	// 아이디 찾기 화면
	@RequestMapping("findIdForm")
	public String findIdFormView() { // findIdForm 이거엿음.. 
		return "member/findIdForm";
	}
	
	// 아이디 찾기 동작
	@RequestMapping("findIdResultForm") // 결과화면으로 
	public String findIdFormAction(@ModelAttribute("member") Member member,
			HttpServletRequest request, Model model) { 
		
//		String memberName = request.getParameter("memberName"); String memberEmail =
//		request.getParameter("memberEmail");
		
		
//		 Member member = new Member(); 
//		 member.setMemberName(memberName);
//		 member.setMemberEmail(memberEmail);
		
	    Member findMember = service.findIdResult(member);
	    System.out.println(findMember);
	    
	    String memberId = findMember.getMemberId();
		System.out.println("findMember : " + findMember.getMemberId());
		
		if(findMember!=null) {
			model.addAttribute("memberId", memberId);
		}else {
			System.out.println("실패 ");
		}
		
		return "member/findIdResultForm";
	}
	

	// 아이디 찾기2
//	@RequestMapping("findIdResultForm")
//	public String findIdResultForm() {
//		return "member/findIdResultForm";
//	}
	
	// ---------------------------------------------------
	// 이름, 메일 일치 검사 Controller (AJAX)
	// ---------------------------------------------------
	@RequestMapping("nameMailCheck")
	@ResponseBody
	public int nameMailCheck(@RequestParam("name") String name,
							@RequestParam("mail") String mail) {
		// System.out.println(memberId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("name", name);
		map.put("mail", mail);
		
		System.out.println(name);
		System.out.println(mail);
		
		int result = service.nameMailCheck(map);
		
		System.out.println(result);
		
		return result;
	}
	
	
	
	// ---------------------------------------------------
	// 아이디 찾기 이메일 발송 Controller (AJAX)
	// ---------------------------------------------------
	@ResponseBody
	@RequestMapping("FindIdMail")
	public String FindIdMail(HttpServletRequest request) {
		String setfrom = "singlebungle.dev@gmail.com";
		String tomail = request.getParameter("mail"); // 받는 사람 이메일
		String title = "[싱글벙글] 아이디 찾기에 필요한 이메일 인증 키값 전송"; // 제목
		String content = "키 값을 인증번호 확인영역에 입력해주세요."; // 내용
		String key = "";

		try {
			Random random = new Random();

			for (int i = 0; i < 3; i++) {
				int index = random.nextInt(25) + 65; // A~Z까지 랜덤 알파벳 생성
				key += (char) index;
			}
			int numIndex = random.nextInt(8999) + 1000; // 4자리 정수를 생성
			key += numIndex;

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content + key); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}

		return key;
	}
	
	

	// 비밀번호 찾기 ------------------------------------------------------------------------
	
	// 비밀번호 찾기 화면 
	@RequestMapping("findPwForm")
	public String findPwFormView() {
		return "member/findPwForm";
	}
	
	// 비밀번호 찾기 동작
	@RequestMapping("findPwChangeForm")
	public String findPwFormAction(@ModelAttribute("member") Member member,
			HttpServletRequest request, Model model) {
		
		Member findMember = service.findPw(member);
		System.out.println("member : " + member);
		System.out.println("findMember" + findMember);
	    String memberPwd = findMember.getMemberPwd();
	    int memberNo = findMember.getMemberNo();
		
	    //	System.out.println("findMember : " + findMember.getMemberId());
		
		if(findMember!=null) {
			model.addAttribute("memberPwd", memberPwd);
			model.addAttribute("memberNo", memberNo);
		}else {
			System.out.println("실패 ");
		}
		
		return "member/findPwChangeForm";
	}
	
	// ---------------------------------------------------
	// 아이디, 메일 일치 검사 Controller (AJAX)
	// ---------------------------------------------------
	@RequestMapping("idMailCheck")
	@ResponseBody
	public int idMailCheck(@RequestParam("memberId") String memberId,
							@RequestParam("mail") String mail) {
		// System.out.println(memberId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("memberId", memberId);
		map.put("mail", mail);
		
		System.out.println(memberId);
		System.out.println(mail);
		
		int result = service.idMailCheck(map);
		
		System.out.println(result);
		
		return result;
	}
	
	// ---------------------------------------------------
	// 비밀번호 찾기 인증(이메일 발송) Controller (ajax) 
	// ---------------------------------------------------
	@ResponseBody
	@RequestMapping("FindPwMail")
	public String FindPwMail(HttpServletRequest request) {
		
		String setfrom = "singlebungle.dev@gmail.com";
		String tomail = request.getParameter("mail"); // 받는 사람 이메일
		String title = "[싱글벙글] 비밀번호 찾기에 필요한 이메일 인증 키값 전송"; // 제목
		String content = "키 값을 인증번호 확인영역에 입력해주세요."; // 내용
		String key = "";
		
		//String mailId = request.getParameter("mailId"); // 받는 사람 이메일
		
		System.out.println("tomail :" + tomail);
		// 얘가 안나옴 ㄱ- 이게 실행이 안됨. 
		//System.out.println("mailId : " + mailId);
		
		try {
			Random random = new Random();
			
			for (int i = 0; i < 3; i++) {
				int index = random.nextInt(25) + 65; // A~Z까지 랜덤 알파벳 생성
				key += (char) index;
			}
			int numIndex = random.nextInt(8999) + 1000; // 4자리 정수를 생성
			key += numIndex;
			
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content + key); // 메일 내용
			
			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return key;
	}
	
	// 비밀번호 찾기 변경(?) Controller
	@RequestMapping(value="findPwChangeAction", method=RequestMethod.POST) // 비밀번호와 관련된 것은 POST로 
	public String findPwChangeAction(@RequestParam("memberNo") int memberNo, @RequestParam("newPwd") String newPwd,
			RedirectAttributes ra ) {
		
		// Map을 이용하여 필요한 데이터를 하나로 묶어둠
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("newPwd", newPwd);
		map.put("memberNo", memberNo);
		
		// 비밀번호 변경 Service 호출
		int result = service.findPwUpdate(map);
		System.out.println("result : " + result);
		
		// 재요청할 주소 저장 변수 선언
		String returnUrl = null; 
		
		// 비밀번호 수정 성공 시
		// success, 비밀번호 수정 성공, 마이페이지 재요청
		if(result > 0) {
		swalIcon = "success";
		swalTitle = "비밀번호 수정 성공";
		returnUrl = "findPwResultForm";
		}
		// 비밀번호 변경 실패 시
		// error, 비밀번호 수정 실패, 비밀번호 수정 페이지 재요청
		else {
		swalIcon = "error";
		swalTitle = "비밀 번호 수정 실패";
		returnUrl = "findPwChangeForm";
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		
		
		return "redirect:" + returnUrl;
	}
	
	// 비밀번호 찾기 변경 Controller
	@RequestMapping("findPwResultForm")
	public String findPwResultForm() {
		return "member/findPwResultForm";
	}
	
	// 마이페이지 ------------------------------------------------------------------------

	// 마이페이지
	@RequestMapping("mypage")
	public String mypage(@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
			@RequestParam(value = "cp2", required = false, defaultValue = "1") int cp2,
			@RequestParam(value = "cp3", required = false, defaultValue = "1") int cp3, Model model,
			@ModelAttribute(name="loginMember") Member loginMember) {
		
		int memberNo = loginMember.getMemberNo();
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("cp", cp);
		map.put("memberNo", memberNo);
		
		// 내가 좋아요 한 글 페이징
		APageInfo pInfo = service.getLikeBoardPageInfo(cp,map);
		pInfo.setLimit(5);
		
		// 내가 좋아요 한 글 조회 
		List<ABoard> boardList = service.selectLikeBoard(pInfo, memberNo);
		model.addAttribute("boardList", boardList);
		model.addAttribute("pInfo", pInfo);
		
		//내가 쓴 글 페이징
		APageInfo pInfo2 = service.getMyBoardPageInfo(cp2,map);
		pInfo2.setLimit(5);
		
		//내가 쓴 글 리스트 조회
		List<ABoard> myBoardList = service.selectMyBoard(pInfo2, memberNo);
		model.addAttribute("myBoardList", myBoardList);
		model.addAttribute("pInfo2", pInfo2);
		
		//내가 쓴 댓글 페이징
		APageInfo pInfo3 = service.getMyReplyPageInfo(cp3,map);
		pInfo3.setLimit(5);
		
		//내가 쓴 댓글 리스트 조회
		List<MReply> myReplyList = service.selectMyReply(pInfo3, memberNo);
		model.addAttribute("myReplyList", myReplyList);
		model.addAttribute("pInfo3", pInfo3);
		
		//System.out.println(myBoardList);
	

		return "member/mypage";
	}
	
	
	

	// ---------------------------------------------------------------
	
	// 내 정보 수정 화면 전환 Controller
	@RequestMapping("mypageInfoUpdate")
	public String mypageInfoUpdate() {
		return "member/mypageInfoUpdate";
	}
	
	// 내 정보 수정 Controller
	@RequestMapping(value="mypageInfoUpdateAction", method=RequestMethod.POST)
	public String mypageInfoUpdateAction(@ModelAttribute Member updateMember,
								Model model,
								@ModelAttribute(name="loginMember", binding=false) Member loginMember,
								// binding 속성 : 요청 파라미터를 해당 객체에 반영할 것인가? 
								RedirectAttributes ra ) { // redirect시 데이터 전달용 객체
		// updateMember : 이메일, 전화번호, 주소, 관심분야 
		
		// 세션에서 회원 정보를 얻어오는 방법
		// 1) HttpSession의 getAttribute("loginMember")
		// 2) Model, @SessionAttributes 로 세션에 등록된 값은 반대로 얻어오는 것도 가능함. 
		//Member loginMember = (Member)model.getAttribute("loginMember");
		
		// 3) @ModelAttribute 를 이용하여 Model로 세팅한 값을 반대로 얻어오는 것도 가능함. 
		// 매개변수에 @ModelAttribute("모델로 등록한 key값") 자료형 변수명
		//System.out.println(loginMember);
		
		
		// 로그인 정보에서 회원 번호를 얻어와 updateMember에 세팅
		updateMember.setMemberNo( loginMember.getMemberNo() );
		
		// 수정된 회원정보 + 로그인된 회원의 번호를 가지고 Service 수행
		int result = service.mypageInfoUpdateAction(updateMember);
		
		
		// 성공/실패 관계없이 다시 마이페이지 재요청
		// 성공 시 : success, 회원 정보 수정 성공
		//        session에 저장된 변경 전 회원정보를 수정된 내용으로 변경
		if(result > 0) { // 성공
		swalIcon = "success";
		swalTitle = "내 정보 수정 성공";
		
		
		// 변경된 정보를 loginMember 변수에 저장
		loginMember.setMemberNickname(updateMember.getMemberNickname());
		loginMember.setMemberPhone(updateMember.getMemberPhone());
		
		// 변경된 정보가 담긴 loginMember 변수를 다시 Session에 추가 
		model.addAttribute("loginMember", loginMember);
		
		}
		// 실패 시 : error, 회원 정보 수정 실패
		else { // 실패
		swalIcon = "error";
		swalTitle = "내 정보 수정 실패";
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
	
	
	return "redirect:mypageInfoUpdate";
			// redirect:/member/mypageInfoUpdate 라고 적어도 됨
	}
	
	// ---------------------------------------------------------------
	
	// 비밀번호 수정 화면 전환 Controller
	@RequestMapping("mypagePwUpdate")
	public String mypagePwUpdate() {
		return "member/mypagePwUpdate";
	}
	
	// 비밀번호 수정 화면 Controller
	@RequestMapping(value="mypagePwUpdateAction", method=RequestMethod.POST) // 비밀번호와 관련된 것은 POST로 
	public String mypagePwUpdateAction(@RequestParam("memberPwd") String memberPwd,
			@RequestParam("newPwd1") String newPwd,
			@ModelAttribute(name="loginMember", binding=false) Member loginMember,
			RedirectAttributes ra ) { // redirect시 데이터 전달용 객체

		// Map을 이용하여 필요한 데이터를 하나로 묶어둠
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberPwd", memberPwd);
		map.put("newPwd", newPwd);
		map.put("memberNo", loginMember.getMemberNo());
		
		// 비밀번호 변경 Service 호출
		int result = service.mypagePwUpdate(map);
		
		// 재요청할 주소 저장 변수 선언
		String returnUrl = null; 
		
		// 비밀번호 수정 성공 시
		// success, 비밀번호 수정 성공, 마이페이지 재요청
		if(result > 0) {
		swalIcon = "success";
		swalTitle = "비밀번호 수정 성공";
		returnUrl = "mypage";
		}
		// 비밀번호 변경 실패 시
		// error, 비밀번호 수정 실패, 비밀번호 수정 페이지 재요청
		else {
		swalIcon = "error";
		swalTitle = "비밀 번호 수정 실패";
		returnUrl = "changePwd";
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		return "redirect:" + returnUrl;
	}
	
	
	
	// 탈퇴 화면 전환 Controller --------------------------------------
	@RequestMapping("mypageSecession")
	public String mypageSecession() {
		return "member/mypageSecession";
	}
	
	
	// 회원 탈퇴 Controller
	@RequestMapping(value="mypageSecessionAction", method=RequestMethod.POST)
	public String mypageSecession(@ModelAttribute("loginMember") Member loginMember,
								RedirectAttributes ra,
								SessionStatus status) {
		
		// 회원 번호가 필요 == Session에 있는 loginMember에 저장되어 있음
		// --> @ModelAttribute("loginMember") 를 통해서 얻어옴
		
		// 입력받은 현재 비밀번호 필요 == parameter로 전달 받음(memberPwd)
		// --> @ModelAttribute를 통해 Member 객체에 자동으로 세팅됨
		
		// 회원 번호, 현재 비밀번호를 하나의 VO에 담아서 Service로 전달할 예정
		// --> 이 작업을 별도로 진행하지 않고 @ModelAttribute를 이용하여 진행 
		
		// 회원 탈퇴 Service 호출
		int result = service.mypageSecession(loginMember);
		
		String returnURL = null;
		
		if(result > 0) {
			swalIcon = "success";
			swalTitle = "탈퇴되었습니다.";
			returnURL = "/"; // 메인페이지 
			
			// 회원 탈퇴 성공 시 로그아웃 (세션을 만료시키면 로그아웃)
			status.setComplete();
			
		} else {
			swalIcon = "error";
			swalTitle = "탈퇴 실패였습니다. 비밀번호를 확인해주세요.";
			returnURL = "mypageSecession"; // 회원 탈퇴 페이지
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		return "redirect:"+returnURL;
	}
	
	
	
	
	
	
	// -------------------------------------------------------------

	@ExceptionHandler(Exception.class) // 모든 예외를 처리하겠다
	public String etcException(Exception e, Model model) {
		// 특정 예외를 제외한 나머지 예외 처리

		e.printStackTrace(); // 예외 내용 출력
		model.addAttribute("errorMsg", "회원 관련 서비스 처리 중 오류 발생");
		return "common/errorPage";
	}

}
