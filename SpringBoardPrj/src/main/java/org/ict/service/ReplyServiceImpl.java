package org.ict.service;

import java.util.List;

import org.ict.domain.ReplyVO;
import org.ict.mapper.BoardMapper;
import org.ict.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {

	// 서비스는 매퍼를 호출하기 떄문에 매퍼 생성
	@Autowired
	private ReplyMapper mapper;
	
	// 리플 썼을때 board_tbl도 업데이트 해야하므로 board_tbl에 접근할 수 있는
	// BoardMapper도 같이 호출할 수 있게 생성
	@Autowired BoardMapper boardMapper;

	@Override
	public List<ReplyVO> listReply(Long bno) {
		log.info("댓글 조회");
		return mapper.getList(bno);
	}

	@Transactional
	@Override
	public void addReply(ReplyVO vo) {
		log.info("댓글 생성");
		mapper.create(vo);
		// 글 쓰고 나서, board_tbl쪽에 해당 글번호에 댓글 1 증가
		boardMapper.updateReplyCount(vo.getBno(), 1L);
		
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		log.info("댓글 수정");
		mapper.update(vo);
	}

	@Transactional		// 두 메서드가 실행되야 전체 로직 실행 --- 일종의 보험역할
	@Override
	public void removeReply(Long rno) {
		log.info("댓글 삭제");
		
		// mapper.delete가 실행되는 순간, bno를 포함한 모든 rno번 로우가 날아감
		// 먼저 bno를 얻어서 저장까지 한 다음, rno번 로우 삭제를 해야 마지막 로직 실행
		Long bno = mapper.getBno(rno);			// 글 번호 얻기
		mapper.delete(rno);
		boardMapper.updateReplyCount(bno, -1L);	// replycount -1
	}
}
