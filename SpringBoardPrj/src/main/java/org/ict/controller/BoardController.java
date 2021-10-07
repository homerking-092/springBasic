package org.ict.controller;

import java.util.List;

import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;
import org.ict.domain.PageDTO;
import org.ict.domain.SearchCriteria;
import org.ict.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller			// 의존성 - 컨트롤러이므로 컨트롤러로 빈컨테이너에 컴포넌트 스캔
@Log4j				// 로깅기능 
@RequestMapping("/board/*")	// 클래스 위에 작성시 이 클래스를 사용하는 모든 메서드의 연결주소 앞에 /board/ 추가
@AllArgsConstructor	// 의존성 주입 설정을 위해 생성자만 생성
public class BoardController {
	
	// 컨트롤러는 서비스를 호출합니다 / 서비스는 매퍼를 호출합니다
	@Autowired
	private BoardService service;
	
	/*
	@GetMapping("/list")	// GET방식으로만 주소연결
	public void list(Model model, String keyword) {
		if (keyword == null) {
			// keyword를 수정해주면 ㅇㅇ
			keyword = "";
		}
		log.info("list로직 접속");
		// 전체 글 정보를 얻어와서
		List<BoardVO> boardList = service.getList(keyword);
		// view 파일에 list라는 이름으로 넘겨주기
		model.addAttribute("list", boardList);
		model.addAttribute("keyword", keyword);
	}
	*/
	
	// 페이징 처리가 되는 리스트 메서드를 새로 연결합니다
	// 페이징 처리용 메서드는 기존과 접속주소는 같으나
	// 기존에 반던 자료에 더해서, Criteria를 추가로 더 입력받습니다
	@GetMapping("/list")
	// Criteria를 파라미터에 선언해 pageNum, amount 처리
	public void list(Model model, SearchCriteria cri) {
		log.info("list 로직");
		log.info("한글 키워드 확인 : " + cri);
		
		
		// pageNum, amount로 전달된 자료를 활용해 게시글 목록을 가져오기
		List<BoardVO> paging = service.getListPaging(cri);
		
		
		// 페이지 정보를 얻기 이전에 전체 글 갯수를 가져옴
		int total = service.boardCount(cri);
		
		// 페이지 밑에 깔아줄 페이징버튼 관련 정보 생성
		// 단순히 페이지버튼 깔리는지 여부를 테스트할 때는
		// 우선 글 갯수를 정확하게 모르기 때문에 253개를 임의로 넣고
		// 까는 버튼 갯수는 최대 10개로 고정
		// 1. mapper 내부에 전체 글 개수를 가져오는 로직 추가
		// 2. 전체 글 개수를 얻어와서 현재 PageDTO의 총 글 갯수 위치에
		// DB에서 그떄그때 조회해 온 총글 갯수를 넣도록 코드 추정
		PageDTO btnMaker = new PageDTO(cri, total, 10);
		
//		Long replycnt = service.
		
		model.addAttribute("list", paging);
		// 버튼 정보도 같이 넘겨줌
		// btnMaker를 넘기면 동시에 SearchVriteria도 같이 넘어감
		// 
		model.addAttribute("btnMaker", btnMaker);
		
		// board/list.jsp로 자동연결이 되므로
		// 리턴구문은 필요없습니다
	}
	
	// 아래 주소로 데이터를 보내줄 수 있는 form을 작성
	// 파일명 register.jsp
	//@GetMapping으로 register.jsp에 접근할 수 있는 컨트롤러 메서드도 작성
	@PostMapping("/register")	// post방식으로만 접속 허용
	public String register(BoardVO vo, RedirectAttributes rttr) {
		// 글을 썼으면 상세페이지나 혹은 글목록으로 이동시켜야 합니다
		// 1. 글 쓰는 로직 실행후
		service.register(vo);
		log.info("insertSelectKey 확인: " + vo);
		// 2. list 주소로 강제로 이동을 시킵니다
		// 이동을 시킬때 몇번 글을 썻는지 안내해주는 로직을 추가합니다
		// addFlashAttribute는 redirect 시에 컨트롤러에서
		// .jsp 파일로 데이터를 보내줄 떄 사용합니다
		// model.addAttribute()를 쓴다면
		// 일반 이동이 아닌 redirect 이동시는 데이터가 소실됩니다
		// 이를 막기 위해 rttr.addFlashAttribute로 대체합니다
		rttr.addFlashAttribute("bno", vo.getBno());
		rttr.addFlashAttribute("success", "register");
		
		// views 폴더 하위 board폴더의 list.jsp 출력
		// redirect로 이동시킬때는 "redirect:파일명"
		return "redirect:/board/list";
	}
	
	// get방식으로만 접속되는 /board/register
	@GetMapping("/register")
	public String register() {
		
		return "/board/register";
		
	}
	
