package org.mermer.todoapi.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TimeUser {

	@Id
	@Column(name = "user_id")
	public String id;
	public String userName;
	public String email;
	public String password;
	public String ci;
	public String cd;

}
