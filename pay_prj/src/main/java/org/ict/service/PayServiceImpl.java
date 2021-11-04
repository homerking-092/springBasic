package org.ict.service;

import org.ict.domain.PayVO;
import org.ict.mapper.PayMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PayServiceImpl implements PayService {

	@Autowired
	private PayMapper mapper;

	@Override
	public void insertPay(PayVO vo) {
		System.out.println("결제 정보 추가");
		mapper.insertPay(vo);

	}

}
