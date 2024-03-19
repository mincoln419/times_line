package org.mermer.todoapi.dto;

public enum TodoTaskStatus {
	NOT_YET("not_yet"),
	MATCHED("matched"),
	UNMATCHED("unmatched");

	private String value;
	TodoTaskStatus(String value){
		this.value = value;
	}

	public String value() {
		return this.value;
	}
}
