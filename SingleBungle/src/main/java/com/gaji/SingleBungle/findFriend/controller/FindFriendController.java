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
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gaji.SingleBungle.findFriend.model.service.FindFriendService;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendAttachment;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriend;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendPageInfo;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendSearch;
import com.gaji.SingleBungle.findFriend.model.vo.FriendReport;
import com.gaji.SingleBungle.member.model.vo.Member;
import com.google.gson.Gson;

@Controller
@SessionAttributes({"loginMember"})
@RequestMapping("/findFriend/*")
public class FindFriendController {
	
	@Autowired
	private FindFriendService service;
	
	private String swalIcon = null;
	private String swalTitle = null;
	private String swalText = null;
	
	// 친구찾기 목록 조회 Controller
	@RequestMapping("list")
	public String friendList(@RequestParam(value = "cp", required = false, defaultValue = "1") int cp, RedirectAttributes ra,
							 Model model, @ModelAttribute(name = "loginMember", binding = false) Member loginMember) {
		
		String url = null;
		
		if(loginMember != null) {
			
			if(loginMember.getMemberGrade().charAt(0) != 'F') {
				swalIcon = "error";
				swalTitle = "만남의 광장은 2등급부터 이용할 수 있습니다.";
				url = "redirect:/";
			}else {
				
			// 1) 페이징 처리를 위한 객체 PageInfo 생성
			FindFriendPageInfo pInfo = service.getPageInfo(cp);
			
			// 2) 게시글 목록 조회
			List<FindFriend> fList = service.selectList(pInfo);
			
			
			model.addAttribute("pInfo", pInfo);
			model.addAttribute("fList", fList);
			
			url = "findFriend/findFriendList";
				
			}
			
		}else {
			swalIcon = "error";
			swalTitle = "로그인 후 이용해주세요.";
			url = "redirect:/";
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
		
	}
	
	// 친구찾기 검색 Controller
	@RequestMapping("search")
	public String friendSearch(@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
							   @RequestParam(value = "sk", required = false) String sk, 
							   @RequestParam(value = "sv", required = false) String sv,
							   @RequestParam(value = "ct", required = false) String ct,
							   @RequestParam(value = "sort", required = false) String sort,
							   @ModelAttribute("fSearch") FindFriendSearch fSearch,
							   Model model) {
		
		fSearch.setSk(sk);
		fSearch.setSv(sv);
		fSearch.setCt(ct);
		fSearch.setSort(sort);
		
		// 1) 페이징 처리를 위한 객체 PageInfo 생성
		FindFriendPageInfo pInfo = service.getSearchPageInfo(fSearch, cp);
		
		// 2) 게시글 목록 조회
		List<FindFriend> fList = service.selectSearchList(fSearch, pInfo);
		
		model.addAttribute("pInfo", pInfo);
		model.addAttribute("fList", fList);
		model.addAttribute("fSearch", fSearch);
		
		return "findFriend/findFriendList";
	}
	
	// 친구찾기 상세 조회 Controller
	@RequestMapping("{friendNo}")
	public String friendView(@PathVariable("friendNo") int friendNo, Model model,
							 @ModelAttribute(name = "loginMember", binding = false) Member loginMember,
							 @RequestHeader(value = "referer", required = false) String referer,
							 RedirectAttributes ra) {
		
		// 상세 조회
		FindFriend findFriend = service.selectBoard(friendNo);
		
		int memNo = loginMember.getMemberNo();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("friendNo", friendNo);
		map.put("memNo", memNo);
		
		// 참여신청 여부 확인
		int checkApply = service.checkApply(map);
		model.addAttribute("checkApply", checkApply);
		
		String url = null;
		
		if(findFriend != null) { // 상세 조회 성공 시
			
			List<FindFriendAttachment> attachmentList = service.selectAttachmentList(friendNo);
			
			if(attachmentList != null && !attachmentList.isEmpty()) {
				model.addAttribute("attachmentList", attachmentList);
			}
			
			model.addAttribute("findFriend", findFriend);
			url = "findFriend/findFriendView"; 
			
		}else {
			
			if(referer == null) { // 이전 요청 주소가 없는 경우
				url = "redirect:../list";
			}else { // 이전 요청 주소가 있는 경우
				url = "redirect:" + referer;
			}
			
			ra.addFlashAttribute("swalIcon", "error");
			ra.addFlashAttribute("swalTitle", "존재하지 않는 게시글입니다.");
			
		}
		
		return url;
	}
	
	// 친구찾기 참여 신청 Controller
	@ResponseBody
	@RequestMapping("insertApply/{friendNo}")
	public int insertApply(@PathVariable("friendNo") int friendNo,
						   @ModelAttribute(name = "loginMember", binding = false) Member loginMember) {
		
		int memNo = loginMember.getMemberNo();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("friendNo", friendNo);
		map.put("memNo", memNo);
		
		return service.insertApply(map);
	}
	
	// 친구찾기 참여 취소 Controller
	@ResponseBody
	@RequestMapping("deleteApply/{friendNo}")
	public int deleteApply(@PathVariable("friendNo") int friendNo,
						   @ModelAttribute(name = "loginMember", binding = false) Member loginMember) {
		
		int memNo = loginMember.getMemberNo();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("friendNo", friendNo);
		map.put("memNo", memNo);
		
		int result = service.deleteApply(map);
		
		return result;
		
	}
	
	// 친구찾기 참여인원 카운트 Controller
	@ResponseBody
	@RequestMapping("selectApplyCount/{friendNo}")
	public int selectApplyCount(@PathVariable("friendNo") int friendNo) {
		return service.selectApplyCount(friendNo);
	}
	
	// 친구찾기 게시글 신고 연결 Controller
	@RequestMapping("findFriendreport/{friendNo}")
	public String reportForm(@PathVariable int friendNo, Model model) {
		model.addAttribute("friendNo", friendNo);
		return "findFriend/findFriendReport";
	}
	
	// 친구찾기 게시글 신고 등록 Controller
	@RequestMapping("findFriendReportAction")
	public String insertFindFriendReport(@ModelAttribute FriendReport report, @RequestParam("friendNo") int friendNo,
										 @ModelAttribute("loginMember") Member loginMember,
										 HttpServletRequest request, RedirectAttributes ra) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memNo", loginMember.getMemberNo());
		map.put("friendNo", friendNo);
		
		map.put("reportTitle", report.getReportTitle());
		map.put("reportContent", report.getReportContent());
		map.put("categoryCd", report.getCategoryCd());
		
		int result = service.insertFindFriendReport(map);
		
		String url = "redirect:" + request.getHeader("referer");
		
		if(result > 0) {
			swalIcon = "success";
			swalTitle = "신고가 접수되었습니다.";
		}else {
			swalIcon = "error";
			swalTitle = "신고 접수 실패";
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
	}
	
	// 친구찾기 게시글 등록 화면 전환 Controller
	@RequestMapping("insert")
	public String insertView() {
		return "findFriend/findFriendInsert";
	}
	
	// summernote에 업로드된 이미지 저장 Controller
	@ResponseBody
	@RequestMapping(value = {"insertImage", "{friendNo}/insertImage"})
	public String insertImage(HttpServletRequest request,
					@RequestParam(value = "uploadFile") MultipartFile uploadFile){
		
		String savePath = request.getSession().getServletContext().getRealPath("resources/findFriendImages");
		
		FindFriendAttachment at = service.inserImage(uploadFile, savePath);
		
		return new Gson().toJson(at);
		
	}
	
	// 친구찾기 게시글 등록(+ 파일 업로드) Controller
	@RequestMapping("insertAction")
	public String insertAction(@ModelAttribute FindFriend findFriend,
			@ModelAttribute("loginMember") Member loginMember,
			HttpServletRequest request,
			RedirectAttributes ra) {
		
		findFriend.setMemNo(loginMember.getMemberNo());
		
		String savePath 
			= request.getSession().getServletContext().getRealPath("resources/findFriendImages");
		
		int result = service.insertBoard(findFriend, savePath);
		
		String url = null;
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("friendNo", findFriend.getFriendNo());
		map.put("memNo", loginMember.getMemberNo());
		
		if(result > 0) {
			swalIcon = "success";
			swalTitle = "게시글 등록 성공";
			url = "redirect:" + result;
			
			// 작성자 친구찾기 참여 등록
			service.insertApply(map);
			
			// 새로 작성한 게시글 상세 조회시 목록으로 버튼 경로 지정하기
			request.getSession().setAttribute("returnListURL", "list");
			
		}else {
			swalIcon ="error";
			swalTitle ="게시글 등록 실패";
			url = "redirect:insert";
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
	}
	
	// 친구찾기 게시글 수정 화면 전환 Controller
	@RequestMapping("{friendNo}/update")
	public String updateView(@PathVariable("friendNo") int friendNo, Model model) {
		
		// 1) 게시글 상세 조회
		FindFriend findFriend = service.selectBoard(friendNo);
		
		System.out.println(findFriend);
		
		// 2) 해당 게시글에 포함된 이미지 목록 조회
		if(findFriend != null) {
			
			List<FindFriendAttachment> attachmentList = service.selectAttachmentList(friendNo);
			model.addAttribute("attachmentList", attachmentList);
			
		}
		
		model.addAttribute("findFriend", findFriend);
		
		return "findFriend/findFriendUpdate";
	}
	
	// 친구찾기 게시글 수정 Controller
	@RequestMapping("{friendNo}/updateAction")
	public String updateAction(@PathVariable("friendNo") int friendNo,
							   @ModelAttribute FindFriend updateBoard,
							   Model model, RedirectAttributes ra,
							   HttpServletRequest request) {
		
		// friendNo을 updateFriend에 세팅
		updateBoard.setFriendNo(friendNo);
		
		//System.out.println(updateBoard);
		
		// 파일 저장 경로 얻어오기
		String savePath = request.getSession().getServletContext().getRealPath("resources/findFriendImages");
		
		// 게시글 수정
		int result = service.updateBoard(updateBoard);
		
		String url = null;
		
		if(result > 0) {
			swalIcon = "success";
			swalTitle = "게시글 수정 성공";
			url = "redirect:../" + friendNo;
		}else {
			swalIcon = "error";
			swalTitle = "게시글 수정 실패";
			url = "redirect:" + request.getHeader("referer");
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
	}
	
	// 친구찾기 게시글 상태변경 Controller
	@RequestMapping("{friendNo}/updateStatus")
	public String updateStatus(@PathVariable("friendNo") int friendNo, RedirectAttributes ra, HttpServletRequest request) {
		
		int result = service.updateStatus(friendNo);
		
		String url = null;
		
		if(result > 0) {
			swalIcon = "success";
			swalTitle = "게시글 삭제 성공";
			url = "redirect:../list";
		}else {
			swalIcon = "error";
			swalTitle = "게시글 삭제 실패";
			url = "redirect:" + request.getHeader("referer");
		}
		
		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
	}
	
	
	// -------------------------------------------------------------------------------------------------------------------------
	
	// 친구찾기 삭제 게시글 관리자 상세 조회 Controller
	@RequestMapping("deleteManage/{boardCode}/{boardNo}")
	public String adminView(@PathVariable("boardCode") int boardCode,
							@PathVariable("boardNo") int friendNo, Model model,
							@ModelAttribute("loginMember") Member loginMember,
							@RequestHeader(value = "referer", required = false) String referer,
							RedirectAttributes ra) {
		
		// 삭제 게시글 상세 조회
		FindFriend findFriend = service.selectDeleteBoard(friendNo);
		
		int memNo = loginMember.getMemberNo();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("friendNo", friendNo);
		map.put("memNo", memNo);
		
		// 참여신청 여부 확인
		int checkApply = service.checkApply(map);
		model.addAttribute("checkApply", checkApply);
		
		String url = null;
		
		if(findFriend != null) { // 상세 조회 성공 시
			
			List<FindFriendAttachment> attachmentList = service.selectAttachmentList(friendNo);
			
			if(attachmentList != null && !attachmentList.isEmpty()) {
				model.addAttribute("attachmentList", attachmentList);
			}
			
			model.addAttribute("findFriend", findFriend);
			url = "findFriend/findFriendView"; 
			
		}else {
			
			if(referer == null) { // 이전 요청 주소가 없는 경우
				url = "${contextPath}/admin/boardManage";
			}else { // 이전 요청 주소가 있는 경우
				url = "redirect:" + referer;
			}
			
			ra.addFlashAttribute("swalIcon", "error");
			ra.addFlashAttribute("swalTitle", "존재하지 않는 게시글입니다.");
			
		}
		
		return url;
	}
	
}
