package kr.co.forspace.room;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/room")
public class RoomController {
	
	@GetMapping("/addroom")
	public void addroom() {
		
	}

}
