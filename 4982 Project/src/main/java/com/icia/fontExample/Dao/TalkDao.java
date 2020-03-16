package com.icia.fontExample.Dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.fontExample.entity.*;

@Repository
public class TalkDao {
	@Autowired
	private SqlSessionTemplate tpl;
	
	public Purchase finTalker(long no) {
		return tpl.selectOne("talkMapper.finTalker", no);
	}

	public Member findbuyer(String username) {
		return tpl.selectOne("talkMapper.findbuyer", username);
	}
}