	// 상세 페이지 조회는 Long bno에 적힌 글번호를 이용해서 합니다
	// /get을 주소로 getmapping을 사용하는 메서드 get을 만들어주세요
	// /get?파라미터명=글번호 형식으로 가져옵니다(get방식이므로)
	// service에서 get()을 호출해 가져온 글 하나의 정보를
	// get.jsp로 보내줍니다
	// get.jsp에는 글 본문을 포함한 정보를 조회할 수 있도록 ㄱ
	@GetMapping("/get")
	public String get(Long bno, Model model, SearchCriteria cri) {		//s SearchCriteria는 db 관련 X
		// 모든 로직 실행 전 bno가 null로 들어오는 경우
		if (bno == null) {
			return "redirect:/board/list";
		}
		
		// 현재 윗라인 기준으로 글번호만 전달받은 상황임
		// 번호를 이용해 전체 글 정보를 받아오는게 우선 진행할 사항임
		// bno번 글의 전체 정보를 vo에 저장
		BoardVO vo = service.get(bno);
		
		// .jsp 파일로 vo를 보내기 위해
		model.addAttribute("get", vo);
		
//		model.addAttribute("cri", cri);
		
		// board 폴더의 get.jsp로 연결
		return "/board/get";
		
	}
	
	// get 방식으로 삭제를 허용하면 매크로 등을 이용해서
	// 마음대로 글삭제를 하는 경우가 생길수 있으므로
	// 무조건 삭제 버튼을 클릭해서 삭제할 수 있도록
	// post방식 접근만 허용
	// bno를 받아서 삭제하고, 삭제 후에는 "success"라는 문자열을
	// .jsp로 보내줍니다
	// 삭제가 완료되면 redirect 기능을 이용해 list페이지로 넘어가게
	// 코드 및 파라미터를 내부에 작성 ㄱㄱ
	@PostMapping("/remove")
	public String remove(Long bno, RedirectAttributes rttr) {
		log.info("삭제 로직: " + bno);
		service.remove(bno);
		rttr.addFlashAttribute("success", "delete");	// success라는 왼쪽 문자열 변수에 오른쪽 success 문자열에 담아 ㅍㅇㄷ
		
		// X번 글이 삭제되었습니다 라고 메세지를 띄우도록
		// bno 정보를 list.jsp에 같이 넘겨주시고 메세지도 수정
		rttr.addFlashAttribute("bno", bno);
		
		return "redirect:/board/list";
	}
	
	// 수정로직도 post방식으로 진행해야 합니다
	// /modify를 주소로 하고, 사용자가 수정할 수 있는 요소들을
	// BoardVO로 받아서 수정한 다음 수정한 글의 디테일페이지로 넘어오면 ok
	@PostMapping("/modify")
	// SearchType, keyword, pageNum을 컨트롤러가 받아올 수 있도록
	// 해당 이름의 멤버변수를 가진 SearchCriteria를 파라미터 선언
	public String modify(BoardVO vo, RedirectAttributes rttr, SearchCriteria cri) {
		log.info("수정로직입니다: " + vo);
		log.info("키워드: " + cri.getKeyword());
		log.info("검색조건: " + cri.getSearchType());
		log.info("페이지번호: " + cri.getPageNum());
		service.modify(vo);
		
		// rttr.addAttribute("파라미터명", "전달자료")
		// 는 호출되면 redirect 주소 뒤에 파라미터를 붙여줍니다
		// rttr.addFlashAttribute()는 넘어간 페이지에서 파라미터를
		// 쓸 수 있도록 전달하는 것으로 둘의 역할이 다르니 주의
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		// 상세 페이지는 bno가 파라미터로 주어져야 하기 때문에
		// 아래와 같이 리턴구문을 작성해야 합니다
		return "redirect:/board/get";
	}
	
	// 글을 수정할때는 modify.jsp를 이용해 수정을 해야합니다
	// PostMapping을 이용해서 /boardmodify로 접속시 수정폼으로 접근시켜주세연
	// 수정 폼은 register.jsp와 비슷한 양식으로 작성되어 있지만
	// 해당 글이 몇 번인지에 대한 정보도 화면에 표출시켜야 하고
	// 글쓴이는 readonly를 걸어서 수정 불가하게 만들어주세요
	// 아래 메서드를 수정 폼으로 접근하도록 만들고
	// 수정 폼에는 내가 수정하고자 하는 글의 정보를 먼저 받아온 다음
	// model.addAttribute로 정보를 .jsp로 보내서 폼을 채워주면 됩니다
	@PostMapping("/boardmodify")
	public String modifyForm(Long bno, Model model) {
		
		// 아무 글 번호나 하나를 입력해서 해당 글 정보를 얻어오는 로직
		BoardVO vo = service.get(bno);
		log.info(vo);
		
		// vo를 modify.jsp로 전달하고 modify.jsp에서 전달여부도 확인
		model.addAttribute("vo", vo);
		
		
		// board폴더 하위의 modify.jsp 파일로 연결
		return "/board/modify";
	}
	
	
	
	
	
	
}//end class
