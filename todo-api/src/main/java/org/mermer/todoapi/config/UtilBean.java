package org.mermer.todoapi.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

@Component
public class UtilBean {

	@Bean
	public ObjectMapper objectMapper(){
		return new ObjectMapper();
	}
}
