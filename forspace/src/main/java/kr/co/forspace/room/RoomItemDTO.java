package kr.co.forspace.room;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RoomItemDTO {
	private Integer riNo;
	private Integer roNo;
	private Integer itNo;
	private Integer riCnt;
	
	private ItemDTO itemDTO;
}
