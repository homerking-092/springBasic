package com.ict.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.mapper.Sample1Mapper;
import com.ict.mapper.Sample2Mapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SampleTxServiceImpl implements SampleTxService {
	
	@Autowired
	private Sample1Mapper mapper1;
	
	@Autowired
	private Sample2Mapper mapper2;

	@Transactional	// 이걸 붙이면 메서드 내 모든 쿼리문이 처리되었을때만 최종 처리
	@Override
	public void addData(String value) {
		
		log.info("mapper1.........");
		mapper1.insertCol1(value);
		
		log.info("mapper2.........");
		mapper2.insertCol2(value);
	}

}
