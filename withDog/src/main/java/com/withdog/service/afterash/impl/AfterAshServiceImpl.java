package com.withdog.service.afterash.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.common.Search;
import com.withdog.service.afterash.AfterAshDao;
import com.withdog.service.afterash.AfterAshService;
import com.withdog.service.ash.AshDAO;
import com.withdog.service.domain.AfterAsh;
import com.withdog.service.domain.DogInfo;
import com.withdog.service.domain.User;

@Service("afterAshServiceImpl")
public class AfterAshServiceImpl implements AfterAshService {

	@Autowired
	@Qualifier("afterAshDaoImpl")
	private AfterAshDao afterAshDao;

	public AfterAshServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addAfterAsh(AfterAsh afterAsh) throws Exception {
		afterAshDao.addAfterAsh(afterAsh);

	}

	@Override
	public AfterAsh getAfterAsh(int afterAshNo) throws Exception {
		AfterAsh afterAsh = afterAshDao.getAfterAsh(afterAshNo);
		////조회수 증가
		int viewCount = Integer.parseInt(afterAsh.getViewCount());
		viewCount++;
		String viewCount2 = Integer.toString(viewCount);
		afterAsh.setViewCount(viewCount2);
		afterAshDao.updateViewCount(afterAsh);
		////// end 조회수 증가
		return afterAsh;
	}

	@Override
	public void updateAfterAsh(AfterAsh afterAsh) throws Exception {
		afterAshDao.updateAfterAsh(afterAsh);

	}

	@Override
	public Map<String,Object> getAfterAshList(Search search,User user) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		List<AfterAsh> list = afterAshDao.getAfterAshList(search,user);
		int totalCount = afterAshDao.getTotalCount(search,user);
		
		map.put("list", list);
		map.put("totalCount", totalCount);

		return map;
	}

	@Override
	public void deleteAfterAsh(AfterAsh afterAsh) throws Exception {
		afterAshDao.deleteAfterAsh(afterAsh);

	}

	@Override
	public List<AfterAsh> getAfterAshListByViewCount() throws Exception {
		// TODO Auto-generated method stub
		return afterAshDao.getAfterAshListByViewCount();
	}

}
