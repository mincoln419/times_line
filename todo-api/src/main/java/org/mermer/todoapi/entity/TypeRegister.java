package org.mermer.todoapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TypeRegister {

	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE)
	@Column(name = "type_id")
	private Long id;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private TimeUser timeUser;

	private String typeName;

}
