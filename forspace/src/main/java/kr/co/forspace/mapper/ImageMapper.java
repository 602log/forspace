package kr.co.forspace.mapper;

import kr.co.forspace.image.ImageDTO;

public interface ImageMapper {

	void memberjoinWithprofileImg(ImageDTO imageDTO);
	
	void updateProfileImg(ImageDTO imageDTO);
	
	int selectMyImg(String imEmail);
	
	ImageDTO myImg(String imEmail);
}
