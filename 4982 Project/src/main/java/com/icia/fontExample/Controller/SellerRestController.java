package com.icia.fontExample.Controller;

import java.io.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;

import com.icia.fontExample.Service.*;
import com.icia.fontExample.entity.*;

@RestController
public class SellerRestController {
	@Autowired
	private SellerService service;

	@GetMapping("/findseller")
	public ResponseEntity<?> findSeller(@RequestParam String username){
		return ResponseEntity.ok(service.findSeller(username));
	}
	
	@GetMapping("/findsellerAll")
	public ResponseEntity<?> findSellerAll(@RequestParam String username){
		return ResponseEntity.ok(service.findSellerAll(username));
	}
	@PostMapping("/salesRights")
	public ResponseEntity<?> insert(@ModelAttribute Seller seller ,  MultipartFile storeSajin) 
			throws IllegalStateException, IOException{
		return ResponseEntity.ok(service.insert(seller, storeSajin));
	}
	@GetMapping("/checkName/{name}")
	public ResponseEntity<?> checkName(@PathVariable String name) {
		boolean result = service.checkName(name);
		if(result==true)
			return ResponseEntity.ok(null);
		return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
	}
	@GetMapping("/checkSns/{sns}")
	public ResponseEntity<?> checkSns(@PathVariable String sns) {
		boolean result = service.checkSns(sns);
		if(result==true)
			return ResponseEntity.ok(null);
		return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
	}
	@GetMapping("/checkAccount/{account}")
	public ResponseEntity<?> checkAccount(@PathVariable String account) {
		boolean result = service.checkAccount(account);
		if(result==true)
			return ResponseEntity.ok(null);
		return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
	}
}
