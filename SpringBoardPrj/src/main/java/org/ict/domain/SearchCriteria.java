package org.ict.domain;

import lombok.Data;

@Data
public class SearchCriteria extends Criteria {

	private String searchType;
	//키워드 자료형이 int였스빈다. 아.. 학인했습니ㅏ...
	private String keyword;
}
