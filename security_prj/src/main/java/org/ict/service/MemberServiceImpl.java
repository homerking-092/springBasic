package org.ict.service;

import org.ict.domain.MemberVO;
import org.ict.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;

public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberMapper mapper;

	@Override
	public void userJoin(MemberVO vo) {

		mapper.userJoin(vo);

	}

	@Override
	public void read(MemberVO vo) {
		// TODO Auto-generated method stub
		
	}

	

	
	

	

}
