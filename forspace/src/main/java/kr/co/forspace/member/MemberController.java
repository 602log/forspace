package kr.co.forspace.member;

import java.util.List;
import java.util.Random;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.forspace.image.ImageController;
import kr.co.forspace.image.ImageDTO;
import kr.co.forspace.image.ImageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@Log4j
@RequestMapping("/member")
public class MemberController {

	private final MemberService memberService;
	private final PasswordEncoder passwordEncoder;
	private final ImageService imageService;
	
	@ResponseBody
	@PostMapping("/findMember")
	public MemberDTO findMember(String meEmail, Model model) {
		log.info("findMember...............................");
		log.info(meEmail);
		MemberDTO dto = memberService.myProfile(meEmail);
		
		ImageDTO imageDTO = memberService.myImg(meEmail);
		dto.setImageDTO(imageDTO);
		return dto;
	}
	
	@PostMapping("/modifyCode")
	public String modifyCode(int scNo, String scChecknum, RedirectAttributes rttr) {
		log.info("modifyCode.....................................");
		
		//난수(기관별 보안번호) 만들기
		Random random = new Random();
		int length = random.nextInt(5)+5;
		
		StringBuffer checkNum = new StringBuffer();
		for(int i=0; i<length; i++) {
			int mixed = random.nextInt(3);
			switch(mixed) {
			case 0 : 
				checkNum.append(randomWord("lower", 1));
				break;
			case 1 :
				checkNum.append(randomWord("upper", 1));
				break;
			case 2 :
				checkNum.append(randomWord("number", 1));
				break;
			default :
				break;
			}
		}
		
		//log.info(checkNum);
		
		scChecknum = checkNum.toString();

		//log.info("string으로 형변환 함"+chNum);
		memberService.modifyCode(scNo, scChecknum);
		
		rttr.addFlashAttribute("msg", "수정되었습니다.");
		return "redirect:/member/codeCheck";
		
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/codeCheck")
	public void codeCheck(Authentication auth, Model model) {
		String meEmail = auth.getName();
		int scNo = memberService.mySchoolNo(meEmail);
		
		model.addAttribute("dto", memberService.findCode(scNo));
	}
	
	@GetMapping("/join")
	public void join() {
		
	}
	
	@PostMapping("/updateProfile")
	public String updateProfile(MultipartFile image, MemberDTO memberDTO, Model model, RedirectAttributes rttr) throws Exception {
		
		log.info("updateProfile..................");
		
		// 넘어온 파일의 정보를 출력
		log.info("name:" + image.getOriginalFilename()); // 파일을 처음 올릴 때 이름
		log.info("size:" + image.getSize());

		if (!image.getOriginalFilename().isEmpty() && image != null && !(image.getOriginalFilename().equals(""))) {// 프로필
																									// 등록&회원가입
			ImageDTO imageDTO = ImageController.uploadImage(image);
			imageDTO.setImEmail(memberDTO.getMeEmail());
			memberDTO.setImageDTO(imageDTO);			
		}
		
		if(memberDTO.getMePwd() != null && memberDTO.getMePwd().trim().length()!=0) {
			memberService.updateProfileImg(memberDTO);
		}else if(memberDTO.getMePwd().equals("")) {
			memberService.updateProfileWithoutPwd(memberDTO);
		}//end of if
		
		rttr.addFlashAttribute("msg", "수정되었습니다.");
		return "redirect:/";

	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/checkMyPwd")
	public String checkMyPwd(MemberDTO memberDTO, Authentication auth, RedirectAttributes rttr) {
		String meEmail = auth.getName();
		
		String mePwd = memberDTO.getMePwd();
		
		memberDTO = memberService.myProfile(meEmail);
		String encodedPwd = memberDTO.getMePwd();
		
		if(passwordEncoder.matches(mePwd, encodedPwd)) {
			return "redirect:/member/myProfile";
		}else {
			rttr.addFlashAttribute("msg", "비밀번호를 다시 입력해주세요.");
			return "redirect:/member/checkPwd";
		}
	}
	
	@GetMapping("/checkPwd")
	public void checkPwd() {
		
	}
	
	@GetMapping("/adminjoin")
	public void adminjoin() {
		log.info("/adminjoin.................");
	}
	
	@GetMapping("/memberjoin")
	public void memberjoin() {
		log.info("/memberjoin.................");
	}

	@ResponseBody
	@PostMapping("/searchSch")
	public List<SchoolDTO> searchSch(String scName) {
		log.info("searchSch.................");
		List<SchoolDTO> list = memberService.getSchool(scName);
		log.info(list);
		return list;
	}

	@PostMapping("/adminjoin")
	public String adminjoin(MultipartFile image, MemberDTO memberDTO, SchoolDTO schoolDTO, Model model, RedirectAttributes rttr)
			throws Exception {
		log.info("-------------------------------------------------------------");
		// 넘어온 파일의 정보를 출력
		log.info("name:" + image.getOriginalFilename()); // 파일을 처음 올릴 때 이름
		log.info("size:" + image.getSize());

		log.info(schoolDTO);
		
		//난수(기관별 보안번호) 만들기
		Random random = new Random();
		int length = random.nextInt(5)+5;
		
		StringBuffer checkNum = new StringBuffer();
		for(int i=0; i<length; i++) {
			int mixed = random.nextInt(3);
			switch(mixed) {
			case 0 : 
				checkNum.append(randomWord("lower", 1));
				break;
			case 1 :
				checkNum.append(randomWord("upper", 1));
				break;
			case 2 :
				checkNum.append(randomWord("number", 1));
				break;
			default :
				break;
			}
		}
		
		//log.info(checkNum);
		
		String chNum = checkNum.toString();

		//log.info("string으로 형변환 함"+chNum);
		schoolDTO.setScChecknum(chNum);
		log.info(schoolDTO);
		
		memberService.insertSchool(schoolDTO);
		
		int scNo = schoolDTO.getScNo();
		memberDTO.setScNo(scNo);
		
		if (!image.getOriginalFilename().isEmpty() && image != null && !(image.getOriginalFilename().equals(""))) {// 프로필
																										// 등록&회원가입
			ImageDTO imageDTO = ImageController.uploadImage(image);
			imageDTO.setImEmail(memberDTO.getMeEmail());
			memberDTO.setImageDTO(imageDTO);

			log.info(memberDTO.getScNo());
			// memberService.memberjoin(studentDTO);
			
			memberService.memberjoinWithprofileImg(memberDTO);

		} else {// 프로필사진 등록하지 않고 가입
			memberService.memberjoin(memberDTO);
		}

		rttr.addFlashAttribute("msg", "가입되었습니다.");

		return "redirect:/member/login";
	}

	static String randomWord(String selectCase, int length) {//난수(기관별 보안번호 생성)
		if(selectCase == "lower") {
			String lowerRandom = "";
			for(int i=0; i<length; i++) {
				char lowerCh = (char)((int)(Math.random()*25)+97);
				lowerRandom += lowerCh;
			}//end of for
			return lowerRandom;
		}
		if(selectCase == "upper") {
			String upperRandom = "";
			for(int i=0; i<length; i++) {
				char upperCh = (char)((int)(Math.random()*25)+65);
				upperRandom += upperCh;
			}//end of for
			return upperRandom;
		}
		if(selectCase == "number") {
			String numRandom = "";
			for(int i=0; i<length; i++) {
				char ch = (char)((int)(Math.random()*10)+48);
				numRandom += ch;
			}//end of for
			return numRandom;
		}
		return null;
	}
	
	// 업로드 처리 - 파일 여러개를 전달 받으려면 배열 구조의 객체를 파리메터로 선언한다.
	@PostMapping("/memberjoin")
	public String memberjoin(MultipartFile image, MemberDTO memberDTO, Model model, RedirectAttributes rttr)
			throws Exception {
		log.info("-------------------------------------------------------------");
		// 넘어온 파일의 정보를 출력
		log.info("name:" + image.getOriginalFilename()); // 파일을 처음 올릴 때 이름
		log.info("size:" + image.getSize());

		if (!image.getOriginalFilename().isEmpty() && image != null && !(image.getOriginalFilename().equals(""))) {// 프로필
																													// 사진
																													// 등록&회원가입
			ImageDTO imageDTO = ImageController.uploadImage(image);
			imageDTO.setImEmail(memberDTO.getMeEmail());
			memberDTO.setImageDTO(imageDTO);

			// memberService.memberjoin(studentDTO);
			memberService.memberjoinWithprofileImg(memberDTO);

		} else {// 프로필사진 등록하지 않고 가입
			memberService.memberjoin(memberDTO);
		}

		rttr.addFlashAttribute("msg", "가입되었습니다.");

		return "redirect:/member/login";
	}

	@ResponseBody
	@PostMapping("/schoolCheck")
	public ResponseEntity<String> schoolCheck(@Param("scName") String scName, @Param("scCampus") String scCampus, @Param("scMajor") String scMajor) throws Exception {
		scName = scName.trim();
		scCampus = scCampus.trim();
		scMajor = scMajor.trim();
		
		int result = memberService.duplecateSchool(scName, scCampus, scMajor);
		String msg = "";
		if (result == 0)
			msg = "success";
		else
			msg = "fail";
		return new ResponseEntity<String>(msg, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping("/emailCheck")
	public ResponseEntity<String> emailCheck(String meEmail) throws Exception {
		int result = memberService.duplecateEmail(meEmail);
		String msg = "";
		if (result == 0)
			msg = "success";
		else
			msg = "fail";
		return new ResponseEntity<String>(msg, HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping("/myProfileImg")
	public ImageDTO myProfileImg(Authentication auth, Model model) {
		String meEmail = auth.getName();
		ImageDTO imageDTO = memberService.myImg(meEmail);
		log.info(imageDTO);
		return imageDTO;
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/myProfile")
	public void myProfile(String meEmail, Model model, Authentication auth) {
		log.info("myProfile...................................");
		meEmail = auth.getName();
		MemberDTO memberDTO = memberService.myProfile(meEmail);
		model.addAttribute("dto", memberDTO);
		
		ImageDTO imageDTO = memberService.myImg(meEmail);
		log.info(imageDTO);
		model.addAttribute("img", imageDTO);
		
	}
	
	@GetMapping("/login")
	public void login(String error, String logout, Model model, Authentication auth) {
		
		
		if(error!=null) {
			model.addAttribute("error","아이디와 패스워드를 확인해주십시오.");
		}
		if(logout!=null) {
			model.addAttribute("logout","로그아웃 되었습니다.");
		}
		
	}

}
