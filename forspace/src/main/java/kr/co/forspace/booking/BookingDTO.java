package kr.co.forspace.booking;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BookingDTO {
	private int boNo;
	private int scNo;
	private String meEmail;
	private int roNo;
	private Date boDate;
	private String boStart;
	private String boEnd;
}
