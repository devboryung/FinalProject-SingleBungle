package com.gaji.SingleBungle.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gaji.SingleBungle.admin.vo.ABoard;
import com.gaji.SingleBungle.admin.vo.APageInfo;
import com.gaji.SingleBungle.admin.vo.Reply;
import com.gaji.SingleBungle.member.model.vo.MReply;
import com.gaji.SingleBungle.member.model.vo.Member;


@Repository
public class MemberDAO {
	
	@Autowired 
	private SqlSessionTemplate sqlSession; 
	
	
	/** 로그인 DAO 
	 * @param inputMember
	 * @return loginMember
	 */
	public Member loginAction(Member inputMember) {
		return sqlSession.selectOne("memberMapper.loginAction", inputMember);
	}


	/** 아이디 중복 체크 DAO 
	 * @param memberId
	 * @return result
	 */
	public int idDupCheck(String memberId) {
		return sqlSession.selectOne("memberMapper.idDupCheck", memberId);
	}
	
	
	/** 닉네임 중복 체크 DAO 
	 * @param memberNickname
	 * @return result
	 */
	public int nnDupCheck(String memberNickname) {
		return sqlSession.selectOne("memberMapper.nnDupCheck", memberNickname);
	}
	
	
	/** 회원가입 DAO 
	 * @param signUpMember
	 * @return result 
	 */
	public int signUp(Member signUpMember) {
		return sqlSession.insert("memberMapper.signUp", signUpMember);
	}


	/** 이름, 메일 일치 검사 DAO 
	 * @param map
	 * @return result 
	 */
	public int nameMailCheck(Map<String, Object> map) {
		return sqlSession.selectOne("memberMapper.nameMailCheck", map);
	}
	
	/** 아이디 찾기 DAO 
	 * @param member
	 * @return
	 */
	public Member findIdResult(Member member) {
		return sqlSession.selectOne("memberMapper.findIdResult", member);
	}
	
	/** 아이디, 메일 일치 검사 DAO 
	 * @param map
	 * @return
	 */
	public int idMailCheck(Map<String, Object> map) {
		return sqlSession.selectOne("memberMapper.idMailCheck", map);
	}
	
	/** 비밀번호 찾기 DAO
	 * @param member
	 * @return
	 */
	public Member findPw(Member member) {
		return sqlSession.selectOne("memberMapper.findPw", member);
	}
	
	/** 비번 설정 DAO 
	 * @param map
	 * @return
	 */
	public int findPwUpdate(Map<String, Object> map) {
		return sqlSession.update("memberMapper.findPwUpdate", map);
	}



	/** 내 정보 수정 DAO 
	 * @param updateMember
	 * @return result 
	 */
	public int mypageInfoUpdateAction(Member updateMember) {
		return sqlSession.update("memberMapper.mypageInfoUpdateAction", updateMember);
	}


	/** 비밀번호 조회 DAO 
	 * @param memberNo
	 * @return savePwd
	 */
	public String selectPwd(int memberNo) {
		return sqlSession.selectOne("memberMapper.selectPwd", memberNo);
	}


	/** 비밀번호 수정 DAO
	 * @param map
	 * @return result 
	 */
	public int mypagePwUpdate(Map<String, Object> map) {
		return sqlSession.update("memberMapper.mypagePwUpdate", map);
	}

	/** 회원 탈퇴 DAO 
	 * @param updateMember
	 * @return result 
	 */
	public int mypageSecession(int memberNo) {
		return sqlSession.update("memberMapper.mypageSecession", memberNo);
		}


	/** 마이페이지 좋아요 한 글 페이징 DAO 
	 * @param cp
	 * @param memberNo 
	 * @return
	 */
	public int getLikeBoardPageInfo(Map<String, Integer> map) {
		return sqlSession.selectOne("memberMapper.getLikeBoardPageInfo", map);
	}


	/** 마이페이지 좋아요 한 글 보기 DAO 
	 * @param pInfo
	 * @param memberNo 
	 * @return
	 */
	public List<ABoard> selectLikeBoard(APageInfo pInfo, int memberNo) {
		int offset = (pInfo.getCurrentPage() -1) * pInfo.getLimit();
	    RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("memberMapper.selectLikeBoard", memberNo, rowBounds);
	}


	/** 내가 쓴 글 페이징.. DAO 
	 * @param map
	 * @return
	 */
	public int getMyBoardPageInfo(Map<String, Integer> map) {
		return sqlSession.selectOne("memberMapper.getMyBoardPageInfo", map);
	}


	/** 내가 쓴 글 리스트 DAO 
	 * @param pInfo
	 * @param memberNo
	 * @return
	 */
	public List<ABoard> selectMyBoard(APageInfo pInfo, int memberNo) {
		int offset = (pInfo.getCurrentPage() -1) * pInfo.getLimit();
	    RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("memberMapper.selectMyBoard", memberNo, rowBounds);
	}


	/** 내가 쓴 댓글 페이징 DAO 
	 * @param map
	 * @return
	 */
	public int getMyReplyPageInfo(Map<String, Integer> map) {
		return sqlSession.selectOne("memberMapper.getMyReplyPageInfo", map);
	}


	/** 내가 쓴 댓글 리스트 DAO 
	 * @param pInfo
	 * @param memberNo
	 * @return
	 */
	public List<MReply> selectMyReply(APageInfo pInfo, int memberNo) {
		int offset = (pInfo.getCurrentPage() -1) * pInfo.getLimit();
	    RowBounds rowBounds = new RowBounds(offset, pInfo.getLimit());
		return sqlSession.selectList("memberMapper.selectMyReply", memberNo, rowBounds);
	}


	

	


	


	



	
	


}
