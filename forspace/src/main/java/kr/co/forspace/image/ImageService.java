package kr.co.forspace.image;

public interface ImageService {
	
	int selectMyImg(String imEmail);
	
	ImageDTO myImg(String imEmail);

}
