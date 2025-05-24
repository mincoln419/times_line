package org.mermer.todoapi.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;

@Data
@Builder
public class SearchCondItem {

	public LocalDate searchDate;
	public String timeUserId;
}
