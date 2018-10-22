package com.withdog.service.afterash;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.AfterAsh;
import com.withdog.service.domain.User;

public interface AfterAshService {
	public void addAfterAsh(AfterAsh afterAsh) throws Exception;

	public AfterAsh getAfterAsh(int afterAshNo) throws Exception;

	public void updateAfterAsh(AfterAsh afterAsh) throws Exception;

	public Map<String, Object> getAfterAshList(Search search,User user) throws Exception;

	public void deleteAfterAsh(AfterAsh afterAsh) throws Exception;

	public List<AfterAsh> getAfterAshListByViewCount() throws Exception;
}
