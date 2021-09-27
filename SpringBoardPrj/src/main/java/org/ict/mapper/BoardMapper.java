package org.ict.mapper;

import java.util.List;

//import org.apache.ibatis.annotations.Select;
import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;

public interface BoardMapper {
	
	// board_tbl에서 글번호 3번 이하만 조회하는 쿼리문을
	// 어노테이션을 이용해 작성
//	@Select("SELECT * FROM board_tbl WHERE bno <= 3")
	
	public List<BoardVO> getList(String keyword);
	
	// insert 구문 실행용으로 메서드 선언
	// VO내부에 적혀있는 정보를 이용해 insert를 합니다
	// BoardVO를 매개로 insert 정보를 전달받음
	public void insert(BoardVO vo);
	
	// insertSelectKey를 메퍼, 서비스, 컨트롤러에 적용
	public void insertSelectKey(BoardVO vo);
	
	// 글 번호(Long bno)를 파라미터로 받아
	// 해당 글 번호에 해당하는 글을 리턴해 보여주는 메서드를 작성
	// 메서드 이름은 select
	// xml 파일에 쿼리문도 작성 ㄱㄱ
	public BoardVO select(Long bno);
	
	// 글 번호(Long bno)를 파아미터로 받아
	// 해당 글 번호에 해당하는 글을 삭제해주는 메서드를 작성
	// 메서드 이름은 delete
	// xml 마핑레 쿼리문도 작성하고 테스트코드까지 만ㄷ르어 실제로 삭제 되는지 sqldeveloper로 확인 ㄱㄱ
	public void delete(Long bno);
	
	// 글 수정 로직
	// BoardVO를 받아서 수정해줍니다
	// 바꿀 내역은 title, content, writer는 BoardVO에서 받아서
	// updatedate는 sysdate로 where 구문은 bno로 구분해서 처리
	// 수정로직을 작성하고 테스트까지 ㄱㄱ
	public void update(BoardVO vo);
	
	// 페이징 처리를 하면서 조회할 것이기 때문에
	// Criteria 정보를 파라미터로 제공해야
	// 몇 페이지의 글을 조회할지 정보를 같이 쿼리문에 전송할 수 있습니다
	public List<BoardVO> getListPaging(Criteria cri);
	
	public int boardCount();
	
	
	
}
