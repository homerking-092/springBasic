package org.ict.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardVO {
	
	private Long rn;
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;		// 시간은 Date 타입 
	private Date updatedate;	// jsva.sql 내부 자료
}
