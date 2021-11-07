package kr.co.forspace.notice;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NoticeDTO {
	
	private int noNo;
	private String meEmail;
	private int scNo;
	private String noSubject;
	private String noContent;
	private Date noDate;
	private int noCnt;
}
