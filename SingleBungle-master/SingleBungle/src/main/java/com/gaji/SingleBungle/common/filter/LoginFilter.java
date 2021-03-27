package com.gaji.SingleBungle.common.filter;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// 전체 요청이 필터를 거치게 함
@WebFilter(urlPatterns = {"/*"})
public class LoginFilter implements Filter {
	
    public LoginFilter() {}
    public void init(FilterConfig fConfig) throws ServletException {}
	public void destroy() {}


	// 로그인이 되어있지 않아도 접근 가능한(허용되는) 경로를 모아둘 Set 생성
	private static final Set<String> ALLOWED_PATH = new HashSet<String>();
	
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
	
		// 로그인이 되어있지 않아도 접근 가능한 경로 추가
		// ALLOWED_PATH.add("/"); // 메인페이지
		// ALLOWED_PATH.add("/resources/\\w"); // 이미지, css, js 파일 등을 접근할 수 있는 경로 추가
		
		// 회원 전용 페이지 중 비회원이 접근 가능한 페이지 경로 추가
		ALLOWED_PATH.add("/member/login"); // 로그인 페이지 요청
		ALLOWED_PATH.add("/member/loginAction"); // 로그인 요청
		ALLOWED_PATH.add("/member/signUp"); // 회원 가입 페이지 요청
		ALLOWED_PATH.add("/member/signUpAction"); // 회원 가입 요청
		ALLOWED_PATH.add("/member/idDupCheck"); // 아이디 중복검사 요청
		ALLOWED_PATH.add("/member/nnDupCheck"); // 닉네임 중복검사 요청
		ALLOWED_PATH.add("/member/SignUpMail"); // 회원가입 이메일 전송 
		
		ALLOWED_PATH.add("/member/findIdForm"); // 아이디찾기
		ALLOWED_PATH.add("/member/nameMailCheck"); // 이름, 메일 일치 검사
		ALLOWED_PATH.add("/member/FindIdMail"); // 아이디찾기 이메일 전송
		ALLOWED_PATH.add("/member/findIdResultForm"); // 아이디찾기2
		
		ALLOWED_PATH.add("/member/findPwForm"); // 비밀번호찾기1
		ALLOWED_PATH.add("/member/idMailCheck"); // 아이디, 메일 일치 검사
		ALLOWED_PATH.add("/member/FindPwMail"); // 아이디찾기 이메일 전송
		ALLOWED_PATH.add("/member/findPwChangeForm"); // 비밀번호찾기2
		ALLOWED_PATH.add("/member/findPwChangeAction"); // 비밀번호찾기2
		ALLOWED_PATH.add("/member/findPwResultForm"); // 비밀번호찾기3
		
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		HttpSession session = req.getSession();
		
		// 요청 주소 확인
		String path = req.getRequestURI().substring( req.getContextPath().length() );
				//    /spring/member/login                /spring
		
		// 로그인 여부 확인
		boolean isLogin = session.getAttribute("loginMember") != null;
		
		// 요청 주소가 허용 목록에 있는 주소인지 확인
		boolean isAllowedPath = false;
		
		for(String p : ALLOWED_PATH) {
			
			// ALLOWED_PATH 목록의 내용과 요청주소가 일치할 경우
			if(Pattern.matches(p, path) ) {
				isAllowedPath = true;
				break;
			}
		}
		
		// 로그인이 되어 있지 않고
		// 로그인이 되어있지 않아도 접근 가능한 경로로 요청이 온 경우
		// == 비로그인 상태로 요청 허용된 주소
		if( !isLogin && isAllowedPath ) {
			chain.doFilter(request, response);
	
		}else if(isLogin && !isAllowedPath ) {
			// 로그인 되어있을 때 허용 주소를 제외한 요청
			// 로그인이 되었을 때만 이용 가능한 주소
			chain.doFilter(request, response);
			
		} else { // 로그인이나 허용 주소 여부 관계없이
			
			if(Pattern.matches("/", path) || Pattern.matches("/resources/.*", path) || Pattern.matches("/board/list/.*", path) ) {
				chain.doFilter(request, response);
			}else {
				res.sendRedirect(req.getContextPath()+"/member/login"); // 메인페이지로 이동
			}
		}
			

	}


}
