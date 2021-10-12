package org.ict.service;

import org.ict.domain.AuthVO;
import org.ict.mapper.AuthMapper;
import org.springframework.beans.factory.annotation.Autowired;

public class AuthServiceImpl implements AuthService {
	
	@Autowired
	private AuthMapper mapper;

	@Override
	public void insertAuth(AuthVO vo) {
		
		mapper.insertAuth(vo);
		
	}

}
