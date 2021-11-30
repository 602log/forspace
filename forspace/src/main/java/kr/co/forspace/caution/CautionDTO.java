package kr.co.forspace.caution;

import java.util.Date;

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
}
