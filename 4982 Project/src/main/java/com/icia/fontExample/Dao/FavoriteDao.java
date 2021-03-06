package com.icia.fontExample.Dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.fontExample.entity.*;

@Repository
public class FavoriteDao {
	@Autowired
	private SqlSessionTemplate tpl;
	
	public List<Integer> findFavorite(String username){
		return tpl.selectList("favoriteMapper.findFavorite",username);
	}
	
	public Favorite findProductByFavorite(String username,long productNo){
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("username",username);
		map.put("productNo",productNo);
		return tpl.selectOne("favoriteMapper.findProductByFavorite",map);
	}
	
	public long findFavoriteByPno(String username,long productNo) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("username",username);
		map.put("productNo",productNo);
		return tpl.selectOne("favoriteMapper.findFavoriteByPNo",map);
	}
	
	public int insertFavorite(String username,long productNo) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("username",username);
		map.put("productNo",productNo);
		return tpl.insert("favoriteMapper.insertFavorite",map);
	}
	
	public int favoriteCount(String username) {
		return tpl.selectOne("favoriteMapper.favoriteCount",username);
	}
	
	public int delete(long no) {
		return tpl.delete("favoriteMapper.deleteFavorite",no);
	}
	
	public int findProductBySoldOut(int isSO) {
		return tpl.selectOne("favoriteMapper.findProductBySoldOut",isSO);
	}
	public int findNoByProNo(long productNo,String username) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("username",username);
		map.put("productNo",productNo);
		return tpl.selectOne("favoriteMapper.findNoByProNo",map);
	}
}
