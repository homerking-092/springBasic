package org.ict.service;

import java.util.List;

import org.ict.domain.BoardAttachVO;
import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;
import org.ict.domain.SearchCriteria;
import org.ict.mapper.BoardAttachMapper;
import org.ict.mapper.BoardMapper;
import org.ict.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

// BoardServiceImpl은 BoardService 인터페이스를 구현합니다
@Log4j				// 로깅을 위한 어노테이션 (x가 뜨면  porm.xml에서 추가수정)
// 자세한 사항은 porm.xml의 log4j 참조
@Service			// 의존성 등록을 위한 어노테이션
@AllArgsConstructor	// 서비스 생성자 자동생성
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardMapper mapper;
	
	/////////
	@Autowired
	private ReplyMapper replyMapper;
	
	@Autowired
	private BoardAttachMapper attachmapper;
	
	// 등록작업시 BoardVO를 매개로 실행하기 때문에
	// 아래와 같이 BoardVO를 파라미터에 설정해둠
	// BoardServiceTests에 VO를 생성해 테스트 ㄱㄱ
	
	@Transactional
	@Override
	public void register(BoardVO vo) {
		log.info("등록작업 실행");
		// mapper.insert(vo); 에서 bno를 얻기위해 변경
		mapper.insertSelectKey(vo);
		
		// 첨부파일이 존재하지 않는다면
		if (vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return;
		}
		vo.getAttachList().forEach(attach ->{
			// 첨부파일이 위치할 글 번호를 입력해준 다음
			attach.setBno(vo.getBno());
			// DB에 첨부파일 관련 정보 입력
			attachmapper.insert(attach);
			
		});
	}

	// 전체 글을 다 가져오는게 아닌 특정 글 하나만 가져오는 로직
	// 완성 및 테스트 ㄱㄱ
	@Override
	public BoardVO get(Long bno) {
		BoardVO getBno = mapper.select(bno);
		log.info(bno + "번 글 조회");
		return getBno;
	}

	@Override
	public void modify(BoardVO vo) {
		mapper.update(vo);
	}

	@Transactional
	@Override
	public void remove(Long bno) {
		//////////////////////////////// 글 삭제시 리플도 같이 삭제
		replyMapper.allDelete(bno);
		mapper.delete(bno);
	}

	// 글 전체 목록을 가져오는 로직을 작성
	// 해당 로직은 mapper 내부의 getList의 쿼리문을 먼저
	// 전체 글을 가져오는 로직으로 수정한 후 service에
	// 등록해서 구현 및 테스트 ㄱㄱ
	@Override
	public List<BoardVO> getList(String keyword) {
		List<BoardVO> boardList = mapper.getList(keyword);
		log.info("전체 글 목록 조회");
		return boardList;
//		 return mapper.getList();
		
	}

	@Override
	public void insertSelectKey(BoardVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<BoardVO> getListPaging(SearchCriteria cri) {
		
		// cri정보(pageNum, amount)를 받아오면
		// 그걸 이용해서 mapper쪽의 getListPaging 호출후
		// 나온 결과물을 리턴해서 컨트롤러에서 쓸 수 있도록 처리
		List<BoardVO> listPaging = mapper.getListPaging(cri);
		return listPaging;
	}

	@Override
	public int boardCount(SearchCriteria cri) {
		return mapper.boardCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach List: " + bno);
		return attachmapper.findByBno(bno);
	}

}
