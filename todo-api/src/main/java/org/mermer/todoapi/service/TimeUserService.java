package org.mermer.todoapi.service;

import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.dto.TimeUserDto;
import org.mermer.todoapi.entity.TimeUser;
import org.mermer.todoapi.repository.TimeUserRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class TimeUserService {

	private final TimeUserRepository timeUserRepository;

	static LocalDateTime NOW = LocalDateTime.now();

	public TimeUserDto selectTimeUser(String userId){
		return timeUserRepository.findById(userId).orElseThrow(RuntimeException::new).parseDto();
	}

	public TimeUserDto saveTimeUser(TimeUserDto userDto){

		TimeUser parse = TimeUser.builder()
				.id(userDto.getId())
				.di(userDto.getDi())
				.ci(userDto.getCi())
				.hp(userDto.getHp())
				.email(userDto.getEmail())
				.signUpAt(NOW)
				.lastSignAt(NOW)
				.userName(userDto.getUserName())
				.build();

		return timeUserRepository.save(parse).parseDto();
	}

}
