package com.icia.fontExample.Service;

import java.io.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.multipart.*;

import com.icia.fontExample.Dao.*;
import com.icia.fontExample.entity.*;

@Service
public class SellerService {
	@Autowired
	private SellerDao dao;
	@Autowired
	private AuthorityDao authorityDao;
	@Value("#{config['upload.storeSajin.folder']}")
	private String PROFILE_FOLDER;
	@Value("#{config['download.storeSajin.uri']}")
	private String PROFILE_URI;
	
	public Seller findSeller(String username) {
		return dao.findSeller(username);
	}
	public Seller findSellerAll(String username) {
		return dao.findSellerAll(username);
	}
	public boolean checkName(String name) {
		return dao.checkName(name)==null;
	}

	public boolean checkSns(String sns) {
		return dao.checkSns(sns)==null; 
	}
	public boolean checkAccount(String account) {
		return dao.checkAccount(account)==null;
	}
	
	public int insert(Seller seller , MultipartFile storeSajin) throws IllegalStateException, IOException {
		authorityDao.insert(seller.getUsername(),"ROLE_SELLER");
		if(storeSajin != null) {
			if(storeSajin.getContentType().toLowerCase().startsWith("image/")) {
				int lastIndexOfDot = storeSajin.getOriginalFilename().lastIndexOf('.');
				String extension = storeSajin.getOriginalFilename().substring(lastIndexOfDot);
				String imageName = seller.getUsername() + extension;
				File file = new File( PROFILE_FOLDER, imageName);
				storeSajin.transferTo(file);
				String fileUrl = PROFILE_URI + imageName;
				seller.setImage(fileUrl);
			}
		}
		return dao.insertRight(seller);
	}
}
