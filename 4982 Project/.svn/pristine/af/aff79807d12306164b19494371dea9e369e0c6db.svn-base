package com.icia.fontExample.Service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.fontExample.Dao.*;
import com.icia.fontExample.entity.*;

@Service
public class TalkerService {
	@Autowired
	private TalkDao dao;

	public Purchase findTalker(long no) {
		return dao.finTalker(no);
	}

	public Member findBuyer(String username) {
		return dao.findbuyer(username);
	}
}
