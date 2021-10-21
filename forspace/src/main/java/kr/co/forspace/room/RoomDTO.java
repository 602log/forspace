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
	
    private Long roNo;
    private Long scNo;
    private String roName;
    private Integer roFloor;
    private Long roMax;
    private String roStart;
    private String roClose;
    private Long roLimit;
    private Date roRegdate;
	
}
