package com.withdog.web.afterash;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;import com.withdog.service.afterash.AfterAshDao;
import com.withdog.service.afterash.AfterAshService;
import com.withdog.service.domain.AfterAsh;

@RestController
@RequestMapping("/afterAsh/*")
public class AfterAshRestController {
	
	@Autowired
	@Qualifier("afterAshServiceImpl")
	private AfterAshService afterAshService;
	
	public AfterAshRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value = "json/getAfterAshListByViewCount")
	public JSONObject getAfterAshListByViewCount() throws Exception{
		List<AfterAsh> list = afterAshService.getAfterAshListByViewCount();
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("list", list);
		
		return jsonObject;
	}

}
