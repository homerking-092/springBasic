package org.ict.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
// controller 호출시 둘다 포함시켜야함
@ContextConfiguration(
		{"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		 "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"}
		)
@Log4j
@WebAppConfiguration	// 웹사이트 모의접속용 어노테이션
public class BoardControllerTests {
	
	// 아래 나오는 MockMvc를 만들기 위해 생성하는 객체
	@Autowired
	private WebApplicationContext ctx;
	
	// 브라우저 없이 모의로 접속하는 기능을 가진 객체
	private MockMvc mockMvc;
	
	// @Test 이전에 실행할 내용을 기술하는 어노테이션
	// org.junit.Before로 임포트
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
//	@Test
	public void testList() throws Exception {
		log.info(
				// .get(접속주소) / .post(접속주소)를 제외한 나머지는
				// 고정된 양식을 가진 코드이므로 복잡해 보이지만 실제로는 복붙해도 상관없다
				// .get(접속주소)를 입력하면 get방식으로 해당 주소에 접속합니다
				// /board/list에 접속하면 글 목록 가져오기 페이지이기 때문에
				// 글 전체 목록을 가져오는지 여부를 테스트해야 합니다
				mockMvc.perform(
					MockMvcRequestBuilders.get("/board/list"))
					.andReturn()
					.getModelAndView()
					.getModelMap()
					);
	}
	
	// /board/register 주소로 파라미터값을 post방식으로 넘겼을때
	// 글이 써지는지 안 써지는지 테스트
//	@Test
	public void testRegister() throws Exception {
		
		// 아래 코드는 post 방식으로 파라미터 2개를 주소에 전달해주는 코드입니다
		// 결과 메세지는 문자열 resultPage에 저장해두고
		String resultPage = mockMvc.perform(
				MockMvcRequestBuilders.post("/board/register")
				.param("title", "제목이야")
				.param("content", "본문이야")
				.param("writer", "글쓴이야")
				).andReturn().getModelAndView().getViewName();
		
		// 변수에 저장된 값을 다시 로길을 해서 출력합니다
		log.info(resultPage);
	}// end testRegister()
	
	// .param("bno", "글번호")로 파라미터를 줬을때
	// 해당 글이 잘 얻어와지는지 체크
	// 참고로 .param()으로 전달하는 자료는 자료형을 막론하고 무조건
	// ""로 감싸서 문자화 시켜야하는데 이유는
	// url에는 자료형 구분이 없고 오직 String뿐이기 떄문입니다
//	@Test
	public void testGet() throws Exception {
		String resultGet = mockMvc.perform(
				MockMvcRequestBuilders.get("/board/get")
				.param("bno", "2")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultGet);
	}
	
//	@Test
	public void testDelete() throws Exception {
		String resultDelete = mockMvc.perform(
				MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "7")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultDelete);
	}
	
//	@Test
	public void testModify() throws Exception {
		
		// 실제로 실행될 쿼리문과 비교해서 데이터를 날려주면 됩니다
		// 현재 수정로직은 bno를 WHERE절의 조건으로,
		// title, content, writer를 수정내역으로 받으니
		// 파라미터도 위 4개 항목을 전달해줍니다
		String restultModify = mockMvc.perform(
				MockMvcRequestBuilders.post("/board/modify")
				.param("title", "수정제목")
				.param("content", "수정내용")
				.param("writer", "수정글쓴이")
				.param("bno", "11")
				).andReturn().getModelAndView().getViewName();
		
		// 변수에 저장된 값을 다시 로깅해서 출력
		log.info(restultModify);
		
	}

	@Test
	public void testGetListPaging() throws Exception {
		
		// get 방식 접속
		// .param을 이용해 creteria 관련정보 전달
		String resultPaging = mockMvc.perform(
				MockMvcRequestBuilders.get("/board/list")
				.param("pageNum", "10")
				.param("amount", "20")
				).andReturn().getModelAndView().getViewName();
				
		log.info(resultPaging);
		
	}
	
	
	
	
	
	
	
	
}
