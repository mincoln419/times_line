package org.mermer.todoapi.entity;

import org.junit.jupiter.api.Test;
import org.mermer.todoapi.util.PasswordUtil;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class TimeUserTest {


	@Test
	void setPassword() {
		String password = "1234";
		TimeUser user = TimeUser.builder().build();


	}

	@Test
	void verifyPassword() {
	}
}