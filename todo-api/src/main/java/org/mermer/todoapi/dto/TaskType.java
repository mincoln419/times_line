package org.mermer.todoapi.dto;

public enum TaskType {
	SOUL("soul"),
	PHYSICAL("physical"),
	KNOWLEDGE("knowledge"),
	SOCIAL("social"),
	ETC("etc"),
	SLEEP("sleep"),
	WASTE("waste");

	private final String value;

	private TaskType(String value){
		this.value = value;
	}

	public String value(){
		return this.value;
	}
}
