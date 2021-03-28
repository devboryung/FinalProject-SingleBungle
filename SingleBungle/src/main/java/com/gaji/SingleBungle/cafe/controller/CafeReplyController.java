package com.gaji.SingleBungle.cafe.controller;

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

import com.gaji.SingleBungle.cafe.model.service.CafeReplyService;
import com.gaji.SingleBungle.cafe.model.vo.CafeReply;
import com.gaji.SingleBungle.cafe.model.vo.CafeReplyReport;
import com.gaji.SingleBungle.member.model.vo.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@SessionAttributes({"loginMember"})
@RequestMapping("/cafeReply/*")
public class CafeReplyController {
	
	@Autowired
	private CafeReplyService service;
	
	private String swalIcon = null;
	private String swalTitle = null;
	private String swalText = null;
	
	// 댓글 목록 조회 Controller
	@ResponseBody
	@RequestMapping("selectReplyList/{cafeNo}")
	public String selectReplyList(@PathVariable("cafeNo") int cafeNo ) {
		
		List<CafeReply> rList = service.selectReplyList(cafeNo);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy년 MM월 dd일 HH:mm:ss").create();
		
		return gson.toJson(rList);
	}
	
	// 댓글 삽입 Controller
	@ResponseBody
	@RequestMapping("insertReplyList/{cafeNo}")
	public int insertReply(@PathVariable("cafeNo") int cafeNo,
							@ModelAttribute CafeReply reply) {
		
		reply.setCafeNo(cafeNo);
		
		return service.insertReply(reply);
	}
	
	// 댓글 수정 Controller
	@ResponseBody
	@RequestMapping("updateReply/{replyNo}")
	public int updateReply(@PathVariable("replyNo") int replyNo,
							@ModelAttribute CafeReply reply) {
		
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
	@RequestMapping("insertChildReply/{cafeNo}")
	public int insertChildReply(@PathVariable("cafeNo") int cafeNo,
								@ModelAttribute CafeReply reply) {
		
		reply.setCafeNo(cafeNo);
		
		return service.insertChildReply(reply);
	}
	
	
	// 댓글 신고 페이지 연결 Controller
	@RequestMapping("cafeReplyReport/{replyNo}")
	public String replyReport(@PathVariable int replyNo, Model model) {
		model.addAttribute("replyNo", replyNo);
		return "cafe/cafeReplyReport";
	}
	
	// 댓글 신고 등록 Controller
	@RequestMapping("cafeReplyReportAction")
	public String insertReplyReport(@ModelAttribute CafeReplyReport report, @RequestParam("replyNo") int replyNo,
									@RequestParam("cafeNo") int cafeNo,
									@ModelAttribute("loginMember") Member loginMember,
									HttpServletRequest request, RedirectAttributes ra) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", loginMember.getMemberNo());
		map.put("cafeNo", cafeNo);
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
