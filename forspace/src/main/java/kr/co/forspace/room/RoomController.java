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
import org.springframework.web.bind.annotation.ResponseBody;

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
		
		for(int i=0; i<list.size(); i++) {
		
			int roNo = list.get(i).getRoNo(); // i번째 roNo
			int myLike = roomService.getLikeInfo(roNo, meEmail);//user가 i번째를 좋아요 했으면 1, 아니면 0
			list.get(i).setMyLike(myLike);
		}
		/*
		 * 
		 * int likeCnt = roomService.getLike(roNo); //해당 연습실의 like 수
		 * list.get(i).setLikeCnt(likeCnt);//i번째의 like 수 setting
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
	
	@ResponseBody
	@PostMapping("/insertLike")
	public String insertLike(int roNo, String meEmail) throws Exception {
		log.info("roNo : "+ roNo + "meEmail : "+meEmail);
		
		int myLike = roomService.getLikeInfo(roNo, meEmail); //user가 like 했는지
		
		String result = "";
		
		if(myLike == 0) {
			roomService.insertLike(roNo, meEmail);//insert like
			result =  "like";
			
		}else {
			roomService.deleteLike(roNo, meEmail);
			result =  "unlike";
		}
		roomService.updateLikeCnt(roNo, myLike);
		return result;
	}
	
}
