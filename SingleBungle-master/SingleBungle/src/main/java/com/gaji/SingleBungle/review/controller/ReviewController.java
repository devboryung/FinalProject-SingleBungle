package com.gaji.SingleBungle.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gaji.SingleBungle.member.model.vo.Member;
import com.gaji.SingleBungle.review.model.service.ReviewService;
import com.gaji.SingleBungle.review.model.vo.Review;
import com.gaji.SingleBungle.review.model.vo.ReviewAttachment;
import com.gaji.SingleBungle.review.model.vo.ReviewLike;
import com.gaji.SingleBungle.review.model.vo.ReviewPageInfo;
import com.gaji.SingleBungle.review.model.vo.ReviewReply;
import com.gaji.SingleBungle.review.model.vo.ReviewReport;
import com.gaji.SingleBungle.review.model.vo.ReviewSearch;
import com.google.gson.Gson;

@Controller
@SessionAttributes({"loginMember"})
@RequestMapping("/review/*")
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	
	private String swalIcon = null;
	private String swalTitle = null;
	private String swalText = null;

	
	
	// 목록 조회
	@RequestMapping("list")
	public String reviewList(@RequestParam(value="cp", required=false, defaultValue="1") int cp, 
							@ModelAttribute(name="loginMember", binding=false) Member loginMember, Model model,
							RedirectAttributes ra) {
		
		String url = null;
		
		if(loginMember.getMemberGrade().charAt(0) == 'T') {
			swalIcon = "error";
			swalTitle ="'싱글이의 영수증'게시판은 2등급부터 이용할 수 있습니다.";
			url = "redirect:/";
		}else {
		
			// 페이징 처리
			ReviewPageInfo pInfo = service.getPageInfo(cp);
			
			
			//게시글 목록 조회
			List<Review> rList = service.selectList(pInfo);
			
			
			/* 썸네일 출력 */
			if(rList!=null && !rList.isEmpty()) {
				List<ReviewAttachment> thumbnailList = service.selectThumbnailList(rList);
				
				if(thumbnailList!=null) {
					model.addAttribute("thList", thumbnailList);
				}
			
			}
			
			List<ReviewLike> likeInfo = service.selectLike(loginMember.getMemberNo());

			
			model.addAttribute("likeInfo", likeInfo);
			model.addAttribute("rList", rList);
			model.addAttribute("pInfo",pInfo);
			
			url = "review/reviewList";
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
	}
	
	
	
	// 상세조회
	@RequestMapping("{boardNo}")
	public String reviewView(@PathVariable("boardNo") int boardNo, Model model, @RequestHeader(value="referer",required=false) String referer,
							RedirectAttributes ra, @ModelAttribute(name="loginMember", binding=false) Member loginMember) {
		
		Review review = service.selectReview(boardNo);
		
		String url = null;
		
		if(review!=null) { // 상세조회 성공시
			
			// 조회수 상위3  게시글 출력
			List<Review> reviewList = service.reviewListTop3();
			
			// 조회수 상위3 썸네일
			if(reviewList!=null && !reviewList.isEmpty()) {
				/* 썸네일 출력 */
				List<ReviewAttachment> thumbnailList = service.selectThumbnailList(reviewList);
		
				
				if(thumbnailList!=null) {
					model.addAttribute("thList", thumbnailList);
				}
			}
			
			// 좋아요 정보 출력
			int memberNo = loginMember.getMemberNo();
			
			List<ReviewLike> likeInfo = service.selectLike(memberNo);
			
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("memberNo", memberNo);
			map.put("boardNo", boardNo);
			
			int like = service.selectLikePushed(map);
			
			
			model.addAttribute("review",review);
			model.addAttribute("reviewList",reviewList);
			model.addAttribute("likeInfo",likeInfo);
			model.addAttribute("like", like);
			
			url = "review/reviewView";
		}else {
			
			if(referer == null) { //이전 요청주소가 없는 경우
				url = "redirect:../list";
			}else {
				url="redirect:"+referer;
			}
			
			ra.addFlashAttribute("swalicon","error");
			ra.addFlashAttribute("swalTitle","존재하지 않는 게시글입니다.");
		}
		
		return url;
	}
	
	
	// 좋아요 증가 Controller
	@ResponseBody
	@RequestMapping("increaseLike")
	public int increaseLike(@RequestParam("boardNo") int boardNo, @ModelAttribute(name="loginMember", binding=false) Member loginMember) {
		
		int memberNo = loginMember.getMemberNo();
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("memberNo", memberNo);
		map.put("boardNo", boardNo);
		
		int result = service.increaseLike(map);
		
		return result;
	}
	
	
	
	// 좋아요 감소 Controller
	@ResponseBody
	@RequestMapping("decreaseLike")
	public int decreaseLike(@RequestParam("boardNo") int boardNo,
			@ModelAttribute("loginMember") Member loginMember) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", loginMember.getMemberNo());
		map.put("boardNo", boardNo);
		
		int result = service.decreaseLike(map);
		return result;
	}
	
	
	
	
	//  게시글 등록화면
	@RequestMapping("insert")
	public String reviewInsertView() {
		return "review/reviewInsert";
	}
	
	
	
	// 게시글 등록
	@RequestMapping("reviewInsert")
	public String reviewInsert(@ModelAttribute Review review, @ModelAttribute(name="loginMember", binding=false) Member loginMember,
							    HttpServletRequest request, RedirectAttributes ra) {
		
		
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("memberNo", loginMember.getMemberNo());
		map.put("boardTitle", review.getBoardTitle());
		map.put("boardContent", review.getBoardContent());
		map.put("categoryCode", review.getCategoryCode());
		

		
		
		// 파일 저장 경로 설정
		String savePath = request.getSession().getServletContext().getRealPath("resources/reviewBoardImages");
		
		// 게시글 map, 이미지 images, 저장경로 savePath
		// 게시글 삽입 Service 호출
		int result = service.insertReview(map, savePath);
		
		String url = null;
		
		if(result>0) {
			swalIcon = "success";
			swalTitle = "게시글 등록 성공";
			url = "redirect:"+result;
			

			// 새로 작성한 게시글 상세 조회 시 목록으로 버튼 경로 지정하기
			request.getSession().setAttribute("returnListURL", "list");
		}else {
			swalIcon = "error";
			swalTitle = "게시글 등록 실패";
			url = "redirect:insert";
		}
		
		ra.addFlashAttribute("swalIcon",swalIcon);
		ra.addFlashAttribute("swalTitle",swalTitle);
		
		return url;
	}
	
	
	
	
	
	
	// summernote에 업로드된 이미지 저장
	@ResponseBody
	@RequestMapping(value= {"insertImage", "{boardNo}/insertImage"})
	public String insertImage(HttpServletRequest request, @RequestParam("uploadFile") MultipartFile uploadFile) {
		
		// 서버에 이미지를 저장할 폴더 경로 얻어오기
		String savePath = request.getSession().getServletContext().getRealPath("resources/reviewBoardImages");
		
		ReviewAttachment at = service.insertImage(uploadFile, savePath);
		
		
		return new Gson().toJson(at);
	}
	
	
	
	
	// 게시글 수정 화면 전환
	@RequestMapping("{boardNo}/update")
	public String update(@PathVariable("boardNo") int boardNo, Model model) {
		
		Review review = service.selectReview(boardNo);
		
		model.addAttribute("review", review);
		
		return "review/reviewUpdate";
	}
	
	
	
	// 게시글 수정
	@RequestMapping("{boardNo}/updateAction")
	public String updateAction(@PathVariable("boardNo") int boardNo, @ModelAttribute Review updateReview, Model model,
								RedirectAttributes ra, HttpServletRequest request) {
		
		updateReview.setBoardNo(boardNo);
		
		// 파일 저장 경로 얻어오기
		String savePath = request.getSession().getServletContext().getRealPath("resources/reviewBoardImages");
		
		
		int result = service.updateReview(updateReview, savePath);
		
		String url = null;
		
		if(result>0) {
			swalIcon = "success";
			swalTitle = "게시글 수정 성공";
			url = "redirect:../"+boardNo;
			
		}else {
			swalIcon = "error";
			swalTitle = "게시글 수정 실패";
			url = "redirect:" + request.getHeader("referer");
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
	}
	
	
	
	

	// 게시글 삭제
	@RequestMapping("{boardNo}/delete")
	public String deleteReview(@PathVariable("boardNo") int boardNo, @ModelAttribute Review review, HttpServletRequest request, RedirectAttributes ra) {
		
		review.setBoardNo(boardNo);
		
		int result = service.deleteReview(review);
		
		String url = null;
		
		if(result>0) {
			swalIcon = "success";
			swalTitle ="삭제 성공";
			url = "redirect:../list";
		}else {
			swalIcon = "error";
			swalTitle = "삭제 실패";
			url = "redirect:" + request.getHeader("referer");
		}
		
		ra.addFlashAttribute("swalIcon",swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		return url;
	}
	
	
	
	
	
	
	// 게시글 검색
	@RequestMapping("search")
	public String searchBoard(@RequestParam(value="cp", required=false, defaultValue ="1")  int cp,
								@RequestParam(value="sk",required = false) String sk, 
								@RequestParam(value="sv",required = false) String sv,
								@RequestParam(value="ct",required = false) String ct,
								@RequestParam(value="sort",required = false) String sort, 
								@ModelAttribute("rSearch") ReviewSearch rSearch,
								Model model) {
		
		
		rSearch.setSk(sk);
		rSearch.setSv(sv);
		rSearch.setCt(ct);
		rSearch.setSort(sort);
		
		ReviewPageInfo pInfo = service.getSearchPageInfo(rSearch,cp);
		
		
		List<Review> rList = service.selectSearchList(rSearch,pInfo);
		
		
		if(!rList.isEmpty()) {
			List<ReviewAttachment> thList = service.selectThumbnailList(rList);
			model.addAttribute("thList",thList);
		}
		
		model.addAttribute("rList",rList);
		model.addAttribute("pInfo",pInfo);
		model.addAttribute("rSearch",rSearch);
		
		
		return "review/reviewList";
	}
	
	
	
	// 신고 페이지 연결
	@RequestMapping("reviewReport/{boardNo}")
	public String boardReport(@PathVariable int boardNo, Model model) {
		model.addAttribute("boardNo", boardNo);
		return "review/reviewReport";
	}
	
	
	// 게시글 신고 등록
	@RequestMapping("reviewReportAction")
	public String insertReviewReport(@ModelAttribute("report") ReviewReport reply , @RequestParam("boardNo") int boardNo,
									@ModelAttribute(name="loginMember", binding=false) Member loginMember, HttpServletRequest request, RedirectAttributes ra) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", loginMember.getMemberNo());
		map.put("boardNo", boardNo);
		map.put("reportTitle", reply.getReportTitle());
		map.put("reportContent", reply.getReportContent());
		map.put("categoryCode", reply.getCategoryCode());
		
		int result = service.insertReviewReport(map);

		String url = "redirect:" + request.getHeader("referer");
		
		if (result > 0) {
			swalIcon = "success";
			swalTitle = "신고가 접수되었습니다.";
		} else {
			swalIcon = "error";
			swalTitle = "신고 접수 실패";
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
	}
	
	
	
	
//--------------------------------------------------------------------------------------------------------------------------	
	// 관리자 삭제된 게시글 상세조회
	@RequestMapping("deleteManage/{boardCode}/{boardNo}")
	public String deleteManageBoard(@PathVariable("boardCode") int boardCode, @PathVariable("boardNo") int boardNo, Model model,
			@RequestHeader(value="referer",required=false) String referer, RedirectAttributes ra, @ModelAttribute(name="loginMember", binding=false) Member loginMember) {


		Review review = service.selectDeleteReview(boardNo);
		
		String url = null;
		
		if(review!=null) { // 상세조회 성공시
			
			// 조회수 상위3  게시글 출력
			List<Review> reviewList = service.reviewListTop3();
			
			// 조회수 상위3 썸네일
			if(reviewList!=null && !reviewList.isEmpty()) {
				/* 썸네일 출력 */
				List<ReviewAttachment> thumbnailList = service.selectThumbnailList(reviewList);
		
				
				if(thumbnailList!=null) {
					model.addAttribute("thList", thumbnailList);
				}
			}
			
			// 좋아요 정보 출력
			int memberNo = loginMember.getMemberNo();
			
			List<ReviewLike> likeInfo = service.selectLike(memberNo);
			
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("memberNo", memberNo);
			map.put("boardNo", boardNo);
			
			int like = service.selectLikePushed(map);
			
			
			model.addAttribute("review",review);
			model.addAttribute("reviewList",reviewList);
			model.addAttribute("likeInfo",likeInfo);
			model.addAttribute("like", like);
			
			url = "review/reviewView";
		}else {
			
			if(referer == null) { //이전 요청주소가 없는 경우
				url = "${contextPath}/admin/boardManage";
			}else {
				url="redirect:"+referer;
			}
			
			ra.addFlashAttribute("swalicon","error");
			ra.addFlashAttribute("swalTitle","존재하지 않는 게시글입니다.");
		}
		
		return url;
	}
	
	
	
	
	
	
	


	

}
