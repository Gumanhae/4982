package com.icia.fontExample.Service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.fontExample.Dao.*;
import com.icia.fontExample.date.dto.*;
import com.icia.fontExample.entity.*;

@Service
public class DeclarationService {
	@Autowired
	private DeclarationDao dao;
	
	public int declaration(String reason) {
		return dao.update(reason); 
	}
	public int insert(Declaration declaration) {
		declaration.getReason_no(); 
		return dao.insert(declaration);
	}
	public DeclarationPage findByPage(int pageno, int pagesize) {
		int count = dao.findCount();
		int startRowNum = ((pageno-1) * pagesize + 1);
		int endRowNum = startRowNum + pagesize -1;
		if(endRowNum >= count)
			endRowNum = count;
		List<Declaration> declaration = dao.findByPage(startRowNum, endRowNum);
		return new DeclarationPage().builder().pageno(pageno).pagesize(pagesize).totalcount(count).declarationPage(declaration).build();
	}
	public List<Declaration> declarationList(){
		return dao.findAll();
	}
	public Declaration detailView(long no) {
		return dao.detailView(no); 
	}
}

