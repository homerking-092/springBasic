package org.ict.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/secu/*")
public class securityController {

	@GetMapping("/all")
	public void doAll() {
		log.info("모든 사람이 접속 가능한 all 로직");
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/member")
	public void doMember() {
		log.info("회원들이 접속 가능한 member 로직");
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("운영자만 접속 가능한 admin 로직");
	}
}
