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

	private int imNo;
	private String imUuid;
	private String imEmail;
	private String imName;
	private String imDir;
	private Long imSize;

	public String getImagePath() throws Exception {
		return imDir + "/" + imUuid + imName.substring(imName.lastIndexOf("."));
	}
}
