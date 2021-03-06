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
				swalTitle = "???????????? ???????????? 2???????????? ????????? ??? ????????????.";
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
			swalTitle = "????????? ??? ??????????????????.";
			url = "redirect:/";
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		return url;
	}
	
	
	// ????????? ?????? Controller
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
	
	// ????????? ?????? Controller
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
	
	
	// ???????????? ?????? ??????
	@RequestMapping("{marketNo}") 
	public String marketView(@PathVariable int marketNo,
							Model model, @RequestHeader(value = "referer", required = false) String referer,
							RedirectAttributes ra, @ModelAttribute("loginMember") Member loginMember) {
		
		Market market = service.selectMarket(marketNo);
		String url = null;
		
		if (market != null) {
			
			// ????????? ?????? 3 ?????????
			List<Market> marketList = service.marketListTop3();
			
			if(marketList != null && !marketList.isEmpty()) {
				List<MarketAttachment> thList = service.selectThumbnailList(marketList);
				
				if(thList != null) {
					model.addAttribute("thList", thList);
				}
			}
			
			
			// ?????? ???????????? ???????????? ???????????? ??????
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
			ra.addFlashAttribute("swalTitle", "???????????? ?????? ??????????????????.");
		}
		return url;
	}
	
	
	
	// ??????????????? ?????? Controller
	@ResponseBody
	@RequestMapping("reservation/{type}")
	public int reservation(@PathVariable("type") int type,
			@RequestParam("marketNo") int marketNo) {
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		map.put("marketNo", marketNo);
		map.put("type", type);
		
		
		return service.reservation(map);
	}
	
	 
	
	// ???????????? ????????? ?????? view 
	@RequestMapping("insert")
	public String marketInsert() {
		return "market/marketInsert"; 
	}
	
	// ???????????? ????????? ?????? Controller
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
			swalTitle = "????????? ?????? ??????";
			url = "redirect:" + result;
			
			request.getSession().setAttribute("returnListURL", "list");
					
		} else {
			swalIcon = "error";
			swalTitle = "????????? ?????? ??????";
			url = "redirect:insert";
		}
		 ra.addFlashAttribute("swalIcon", swalIcon);
		 ra.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
	}
	
	
	// ????????? ?????? ?????? ?????? Controller
	@RequestMapping("update/{marketNo}")
	public String marketUpdate(@PathVariable("marketNo") int marketNo, Model model) {
		
		// ????????? ?????? ?????? 
		Market market = service.selectMarket(marketNo);
		System.out.println(market);
		
		// ?????? ???????????? ????????? ????????? ?????? ??????
		if(market != null) {
			List<MarketAttachment> attachmentList = service.selectAttachmentList(marketNo);
			model.addAttribute("at", attachmentList);
		}
		
		model.addAttribute("market", market);
		return "market/marketUpdate";
	}
	
	
	
	

	// ????????? ?????? ?????? ?????? Controller
	@RequestMapping("updateAction/{marketNo}")
	public String marketUpdateAction(@PathVariable("marketNo") int marketNo, Model model, RedirectAttributes ra,
									@ModelAttribute Market market, HttpServletRequest request,
									@RequestParam("beforeImages") int[] beforeImages,
									@RequestParam(value="images", required=true) List<MultipartFile> images
									) {
		
		// marketNo??? market??? ??????
		market.setMarketNo(marketNo);
		
		// ?????? ?????? ?????? ??????
		String savePath = request.getSession().getServletContext().getRealPath("resources/marketImages");
		
		int result = service.updateMarket(market, images, savePath, beforeImages);
		
		
		String url = null;
		
		if(result > 0) {
			swalIcon = "success";
			swalTitle = "???????????? ?????? ??????";
			url = "redirect:../" + marketNo;
			
			request.getSession().setAttribute("returnListURL", "../list");
		}else {
			swalIcon = "error";
			swalTitle = "???????????? ?????? ??????";
			url = "redirect:" + request.getHeader("referer");
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);

		return url;
	}
	
	
	
	
	
	
	
	
	
	// ????????? ??????
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
	
	
	// ?????? ????????? ??????
	@RequestMapping("marketReport/{marketNo}")
	public String marketReport(@PathVariable int marketNo, Model model) {
		model.addAttribute("marketNo", marketNo);
		return "market/marketReport";
	}
	
	
	
	// ????????? ?????? ??????
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
			swalTitle = "????????? ?????????????????????.";
		} else {
			swalIcon = "error";
			swalTitle = "?????? ?????? ??????";
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
		
	}
	
	// ????????? ??????
	@RequestMapping("delete/{marketNo}")
	public String deleteMarket(@PathVariable("marketNo") int marketNo,
							 @ModelAttribute Market market,HttpServletRequest request, RedirectAttributes ra ) {
		market.setMarketNo(marketNo);
		
		int result = service.deleteMarket(market);
		
		String url = null;
		
		if(result > 0) {
			swalIcon = "success";
			swalTitle = "?????? ??????";
			url = "redirect:../list";
		} else {
			swalIcon = "error";
			swalTitle = "?????? ??????";
			url = "redirect:" + request.getHeader("referer");
		}
		
		ra.addFlashAttribute("swalIcon",swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		return url;
	}
	
	
	// ???????????? ?????????
	@RequestMapping("mypage/{memberNo}/{marketNo}")
	public String marketMypage(@RequestParam(value="cp", required=false, defaultValue ="1")  int cp,
								@PathVariable("memberNo") int memberNo,
								@PathVariable("marketNo") int marketNo, HttpServletRequest request,
								Model model) {
		
		// ????????? 
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
	
	
	
	
	
	// ???????????? Controller
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
		} else if(certificationCheck.charAt(0) == 'Y' || certificationCheck.charAt(0) == 'N') { // ?????? ??? ????????? ???
			System.out.println("?????? ??????????");
			String currAddr = loginMember.getAddress();
			
			if(currAddr.equals(locate)) { // ?????? ?????? ????????? ?????? ?????? ?????? ????????? ?????? ???
				loginMember.setMemberCertifiedFl("Y");
				lResult = locate;
				return lResult;
			} else { // ?????? ?????? ????????? ?????? ?????? ?????? ????????? ?????? ???
				
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
	
	
	// ??? ?????? ?????? ?????? Controller
	@ResponseBody
	@RequestMapping(value="locateNoCertification", produces ="application/text; charset=utf8")
	public String locateNoCertification(@ModelAttribute(name="loginMember", binding=false) Member loginMember,
		  								@RequestParam("locate") String locate) {
		String certificationCheck = loginMember.getMemberCertifiedFl();
		String lResult = null;
		System.out.println("????????? " + locate);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("locate", locate);
		map.put("memberNo", loginMember.getMemberNo());

		if (certificationCheck == null) {
			int result = service.NoCertificationInsert(map);

			if (result > 0) {
				lResult = locate;
				loginMember.setAddress(locate);
				loginMember.setMemberCertifiedFl("N");
				System.out.println("????????? 2" + lResult);
				return lResult;
			}
		} else {
			String currAddr = loginMember.getAddress();

			if (currAddr.equals(locate)) { // ?????? ?????? ????????? ?????? ?????? ?????? ????????? ?????? ???

				lResult = locate;
				return lResult;
			} else {
				
				int result = service.NoCertificationUpdate(map);

				if (result > 0) {
					lResult = locate;
					loginMember.setAddress(locate);
					System.out.println("?????????3 " + lResult);
					return lResult;
				}

			}
		}

		return lResult;
	}
	
	

	//------------------------------------------------------------------------------------------------------
	
	// ???????????? Controller
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
		} else if(certificationCheck.charAt(0) == 'Y' || certificationCheck.charAt(0) == 'N') { // ?????? ??? ????????? ???
			System.out.println("?????? ??????????");
			String currAddr = loginMember.getAddress();
			
			if(currAddr.equals(locate)) { // ?????? ?????? ????????? ?????? ?????? ?????? ????????? ?????? ???
				loginMember.setMemberCertifiedFl("Y");
				lResult = locate;
				return lResult;
			} else { // ?????? ?????? ????????? ?????? ?????? ?????? ????????? ?????? ???
				
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
	
	
	// ??? ?????? ?????? ?????? Controller
	@ResponseBody
	@RequestMapping(value="update/updateLocateNoCertification", produces ="application/text; charset=utf8")
	public String updateLocateNoCertification(@ModelAttribute(name="loginMember", binding=false) Member loginMember,
		  								@RequestParam("locate") String locate) {
		String certificationCheck = loginMember.getMemberCertifiedFl();
		String lResult = null;
		System.out.println("????????? " + locate);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("locate", locate);
		map.put("memberNo", loginMember.getMemberNo());

		if (certificationCheck == null) {
			int result = service.NoCertificationInsert(map);

			if (result > 0) {
				lResult = locate;
				loginMember.setAddress(locate);
				loginMember.setMemberCertifiedFl("N");
				System.out.println("????????? 2" + lResult);
				return lResult;
			}
		} else {
			String currAddr = loginMember.getAddress();

			if (currAddr.equals(locate)) { // ?????? ?????? ????????? ?????? ?????? ?????? ????????? ?????? ???

				lResult = locate;
				return lResult;
			} else {
				
				int result = service.NoCertificationUpdate(map);

				if (result > 0) {
					lResult = locate;
					loginMember.setAddress(locate);
					System.out.println("?????????3 " + lResult);
					return lResult;
				}

			}
		}

		return lResult;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// ------------------------------------------------------------------------------------------------------
	
	// ????????? ????????? ????????? ?????? ??????
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
			
			// ????????? ?????? ??????
			
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
			if(referer == null) { //?????? ??????????????? ?????? ??????
				url = "${contextPath}/admin/boardManage";
			}else {
				url="redirect:"+referer;
			}
			
			ra.addFlashAttribute("swalicon","error");
			ra.addFlashAttribute("swalTitle","???????????? ?????? ??????????????????.");
		}
		return url;
	}
	
}
