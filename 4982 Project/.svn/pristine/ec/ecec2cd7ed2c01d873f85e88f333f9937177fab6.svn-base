package com.icia.fontExample.Dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Repository // 모든 공용 Component == ( Controller Repository Service ) 
public class WithdrawalDao {
	@Autowired 
	private SqlSessionTemplate tpl;
	
	public int delete(String username) {
		return tpl.delete("withdrawalMapper.delete",username);
	}
	public int update(String reason) {
		return tpl.update("withdrawalMapper.withdrawalupdate",reason);
	}
	public int insert(String reason_detail) {
		// map.put entity 없이 여러 값을 넘길 때 사용
		Map <String, Object> map = new HashMap<String, Object>();
		map.put("no",1); // mapper에서 사용하는 insert keyProperty no값에 저장하기 위한 공간
		map.put("reason_detail",reason_detail);
		return tpl.insert("withdrawalMapper.insert",map);

	}
	
}
