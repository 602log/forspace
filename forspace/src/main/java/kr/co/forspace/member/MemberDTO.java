package kr.co.forspace.member;

import java.io.Serializable;

import kr.co.forspace.image.ImageDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO{

	private String meEmail;
	private Integer scNo;
	private String meNo;
	private String meName;
	private String mePwd;
	private String meRole;

	private ImageDTO imageDTO;

}
