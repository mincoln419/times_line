package org.mermer.todoapi.entity;


import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SignInHistory {

	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE)
	@Column(name = "sign_in_history_id")
	private String id;
	@ManyToOne
	@JoinColumn(name = "user_id")
	private TimeUser timeUser;
	private LocalDateTime signInAt;

}
