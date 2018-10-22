package com.withdog.web.abanddog;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.domain.AbandDog;

@RestController
@RequestMapping("/abandDog/*")
public class AbanddogRestController {
	
	public AbanddogRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['healingDogPageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['healingDogPageSize']}")
	int pageSize;
	
	// 견종리스트
	@RequestMapping(value = "json/dogBreed")
	public Map<String,String> dogBreed() throws Exception{
		
		//오늘 날짜
//		Date today = new Date();         
//		SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd"); 
//		String toDay = date.format(today);
		
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
        String abandonmentPublic = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?upkind=417000&bgnde="+beforeWeek2+"&endde="+beforeWeek+"&pageNo=1&numOfRows=10000&ServiceKey="+ key;
        
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();

        Document doc = dBuilder.parse(kindPublic);
        
        NodeList nList = doc.getElementsByTagName("item");

        Map<String,String> map = new HashMap<String, String>();
        
        for (int i = 0; i < nList.getLength(); i++) {
        	
			Node nNode = nList.item(i);
			if(nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element element = (Element) nNode;
				map.put(getTagValue("KNm",element), getTagValue("kindCd",element));
			}
		}
        
        Document doc1 = dBuilder.parse(abandonmentPublic);
        
        doc1.getDocumentElement().normalize();
        NodeList nList1 = doc1.getElementsByTagName("item");
        
        Map<String,String> map1 = new LinkedHashMap<String, String>();
        
        for (int i = 0; i < nList1.getLength(); i++) {
        	
			Node nNode = nList1.item(i);
			if(nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element element = (Element) nNode;
				String dogName = getTagValue("kindCd",element).replaceAll("\\[개\\] ", "");
		        if(map.get(dogName) != null) {
		        	String dogNo = map.get(dogName).toString();
					map1.put(dogNo,dogName);
		        }
			}
		}
        //System.out.println(map);
        System.out.println(map1);
        //System.out.println(map1.size());
		
		return map1;
	}
	
	// 시도
	@RequestMapping(value = "json/sido")
	public Map<String,String> sido() throws Exception{
        String key = "vEYg%2BNRxHmeqdqQ0Ib90AFGCNR5kfBrGWu297fjkmhJ8NEby3rAPqzcJ75luVTmfoIck7Z10ZVDq6tjQ6%2F9dCQ%3D%3D";
        
        String sido = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/sido?ServiceKey="+key;
        
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        
        Document doc1 = dBuilder.parse(sido);
        
        doc1.getDocumentElement().normalize();
        NodeList nList1 = doc1.getElementsByTagName("item");
        
        Map<String,String> map = new HashMap<String, String>();
        
        for (int i = 0; i < nList1.getLength(); i++) {
        	
			Node nNode = nList1.item(i);
			if(nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element element = (Element) nNode;
				map.put(getTagValue("orgCd",element), getTagValue("orgdownNm",element));
			}
		}
		
		return map;
	}
	
	// 시군구
	@RequestMapping(value = "json/sigungu/{sido}")
	public Map<String,String> sigungu(@PathVariable String sido) throws Exception{
		System.out.println("sido : "+sido);
        String key = "vEYg%2BNRxHmeqdqQ0Ib90AFGCNR5kfBrGWu297fjkmhJ8NEby3rAPqzcJ75luVTmfoIck7Z10ZVDq6tjQ6%2F9dCQ%3D%3D";
        
        String sigungu = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/sigungu?upr_cd="+sido+"&ServiceKey="+key;
        
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        
        Document doc1 = dBuilder.parse(sigungu);
        
        doc1.getDocumentElement().normalize();
        NodeList nList1 = doc1.getElementsByTagName("item");
        
        Map<String,String> map = new HashMap<String, String>();
        
        for (int i = 0; i < nList1.getLength(); i++) {
        	
			Node nNode = nList1.item(i);
			if(nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element element = (Element) nNode;
				map.put(getTagValue("orgCd",element), getTagValue("orgdownNm",element));
			}
		}
		
		return map;
	}
	
	@RequestMapping(value = "json/getAbandDogList")
	public JSONObject getAbandDogList(@ModelAttribute("Search") Search search, @RequestParam("dogBreed") String dogBreed, @RequestParam("sido") String sido
														, @RequestParam("sigungu") String sigungu, @RequestParam("abandDogGender") String abandDogGender
														, @RequestParam("abandDogState") String abandDogState) throws Exception{
		System.out.println("currentPage : "+search.getCurrentPage());
		System.out.println("dogBreed : "+dogBreed);
		System.out.println("sido : "+sido);
		System.out.println("sigungu : "+sigungu);
		System.out.println("abandDogGender : "+abandDogGender);
		System.out.println("abandDogState : "+abandDogState);
				
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
		
        //String key = "vEYg%2BNRxHmeqdqQ0Ib90AFGCNR5kfBrGWu297fjkmhJ8NEby3rAPqzcJ75luVTmfoIck7Z10ZVDq6tjQ6%2F9dCQ%3D%3D";
        String key = "ExDLAgs3qtTZPi3Fj%2BaZpRoLstLp78b8uJjdKCZYS1qKDuXGAR%2FdJD6Tfk24TXzTb%2Bv%2BduOmyBbE5emt%2F%2FF2NQ%3D%3D";

        String abandonmentPublicAll = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?upkind=417000&kind="+dogBreed+"&upr_cd="+sido+"&org_cd="+sigungu+"&state="+abandDogState+"&bgnde="+beforeWeek2+"&endde="+beforeWeek+"&pageNo=1&numOfRows=10000&ServiceKey="+ key;
        
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();

        Document docAll = dBuilder.parse(abandonmentPublicAll);
        
        docAll.getDocumentElement().normalize();
        NodeList nListAll = docAll.getElementsByTagName("item");
        
        List<AbandDog> listAll = new ArrayList<>();
        for (int i = 0; i < nListAll.getLength(); i++) {
        	
			Node nNode = nListAll.item(i);
			if(nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element element = (Element) nNode;
	        	AbandDog abandDog = new AbandDog();		
	        	if(abandDogGender != "") {
	        		if(abandDogGender.equals(getTagValue("sexCd",element)) && getTagValue("processState",element).equals("보호중")) {
		        		if(totalCount>=8*(search.getCurrentPage()-1) && totalCount<8*search.getCurrentPage()) {
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
		        			if(totalCount>=8*(search.getCurrentPage()-1) && totalCount<8*search.getCurrentPage()) {
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
        
        
        System.out.println("전체크기 : "+nListAll.getLength());
        System.out.println("조회크기 : "+totalCount);

		Page resultPage = new Page( search.getCurrentPage(), totalCount, pageUnit, pageSize);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("list", listAll);
		jsonObject.put("resultPage", resultPage);
		
		return jsonObject;
	}

	private static String getTagValue(String tag, Element eElement) {
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}
}
