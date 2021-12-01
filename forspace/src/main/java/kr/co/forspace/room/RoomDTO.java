package kr.co.forspace.room;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RoomDTO {

	private Integer roNo;
	private Integer scNo;
	private String roName;
	private Integer roFloor;
	private Integer roMax;
	private String roStart;
	private String roClose;
	private Integer roLimit;
	private Date roRegdate;
	private Integer roLikecnt;
	
	private int myLike;
	private LikeItDTO likeDTO;
}
