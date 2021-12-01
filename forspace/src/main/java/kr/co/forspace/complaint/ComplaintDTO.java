package kr.co.forspace.complaint;

import java.util.Date;

import kr.co.forspace.room.LikeItDTO;
import kr.co.forspace.room.RoomDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ComplaintDTO {
	private int coNo;
	private int roNo;
	private String coContent;
	private String meEmail;
	private Date coDate;
	private Date coFinish;
	
	private String roName;
}
