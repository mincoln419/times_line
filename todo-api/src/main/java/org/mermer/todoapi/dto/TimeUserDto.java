package org.mermer.todoapi.dto;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class TimeUserDto {

	private String id;
	private String userName;
	private String password;
	private String email;
	private String ci;
	private String cd;
	private String hp;
}
