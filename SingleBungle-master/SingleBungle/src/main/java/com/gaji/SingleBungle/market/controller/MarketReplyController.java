package com.gaji.SingleBungle.market.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gaji.SingleBungle.market.model.service.MarketReplyService;
import com.gaji.SingleBungle.market.model.vo.MarketReply;
import com.gaji.SingleBungle.market.model.vo.MarketReplyReport;
import com.gaji.SingleBungle.member.model.vo.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@SessionAttributes({"loginMember"})
@RequestMapping("/marketReply/*")
public class MarketReplyController {

	@Autowired
	private MarketReplyService service;
	
	private String swalIcon = null;
	private String swalTitle = null;
	private String swalText = null;
	
	// 댓글 목록 조회 Controller
	@ResponseBody
	@RequestMapping("selectReplyList/{parentMarketNo}")
	public String selectReplyList(@PathVariable("parentMarketNo") int parentMarketNo){
		
		List<MarketReply> rList = service.selectReplyList(parentMarketNo);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy년 MM월 dd일 HH:mm:ss").create();
		
		return gson.toJson(rList);
	}
	
	// 댓글 삽입 Controller insertReplyList
	@ResponseBody
	@RequestMapping("insertReplyList/{parentMarketNo}")
	public int insertReply(@PathVariable("parentMarketNo") int parentMarketNo,
						@ModelAttribute("reply") MarketReply reply) {
		reply.setParentMarketNo(parentMarketNo);
		int result = service.insertReply(reply);
		return result;
	}
	
	
	// 댓글 수정 Controller
	@ResponseBody
	@RequestMapping("updateReply/{replyNo}")
	public int updateReply(@PathVariable("replyNo") int replyNo,
							@ModelAttribute MarketReply reply) {
		reply.setReplyNo(replyNo);
		return service.updateReply(reply);
	}
	
	// 댓글 삭제 Controller
	@ResponseBody
	@RequestMapping("deleteReply/{replyNo}")
	public int deleteReply(@PathVariable("replyNo") int replyNo) {
		return service.deleteReply(replyNo);
	}
	
	
	// 답글 삽입 Controller
	@ResponseBody
	@RequestMapping("insertChildReply/{parentMarketNo}")
	public int insertChildReply(@PathVariable("parentMarketNo") int parentMarketNo,
								@ModelAttribute MarketReply reply) {
		reply.setParentMarketNo(parentMarketNo);
		return service.insertChildReply(reply);
	}
	
	// 댓글 신고 페이지 연결
	@RequestMapping("marketReplyReport/{replyNo}")
	public String replyReport(@PathVariable int replyNo, Model model) {
		model.addAttribute("replyNo", replyNo);
		return "market/marketReplyReport";
	}
	
	
	// 댓글 신고 등록 Controller
	@RequestMapping("marketReplyReportAction")
	public String insertReplyReport(@ModelAttribute MarketReplyReport report, @RequestParam("replyNo") int replyNo,
									@RequestParam("marketNo") int marketNo,
									@ModelAttribute("loginMember") Member loginMember,
									HttpServletRequest request, RedirectAttributes ra) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", loginMember.getMemberNo());
		map.put("marketNo", marketNo);
		map.put("replyNo", replyNo);
		
		map.put("reportTitle", report.getReportTitle());
		map.put("reportContent", report.getReportContent());
		map.put("categoryCode", report.getCategoryCode());
		
		int result = service.insertBoardReport(map);
		
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
}


























