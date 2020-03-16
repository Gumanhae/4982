package com.icia.fontExample.Controller;

import java.io.*;
import java.net.*;
import java.security.*;

import javax.mail.*;
import javax.servlet.http.*;
import javax.validation.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.lang.*;
import org.springframework.security.access.prepost.*;
import org.springframework.security.core.*;
import org.springframework.security.web.authentication.logout.*;
import org.springframework.validation.*;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;
import org.springframework.web.util.*;

import com.icia.fontExample.Service.*;
import com.icia.fontExample.entity.*;

import io.swagger.annotations.*;
import lombok.*;
import lombok.NonNull;

@RequestMapping("/api")
@CrossOrigin("*")
@RestController
public class MemberRestController {
	@Autowired
	private MemberService service;
	@GetMapping("/checkId/{username}")
	public ResponseEntity<?> checkId(@PathVariable String username) {
		boolean result = service.checkId(username);
		if(result==true)
			return ResponseEntity.ok(null);
		return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
	}
	
	@GetMapping(path="/checkEmail", produces="text/plain;charset=utf-8")
	public ResponseEntity<?> checkEmail(String email) {
		boolean result = service.checkEmail(email);
		if(result==true)
			return ResponseEntity.ok(null);
		return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
	}
	@PostMapping(path="/join")
	public ResponseEntity<?> join(@ModelAttribute @Valid Member member, BindingResult results)
			throws BindException, IOException {
		if(results.hasErrors())
			throw new BindException(results);
		URI location = UriComponentsBuilder.newInstance().path("/fontExample/").build().toUri();
		return ResponseEntity.created(location).body(service.insert(member));
	}
	@GetMapping(path="/findId", produces="text/plain;charset=utf-8")
	public ResponseEntity<?> findId(@NonNull String name, @NonNull String tel) throws MessagingException {
		return ResponseEntity.ok(service.findId(name, tel));
	}
	@GetMapping(path="/findMemberByUsername")
	public ResponseEntity<?> findMemberByUsername(@NonNull String username) throws MessagingException {
		return ResponseEntity.ok(service.findMemberByUsername(username));
	}
	@PostMapping(path="/changePwd", produces="text/plain;charset=utf-8")
	public ResponseEntity<?> resetPwd(@NonNull String name, @NonNull String tel) throws MessagingException {
		return ResponseEntity.ok(service.changePwd(name, tel));
	}
	@PostMapping(path="/changeSajin", produces="text/plain;charset=utf-8")
	public ResponseEntity<?> changeSajin(Principal principal, @Nullable MultipartFile upload) throws BindException, IllegalStateException, IOException {
		return ResponseEntity.ok(service.changeSajin(principal.getName(),upload));
	}
	@PostMapping(path="/findProfilByUsername", produces="text/plain;charset=utf-8")
	public ResponseEntity<?> findProfilByUsername(Principal principal){
		return ResponseEntity.ok(service.findProfilByUsername(principal.getName()));
	}
	@PostMapping(path="/tel/certification", produces="text/plain;charset=utf-8")
	public ResponseEntity<?> telCertification(@NonNull String tel, @NonNull String random) {
		return ResponseEntity.ok(service.telCertification(tel, random));
	}
	@PostMapping(path="/email/certification", produces="text/plain;charset=utf-8")
	public ResponseEntity<?> emailCertification(@NonNull String email, @NonNull String random) 
			throws MessagingException {
		return ResponseEntity.ok(service.emailCertification(email, random));
	}
	@PostMapping(path="/notloginchangePwd", produces="text/plain;charset=utf-8")
	public ResponseEntity<?> notLoginChangePwd(@NonNull String newPassword, @NonNull String username) {
		System.out.println("컨트롤러" + username);
		return ResponseEntity.ok(service.notLoginChangePwd(newPassword, username));
	}
	@PostMapping(path="/changePassword", produces="text/plain;charset=utf-8")
	public ResponseEntity<?> changePwd(@NonNull String password, @NonNull String newPassword, Principal principal) {
		return ResponseEntity.ok(service.changePassword(principal.getName(), password, newPassword));
	}
}
