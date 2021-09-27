package org.ict.domain;

import lombok.Getter;
import lombok.ToString;

// DTO는 Data Transfer Object로 데이터 전달 객체라고 합니다
// DTO나 VO나 엄격하게 구분되는 것은 아니고 둘 다 특정 데이터를
// 한 변수에 묶어서 보내기 위해 사용합니다
// 차이점이 있다면 VO는 DB에서 바로 꺼낸 데이터를 매칭시키고
// DTO는 DB에 있는 정보를 토개로 가공한 데이터를 전달할때 
// 사용한다는 차이가 있습니다

@Getter
@ToString
public class PageDTO {

	// 페이지네이션 버튼을 몇 개 깔지
	private int btnNum;

	// 페이지 세트 중 시작하는 페이지
	// 16페이지 조회중이라면 11이 시작페이지
	private int startPage;

	// 페이지 세트 중 끝나는 페이지
	// 16페이지 조회중이라면 20이 끝페이지
	private int endPage;

	// 이전, 이후 10개 페이지 버튼 유무여부
	private boolean prev, next;

	// 전체 데이터 개수
	private int total;

	// 페이지, 글 정보
	private Criteria cri;

	// 위의 변수 정보들을 자동으로 계산하게 하기 위한 생성자
	public PageDTO(Criteria cri, int total, int btnNum) { // 생성자
		this.cri = cri;
		this.total = total;
		this.btnNum = btnNum;

		// 위에서 저장된 멤버변수를 이용해 나머지 정보 구하기

		// 끝페이지 공식
		// 현재 보고있는 페이지를 (실수인) btnNum으로 나눴다가
		// 다시 곱한 결과물에 올림을 하고 btnNum을 다시 곱해 자릿수를 원상복구 시킵니다 /// Math.ceil함수 -- 올림
		this.endPage = (int) (Math.ceil(cri.getPageNum() / (double) this.btnNum) * this.btnNum);

		// endPage를 구했으면, 그걸 토대로 startPage를 구한다
		// 다음 시작페이지는 (끝페이지 - 까는버튼수) + 1을 해서 구함
		this.startPage = this.endPage - this.btnNum + 1;
		
		// realEnd오직은 startPage를 구하고 나서 구해야함
		// startPage는 1단위로 시작을 무조건 해야하기 때문이다
		/// 전체 페이지의 갯수가 10으로 떨어지지 않을 경우	/// 10 | 1
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage == 1 ? false : true;
		
		this.next = this.endPage < realEnd;
		
	}
}// end class
