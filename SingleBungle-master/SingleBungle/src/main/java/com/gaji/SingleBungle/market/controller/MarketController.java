package com.gaji.SingleBungle.market.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gaji.SingleBungle.board.model.service.BoardService;
import com.gaji.SingleBungle.cafe.model.vo.CafeAttachment;
import com.gaji.SingleBungle.market.model.service.MarketService;
import com.gaji.SingleBungle.market.model.vo.Market;
import com.gaji.SingleBungle.market.model.vo.MarketAttachment;
import com.gaji.SingleBungle.market.model.vo.MarketLike;
import com.gaji.SingleBungle.market.model.vo.MarketPageInfo;
import com.gaji.SingleBungle.market.model.vo.MarketReport;
import com.gaji.SingleBungle.market.model.vo.MarketSearch;
import com.gaji.SingleBungle.member.model.vo.Member;
import com.gaji.SingleBungle.review.model.vo.Review;
import com.gaji.SingleBungle.review.model.vo.ReviewAttachment;
import com.gaji.SingleBungle.review.model.vo.ReviewLike;
import com.gaji.SingleBungle.review.model.vo.ReviewPageInfo;
import com.gaji.SingleBungle.review.model.vo.ReviewReport;
import com.gaji.SingleBungle.review.model.vo.ReviewSearch;

@Controller
@SessionAttributes({"loginMember"})
@RequestMapping("/market/*")

public class MarketController {
	@Autowired
	private MarketService service;
	
	private String swalIcon = null;
	private String swalTitle = null;
	private String swalText = null;
	
	@RequestMapping("list")
	public String marketList(@RequestParam(value= "cp", required = false, defaultValue="1")  
								int cp, Model model, @ModelAttribute("loginMember") Member loginMember,
								RedirectAttributes ra) {
		String url = null;		
		
		if (loginMember != null) {
			//if (loginMember.getMemberGrade().charAt(0) != 'F' && loginMember.getMemberGrade().charAt(0) != 'G') {
			if(loginMember.getMemberGrade().charAt(0) == 'T') {
				swalIcon = "error";
				swalTitle = "사고팔고 게시판은 2등급부터 이용할 수 있습니다.";
				url = "redirect:/";
			} else {
				MarketPageInfo mpInfo = service.getPageInfo(cp);

				List<Market> mList = service.selectList(mpInfo);
				
				if(mList != null && !mList.isEmpty()) {
					List<MarketAttachment> thumbnailList = service.selectThumbnailList(mList);
					if(thumbnailList != null) {
						model.addAttribute("thList", thumbnailList);
					}
				}
				
				List<MarketLike> likeInfo = service.selectLike(loginMember.getMemberNo());
				

				model.addAttribute("mpInfo", mpInfo);
				model.addAttribute("mList", mList);
				model.addAttribute("likeInfo", likeInfo);

				url = "market/marketList";

			}
		} else {
			
			swalIcon = "error";
			swalTitle = "로그인 후 이용해주세요.";
			url = "redirect:/";
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		return url;
	}
	
	
	// 좋아요 증가 Controller
	@ResponseBody
	@RequestMapping("increaseLike")
	public int increaseLike(@RequestParam int marketNo,
			@ModelAttribute("loginMember") Member loginMember) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("memberNo", loginMember.getMemberNo());
		map.put("marketNo", marketNo);
		
		int result = service.increaseLike(map);
		
		return result;
	}
	
	// 좋아요 감소 Controller
	@ResponseBody
	@RequestMapping("decreaseLike")
	public int decreaseLike(@RequestParam int marketNo,
			@ModelAttribute("loginMember") Member loginMember) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", loginMember.getMemberNo());
		map.put("marketNo", marketNo);
		
