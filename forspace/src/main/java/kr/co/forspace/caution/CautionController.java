package kr.co.forspace.caution;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@Log4j
@RequestMapping("/caution")
public class CautionController {
	
	private final CautionService cautionService;
	
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
	public String insCaution(String meEmail, String caReason) {
		log.info("insCaution..........................");
		log.info("meEmail : "+meEmail + " caReason: "+caReason);
		//오늘 날짜 String
		Date now = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String today = simpleDateFormat.format(now);
		
		//마지막 이용제한 날짜 가져오기
		String caCloseStr = cautionService.findCloseDate(meEmail);
		
		if(caCloseStr == null || caCloseStr == "" || caCloseStr.equals("")) {//이용제한된 적이 없는 경우
			cautionService.insertCaution(meEmail, caReason);
			return "success";
		}else {
			if(today.compareTo(caCloseStr) > 0) {//이용제한이 풀린 경우
				//이용제한 insert
				cautionService.insertCaution(meEmail, caReason);
				return "success";
			}else if(today.compareTo(caCloseStr) < 0 || today.compareTo(caCloseStr) == 0) {//아직 이용이 제한된 경우
				return "fail";
			}
		}
		return "fail";
	}
}
