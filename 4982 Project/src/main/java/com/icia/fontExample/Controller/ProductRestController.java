package com.icia.fontExample.Controller;

import java.io.*;

import javax.validation.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.lang.*;
import org.springframework.validation.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;

import com.icia.fontExample.Service.*;
import com.icia.fontExample.entity.*;

import lombok.NonNull;

@RequestMapping("/api")
@CrossOrigin("*")
@RestController
public class ProductRestController {
	@Autowired
	private ProductService service;

//	@Secured("ROLE_SELLER")
	@PostMapping(path="/uploadProduct",produces="application/json;charset=utf-8")
	public ResponseEntity<?> productInsert(@ModelAttribute @Valid UploadInfo uploadInfo, BindingResult results,@Nullable MultipartFile productImage) throws BindException, IllegalStateException, IOException {
		if(results.hasErrors())
			throw new BindException(results);
		System.out.println(uploadInfo);
		return ResponseEntity.ok(service.insert(uploadInfo, productImage));
	}
	
	@GetMapping("/product/findAll")
	public ResponseEntity<?> findAllProduct(){
		return ResponseEntity.ok(service.findAllProduct());
	}
	
	@GetMapping("/product/find")
	public ResponseEntity<?> findProduct(@Valid int no){
		return ResponseEntity.ok(service.findProduct(no));
	}

	@GetMapping("/product/find/price")
	public ResponseEntity<?> findPriceByProduct(@RequestParam int no){
		return ResponseEntity.ok(service.findPriceByProduct(no));
	}
	@GetMapping("/product/quantity")
	public ResponseEntity<?> findQuantity(@NonNull long no){
		return ResponseEntity.ok(service.findQuantityByProduct(no));
	}
	@PostMapping("/product/quantity")
	public ResponseEntity<?> updateQuantity(@NonNull long no,@NonNull int quantity){
		return ResponseEntity.ok(service.updateQuantity(no, quantity));
	}
	@DeleteMapping("/product/delete")
	public ResponseEntity<?> delete(long no){
		service.delete(no);
		return ResponseEntity.ok("삭제 완료!");
	}
	@GetMapping("/relatedProducts")
	@ResponseBody
	public ResponseEntity<?> findRelatedProducts(@RequestParam(defaultValue = "0") long no) {
			return ResponseEntity.ok(service.findRelatedProducts(no));			
	}
}