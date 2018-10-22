package com.withdog.web.abanddog;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.domain.AbandDog;

@Controller
@RequestMapping("/abandDog/*")
public class AbanddogController {
	
	public AbanddogController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['abandDogPageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['abandDogPageSize']}")
	int pageSize;
	
	@RequestMapping(value = "getAbandDogInfo", method = RequestMethod.GET)
	public String addAfterAsh() throws Exception {
		System.out.println("/getAbandDogInfo : GET");

		return "forward:/abandDog/getAbandDogInfo.jsp";
	}
	

	@RequestMapping(value="getAbandDogList")
	public String getAbandDogList(@ModelAttribute("Search") Search search, Model model) throws Exception{ 
		System.out.println("search : "+search);
		
		String dogBreed = search.getDogBreed()==null?"":search.getDogBreed();
		String sido = search.getSido()==null?"":search.getSido();
		String sigungu = search.getSigungu()==null?"":search.getSigungu();
		String abandDogState = search.getAbandDogState()==null?"":search.getAbandDogState();
		String abandDogGender = search.getAbandDogGender()==null?"":search.getAbandDogGender();
		
		System.out.println("dogBreed : "+dogBreed);
		System.out.println("sido : "+sido);
		System.out.println("sigungu : "+sigungu);
		System.out.println("abandDogState : "+abandDogState);
		System.out.println("abandDogGender : "+abandDogGender);

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		int totalCount = 0 ;
		
		//조회 종료날짜
		Calendar week = Calendar.getInstance();
		week.add(Calendar.DATE , -10);
		String beforeWeek = new java.text.SimpleDateFormat("yyyyMMdd").format(week.getTime());
		
		//조회 시작날짜
		Calendar week2 = Calendar.getInstance();
		week2.add(Calendar.DATE , -12);
		String beforeWeek2 = new java.text.SimpleDateFormat("yyyyMMdd").format(week2.getTime());
		
		String key = "vEYg%2BNRxHmeqdqQ0Ib90AFGCNR5kfBrGWu297fjkmhJ8NEby3rAPqzcJ75luVTmfoIck7Z10ZVDq6tjQ6%2F9dCQ%3D%3D";

        String kindPublic = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/kind?up_kind_cd=417000&ServiceKey="+key;
        String sidoKey = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/sido?ServiceKey="+key;
        String sigunguKey = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/sigungu?upr_cd="+sido+"&ServiceKey="+key;
        String abandonmentPublicAll = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?upkind=417000&bgnde="+beforeWeek2+"&endde="+beforeWeek+"&pageNo=1&numOfRows=1000&ServiceKey="+ key;
        String abandonmentPublic = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?upkind=417000&kind="+dogBreed+"&upr_cd="+sido+"&org_cd="+sigungu+"&state="+abandDogState+"&bgnde="+beforeWeek2+"&endde="+beforeWeek+"&pageNo=1&numOfRows=10000&ServiceKey="+ key;
        
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        
        // 시도
        Document docSido = dBuilder.parse(sidoKey);
        docSido.getDocumentElement().normalize();
        NodeList nListSido = docSido.getElementsByTagName("item");
        
        Map<String,String> mapSido = new HashMap<String, String>();
        
        for (int i = 0; i < nListSido.getLength(); i++) {
        	
			Node nNodeSido = nListSido.item(i);
			if(nNodeSido.getNodeType() == Node.ELEMENT_NODE) {
				Element element = (Element) nNodeSido;
				mapSido.put(getTagValue("orgCd",element), getTagValue("orgdownNm",element));
			}
		}
		//
        
        // 시군구
        Document docSigungu = dBuilder.parse(sigunguKey);
        docSigungu.getDocumentElement().normalize();
        NodeList nListSigungu = docSigungu.getElementsByTagName("item");
        
        Map<String,String> mapSigungu = new HashMap<String, String>();
        
        for (int i = 0; i < nListSigungu.getLength(); i++) {
        	
			Node nNodeSigungu = nListSigungu.item(i);
			if(nNodeSigungu.getNodeType() == Node.ELEMENT_NODE) {
				Element element = (Element) nNodeSigungu;
				mapSigungu.put(getTagValue("orgCd",element), getTagValue("orgdownNm",element));
			}
		}
		//
		
		// 전체견종
		Document docKindAll = dBuilder.parse(kindPublic);
        
        NodeList nListKindAll = docKindAll.getElementsByTagName("item");

        Map<String,String> mapKindAll = new HashMap<String, String>();
        
        for (int i = 0; i < nListKindAll.getLength(); i++) {
        	
			Node nNodeKindAll = nListKindAll.item(i);
			if(nNodeKindAll.getNodeType() == Node.ELEMENT_NODE) {
				Element element = (Element) nNodeKindAll;
				mapKindAll.put(getTagValue("KNm",element), getTagValue("kindCd",element));
			}
		}
		//
        
        // 조회 견종리스트
        Document docKind = dBuilder.parse(abandonmentPublicAll);
        
        docKind.getDocumentElement().normalize();
        NodeList nListKind = docKind.getElementsByTagName("item");
        
        Map<String,String> mapKind = new LinkedHashMap<String, String>();
        
        for (int i = 0; i < nListKind.getLength(); i++) {
			Node nNodeKind = nListKind.item(i);
			if(nNodeKind.getNodeType() == Node.ELEMENT_NODE) {
				Element element = (Element) nNodeKind;
				
				// 리스트에서 견종만 뽑아내는거
				String dogName = getTagValue("kindCd",element).replaceAll("\\[개\\] ", "");
		        if(mapKindAll.get(dogName) != null) {
		        	String dogNo = mapKindAll.get(dogName).toString();
		        	mapKind.put(dogNo,dogName);
		        }
			}
		}
        //
        

        // 조회 견종리스트
        Document docAband = dBuilder.parse(abandonmentPublic);
        
        docAband.getDocumentElement().normalize();
        NodeList nListAband = docAband.getElementsByTagName("item");
        
        List<AbandDog> listAll = new ArrayList<>();
        
        for (int i = 0; i < nListAband.getLength(); i++) {
			Node nNodeAband = nListAband.item(i);
			if(nNodeAband.getNodeType() == Node.ELEMENT_NODE) {
	        	AbandDog abandDog = new AbandDog();
				Element element = (Element) nNodeAband;
						        
	        	if(abandDogGender != "") {
	        		if(abandDogGender.equals(getTagValue("sexCd",element)) && getTagValue("processState",element).equals("보호중")) {
		        		if(totalCount>=pageSize*(search.getCurrentPage()-1) && totalCount<pageSize*search.getCurrentPage()) {
		    				abandDog.setDesertionNo(getTagValue("desertionNo",element));
		    				abandDog.setNoticeNo(getTagValue("noticeNo",element));
		    				abandDog.setAbandDogBreed(getTagValue("kindCd",element).replaceAll("\\[개\\] ", ""));
		    				abandDog.setAbandDogGender(getTagValue("sexCd",element));
		    				abandDog.setAbandDogFeature(getTagValue("specialMark",element));
		    				abandDog.setAbandDogState(getTagValue("processState",element));
		    				abandDog.setAbandDogImage(getTagValue("popfile",element));
		    				abandDog.setHappenPlace(getTagValue("happenPlace",element));
		    				abandDog.setAbandDogAge(getTagValue("age",element));
		    				abandDog.setAbandDogWeight(getTagValue("weight",element));
		    				abandDog.setAbandDogColor(getTagValue("colorCd",element));
		    				abandDog.setAbandDogNeuter(getTagValue("neuterYn",element));
		    				abandDog.setNoticeSdt(getTagValue("noticeSdt",element));
		    				abandDog.setNoticeEdt(getTagValue("noticeEdt",element));
		    				abandDog.setHappenDt(getTagValue("happenDt",element));
		    				abandDog.setCareNm(getTagValue("careNm",element));
		    				abandDog.setCareTel(getTagValue("careTel",element));
		    				abandDog.setOrgNm(getTagValue("orgNm",element));
//		    				abandDog.setChargeNm(getTagValue("chargeNm",element));
//		    				abandDog.setOfficeTel(getTagValue("officeTel",element));
		    				abandDog.setCareAddr(getTagValue("careAddr",element));
		    				listAll.add(abandDog);
		        		}	    				
			        	totalCount++;
	        		}
	        	}else {
	        		if(getTagValue("processState",element).equals("보호중")) {
		        			if(totalCount>=pageSize*(search.getCurrentPage()-1) && totalCount<pageSize*search.getCurrentPage()) {
		    				abandDog.setDesertionNo(getTagValue("desertionNo",element));
		    				abandDog.setNoticeNo(getTagValue("noticeNo",element));
		    				abandDog.setAbandDogBreed(getTagValue("kindCd",element).replaceAll("\\[개\\] ", ""));
		    				abandDog.setAbandDogGender(getTagValue("sexCd",element));
		    				abandDog.setAbandDogFeature(getTagValue("specialMark",element));
		    				abandDog.setAbandDogState(getTagValue("processState",element));
		    				abandDog.setAbandDogImage(getTagValue("popfile",element));
		    				abandDog.setHappenPlace(getTagValue("happenPlace",element));
		    				abandDog.setAbandDogAge(getTagValue("age",element));
		    				abandDog.setAbandDogWeight(getTagValue("weight",element));
		    				abandDog.setAbandDogColor(getTagValue("colorCd",element));
		    				abandDog.setAbandDogNeuter(getTagValue("neuterYn",element));
		    				abandDog.setNoticeSdt(getTagValue("noticeSdt",element));
		    				abandDog.setNoticeEdt(getTagValue("noticeEdt",element));
		    				abandDog.setHappenDt(getTagValue("happenDt",element));
		    				abandDog.setCareNm(getTagValue("careNm",element));
		    				abandDog.setCareTel(getTagValue("careTel",element));
		    				abandDog.setOrgNm(getTagValue("orgNm",element));
	//	    				abandDog.setChargeNm(getTagValue("chargeNm",element));
	//	    				abandDog.setOfficeTel(getTagValue("officeTel",element));
		    				abandDog.setCareAddr(getTagValue("careAddr",element));
		    				listAll.add(abandDog);
		        		}	       
			        	totalCount++;
	        		}
	        	}
			}
		}
        //

        System.out.println("페이지 수 : "+search.getCurrentPage());
        System.out.println("전체크기 : "+nListAband.getLength());
        System.out.println("검색 수 : "+totalCount);
        System.out.println("시도 : "+mapSido);
        System.out.println("시군구 : "+mapSigungu);
        System.out.println("견종 : "+mapKind);
        System.out.println("유기견 리스트 : "+listAll);
			
		Page resultPage = new Page( search.getCurrentPage(), totalCount, pageUnit, pageSize);

		model.addAttribute("sido", mapSido);		//	시도
		model.addAttribute("sigungu", mapSigungu);		//	시도
		model.addAttribute("breed", mapKind);	//	견종
		model.addAttribute("list", listAll);			//	유기견 리스트
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/abandDog/listAbandDog.jsp";
	}
	

	@RequestMapping(value="getAbandDog")
	public String getAbandDog(@ModelAttribute("abandDog") AbandDog abandDog) throws Exception{ 
		System.out.println("getAbandDog 시작");
		System.out.println("abandDog : "+abandDog);
		
		return "forward:/abandDog/getAbandDog.jsp";
	}

	private static String getTagValue(String tag, Element eElement) {
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}

}
