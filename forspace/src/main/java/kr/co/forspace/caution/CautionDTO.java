package kr.co.forspace.caution;

import java.util.Date;

import kr.co.forspace.member.MemberDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CautionDTO {

	private Integer caNo;
	private String meEmail;
	private Date caStart;
	private Date caClose;
	private String caReason;
	private String caReg;
	
	private String meName;
	private String meNo;
	
	private String caStartStr;
	private String caCloseStr;
	private String result;
}
