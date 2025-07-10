package org.mermer.todoapi.service;

import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.entity.TimeUser;
import org.mermer.todoapi.repository.TimeUserRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TimeUserService {

	private final TimeUserRepository timeUserRepository;

	public TimeUser selectTimeUser(String userId){
		return timeUserRepository.findById(userId).orElseThrow(RuntimeException::new);
	}

}
