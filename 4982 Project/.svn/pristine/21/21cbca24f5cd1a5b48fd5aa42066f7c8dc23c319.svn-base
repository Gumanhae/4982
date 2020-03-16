package com.icia.fontExample.Service;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.password.*;
import org.springframework.stereotype.*;

import com.icia.fontExample.Dao.*;
import com.icia.fontExample.entity.*;

@Service
public class CertificationService {
	@Autowired
	private CertificationDao dao;

	public Certification certification_find(String username) {
		return dao.certification_find(username);
	}

	public String email_Certification(String username) {
		dao.email_Certification(username);
		return "인증이 완료 되었습니다.";
	}
	
	public String tel_Certification(String username) {
		dao.tel_Certification(username);
		return "인증이 완료 되었습니다.";
	}
}
