package org.mermer.todoapi.entity;

import lombok.Getter;

@Getter
public enum ContentType {
	INTELLECTUAL("지적"),

	SPIRITUAL("영적"),

	PHYSICAL("신체적"),

	SOCIAL("사회적"),

	OTHER("기타"),

	WASTE("낭비");

	private final String message;

	ContentType(String message) {
		this.message = message;
	}

}
