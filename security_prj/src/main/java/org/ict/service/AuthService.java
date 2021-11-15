package org.ict.service;

import org.ict.domain.AuthVO;

public interface AuthService {

	public void insertAuth(AuthVO vo);
	
	public void read(AuthVO vo);
}
