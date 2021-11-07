package kr.co.forspace.notice;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/noticeDetail")
	public void noticeDetail(int noNo, Model model) {
		log.info("noticeDetail...............");
		log.info(noNo);
		log.info(noticeService.getNoticeDetail(noNo));
		model.addAttribute("dto", noticeService.getNoticeDetail(noNo));		
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
