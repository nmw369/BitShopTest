package com.withdog.web.ash;

import java.net.URI;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialException;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.ash.AshService;
import com.withdog.service.common.CommonService;
import com.withdog.service.domain.Ash;
import com.withdog.service.domain.Consulting;
import com.withdog.service.domain.HealingDog;
import com.withdog.service.domain.Point;
import com.withdog.service.domain.User;
import com.withdog.service.sns.SnsService;
import com.withdog.service.user.UserService;

@RestController
@RequestMapping("/ash/*")
public class AshRestController {

	@Autowired
	@Qualifier("ashServiceImpl")
	private AshService ashService;

	@Autowired
	@Qualifier("snsServiceImpl")
	private SnsService snsService;

	@Autowired
	@Qualifier("commonServiceImpl")
	private CommonService commonService;

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	public AshRestController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "json/getMyReservationASHListAndroid") // 나의 예약리스트
	public JSONObject getMyReservationASHList(HttpServletRequest request) throws Exception {
		System.out.println("/getMyReservationASHListAndroid");
		Search search = new Search();
		search.setSorting(Integer.parseInt(request.getParameter("sorting")));
		System.out.println("서치 출력 ; " + search);

		User user = (User) userService.getUser(request.getParameter("userId"));

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
			search.setSearchKeyword("");
			search.setSearchStartDay("");
		}
		search.setPageSize(100);
		Map<String, Object> map = ashService.getAshMyReservationList(search, user.getUserId());
		System.out.println("맵확인 : " + map);
		System.out.println("리스트 넘기기전 리스트 확인 : " + map.get("list"));

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("list", map.get("list"));

		return jsonObject;
	}

	@RequestMapping(value = "json/getAllHealingDogList")
	public JSONObject getAllHealingDogList() throws Exception {
		System.out.println("/json/getAllHealingDogList");
		List<HealingDog> healingDogs = ashService.getHealingDogList();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("healingDogs", healingDogs);
		return jsonObject;
	}

	@RequestMapping(value = "json/getHealingDogListByDate/{ashReservationDate}")
	public JSONObject getHealingDogListByDate(@PathVariable String ashReservationDate) throws Exception {
		System.out.println("/json/getHealingDogListByDate");
		System.out.println("선택한 날짜는? : " + ashReservationDate);
		List<HealingDog> healingDogs = ashService.getHealingDogListByDate(ashReservationDate);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("healingDogs", healingDogs);
		return jsonObject;
	}

	@RequestMapping(value = "json/getAshReservationTimeCountByAndroid/{ashReservationDate}")
	public JSONObject getAshReservationTimeCountByAndroid(@PathVariable String ashReservationDate) throws Exception {
		System.out.println("/json/getAshReservationTimeCountByAndroid");
		System.out.println("선택한 날짜는? : " + ashReservationDate);
		List<Ash> ash = ashService.getAshReservationTimeCountByAndroid(ashReservationDate);
		System.out.println("결과 : " + ash);
		System.out.println("결과222 : " + ash.size());
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("ash", ash);
		return jsonObject;
	}

	@RequestMapping(value = "json/getHealingDog/{healingDogNo}")
	public JSONObject getHealingDog(@PathVariable int healingDogNo) throws Exception {
		System.out.println("/json/getHealingDog");
		HealingDog healingDog = ashService.getHealingDog(healingDogNo);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("healingDog", healingDog);
		return jsonObject;
	}

	@RequestMapping(value = "json/getAllReservationASHList")
	public String getAllReservationASHList() throws Exception {
		System.out.println("/json/getAllReservationASHList");

		List<Ash> list = ashService.getAllAshReservationList();
		JSONArray jsonArray = new JSONArray();

		System.out.println("list 출력 : " + list);

		for (Ash ash : list) {
			JSONObject jsonObject = new JSONObject();

			jsonObject.put("id", ash.getAshReservationNo()); // 예약번호
			jsonObject.put("title", ash.getHealingDog().getHealingDogName()); // 예약견 이름
			jsonObject.put("image", ash.getHealingDog().getHealingDogimage()); // 예약견 사진
			jsonObject.put("start", ash.getAshReservationDate()); // 날짜
			System.out.println("날짜출력 : " + ash.getAshReservationDate());
			switch (ash.getHealingDog().getHealingDogNo()) {
			case 10013:
				jsonObject.put("color", "#357cd4"); // 달력 색 파랑
				break;
			case 10014:
				jsonObject.put("color", "#3a87ad"); // 달력 색 기본
				break;
			case 10015:
				jsonObject.put("color", "#8fc9f3"); // 달력 색 연하늘
				break;
			case 10016:
				jsonObject.put("color", "#54bbac"); // 달력 색 민트
				break;
			case 10017:
				jsonObject.put("color", "#be9fef"); // 달력 색 연보라
				break;
			case 10018:
				jsonObject.put("color", "#388996"); // 달력 색 초록
				break;
			case 10019:
				jsonObject.put("color", "#8aace8"); // 달력 색 히늘
				break;
			case 10020:
				jsonObject.put("color", "#5a54b5"); // 달력 색 보라
				break;
			}


			if (ash.getAshReservationTime().equals("0")) { // 시간 0이면 오전 1이면 오후
				jsonObject.put("time", "[오전]");
			} else {
				jsonObject.put("time", "[오후]");
			}
			jsonArray.add(jsonObject);
		}
		JSONObject jsonObject2 = new JSONObject();
		SimpleDateFormat sim = new SimpleDateFormat("YYYY-MM-dd");
		Date d = new Date();
		String today = sim.format(d);
		jsonObject2.put("id", "지난날"); // 예약번호
		jsonObject2.put("title", "지난견"); // 예약견 이름
		jsonObject2.put("start", "2005-07-22"); // 날짜
		jsonObject2.put("end", today); // 날짜
		jsonArray.add(jsonObject2);
		System.out.println(jsonArray.toString());

		return jsonArray.toString();
	}

	@RequestMapping(value = "json/getAshReservationByHealingDog/{healingDogNo}")
	public String getAshReservationByHealingDog(@PathVariable int healingDogNo) throws Exception {
		System.out.println("/json/getAshReservationByHealingDog");
		List<Ash> list = ashService.getAshReservationByHealingDog(healingDogNo);
		JSONArray jsonArray = new JSONArray();

		System.out.println("list 출력 : " + list);

		for (Ash ash : list) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", ash.getAshReservationNo()); // 예약번호
			jsonObject.put("title", ash.getHealingDog().getHealingDogName()); // 예약견 이름
			jsonObject.put("image", ash.getHealingDog().getHealingDogimage()); // 예약견 사진
			jsonObject.put("start", ash.getAshReservationDate()); // 날짜
			switch (ash.getHealingDog().getHealingDogNo()) {
			case 10013:
				jsonObject.put("color", "#357cd4"); // 달력 색 파랑
				break;
			case 10014:
				jsonObject.put("color", "#3a87ad"); // 달력 색 기본
				break;
			case 10015:
				jsonObject.put("color", "#8fc9f3"); // 달력 색 연하늘
				break;
			case 10016:
				jsonObject.put("color", "#54bbac"); // 달력 색 민트
				break;
			case 10017:
				jsonObject.put("color", "#be9fef"); // 달력 색 연보라
				break;
			case 10018:
				jsonObject.put("color", "#388996"); // 달력 색 초록
				break;
			case 10019:
				jsonObject.put("color", "#8aace8"); // 달력 색 히늘
				break;
			case 10020:
				jsonObject.put("color", "#5a54b5"); // 달력 색 보라
				break;
			}

			if (ash.getAshReservationTime().equals("0")) { // 시간 0이면 오전 1이면 오후
				jsonObject.put("time", "[오전]");
			} else {
				jsonObject.put("time", "[오후]");
			}
			jsonArray.add(jsonObject);
		}
		JSONObject jsonObject2 = new JSONObject();
		SimpleDateFormat sim = new SimpleDateFormat("YYYY-MM-dd");
		Date d = new Date();
		String today = sim.format(d);
		jsonObject2.put("id", "지난날"); // 예약번호
		jsonObject2.put("title", "지난견"); // 예약견 이름
		jsonObject2.put("start", "2005-07-22"); // 날짜
		jsonObject2.put("end", today); // 날짜
		jsonArray.add(jsonObject2);
		System.out.println(jsonArray.toString());

		return jsonArray.toString();
	}

	@RequestMapping(value = "/json/getAshReservationTimeCount/{date}")
	public JSONObject getAshReservationTimeCount(@PathVariable String date,
			@RequestParam("healingDogNo") int healingDogNo) throws Exception {
		// int healingDogNo = Integer.parseInt(request.getParameter("healingDogNo"));
		System.out.println("넘어온 힐링독 넘버 : " + healingDogNo);
		System.out.println("넘어온 날짜 : " + date);

		// HealingDog healingDog = ashService.getHealingDog(healingDogNo);
		Ash ash = ashService.getAshReservationTimeCount(healingDogNo, date);

		// System.out.println("힐링독은? : " + healingDog);
		System.out.println("예약은? : " + ash);

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("ash", ash);

		return jsonObject;
	}

	// 컨설팅

	@RequestMapping(value = "json/updateConsultingState/{consultingNo}/{consultingState}")
	public int updateConsultingState(@PathVariable int consultingNo, @PathVariable String consultingState)
			throws Exception {
		System.out.println("/json/updateConsultingState");

		Consulting consulting = new Consulting();
		consulting.setConsultingNo(consultingNo);
		consulting.setConsultingState(consultingState);

		System.out.println(consulting);

		ashService.updateConsultingState(consulting);

		return 1;
	}

	@RequestMapping(value = "json/addConsulting/{healingDogNo}")
	public int addConsulting(@PathVariable int healingDogNo, HttpServletRequest request) throws Exception {
		System.out.println("/json/addConsulting");

		HttpSession session = request.getSession(false);
		User user = new User();
		user = (User) session.getAttribute("user");

		HealingDog healingDog = new HealingDog();
		healingDog.setHealingDogNo(healingDogNo);

		Consulting consulting = new Consulting();
		consulting.setUser(user);
		consulting.setHealingDog(healingDog);

		System.out.println(consulting);

		ashService.addConsulting(consulting);

		return 1;
	}

	// end 컨설팅
	@RequestMapping(value = "json/android/kakaoPay")
	private JSONObject paymentReady2(@ModelAttribute("ash") Ash ash, HttpServletRequest req)
			throws RestClientException, URISyntaxException, Exception {
		System.out.println("kakaoPay Start==================================");

		System.out.println(req.getParameter("userId"));
		System.out.println(req.getParameter("usePoint"));
		System.out.println(req.getParameter("reservationData"));
		ash.setAshReservationDate(req.getParameter("reservationData"));
		System.out.println(ash.toString());
		User user;
		if (req.getParameter("userId") != null) {
			user = userService.getUser(req.getParameter("userId"));
		} else {
			user = new User();
		}
		int price = 0;
		int usePoint = 0;

		/// 영수증.jsp로 카드 결제시 callback 되는지
		String forwardUri = "forward:/sns/kakaoPay.jsp";
		// snsKakaoPay를 위한 로직
		Point pointAsh = new Point();
		pointAsh.setUser(user);
		pointAsh.setAsh(ash);
		System.out.println(1);

		if (pointAsh.getAsh().getAshReservationPrice() == 0) { // 결제 시 사용금액이 0이라면?
			System.out.println("사용한 결제금액이 없다면");
			price = pointAsh.getAsh().getAshReservationPrice(); // price에 0을 넣는다.
		}

		if (Integer.parseInt(req.getParameter("usePoint")) != 0) { // 사용한 포인트가 0이 아니라면
			pointAsh.setUsePoint(Integer.parseInt(req.getParameter("usePoint")));
			usePoint = Integer.parseInt(req.getParameter("usePoint"));
		}
		System.out.println(price + "::" + usePoint);

		System.out.println(123);
		String uri = "http://192.168.0.34:8080/ash/addReservationASHViewAndroid?userId=" + req.getParameter("userId")

				+ "&a=" + ash.getAshReservationAddress1() + "&b=" + ash.getAshReservationAddress2() + "&c="
				+ ash.getAshReservationPhone() + "&d=" + ash.getAshReservationEtc() + "&e="
				+ ash.getAshReservationPrice() + "&f=" + ash.getAshReservationDate() + "&g="
				+ ash.getAshReservationTime() + "&h=" + ash.getHealingDog().getHealingDogNo() + "&i="
				+ ash.getHealingDog().getHealingDogHealer() + "&j=" + req.getParameter("usePoint") + "&state=";
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		JSONObject jobj = snsService.AshKakaoPay(pointAsh, uri); // 카카오페이 다녀와서 데이터를 받는 객체
		System.out.println(jobj.get("tid"));
		String url = (String) jobj.get("next_redirect_app_url");
		// String url = (String)jobj.get("android_app_scheme");
		System.out.println(url);
		// System.out.println(url.replaceAll("kakaotalk", "intent"));
		JSONObject jsonUrl = new JSONObject();
		jsonUrl.put("url", url);

		System.out.println("끝남");

		return jsonUrl;

	}

}
