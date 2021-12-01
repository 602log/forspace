package kr.co.forspace.complaint;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.forspace.member.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@Log4j
@RequestMapping("/complaint")
public class ComplaintController {
	
	private final ComplaintService complaintService;
	private final MemberService memberService;

	@ResponseBody
	@PostMapping("/todayComplaint")
	public List<ComplaintDTO> todayComplaint(String meEmail) {
		log.info("todayComplaint.........................");
		log.info(meEmail);
		
		List<ComplaintDTO> list = complaintService.notFinComplaint(meEmail);
		
		return list;
	}
	
	@ResponseBody
	@PostMapping("/FinishComplaint")
	public String FinishComplaint(int coNo, int roNo) {
		//log.info("ajax에서 넘어온 coNo:"+coNo);
		//log.info("ajax에서 넘어온 roNo:"+roNo);
		
		boolean fincom = complaintService.FinishComplaint(coNo, roNo);
		
		if(fincom == true) {
			return "success";
		}else {
			return "false";
		}
	}
	
	@ResponseBody
	@PostMapping("/deleteComplaint")
	public String deleteComplaint(int coNo, int roNo){
		
		//log.info("ajax에서 넘어온 coNo:"+coNo);
		//log.info("ajax에서 넘어온 roNo:"+roNo);
		
		boolean delcom = complaintService.deleteComplaint(coNo, roNo);

		if(delcom == true) {
			return "success";
		}else {
			return "false";
		}
	}
	
	
	@ResponseBody
	@PostMapping("/insertComplaint")
	public String insertComplaint(int roNo, String coContent, RedirectAttributes rttr, Authentication auth) throws Exception {
		log.info("insertComplaint.................");
		
		log.info(roNo+coContent);
		String meEmail = auth.getName();
		
		complaintService.insertComplaint(roNo, coContent, meEmail);
		try {
			return "success";
		}catch(Exception e){
			return "fail";
		}
	}
}
