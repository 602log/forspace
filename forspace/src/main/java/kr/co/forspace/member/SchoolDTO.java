package kr.co.forspace.member;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class SchoolDTO {
	private int scNo;
	private String scName;
	private String scCampus;
	private String scMajor;
	private String scChecknum;
}
