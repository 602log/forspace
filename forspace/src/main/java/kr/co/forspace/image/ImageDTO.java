package kr.co.forspace.image;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ImageDTO {

	private Integer imNo;
	private String imEmail;
	private String imName;
	private String imPath;
	private Long imSize;

}