		int result = service.decreaseLike(map);
		return result;
	}
	
	
	// 사고팔고 상세 조회
	@RequestMapping("{marketNo}") 
	public String marketView(@PathVariable int marketNo,
							Model model, @RequestHeader(value = "referer", required = false) String referer,
							RedirectAttributes ra, @ModelAttribute("loginMember") Member loginMember) {
		
		Market market = service.selectMarket(marketNo);
		String url = null;
		
		if (market != null) {
			
			// 조회수 상위 3 썸네일
			List<Market> marketList = service.marketListTop3();
			
			if(marketList != null && !marketList.isEmpty()) {
				List<MarketAttachment> thList = service.selectThumbnailList(marketList);
				
				if(thList != null) {
					model.addAttribute("thList", thList);
				}
			}
			
			
			// 해당 게시글에 좋아요를 눌렀는지 확인
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("memberNo", loginMember.getMemberNo());
			map.put("marketNo", marketNo);
			
			List<MarketLike> likeInfo = service.selectLike(loginMember.getMemberNo());			
			
			int like = service.selectLikePushed(map);
			model.addAttribute("likeCheck", like);
			
			
			List<MarketAttachment> at = service.selectAttachmentList(marketNo);
			
			if(at != null & !at.isEmpty()) {
				model.addAttribute("at", at);
			}
			
			//model.addAttribute("loginMember", loginMember);
			model.addAttribute("market", market);
			model.addAttribute("marketList",marketList);
			model.addAttribute("likeInfo",likeInfo);
			model.addAttribute("like", like);
			url = "market/marketView";
		} else {
			
			if (referer == null) {
				url = "redirect:../list/";
			} else {
				url = "redirect:" + referer;
			}

			ra.addFlashAttribute("swalIcon", "error");
			ra.addFlashAttribute("swalTitle", "존재하지 않는 게시글입니다.");
		}
		return url;
	}
	
	
	
	// 예약중으로 변경 Controller
	@ResponseBody
	@RequestMapping("reservation/{type}")
	public int reservation(@PathVariable("type") int type,
			@RequestParam("marketNo") int marketNo) {
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		map.put("marketNo", marketNo);
		map.put("type", type);
		
		
		return service.reservation(map);
	}
	
	 
	
	// 사고팔고 게시글 작성 view 
	@RequestMapping("insert")
	public String marketInsert() {
		return "market/marketInsert"; 
	}
	
	// 사고팔고 게시글 등록 Controller
	@RequestMapping("insertAction")
	public String marketInsertAction(@ModelAttribute Market market, RedirectAttributes ra,
						@ModelAttribute("loginMember") Member loginMember, 
						@RequestParam(value="images", required=true) List<MultipartFile> images,
						HttpServletRequest request) {
		
		//System.out.println(market);
		
		market.setMemNo(loginMember.getMemberNo());
		
//		for(int i=0; i<images.size(); i++) {
//		System.out.println("images[" + i + "] : " + images.get(i).getOriginalFilename());
//			}
		String savePath = null;
		
		savePath = request.getSession().getServletContext().getRealPath("resources/marketImages");
		
		int result = service.insertMarket(market, images, savePath);
		
		String url = null;
		
		if(result > 0) {
			swalIcon = "success";
			swalTitle = "게시글 등록 성공";
			url = "redirect:" + result;
			
			request.getSession().setAttribute("returnListURL", "list");
					
		} else {
			swalIcon = "error";
			swalTitle = "게시글 등록 실패";
			url = "redirect:insert";
		}
		 ra.addFlashAttribute("swalIcon", swalIcon);
		 ra.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
	}
	
	
	// 게시글 수정 화면 전환 Controller
	@RequestMapping("update/{marketNo}")
	public String marketUpdate(@PathVariable("marketNo") int marketNo, Model model) {
		
		// 게시글 상세 조회 
		Market market = service.selectMarket(marketNo);
		System.out.println(market);
		
		// 해당 게시글이 포함된 이미지 목록 조회
		if(market != null) {
			List<MarketAttachment> attachmentList = service.selectAttachmentList(marketNo);
			model.addAttribute("at", attachmentList);
		}
		
		model.addAttribute("market", market);
		return "market/marketUpdate";
	}
	
	
	
	

	// 게시글 수정 화면 전환 Controller
	@RequestMapping("updateAction/{marketNo}")
	public String marketUpdateAction(@PathVariable("marketNo") int marketNo, Model model, RedirectAttributes ra,
									@ModelAttribute Market market, HttpServletRequest request,
									@RequestParam("beforeImages") int[] beforeImages,
									@RequestParam(value="images", required=true) List<MultipartFile> images
									) {
		
		// marketNo를 market에 세팅
		market.setMarketNo(marketNo);
		
		// 실제 파일 저장 경로
		String savePath = request.getSession().getServletContext().getRealPath("resources/marketImages");
		
		int result = service.updateMarket(market, images, savePath, beforeImages);
		
		
		String url = null;
		
		if(result > 0) {
			swalIcon = "success";
			swalTitle = "사고팔고 수정 성공";
			url = "redirect:../" + marketNo;
			
			request.getSession().setAttribute("returnListURL", "../list");
		}else {
			swalIcon = "error";
			swalTitle = "사고팔고 수정 실패";
			url = "redirect:" + request.getHeader("referer");
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);

		return url;
	}
	
	
	
	
	
	
	
	
	
	// 게시글 검색
	@RequestMapping("search")
	public String searchBoard(@RequestParam(value="cp", required=false, defaultValue ="1")  int cp,
			@RequestParam(value="sv",required = false) String sv,
			@RequestParam(value="ct",required = false) String ct,
			@RequestParam(value="sort",required = false) String sort, 
			@ModelAttribute("mSearch") MarketSearch mSearch,
			Model model, @ModelAttribute("loginMember") Member loginMember) {
		
		mSearch.setSv(sv);
		mSearch.setCt(ct);
		mSearch.setSort(sort);
		
		System.out.println(mSearch);
		
		
		MarketPageInfo mpInfo = service.getSearchPageInfo(mSearch,cp);
		
		
		List<Market> mList = service.selectSearchList(mSearch,mpInfo);
		
		
		if(!mList.isEmpty()) {
			List<MarketAttachment> thList = service.selectThumbnailList(mList);
			model.addAttribute("thList",thList);
		}
		
		if(loginMember != null) {
			List<MarketLike> likeInfo = service.selectLike(loginMember.getMemberNo());
			model.addAttribute("likeInfo", likeInfo);
		}
		model.addAttribute("mList", mList);
		model.addAttribute("mpInfo",mpInfo);
		model.addAttribute("mSearch", mSearch);
		
		return "market/marketList";
	}
	
	
	// 신고 페이지 연결
	@RequestMapping("marketReport/{marketNo}")
	public String marketReport(@PathVariable int marketNo, Model model) {
		model.addAttribute("marketNo", marketNo);
		return "market/marketReport";
	}
	
	
	
	// 게시글 신고 등록
	@RequestMapping("marketReportAction") 
	public String insertReviewReport(@ModelAttribute("report") MarketReport report , @RequestParam("marketNo") int marketNo,
			@ModelAttribute("loginMember") Member loginMember, HttpServletRequest request, RedirectAttributes ra) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", loginMember.getMemberNo());
		map.put("marketNo", marketNo);
		map.put("reportTitle", report.getReportTitle());
		map.put("reportContent", report.getReportContent());
		map.put("categoryCode", report.getCategoryCode());
		
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
	
	// 게시글 삭제
	@RequestMapping("delete/{marketNo}")
	public String deleteMarket(@PathVariable("marketNo") int marketNo,
							 @ModelAttribute Market market,HttpServletRequest request, RedirectAttributes ra ) {
		market.setMarketNo(marketNo);
		
		int result = service.deleteMarket(market);
		
		String url = null;
		
		if(result > 0) {
			swalIcon = "success";
			swalTitle = "삭제 성공";
			url = "redirect:../list";
		} else {
			swalIcon = "error";
			swalTitle = "삭제 실패";
			url = "redirect:" + request.getHeader("referer");
		}
		
		ra.addFlashAttribute("swalIcon",swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		return url;
	}
	
	
	// 판매내역 페이지
	@RequestMapping("mypage/{memberNo}/{marketNo}")
	public String marketMypage(@RequestParam(value="cp", required=false, defaultValue ="1")  int cp,
								@PathVariable("memberNo") int memberNo,
								@PathVariable("marketNo") int marketNo, HttpServletRequest request,
								Model model) {
		
		// 닉네임 
		String nickname = service.getNickname(memberNo);
		
		if(nickname != null) {
			
			MarketPageInfo mpInfo = service.getMyPageInfo(cp, memberNo);
			
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("memberNo", memberNo);
			map.put("mpInfo", mpInfo); 
			
			List<Market> mList = service.selectMypageList(map);
			
			if(mList != null && !mList.isEmpty()) {
				List<MarketAttachment> thList = service.selectThumbnailList(mList);
				if(thList != null) {
					model.addAttribute("thList", thList);
				}
			}
			
			request.getSession().setAttribute("returnListURL", "../../" + marketNo);
			model.addAttribute("mpInfo", mpInfo);
			model.addAttribute("mList", mList);
			model.addAttribute("nickname", nickname);
		}
		return "market/marketMypage";
	}
	
	
	
	
	
	// 동네인증 Controller
	@ResponseBody
	@RequestMapping(value="locateCertification", produces ="application/text; charset=utf8") 
	public String locateCertification(@ModelAttribute(name="loginMember", binding=false) Member loginMember,
										@ModelAttribute(name="market", binding=false) Member market,
								  	@RequestParam("locate") String locate) {
		
		
		String certificationCheck = loginMember.getMemberCertifiedFl();
		System.out.println(market);
		//System.out.println(certificationCheck);
		
		String lResult = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("locate", locate);
		map.put("memberNo", loginMember.getMemberNo());
		
		if(certificationCheck == null){
			int result = service.locateInsert(map);
			
			if(result > 0) {
				lResult = locate;
				loginMember.setAddress(locate);
				loginMember.setMemberCertifiedFl("Y");
				return lResult;
			}
		} else if(certificationCheck.charAt(0) == 'Y' || certificationCheck.charAt(0) == 'N') { // 인증 된 회원일 때
			System.out.println("여기 들어와?");
			String currAddr = loginMember.getAddress();
			
			if(currAddr.equals(locate)) { // 기존 인증 주소와 새로 받은 인증 주소가 같을 때
				loginMember.setMemberCertifiedFl("Y");
				lResult = locate;
				return lResult;
			} else { // 기존 인증 주소와 새로 받은 인증 주소가 다를 때
				
				int result = service.locateUpdate(map);
				
				if(result > 0) {
					lResult = locate;
					loginMember.setAddress(locate);
					loginMember.setMemberCertifiedFl("Y");
				}
				
				return lResult;
			}
		} 
		return lResult;
	}
	
	
	// 노 인증 위치 검색 Controller
	@ResponseBody
	@RequestMapping(value="locateNoCertification", produces ="application/text; charset=utf8")
	public String locateNoCertification(@ModelAttribute(name="loginMember", binding=false) Member loginMember,
		  								@RequestParam("locate") String locate) {
		String certificationCheck = loginMember.getMemberCertifiedFl();
		String lResult = null;
		System.out.println("테스트 " + locate);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("locate", locate);
		map.put("memberNo", loginMember.getMemberNo());

		if (certificationCheck == null) {
			int result = service.NoCertificationInsert(map);

			if (result > 0) {
				lResult = locate;
				loginMember.setAddress(locate);
				loginMember.setMemberCertifiedFl("N");
				System.out.println("테스트 2" + lResult);
				return lResult;
			}
		} else {
			String currAddr = loginMember.getAddress();

			if (currAddr.equals(locate)) { // 기존 인증 주소와 새로 받은 인증 주소가 같을 때

				lResult = locate;
				return lResult;
			} else {
				
				int result = service.NoCertificationUpdate(map);

				if (result > 0) {
					lResult = locate;
					loginMember.setAddress(locate);
					System.out.println("테스트3 " + lResult);
					return lResult;
				}

			}
		}

		return lResult;
	}
	
	

	//------------------------------------------------------------------------------------------------------
	
	// 동네인증 Controller
	@ResponseBody
	@RequestMapping(value="update/updateLocateCertification") 
	public String updateLocateCertification(@ModelAttribute(name="loginMember", binding=false) Member loginMember,
										@ModelAttribute(name="market", binding=false) Member market,
								  	@RequestParam("locate") String locate) {
		
		
		String certificationCheck = loginMember.getMemberCertifiedFl();
		System.out.println(market);
		//System.out.println(certificationCheck);
		
		String lResult = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("locate", locate);
		map.put("memberNo", loginMember.getMemberNo());
		
		if(certificationCheck == null){
			int result = service.locateInsert(map);
			
			if(result > 0) {
				lResult = locate;
				loginMember.setAddress(locate);
				loginMember.setMemberCertifiedFl("Y");
				return lResult;
			}
		} else if(certificationCheck.charAt(0) == 'Y' || certificationCheck.charAt(0) == 'N') { // 인증 된 회원일 때
			System.out.println("여기 들어와?");
			String currAddr = loginMember.getAddress();
			
			if(currAddr.equals(locate)) { // 기존 인증 주소와 새로 받은 인증 주소가 같을 때
				loginMember.setMemberCertifiedFl("Y");
				lResult = locate;
				return lResult;
			} else { // 기존 인증 주소와 새로 받은 인증 주소가 다를 때
				
				int result = service.locateUpdate(map);
				
				if(result > 0) {
					lResult = locate;
					loginMember.setAddress(locate);
					loginMember.setMemberCertifiedFl("Y");
				}
				
				return lResult;
			}
		} 
		return lResult;
	}
	
	
	// 노 인증 위치 검색 Controller
	@ResponseBody
	@RequestMapping(value="update/updateLocateNoCertification", produces ="application/text; charset=utf8")
	public String updateLocateNoCertification(@ModelAttribute(name="loginMember", binding=false) Member loginMember,
		  								@RequestParam("locate") String locate) {
		String certificationCheck = loginMember.getMemberCertifiedFl();
		String lResult = null;
		System.out.println("테스트 " + locate);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("locate", locate);
		map.put("memberNo", loginMember.getMemberNo());

		if (certificationCheck == null) {
			int result = service.NoCertificationInsert(map);

			if (result > 0) {
				lResult = locate;
				loginMember.setAddress(locate);
				loginMember.setMemberCertifiedFl("N");
				System.out.println("테스트 2" + lResult);
				return lResult;
			}
		} else {
			String currAddr = loginMember.getAddress();

			if (currAddr.equals(locate)) { // 기존 인증 주소와 새로 받은 인증 주소가 같을 때

				lResult = locate;
				return lResult;
			} else {
				
				int result = service.NoCertificationUpdate(map);

				if (result > 0) {
					lResult = locate;
					loginMember.setAddress(locate);
					System.out.println("테스트3 " + lResult);
					return lResult;
				}

			}
		}

		return lResult;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// ------------------------------------------------------------------------------------------------------
	
	// 관리자 삭제된 게시글 상세 조회
	@RequestMapping("deleteManage/{boardCode}/{boardNo}")
	public String deleteManageMarket(@PathVariable("boardCode") int boardCode,
									@PathVariable("boardNo") int marketNo,
									@RequestHeader(value="referer", required=false) String referer,
									RedirectAttributes ra, @ModelAttribute("loginMember") Member loginMember
									, Model model) {
		
		Market market = service.selectDeleteMarket(marketNo);
		String url = null;
		
		if(market != null) {
			List<Market> marketList = service.marketListTop3();
			
			if(marketList != null && !marketList.isEmpty()) {
				List<MarketAttachment> thList = service.selectThumbnailList(marketList);
				
				if(thList != null) {
					model.addAttribute("thList", thList);
				}
			}
			
			// 좋아요 정보 출력
			
			int memberNo = loginMember.getMemberNo();
			
			List<MarketLike> likeInfo = service.selectLike(memberNo);
			
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("memberNo", memberNo);
			map.put("boardNo", marketNo);
			
			int like = service.selectLikePushed(map);
			
			model.addAttribute("market", market);
			model.addAttribute("marketList", marketList);
			model.addAttribute("likeInfo", likeInfo);
			model.addAttribute("like", like);
			
			url = "market/marketView";
			
		} else {
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
