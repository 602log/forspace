package kr.co.forspace.image;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ImageController {

	private static String uploadFolder = "c:/study/upload";

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

		ImageDTO imageDTO = ImageDTO.builder().imName(originalName).imPath(imageFullName).imSize(image.getSize())
				.build();

		return imageDTO;

	}

	private static String makeDirectory() throws Exception {

		String str = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
		String directory = str.replace("//", File.separator);
		log.info("파일:" + directory);
		File uploadDirectory = new File(uploadFolder, directory);
		if (uploadDirectory.exists() == false) {
			uploadDirectory.mkdirs();
		}
		return directory;
	}

}
