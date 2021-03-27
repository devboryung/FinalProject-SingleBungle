package com.gaji.SingleBungle.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaji.SingleBungle.admin.vo.ABoard;
import com.gaji.SingleBungle.admin.vo.APageInfo;
import com.gaji.SingleBungle.admin.vo.Reply;
import com.gaji.SingleBungle.member.model.dao.MemberDAO;
import com.gaji.SingleBungle.member.model.vo.MReply;
import com.gaji.SingleBungle.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired // 자동으로 MemberDAO 객체(bean)가 의존성 주입됨.(DI)
	private MemberDAO dao;

	@Autowired
	private BCryptPasswordEncoder enc;

	// 로그인 Service
	@Override
	public Member loginAction(Member inputMember) {
		Member loginMember = dao.loginAction(inputMember);
		// bcrypt 암호화를 사용하는 경우
		// 같은 비밀번호를 입력해도 암호화된 문자열이 계속 다르므로
		// DB에서 비밀번호 일치를 이용한 조건식 사용이 불가능 하다.
		// -> 대신 이를 비교할 수 있는 별도의 메소드를
		// BCryptPasswordEncoder가 제공해줌 ( matches() )

		// inputMember에 저장된 비밀번호 : pass03

		// DB에 저장된 비밀번호
		// $2a$10$2pkNGlA2CTVnxWBxzjS.QODewBzL.mQNR4G9kNSwJLlbF0SGIdcii

		if (loginMember != null) {
			// 비밀번호가 같을 때
			if (enc.matches(inputMember.getMemberPwd(), // 입력받은 평문 비밀번호 (pass03)
					loginMember.getMemberPwd())) { // DB에 저장된 암호화 비밀번호

				// DB에서 조회된 회원정보를 반환하면 되지만
				// 비밀번호는 null 값으로 변경해서 내보냄.
				loginMember.setMemberPwd(null);

			} else { // 비밀번호가 다를 때

				// 로그인이 실패한 모양을 만들어줌
				loginMember = null;
			}
		}

		return loginMember;
	}

	// 아이디 중복 체크 Service 구현
	@Override
	public int idDupCheck(String memberId) {
		return dao.idDupCheck(memberId);
	}

	// 닉네임 중복 체크 Service 구현
	@Override
	public int nnDupCheck(String memberNickname) {
		return dao.nnDupCheck(memberNickname);
	}

	// 회원가입 Service 구현
	@Transactional(rollbackFor = Exception.class)
	// SQLException : DB관련 오류가 났을 때 rollback을 하겠다.
	// Exception : 아무 예외 발생시 rollback을 하겠다.
	@Override
	public int signUp(Member signUpMember) {
		// 암호화 추가 예정

		/*
		 * 비밀번호를 저장하는 방법
		 * 
		 * 1. 평문 형태 그대로 저장 -> 범죄 행위
		 * 
		 * 2. SHA-512 같은 단방향 암호화(단방향 해쉬함수)를 사용 -> 같은 비밀번호를 암호화 하면 똑같은 다이제스트가 반환된다는 문제점이
		 * 있음. (해킹에 취약) (암호화된 비밀번호 == 다이제스트) (일반적인 해킹 장비 성능으로 1초에 56억개의 다이제스트를 비교할 수
		 * 있음(참고))
		 * 
		 * 3. bcrypt 방식의 암호화 -> 비밀번호 암호화에 특화된 암호화 방식 -> 입력된 문자열과 임의의 문자열(salt)을 첨부하여
		 * 암호화를 진행 --> 같은 비밀번호를 입력해도 서로 다르 다이제스트가 반환됨.
		 * 
		 * ** Spring-security-core 모듈 추가해야함.
		 */

		// DAO 전달 전에 비밀번호 암호화
		String encPwd = enc.encode(signUpMember.getMemberPwd());

		System.out.println(signUpMember.getMemberPwd());

		// 암호화된 비밀번호를 signUpMember에 다시 세팅
		signUpMember.setMemberPwd(encPwd);

		return dao.signUp(signUpMember);

		// 해당 서비스 메소드에서 예외가 발생하지 않으면 마지막에 commit이 수행됨.
	}
	

	// 이름, 메일 일치 검사 Service
	@Override
	public int nameMailCheck(Map<String, Object> map) {
		return dao.nameMailCheck(map);
	}
	
	// 아이디 찾기 Service 
	@Override
	public Member findIdResult(Member member) {
		return dao.findIdResult(member);
	}
	
	// 아이디, 메일 일치 검사 Service 
	@Override
	public int idMailCheck(Map<String, Object> map) {
		return dao.idMailCheck(map);
	}
	
	// 비밀번호 찾기 Service
	@Override
	public Member findPw(Member member) {
		return dao.findPw(member);
	}
	
	// 비번 설정 Service 
	@Override
	public int findPwUpdate(Map<String, Object> map) {
		// 1. 현재 비밀번호가 일치하는지 확인(본인 확인)
		// bcrypt 암호화가 적용되어 있기 때문에

			// 비밀번호 확인
			// map은 Object라 String으로 형변환
			
				// 비밀번호가 일치할 경우

				// 2. 현재 비밀번호 일치 확인 시 새 비밀번호로 변경
				// == 비밀번호를 수정할 dao 필요

				// 새 비밀번호 암호화 진행
				String encPwd = enc.encode((String) map.get("newPwd"));

				// 암호화된 비밀번호를 다시 map에 세팅
				map.put("newPwd", encPwd);

				// 비밀번호 수정 DAO 호출
				int result = dao.findPwUpdate(map);
			
		
		return result;
//		return dao.findPwUpdate(map);
	}

	
	
	// 마이페이지 좋아요 페이징 Service 
	@Override
	public APageInfo getLikeBoardPageInfo(int cp, Map<String, Integer> map) {
		int listCount = dao.getLikeBoardPageInfo(map);
		return new APageInfo(cp,listCount);
	}
	
	// 마이페이지 좋아요 한 글 조회 Service 
	@Override
	public List<ABoard> selectLikeBoard(APageInfo pInfo, int memberNo) {
		// TODO Auto-generated method stub
		return dao.selectLikeBoard(pInfo, memberNo);
	}
	
	// 내가 쓴 글 페이징 Service 
	@Override
	public APageInfo getMyBoardPageInfo(int cp, Map<String, Integer> map) {
		int listCount = dao.getMyBoardPageInfo(map);
		return new APageInfo(cp,listCount);
	}
	
	// 내가 쓴 글 리스트 조회 Service 
	@Override
	public List<ABoard> selectMyBoard(APageInfo pInfo, int memberNo) {
		return dao.selectMyBoard(pInfo, memberNo);
	}
	
	// 내가 쓴 댓글 페이징 Service 
	@Override
	public APageInfo getMyReplyPageInfo(int cp, Map<String, Integer> map) {
		int listCount = dao.getMyReplyPageInfo(map);
		return new APageInfo(cp,listCount);
	}
	
	// 내가 쓴 댓글 Service 
	@Override
	public List<MReply> selectMyReply(APageInfo pInfo, int memberNo) {
		return dao.selectMyReply(pInfo, memberNo);
	}
	
	
	
	

	// 내 정보 수정 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int mypageInfoUpdateAction(Member updateMember) {
		return dao.mypageInfoUpdateAction(updateMember);
	}

	// 비밀번호 수정 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int mypagePwUpdate(Map<String, Object> map) {
		// 현재 비밀번호, 새 비밀번호, 회원 번호

		// 1. 현재 비밀번호가 일치하는지 확인(본인 확인)
		// bcrypt 암호화가 적용되어 있기 때문에
		// DB에서 비밀번호를 조회해서 비교해야 함. == 현재 비밀번호 조회 dao 필요
		String savePwd = dao.selectPwd((int) map.get("memberNo"));

		// 결과 저장용 변수 선언
		int result = 0;

		if (savePwd != null) { // 비밀번호 조회 성공 시

			// 비밀번호 확인
			// map은 Object라 String으로 형변환
			if (enc.matches((String) map.get("memberPwd"), savePwd)) {
				// 비밀번호가 일치할 경우

				// 2. 현재 비밀번호 일치 확인 시 새 비밀번호로 변경
				// == 비밀번호를 수정할 dao 필요

				// 새 비밀번호 암호화 진행
				String encPwd = enc.encode((String) map.get("newPwd"));

				// 암호화된 비밀번호를 다시 map에 세팅
				map.put("newPwd", encPwd);

				// 비밀번호 수정 DAO 호출
				result = dao.mypagePwUpdate(map);
			}
		}
		return result;
	}

	// 회원탈퇴 Service 구현
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int mypageSecession(Member loginMember) {
		// 1) 입력받은 비밀번호가 맞는지 확인
		// --> bcrypt 암호화를 사용하였기 때문에
		// DB에서 회원 번호를 조건으로 하여 비밀번호를 조회해온 후
		// matches() 메소드를 이용하여 비교
		String savePwd = dao.selectPwd(loginMember.getMemberNo());

		int result = 0; // 결과 저장용 변수

		if (savePwd != null) { // 비밀번호 조회 성공 시
			// 웅앵 비밀번호와 웅앵 비밀번호 비교
			if (enc.matches(loginMember.getMemberPwd(), savePwd)) {

				// 2) 입력된 비밀번호와, 저장된 비밀번호가 같을 경우
				// 회원 탈퇴 DAO 메소드 호출
				result = dao.mypageSecession(loginMember.getMemberNo());
			}
		}
		return result;
	}

	
	
	

	
	

	

	

	


	
	
	

}
