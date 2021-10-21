package kr.co.forspace.room;


import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
@Log4j
@RequestMapping("/room")
public class RoomController {
	
	private final RoomService roomService;
	
	@GetMapping("/addroom")
	public void addroom() {
		
	}

	@GetMapping("/roomDetail")
	public String roomDetail(String roName, Model model) {//연습실별 상세정보
		
		log.info("roName:"+roName);
		
				
		model.addAttribute("dto", roomService.roomDetail(roName));
		log.info(model);
		
		return "room/roomDetailPage";
	}
	
	@GetMapping("/roomList")
	public String roomList(Model model) {//연습실 리스트
		int scNo = 1;
		List<RoomDTO> list = roomService.roomNoList(scNo);

		List<RoomDTO> floorList = roomService.floorList(scNo);
		
		model.addAttribute("list", list);
		model.addAttribute("floorList", floorList);

		return "room/roomList";
	}
}
