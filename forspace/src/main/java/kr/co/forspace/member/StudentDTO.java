package kr.co.forspace.member;

import kr.co.forspace.image.ImageDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class StudentDTO {
	
	private String stEmail;
	private Long scNo;
	private String stNo;
	private String stName;
	private String stPwd;
	private String stAuth;
	
	private ImageDTO imageDTO;
	
}
