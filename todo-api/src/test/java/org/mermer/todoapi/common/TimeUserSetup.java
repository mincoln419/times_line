package org.mermer.todoapi.common;

import jakarta.annotation.Resource;
import org.mermer.todoapi.dto.TimeUserDto;
import org.mermer.todoapi.entity.TimeUser;
import org.mermer.todoapi.repository.TimeUserRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class TimeUserSetup {
	@Resource
	private TimeUserRepository userRepository;

	private static String userId = "stenly";
	@Bean
	public TimeUser getTimeUser(){
		return userRepository.save(TimeUser.registerTimeUser(TimeUserDto.builder()
				.id(userId)
				.password("123456789")
				.userName("Stenly Cho")
				.hp("010-8013-9018")
				.email("mincoln419@naver.com")
				.di(UUID.randomUUID().toString())
				.ci(UUID.randomUUID().toString())
				.build()));
//		return userRepository.findById(userId)
//				.orElseThrow(() -> new RuntimeException("User not found"));
	}
}
