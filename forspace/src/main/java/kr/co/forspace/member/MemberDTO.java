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
public class MemberDTO implements Serializable{

	private String meEmail;
	private Long scNo;
	private String meNo;
	private String meName;
	private String mePwd;
	private String meRole;

	private ImageDTO imageDTO;

}
