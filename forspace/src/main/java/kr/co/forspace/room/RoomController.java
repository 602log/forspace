package kr.co.forspace.room;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.forspace.member.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@Log4j
@RequestMapping("/room")
public class RoomController {

	private final RoomService roomService;
	private final MemberService memberService;

	@GetMapping("/addroom")
	public void addroom() {

	}

//	@PreAuthorize("isAuthenticated()")
	@GetMapping("/roomDetail")
	public String roomDetail(int roNo, Model model, Authentication auth) {// 연습실별 상세정보
		
		log.info("roNo:" + roNo);
		
		model.addAttribute("dto", roomService.roomDetail(roNo));		
		return "/room/roomDetail";
		
	}
	
//	@PreAuthorize("isAuthenticated()")
	@RequestMapping("/roomList")
	public void roomList(Model model, int roFloor, Authentication auth) {// 연습실 리스트
		
		//이용자의 학교 번호 찾기
		String meEmail = auth.getName();//이용자의 이메일
		int scNo = memberService.mySchoolNo(meEmail);
		//int scNo = 1;
		log.info("이용자의 학교"+scNo);
		
		List<RoomDTO> list;
		
		list = roomService.selectFloor(roFloor, scNo);
		
		log.info(list);
		
		/*
		 * for(int i=0; i<list.size(); i++) {// 위에서 찾은 연습실 리스트를 하나씩
		 * 
		 * int roNo = list.get(i).getRoNo();
		 * 
		 * int likeCnt = roomService.getLike(roNo); //해당 연습실의 like 수
		 * list.get(i).setLikeCnt(likeCnt);//i번째의 like 수 setting
		 * 
		 * int checkLike = roomService.getLikeInfo(roNo, meEmail);//해당 연습실의 이용자가 like
		 * 했는지 model.addAttribute("checkLike", checkLike);
		 * 
		 * //model.addAttribute("likeList", likeDTO); //i번째를 좋아요 한 모든 정보
		 * 
		 * }
		 */
		
		model.addAttribute("list", list);
		log.info(list);
		List<RoomDTO> floorList = roomService.floorList(scNo);// 층 리스트
		model.addAttribute("floorList", floorList);
	}

}
