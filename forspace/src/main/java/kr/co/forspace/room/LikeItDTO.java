package kr.co.forspace.room;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LikeItDTO {
	private Integer liNo;
	private String meEmail;
	private Integer roNo;
}
