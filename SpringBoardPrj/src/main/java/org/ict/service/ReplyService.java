package org.ict.service;

import java.util.List;

import org.ict.domain.ReplyVO;

public interface ReplyService {

	public List<ReplyVO> listReply(Long bno);

	public void addReply(ReplyVO vo);

	public void modifyReply(ReplyVO vo);

	public void removeReply(Long rno);
}
