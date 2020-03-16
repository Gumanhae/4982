package com.icia.fontExample.Controller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import com.icia.fontExample.Service.*;
import com.icia.fontExample.entity.*;

@RequestMapping("/api")
@CrossOrigin("*")
@RestController
public class InquiryController {

	@Autowired
	private InquiryService service;
	
	@PostMapping(path="/inquiryInsert",produces="application/json;charset=utf-8")
	public ResponseEntity<?> inqurityInsert(Inquiry inquiry) {
		return ResponseEntity.ok(service.insert(inquiry));
	}
	
	@GetMapping("/inquiryRead")
	public ResponseEntity<?> inquiryByNo(@RequestParam Long no) {
		return ResponseEntity.ok(service.inquiryByNo(no));
	}
	
	@GetMapping("/inquiryMyAllRead")
	public ResponseEntity<?> inquiryMyAllRead(@RequestParam(defaultValue ="1")int pageno,
			@RequestParam(defaultValue = "10")int pagesize, @RequestParam String username) {
		return ResponseEntity.ok(service.inquiryMyAllRead(pageno, pagesize, username));
	}
	@GetMapping("/inquiryAnswer")
	public ResponseEntity<?> inquiryAnswer(int no){
		return ResponseEntity.ok(service.answerFind(no));
	}
	@PostMapping("/inquiry_answerInsert")
	public ResponseEntity<?> inquiryanswerinsert(Inquiry inquiry){
		return ResponseEntity.ok(service.answerInsert(inquiry));
	}
	
	@GetMapping("/inquiry")
	public ResponseEntity<?> findAll(@RequestParam String username){
		return ResponseEntity.ok(service.findAll(username));
	}
	@GetMapping("/inquiryAllRead")
	public ResponseEntity<?> inquiryAllRead(@RequestParam(defaultValue ="1")int pageno,@RequestParam(defaultValue = "10")int pagesize) {
		return ResponseEntity.ok(service.inquiryAllRead(pageno, pagesize));
	}
	
	@DeleteMapping("/inquiryDelete")
	public ResponseEntity<?> delete(@RequestParam Long no){
		return ResponseEntity.ok(service.delete(no));
	}
}