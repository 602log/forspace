package kr.co.forspace.image;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/image")
public class ImageController {

	private static String uploadFolder = "c:/study/upload";
	
	@ResponseBody
	@GetMapping("/show")
    public ResponseEntity<byte[]> showImage(String imagePath) throws Exception{
    	 
        File file = new File(uploadFolder + File.separator + imagePath);
        HttpHeaders header = new HttpHeaders();
        header.add("Content-Type", Files.probeContentType(file.toPath()));
       
        return new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);     
   } 

	public static ImageDTO uploadImage(MultipartFile image) throws Exception {
		if (!(image.getContentType().startsWith("image"))) {// 이미지 파일이 아닐때
			return null;
		}

		String originalName = image.getOriginalFilename();
		String ext = originalName.substring(originalName.lastIndexOf("."));
		String uuid = UUID.randomUUID().toString();
		String dir = makeDirectory();
		String imageFullName = uploadFolder + File.separator + dir + File.separator + uuid + ext;

		Path saveImage = Paths.get(imageFullName);
		image.transferTo(saveImage);

		ImageDTO imageDTO = ImageDTO.builder()
				.imUuid(uuid)
				.imName(originalName)
				.imDir(dir)
				.imSize(image.getSize())
				.build();

		return imageDTO;

	}

	private static String makeDirectory() throws Exception {

		String str = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
		String directory = str.replace("//", File.separator);
		log.info("파일:" + directory);
		File uploadDirectory = new File(uploadFolder, directory);
		
		log.info("uploadDirectory : "+uploadDirectory);
		
		if (uploadDirectory.exists() == false) {
			uploadDirectory.mkdirs();
		}

		return directory;
	}

}
