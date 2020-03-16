package com.icia.fontExample.Dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.fontExample.entity.*;

@Repository
public class TagDao {
	@Autowired
	private SqlSessionTemplate tpl;
	
	public int tagInsert(Tag tag) {
		return tpl.insert("tagMapper.insert", tag);
	}
	public List<String> findTagByPno(long no) {
		return tpl.selectList("tagMapper.findTagByPno", no);
	}
	public String duplicateTagCheck(long no,String name) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("no", no);
		map.put("name",name);
		return tpl.selectOne("tagMapper.duplicateTagCheck",map);
	}
	public List<Tag> findHotTag() {
		return tpl.selectList("tagMapper.findHotTag");
	}
	
	public int updateTagHit(long productNo) {
		return tpl.update("tagMapper.updateTagHit",productNo);
	}
	
}
