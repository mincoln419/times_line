package org.mermer.todoapi.controller;

import lombok.RequiredArgsConstructor;
import org.mermer.todoapi.dto.TimeUserDto;
import org.mermer.todoapi.service.TimeUserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/user")
public class TimeLineUserController {

	private final TimeUserService timeUserService;

	@PostMapping
	public ResponseEntity<TimeUserDto> createTimeUser(@RequestBody TimeUserDto timeUserDto){

		TimeUserDto result = timeUserService.saveTimeUser(timeUserDto);
		return ResponseEntity
				.status(200)
				.body(result);
	}

	@GetMapping("/{id}")
	public ResponseEntity<TimeUserDto> selectTimeUser(@PathVariable("id") String id){
		TimeUserDto result = timeUserService.selectTimeUser(id);
		return ResponseEntity
				.status(200)
				.body(result);
	}
}
