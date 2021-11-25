package kr.co.forspace.notice;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.forspace.member.MemberService;
import kr.co.forspace.paging.PagingDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/notice")
public class NoticeController {
	
	private final MemberService memberService;
	private final NoticeService noticeService;
	
	@PostMapping("/insertNotice")
	public String insertNotice(NoticeDTO noticeDTO, Authentication auth, RedirectAttributes rttr) {
		log.info("insertNotice....................................");
		
		String meEmail = auth.getName();
		
		noticeDTO.setMeEmail(meEmail);
		noticeDTO.setScNo(memberService.mySchoolNo(meEmail));
		noticeService.insertNotice(noticeDTO);
		
		rttr.addFlashAttribute("msg", "등록되었습니다. ");
		return "redirect:/notice/noticeList";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/noticeForm")
	public void noticeForm() {
		log.info("noticeForm.............................");
	}
	
	@PreAuthorize("authentication.principal.username == #noticeDTO.meEmail or hasRole('ROLE_ADMIN')")
	@PostMapping("/remove")
	public String remove(NoticeDTO noticeDTO, RedirectAttributes rttr) {
		noticeService.removeNotice(noticeDTO.getNoNo());
		
		rttr.addFlashAttribute("msg", "삭제되었습니다. ");
		return "redirect:/notice/noticeList";
	}
	
	@PreAuthorize("authentication.principal.username == #noticeDTO.meEmail or hasRole('ROLE_ADMIN')")
	@RequestMapping("/modify")
	public String modify(NoticeDTO noticeDTO) {
		log.info("modify.................");
		int noNo = noticeDTO.getNoNo();
		noticeService.modify(noticeDTO);
		return "redirect:/notice/noticeDetail?noNo="+noNo;
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/modifyNotice")
	public void modifyNotice(int noNo, Model model) {
		log.info("modifyNotice.............");
		log.info("noNo>>"+noNo);
		NoticeDTO dto;
		dto = noticeService.readNotice(noNo);
		model.addAttribute("dto", dto);
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/noticeDetail")
	public void noticeDetail(int noNo, Model model, RedirectAttributes rttr) {
		log.info("noticeDetail...............");
		log.info("noNo>>"+noNo);
		
		//조회수 update
		noticeService.updateCnt(noNo);
		
		//상세정보 불러오기
		NoticeDTO dto;
		dto = noticeService.readNotice(noNo);
		dto.setNoContent(dto.getNoContent().replace("\r\n", "<br>"));


		model.addAttribute("dto", dto);
		rttr.addFlashAttribute("msg", "수정되었습니다.");
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/noticeList")
	public void noticeList(Model model, Authentication auth, @Param("pagingDTO") PagingDTO pagingDTO, 
			@RequestParam(value="nowPage", required=false) String nowPage,
			@RequestParam(value="cntPerPage", required=false) String cntPerPage) {
		String meEmail = auth.getName();
		int scNo = memberService.mySchoolNo(meEmail);
		

		int total = noticeService.countNotice(scNo);
		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		}else if(nowPage == null) {
			nowPage = "1";
		}else if(cntPerPage == null) {
			cntPerPage = "5";
		}
		
		pagingDTO = new PagingDTO(total, Integer.valueOf(nowPage), Integer.valueOf(cntPerPage));
		model.addAttribute("list", noticeService.noticeList(scNo, pagingDTO));
		model.addAttribute("paging", pagingDTO);
	}
}
