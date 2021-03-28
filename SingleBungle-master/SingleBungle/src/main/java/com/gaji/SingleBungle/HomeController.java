package com.gaji.SingleBungle;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaji.SingleBungle.board.model.service.BoardService;
import com.gaji.SingleBungle.board.model.vo.Board;
import com.gaji.SingleBungle.board.model.vo.BoardPageInfo;
import com.gaji.SingleBungle.cafe.model.service.CafeService;
import com.gaji.SingleBungle.cafe.model.vo.Cafe;
import com.gaji.SingleBungle.cafe.model.vo.CafeAttachment;
import com.gaji.SingleBungle.cafe.model.vo.CafePageInfo;
import com.gaji.SingleBungle.findFriend.model.service.FindFriendService;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriend;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendPageInfo;
import com.gaji.SingleBungle.market.model.service.MarketService;
import com.gaji.SingleBungle.market.model.vo.Market;
import com.gaji.SingleBungle.market.model.vo.MarketAttachment;
import com.gaji.SingleBungle.market.model.vo.MarketPageInfo;
import com.gaji.SingleBungle.member.model.vo.Member;
import com.gaji.SingleBungle.review.model.service.ReviewService;
import com.gaji.SingleBungle.review.model.vo.Review;
import com.gaji.SingleBungle.review.model.vo.ReviewAttachment;
import com.gaji.SingleBungle.review.model.vo.ReviewPageInfo;

@Controller
public class HomeController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private BoardService service1; // 자유게시판 서비스
	
	@Autowired
	private ReviewService service2; // 후기게시판 서비스
	
	@Autowired
	private CafeService service6; // 맛집게시판 서비스
	
	@Autowired
	private FindFriendService service7; // 친구찾기 서비스
	
	@Autowired
	private MarketService service8; // 사고팔고 서비스
	
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model,
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp) {
		
	// 메인에 게시글 목록 조회 Controller

	// 자유게시판
	BoardPageInfo bpInfo = service1.getPageInfo(cp);
	bpInfo.setLimit(7);
	List<Board> bList = service1.selectList(bpInfo);
	
	model.addAttribute("bList", bList);
	model.addAttribute("bpInfo", bpInfo);
	
	// 후기게시판
	ReviewPageInfo pInfo2 = service2.getPageInfo(cp);
	pInfo2.setLimit(3);
	List<Review> rList = service2.selectList(pInfo2);
	
	/* 썸네일 출력 */
	if(rList!=null && !rList.isEmpty()) {
		List<ReviewAttachment> thumbnailList = service2.selectThumbnailList(rList);
		
		
		if(thumbnailList!=null) {
			model.addAttribute("thumbnailList", thumbnailList);
		}
	
	}
	
	model.addAttribute("rList", rList);
	model.addAttribute("pInfo2", pInfo2);
	
	
		
	// 친구찾기
	FindFriendPageInfo pInfo = service7.getPageInfo(cp);
	pInfo.setLimit(7);
	List<FindFriend> fList = service7.selectList(pInfo);
	
	model.addAttribute("pInfo", pInfo);
	model.addAttribute("fList", fList);
	
		
	// 맛집게시판
	CafePageInfo cpInfo = service6.getPageInfo(cp);
	cpInfo.setLimit(3);
	List<Cafe> cList = service6.selectList(cpInfo);
	
	// 썸네일
	if (cList != null && !cList.isEmpty()) {
		List<CafeAttachment> thumbnailList3 = service6.selectThumbnailList(cList);

		if (thumbnailList3 != null) {
			model.addAttribute("thumbnailList3", thumbnailList3);
		}

	}
	
	model.addAttribute("cList", cList);
	model.addAttribute("cpInfo", cpInfo);
	
	
	
	
	// 사고팔고
	MarketPageInfo mpInfo = service8.getPageInfo(cp);
	mpInfo.setLimit(2);
	List<Market> mList = service8.selectList(mpInfo);
	
	if(mList != null && !mList.isEmpty()) {
		List<MarketAttachment> thumbnailList2 = service8.selectThumbnailList(mList);
		if(thumbnailList2 != null) {
			model.addAttribute("thumbnailList2", thumbnailList2);
		}
	}	
		
	model.addAttribute("mpInfo", mpInfo);
	model.addAttribute("mList", mList);	
		
	

		return "common/main";
	}
	

	
}
