package com.gaji.SingleBungle.findFriend.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gaji.SingleBungle.findFriend.model.service.FindFriendReplyService;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendReply;
import com.gaji.SingleBungle.findFriend.model.vo.FriendReplyReport;
import com.gaji.SingleBungle.member.model.vo.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@RequestMapping("/findFriendReply/*")
public class FindFriendReplyController {
	
	@Autowired
	private FindFriendReplyService service;
	
	private String swalIcon = null;
	private String swalTitle = null;
	private String swalText = null;
	
	// 댓글 목록 조회 Controller
	@ResponseBody
	@RequestMapping("selectReplyList/{parentFriendNo}")
	public String selectReplyList(@PathVariable("parentFriendNo") int parentFriendNo) {
		
		//System.out.println(parentFriendNo);
		
		List<FindFriendReply> rList = service.selectReplyList(parentFriendNo);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy년 MM월 dd일 HH:mm:ss").create();
		
		return gson.toJson(rList);
		
	}
	
	// 댓글 삽입 Controller
	@ResponseBody
	@RequestMapping("insertReplyList/{parentFriendNo}")
	public int insertReply(@PathVariable("parentFriendNo") int parentFriendNo,
						   @ModelAttribute FindFriendReply reply) {
		
		reply.setParentFriendNo(parentFriendNo);
		
		return service.insertReply(reply);
				
	}
	
	// 댓글 수정 Controller
	@ResponseBody
	@RequestMapping("updateReply/{replyNo}")
	public int updateReply(@PathVariable("replyNo") int replyNo,
						   @ModelAttribute FindFriendReply reply) {
		
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
	@RequestMapping("insertChildReply/{parentFriendNo}")
	public int insertChildReply(@PathVariable("parentFriendNo") int parentFriendNo,
								@ModelAttribute FindFriendReply reply) {
		
		reply.setParentFriendNo(parentFriendNo);
		
		return service.insertChildReply(reply);
	}
	
	// 친구찾기 댓글 신고 화면 연결 Controller
	@RequestMapping("friendReplyReport/{replyNo}")
	public String friendReplyReport(@PathVariable("replyNo") int replyNo, Model model) {
		
		model.addAttribute("replyNo", replyNo);
		
		return "findFriend/findFriendReportReply";
		
	}
	
	// 친구찾기 댓글 신고 등록 Controller
	@RequestMapping("friendReplyReportAction")
	public String insertReplyReport(@ModelAttribute FriendReplyReport report, @RequestParam("replyNo") int replyNo,
									@RequestParam("friendNo") int friendNo,
									@ModelAttribute("loginMember") Member loginMember,
									HttpServletRequest request, RedirectAttributes ra) {
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memNo", loginMember.getMemberNo());
		map.put("friendNo", friendNo);
		map.put("replyNo", replyNo);
		
		map.put("reportTitle", report.getReportTitle());
		map.put("reportContent", report.getReportContent());
		map.put("categoryCd", report.getCategoryCd());
		
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
