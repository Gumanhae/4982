package com.icia.fontExample.Dao;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.fontExample.entity.*;

@Repository
public class SellerDao {
	@Autowired
	private SqlSessionTemplate tpl;
	
	public Seller findSeller(String username) {
		return tpl.selectOne("sellerMapper.findSeller", username);
	}

	public Seller findSellerAll(String username) {
		return tpl.selectOne("sellerMapper.findSellerAll", username);
	}
	
	public int insertRight(Seller seller) {
		 return tpl.insert("sellerMapper.insertSales",seller);
	}
	public int delete(String username) {
		return tpl.delete("withdrawalMapper.sellerdelete",username);
	
	}
	public String checkName(String name) {
		return tpl.selectOne("sellerMapper.checkName",name);
	}
	public String checkSns(String sns) {
		return tpl.selectOne("sellerMapper.checkSns",sns);
	}
	public String checkAccount(String account) {
		return tpl.selectOne("sellerMapper.checkAccount",account);
	}
}
