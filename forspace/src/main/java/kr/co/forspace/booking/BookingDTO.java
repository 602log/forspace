package kr.co.forspace.booking;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import kr.co.forspace.room.RoomDTO;
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
	private String boTime;
	private Date boDate;
	
	private String boDateStr;
	private String boTimeStr;
	
	//private List<RoomDTO> roomList = new ArrayList<>();
	private String roName;
}
