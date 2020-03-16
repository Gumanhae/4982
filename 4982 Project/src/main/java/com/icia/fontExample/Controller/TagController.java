package com.icia.fontExample.Controller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.icia.fontExample.Service.*;

@RequestMapping("/api")
@RestController
public class TagController {
	@Autowired
	private TagService service;
	
	@GetMapping("/findHotTag")
	public ResponseEntity<?> findHotTag() {
		return ResponseEntity.ok(service.findHotTag());
	}
	@PutMapping("/tag")
	public ResponseEntity<?> updateTagHit(@RequestParam long productNo){
		return ResponseEntity.ok(service.updateTagHit(productNo));
	}
	@GetMapping("/tag")
	public ResponseEntity<?> findTagByPno(long no){
		return ResponseEntity.ok(service.findTagByPno(no));
	}
}
