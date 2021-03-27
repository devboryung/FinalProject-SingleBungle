package com.gaji.SingleBungle.findFriend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaji.SingleBungle.findFriend.model.service.FindFriendService;
import com.gaji.SingleBungle.findFriend.model.vo.FindFriendChatting;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@RequestMapping("/findFriendChat/*")
public class FindFriendChatController {
	
	@Autowired
	private FindFriendService service;
	
	@RequestMapping("chatView/{friendNo}")
	public String chatView(@PathVariable int friendNo, Model model) {
		model.addAttribute("friendNo", friendNo);
		return "findFriend/chat";
	}
	
	@ResponseBody
	@RequestMapping("selectChatList/{friendNo}")
	public String selectChatList(@PathVariable("friendNo") int friendNo) {
		
		List<FindFriendChatting> cList = service.selectChatList(friendNo);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		
		return gson.toJson(cList);
	}

}
