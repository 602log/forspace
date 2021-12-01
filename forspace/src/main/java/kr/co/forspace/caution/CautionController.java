package kr.co.forspace.caution;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.forspace.member.MemberService;
import kr.co.forspace.paging.PagingDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@Log4j
@RequestMapping("/caution")
public class CautionController {
	
	private final CautionService cautionService;
	
	@ResponseBody
	@PostMapping("/cancelCaution")
	public String cancelCaution(int caNo) throws Exception{
		try {
			cautionService.cancelCaution(caNo);
			return "success";
		}catch(Exception e) {
			return "fail";
		}
		
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/cautionList")
	public void cautionList(Authentication auth, Model model, @Param("pagingDTO") PagingDTO pagingDTO, 
			@RequestParam(value="nowPage", required=false) String nowPage,
			@RequestParam(value="cntPerPage", required=false) String cntPerPage) {
		log.info("cautionList................................");
		
		String caReg = auth.getName();
		int total = cautionService.cntCaution(caReg);
		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		}else if(nowPage == null) {
			nowPage = "1";
		}else if(cntPerPage == null) {
			cntPerPage = "5";
		}
		
		pagingDTO = new PagingDTO(total, Integer.valueOf(nowPage), Integer.valueOf(cntPerPage));
		List<CautionDTO> list = cautionService.cautionList(caReg, pagingDTO);
		
		Date now = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String today = simpleDateFormat.format(now);
		
		
		for(int i=0; i<list.size(); i++) {
			String caStartStr = simpleDateFormat.format(list.get(i).getCaStart());
			String caCloseStr = simpleDateFormat.format(list.get(i).getCaClose());
			
			list.get(i).setCaStartStr(caStartStr);
			list.get(i).setCaCloseStr(caCloseStr);
				if(today.compareTo(caCloseStr) > 0) {//이용제한이 풀린 경우
					list.get(i).setResult("만료");
				}else if(today.compareTo(caCloseStr) < 0 || today.compareTo(caCloseStr) == 0) {//아직 이용이 제한된 경우
					list.get(i).setResult("해지");
				}
			}
		model.addAttribute("list", list);
		model.addAttribute("paging", pagingDTO);

	}
	
	public String selMyCaution(String meEmail) {
		log.info("selMyCaution..........................");
		Date now = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String today = simpleDateFormat.format(now);
		
		//마지막 이용제한 날짜 가져오기
		String caCloseStr = cautionService.findCloseDate(meEmail);
		if(caCloseStr == null || caCloseStr == "" || caCloseStr.equals("")) {
			return "success";
		}else {
			if(today.compareTo(caCloseStr) > 0) {//이용제한이 풀린 경우
				return "success";
			}else if(today.compareTo(caCloseStr) < 0 || today.compareTo(caCloseStr) == 0) {//아직 이용이 제한된 경우
				return "fail";
			}
		}
		return "fail";
	}
	

	@ResponseBody
	@RequestMapping("/insCaution")
	public String insCaution(String meEmail, String caReason, Authentication auth) {
		log.info("insCaution..........................");
		log.info("meEmail : "+meEmail + " caReason: "+caReason);
		String caReg = auth.getName();
		//오늘 날짜 String
		Date now = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String today = simpleDateFormat.format(now);
		
		//마지막 이용제한 날짜 가져오기
		String caCloseStr = cautionService.findCloseDate(meEmail);
		
		if(caCloseStr == null || caCloseStr == "" || caCloseStr.equals("")) {//이용제한된 적이 없는 경우
			cautionService.insertCaution(meEmail, caReason, caReg);
			return "success";
		}else {
			if(today.compareTo(caCloseStr) > 0) {//이용제한이 풀린 경우
				//이용제한 insert
				cautionService.insertCaution(meEmail, caReason, caReg);
				return "success";
			}else if(today.compareTo(caCloseStr) < 0 || today.compareTo(caCloseStr) == 0) {//아직 이용이 제한된 경우
				return "fail";
			}
		}
		return "fail";
	}
}
