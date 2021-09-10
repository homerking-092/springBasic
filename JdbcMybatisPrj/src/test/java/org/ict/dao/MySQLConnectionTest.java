package org.ict.dao;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class MySQLConnectionTest {
	
	// 커넥터 설정 완료
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 테스트 코드를 실행하면 @Test가 붙은 메서드만 실행합니다
	@Test
	public void testConnection() {
		try(Connection con = 
				DriverManager.getConnection(
						"jdbc:mysql://127.0.0.1:3306/mysql?useSSL=false&serverTimezone=UTC",
						"root",	// 계정
						"mysql"	// 비밀번호
						)){
			log.info(con);
			log.info("MySQL 연결 완료");
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
	
	@Test
	public void testConnection2() {
		log.info("이 코드는 실행되지 않아연");
	}

}// end class
