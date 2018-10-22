package com.withdog.web.dogbreeddic;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.withdog.service.dogbreeddic.DogBreedDicService;
import com.withdog.service.domain.DogBreedDic;

@Controller
@RequestMapping("/dogBreedDic/*")
public class DogBreedDicController {
	
	@Autowired
	@Qualifier("dogBreedDicServiceImpl")
	private DogBreedDicService dogBreedDicService;
	
	public DogBreedDicController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value = "getDogBreed", method = RequestMethod.GET)
	public String getDogBreed (Model model) throws Exception {
		System.out.println("/getDogBreed");
		List<DogBreedDic> list = dogBreedDicService.getAllDogBreedInfoListByKo();
		model.addAttribute("list",list);
		return "forward:/community/dogBreedDicSearch.jsp";
	}
	
	
	@RequestMapping(value = "getRate", method = RequestMethod.POST)
	public String html (String testa, Model model) throws Exception {
		System.out.println("testa ดย? : " + testa);
		model.addAttribute("testa",testa);
		return "forward:/community/test2.jsp";
	}

	


}
