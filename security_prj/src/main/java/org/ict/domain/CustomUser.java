package org.ict.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User {
	
	private static final long serialVersionUID = 1;
	
	// MemberVO 자리에 다른 테이블 구조에 맞춘 VO를 넣어주기만 하면 됨
	private MemberVO member;

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> auth) {
		super(username, password, auth);
	}
	
	public CustomUser(MemberVO vo) {
		super(vo.getUserid(), vo.getUserpw(), 
				vo.getAuthList().stream().map(author ->
				new SimpleGrantedAuthority(author.getAuth())) 
				.collect(Collectors.toList()));
		
		this.member = vo;
	}
}
