package org.ict.service;

import java.util.List;

import org.ict.domain.ReplyVO;
import org.ict.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper mapper;

	@Override
	public List<ReplyVO> listReply(Long bno) {
		log.info("댓글 조회");
		return mapper.getList(bno);
	}

	@Override
	public void addReply(ReplyVO vo) {
		log.info("댓글 생성");
		mapper.create(vo);
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		log.info("댓글 수정");
		mapper.update(vo);
	}

	@Override
	public void removeReply(Long rno) {
		log.info("댓글 삭제");
		mapper.delete(rno);
	}
}
