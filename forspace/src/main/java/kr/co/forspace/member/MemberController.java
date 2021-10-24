package kr.co.forspace.member;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@Log4j
@RequestMapping("/member")
public class MemberController {

	private final MemberService memberService;
	private final PasswordEncoder passwordEncoder;

	@GetMapping("/memberjoin")
	public void memberjoin(Model model) {
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
			imageDTO.setImDiv("ST");
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
	
	@GetMapping("/myProfile")
	public void myProfile(String meEmail, Model model, Authentication auth) {
		meEmail = auth.getName();
		MemberDTO memberDTO = memberService.myProfile(meEmail);
		model.addAttribute("dto", memberDTO);
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