package org.mermer.todoapi.dto;

import lombok.Builder;
import lombok.Data;
import org.springframework.web.bind.annotation.BindParam;

import java.time.LocalDate;

@Data
@Builder
public class SearchCond {

	public LocalDate searchDate;
	public String timeUserId;
}
