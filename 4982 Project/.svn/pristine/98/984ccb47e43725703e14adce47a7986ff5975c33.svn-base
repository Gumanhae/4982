package com.icia.fontExample.Service;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.multipart.*;

import com.fasterxml.jackson.databind.*;
import com.icia.fontExample.Dao.*;
import com.icia.fontExample.entity.*;

@Service
public class ProductService {
	@Autowired
	private ProductDao dao;
	@Autowired
	private TagDao tagDao;
	@Autowired
	private SellDao SellDao;
	@Value("#{config['upload.sajin.folder']}")
	private String PROFILE_FOLDER;
	@Value("#{config['download.sajin.uri']}")
	private String PROFILE_URI;
	//판매하기 위해 제품을 등록
	public String insert(UploadInfo uploadInfo, MultipartFile productImage) throws IllegalStateException, IOException {
		Product product = new Product();
		product.setName(uploadInfo.getName());
		product.setLno(uploadInfo.getLno());
		product.setSno(uploadInfo.getSno());
		product.setPrice(uploadInfo.getPrice());
		product.setQuantity(uploadInfo.getQuantity());
		if (productImage != null) {
			if (productImage.getContentType().toLowerCase().startsWith("image/")) {
				int lastIndexOfDot = productImage.getOriginalFilename().lastIndexOf('.');
				String extension = productImage.getOriginalFilename().substring(lastIndexOfDot);
				String imageName = product.getName() + extension;
				File file = new File(PROFILE_FOLDER, imageName);
				productImage.transferTo(file);
				String fileUrl = PROFILE_URI + imageName;
				product.setImage(fileUrl);
			}
		}
		dao.insert(product);
		long proNo = product.getNo();
		List<String> tagList = uploadInfo.getTags();
		for(String tag:tagList) {
			String tagAlreadyExist = tagDao.duplicateTagCheck(proNo,tag);
			if(!(tag.equals(tagAlreadyExist)));
				Tag tags = new Tag().builder().name(tag).product_no(proNo).build();
				tagDao.tagInsert(tags);
		}
		Sell sell = new Sell();
		sell.setArea(uploadInfo.getPostcode2());
		sell.setProduct_no(proNo);
		sell.setInfomation(uploadInfo.getInformation());
		sell.setUsername(uploadInfo.getUsername());
		sell.setBlock(0);
		SellDao.insert(sell);
		
		return product.getNo()+"";
	}
	//전체 제품조회
	public List<Product> findAllProduct() {
		return dao.findAllProduct();
	}
	//제품번호로 제품검색
	public Product findProduct(long no) {
		return dao.findProduct(no);
	}
	//제품가격검색
	public long findPriceByProduct(long no) {
		return dao.findPriceByProduct(no);
	}
	//제품수량검색
	public long findQuantityByProduct(long no) {
		return dao.findQuantityByProduct(no);
	}
	//제품 숫자 조정 (제품 추가시 +)
	public String updateQuantity(long no,int quantity) {
		try {
			int productQuantity = dao.findQuantityByProduct(no);
			if(productQuantity>quantity) {
				dao.updateQuantity(no, quantity);
			} else {
				dao.updateStateWhereSoldOut(no);
			}
			return "OK";
		}catch(Exception e) {
			return "제품 주입 중 오류가 발생하였습니다.";
		}
	}
	//제품삭제
	public void delete(long no) {
		dao.delete(no);
	}
	//연관제품 검색
	public List<Product> findRelatedProducts(long no) {
		return dao.findRelatedProducts(no);
	}
}