package com.icia.fontExample.Controller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.icia.fontExample.Service.*;

@RequestMapping("/api")
@RestController
public class TalkRestController {
	@Autowired
	private TalkerService service;
	
	@GetMapping("/findTalker/{no}")
	public ResponseEntity<?> findTalker(@PathVariable long no) {
		return ResponseEntity.ok(service.findTalker(no));
	}
	@GetMapping("/findbuyer")
	public ResponseEntity<?> findBuyer(@RequestParam String username){
		System.out.println(username);
		return ResponseEntity.ok(service.findBuyer(username));
	}
}
