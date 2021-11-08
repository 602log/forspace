package kr.co.forspace.image;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.forspace.mapper.ImageMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class ImageServiceImpl implements ImageService{
	
	private final ImageMapper imageMapper;
	
	
	@Override 
	public int selectMyImg(String imEmail) { 
		return imageMapper.selectMyImg(imEmail); 
	
	}
	
	
	@Override
	public ImageDTO myImg(String imEmail) {
		log.info("myImg>>imEamil>>"+imEmail);
		return imageMapper.myImg(imEmail);
	}
}
