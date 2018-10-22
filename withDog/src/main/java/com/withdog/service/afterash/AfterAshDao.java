package com.withdog.service.afterash;

import java.util.List;

import com.withdog.common.Search;
import com.withdog.service.domain.AfterAsh;
import com.withdog.service.domain.DogInfo;
import com.withdog.service.domain.User;

public interface AfterAshDao {
	public void addAfterAsh(AfterAsh afterAsh) throws Exception;

	public AfterAsh getAfterAsh(int afterAshNo) throws Exception;

	public void updateAfterAsh(AfterAsh afterAsh) throws Exception;

	public List<AfterAsh> getAfterAshList(Search search,User user) throws Exception;
	
	public List<AfterAsh> getAfterAshListByViewCount() throws Exception;

	public void deleteAfterAsh(AfterAsh afterAsh) throws Exception;
	
	public void updateViewCount(AfterAsh afterAsh) throws Exception;

	public int getTotalCount(Search search,User user) throws Exception;

}
