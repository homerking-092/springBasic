package org.ict.mapper;

import org.ict.domain.AuthVO;

public interface AuthMapper {

	public void insertAuth(AuthVO vo);
	
	public void read(AuthVO vo);
}
