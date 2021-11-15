package org.ict.service;

import org.ict.domain.MemberVO;

public interface MemberService {
	
	public void userJoin(MemberVO vo);
	
	public void read(MemberVO vo);

}
