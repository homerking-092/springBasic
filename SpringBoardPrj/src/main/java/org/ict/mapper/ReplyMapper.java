package org.ict.mapper;

import java.util.List;

import org.ict.domain.ReplyVO;

public interface ReplyMapper {

	// 특정 게시판 bno글의 전체 댓글 목록 가져오기
	public List<ReplyVO> getList(Long bno);
	
	// 특정 게임정보의 전체 태그 가져오기
//	public list<tagvo> fdsfdsf(long gnum)
	
	public void create(ReplyVO vo);
	
	public void update(ReplyVO vo);
	
	// rno로 삭제하는 로직은 그대로 두고(리플 하나만 삭제되는 케이스)
	public void delete(Long rno);
	
	//새로 bno로 삭제하는 로직(글 삭제시 삭제글번호에 딸린 리플 몇개건 다 삭제하는 케이스) 를 추가해주셔야 하는거빈다. 쟤는 건들면 안되어요.넵
	public void allDelete(Long bno);
	
	// 댓글번호로 글번호 유추하는 로직
	public Long getBno(Long rno);
}
