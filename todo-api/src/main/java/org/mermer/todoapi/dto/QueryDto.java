package org.mermer.todoapi.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;

@Data
@AllArgsConstructor
public class QueryDto {

	private LocalDate targetDate;

}
