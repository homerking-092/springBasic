package org.ict.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("접근 거부: " + auth);
		
		model.addAttribute("errorMessage", "접근 거부");
	}
	
	@GetMapping("/customLogin")		// 로그인창으로 넘겨주는 로직
	public void loginInput(String error, String logout, Model model) {
		log.info("error 여부: " + error);
		log.info("logout 여부: " + logout);
		
		if (error != null) {
			model.addAttribute("error", "로그인 관련 에러입니다. 계정을 다시 확인해 주세요");
		}
		if (logout != null) {
			model.addAttribute("logout", "로그아웃 했습니다");
		}
	}
	
	@GetMapping("/customLogout")
	public void logoutget() {
		log.info("로그아웃 폼으로 이동");
	}
	
	@PostMapping("/customLogout")
	public void logoutPost() {
		log.info("포스트방식으로 로그아웃요청 처리");
	}
	
}// end class
