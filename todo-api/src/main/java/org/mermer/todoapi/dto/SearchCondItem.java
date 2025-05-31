package org.mermer.todoapi.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class SearchCondItem {

	public LocalDate searchDate;
	public String timeUserId;
	public Long templateId;
}
