package org.ict.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.ict.domain.TestVO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class TestController {

	@RequestMapping("/hello")
	public String sayHello() {

		return "Hello Hello";
	}

	@RequestMapping("/sendVO")
	public TestVO sendTestVO() {
		TestVO testVO = new TestVO();

		testVO.setName("son");
		testVO.setAge(30);
		testVO.setMno(7);

		return testVO;
	}

	@RequestMapping("/sendVOList")
	public List<TestVO> sendVOList() {
		List<TestVO> list = new ArrayList<TestVO>();
		for (int i = 0; i < 10; i++) {
			TestVO vo = new TestVO();
			vo.setMno(i);
			vo.setName(i + "sony");
			vo.setAge(30 + i);
			list.add(vo);
		}
		return list;
	}
	
	@RequestMapping("/sendMap")
	public Map<Integer, TestVO> sendMap(){
		Map<Integer, TestVO> map = new HashMap<Integer, TestVO>();
		
		for (int i = 0; i < 10; i++) {
			TestVO vo = new TestVO();
			vo.setName("sony");
			vo.setMno(i);
			vo.setAge(30 + i);
			map.put(i, vo);
		}
		// map의 키값(왼쪽에 선언한 것)은 중복된 값이 등어올 수 없고
		// 들어온다면 가장 마지막에 넣은 하나만 남습니다
		TestVO vo = new TestVO();
		vo.setName("qwer");
		vo.setMno(7);
		vo.setAge(1000);
		map.put(7, vo);
		System.out.println(map);
		return map;
	}
	
	@RequestMapping("/sendErrorAuth")
	public ResponseEntity<Void> sendListAuth(){
		
		// ResponseEntity는 생성자에 HttpStatus.코드번호를 적어서
		// 해당 주소 접속시 어떤 접속코드를 사용자에게 넘겨줄지 결정할 수 있습니다
		return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST); 
	}
	
	// 데이터와 결과코드를 같이 전송
	@RequestMapping("/sendErrorNot")
	public ResponseEntity<List<TestVO>> sendListNot(){
		List<TestVO> list = new ArrayList<TestVO>();
		for (int i = 0; i < 10; i++) {
			TestVO vo = new TestVO();
			vo.setMno(i);
			vo.setName(i + "흥민");
			vo.setAge(30 + i);
			list.add(vo);
		}
		// ResponseEntity의 생성자에, 파라미터 2개를 넘기면
		// 전송할 데이터와 전송시 결과로 나올 코드를 함께 넘길수 있습니다
		return new ResponseEntity<List<TestVO>>(list, HttpStatus.NOT_FOUND);	
	}
	
	
	
	
	
	
}// end class
