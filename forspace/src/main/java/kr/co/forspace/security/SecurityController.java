package kr.co.forspace.security;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SecurityController {
	
	@GetMapping("/accessError")
	public void accessError() {
		
	}

}
