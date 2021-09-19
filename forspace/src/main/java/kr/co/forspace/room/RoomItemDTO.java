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
    private Long riNo;
    private Long roNo;
    private Long itNo;
    private Long riCnt;
}
