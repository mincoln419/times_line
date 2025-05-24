package org.mermer.todoapi.entity;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.mermer.todoapi.dto.TimeUserDto;
import org.mermer.todoapi.util.PasswordUtil;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.UUID;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class TimeUserTest {


	private static TimeUserDto timeUserDto;

	@BeforeAll
	static void setTimeUserDto(){
		timeUserDto = TimeUserDto.builder()
				.id("stenly")
				.password("123456789")
				.userName("Stenly Cho")
				.hp("010-8013-9018")
				.email("mincoln419@naver.com")
				.cd(UUID.randomUUID().toString())
				.ci(UUID.randomUUID().toString())
				.build();
	}


	@Test
	void password_encoding_success() {

		TimeUser timeUser = TimeUser.registerTimeUser(timeUserDto);

		String encryptedPassword = timeUser.getPassword();
		String rawPassword = timeUserDto.getPassword();

		assertThat(encryptedPassword).isNotEqualTo(rawPassword);

		assertTrue(TimeUser.verifyPassword(rawPassword, encryptedPassword));

	}

}