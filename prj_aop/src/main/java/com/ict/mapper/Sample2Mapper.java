package com.ict.mapper;

import org.apache.ibatis.annotations.Insert;

public interface Sample2Mapper {

	@Insert("INSERT INTO tbl_test2 (col2) VALUES (#{data})")
	public int insertCol2(String data);
}
