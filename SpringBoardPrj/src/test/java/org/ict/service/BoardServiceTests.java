package org.ict.service;

import static org.junit.Assert.assertNotNull;

import org.ict.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

// Service 테스트는 BoardServiceImpl 내부 기능을 
// 서버 가동 없이 테스트하기 위해 작성
// 아래에 기본 세팅 ㄱㄱ
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	// 다형성 원리에 의해서 BoardService로 만들어도
	// BoardServiceImpl이 주입됨
	@Autowired
	private BoardService service;
	
	// 서비스가 제대로 주입되었는지 여부 확인
//	@Test
	public void testExist() {
		log.info(service);
		
		// assertNotNull은 해당 객체가 주입이 되지 않아
		// null인 경우 에러를 발생시킵니다
		/// 테스트시 null인 경우 fail, null 아닌 경우 success
		assertNotNull(service);
	
	}
//	@Test
	public void testRegister() {
		// register 로직이 BoardVO를 필요로 하므로
		// 먼저 vo부터 생성해서 자료 입력 후 전달함
		BoardVO vo = new BoardVO();
		vo.setContent("qwer");
		vo.setTitle("qwer");
		vo.setWriter("qwer");
		
		service.register(vo);
		
	}
	
//	@Test
	public void testGetList() {
		service.getList();
	}
	
//	@Test
	public void testSelect() {
		service.get(7L);
	}
//	@Test
	public void testDelete() {
		service.remove(1L);
	}
	@Test
	public void testUpdate() {
		// 수정로직은 수정사항 정보를 BoardVO에 담아서
		// 전달하기 때문에 BoardVo를 만들어놓고 자료를 저장한 뒤 실행
		BoardVO vo = new BoardVO();
		vo.setContent("modify");
		vo.setTitle("modify");
		vo.setWriter("modify");
		vo.setBno(2L);
		service.modify(vo);
		
		
	}
		
		
}
