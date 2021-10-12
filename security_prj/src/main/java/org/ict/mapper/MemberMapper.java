package org.ict.mapper;

import org.ict.domain.AuthVO;
import org.ict.domain.MemberVO;

public interface MemberMapper {

	public MemberVO read(String userid);
	
	public void userJoin(MemberVO vo);
	public void insertAuth(AuthVO vo);
	
}
