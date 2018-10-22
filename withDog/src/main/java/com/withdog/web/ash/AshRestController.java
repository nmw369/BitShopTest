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

	@RequestMapping(value = "json/getMyReservationASHListAndroid") // ���� ���ฮ��Ʈ
	public JSONObject getMyReservationASHList(HttpServletRequest request) throws Exception {
		System.out.println("/getMyReservationASHListAndroid");
		Search search = new Search();
		search.setSorting(Integer.parseInt(request.getParameter("sorting")));
		System.out.println("��ġ ��� ; " + search);

		User user = (User) userService.getUser(request.getParameter("userId"));

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
			search.setSearchKeyword("");
			search.setSearchStartDay("");
		}
		search.setPageSize(100);
		Map<String, Object> map = ashService.getAshMyReservationList(search, user.getUserId());
		System.out.println("��Ȯ�� : " + map);
		System.out.println("����Ʈ �ѱ���� ����Ʈ Ȯ�� : " + map.get("list"));

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
		System.out.println("������ ��¥��? : " + ashReservationDate);
		List<HealingDog> healingDogs = ashService.getHealingDogListByDate(ashReservationDate);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("healingDogs", healingDogs);
		return jsonObject;
	}

	@RequestMapping(value = "json/getAshReservationTimeCountByAndroid/{ashReservationDate}")
	public JSONObject getAshReservationTimeCountByAndroid(@PathVariable String ashReservationDate) throws Exception {
		System.out.println("/json/getAshReservationTimeCountByAndroid");
		System.out.println("������ ��¥��? : " + ashReservationDate);
		List<Ash> ash = ashService.getAshReservationTimeCountByAndroid(ashReservationDate);
		System.out.println("��� : " + ash);
		System.out.println("���222 : " + ash.size());
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

		System.out.println("list ��� : " + list);

		for (Ash ash : list) {
			JSONObject jsonObject = new JSONObject();

			jsonObject.put("id", ash.getAshReservationNo()); // �����ȣ
			jsonObject.put("title", ash.getHealingDog().getHealingDogName()); // ����� �̸�
			jsonObject.put("image", ash.getHealingDog().getHealingDogimage()); // ����� ����
			jsonObject.put("start", ash.getAshReservationDate()); // ��¥
			System.out.println("��¥��� : " + ash.getAshReservationDate());
			switch (ash.getHealingDog().getHealingDogNo()) {
			case 10013:
				jsonObject.put("color", "#357cd4"); // �޷� �� �Ķ�
				break;
			case 10014:
				jsonObject.put("color", "#3a87ad"); // �޷� �� �⺻
				break;
			case 10015:
				jsonObject.put("color", "#8fc9f3"); // �޷� �� ���ϴ�
				break;
			case 10016:
				jsonObject.put("color", "#54bbac"); // �޷� �� ��Ʈ
				break;
			case 10017:
				jsonObject.put("color", "#be9fef"); // �޷� �� ������
				break;
			case 10018:
				jsonObject.put("color", "#388996"); // �޷� �� �ʷ�
				break;
			case 10019:
				jsonObject.put("color", "#8aace8"); // �޷� �� ����
				break;
			case 10020:
				jsonObject.put("color", "#5a54b5"); // �޷� �� ����
				break;
			}


			if (ash.getAshReservationTime().equals("0")) { // �ð� 0�̸� ���� 1�̸� ����
				jsonObject.put("time", "[����]");
			} else {
				jsonObject.put("time", "[����]");
			}
			jsonArray.add(jsonObject);
		}
		JSONObject jsonObject2 = new JSONObject();
		SimpleDateFormat sim = new SimpleDateFormat("YYYY-MM-dd");
		Date d = new Date();
		String today = sim.format(d);
		jsonObject2.put("id", "������"); // �����ȣ
		jsonObject2.put("title", "������"); // ����� �̸�
		jsonObject2.put("start", "2005-07-22"); // ��¥
		jsonObject2.put("end", today); // ��¥
		jsonArray.add(jsonObject2);
		System.out.println(jsonArray.toString());

		return jsonArray.toString();
	}

	@RequestMapping(value = "json/getAshReservationByHealingDog/{healingDogNo}")
	public String getAshReservationByHealingDog(@PathVariable int healingDogNo) throws Exception {
		System.out.println("/json/getAshReservationByHealingDog");
		List<Ash> list = ashService.getAshReservationByHealingDog(healingDogNo);
		JSONArray jsonArray = new JSONArray();

		System.out.println("list ��� : " + list);

		for (Ash ash : list) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", ash.getAshReservationNo()); // �����ȣ
			jsonObject.put("title", ash.getHealingDog().getHealingDogName()); // ����� �̸�
			jsonObject.put("image", ash.getHealingDog().getHealingDogimage()); // ����� ����
			jsonObject.put("start", ash.getAshReservationDate()); // ��¥
			switch (ash.getHealingDog().getHealingDogNo()) {
			case 10013:
				jsonObject.put("color", "#357cd4"); // �޷� �� �Ķ�
				break;
			case 10014:
				jsonObject.put("color", "#3a87ad"); // �޷� �� �⺻
				break;
			case 10015:
				jsonObject.put("color", "#8fc9f3"); // �޷� �� ���ϴ�
				break;
			case 10016:
				jsonObject.put("color", "#54bbac"); // �޷� �� ��Ʈ
				break;
			case 10017:
				jsonObject.put("color", "#be9fef"); // �޷� �� ������
				break;
			case 10018:
				jsonObject.put("color", "#388996"); // �޷� �� �ʷ�
				break;
			case 10019:
				jsonObject.put("color", "#8aace8"); // �޷� �� ����
				break;
			case 10020:
				jsonObject.put("color", "#5a54b5"); // �޷� �� ����
				break;
			}

			if (ash.getAshReservationTime().equals("0")) { // �ð� 0�̸� ���� 1�̸� ����
				jsonObject.put("time", "[����]");
			} else {
				jsonObject.put("time", "[����]");
			}
			jsonArray.add(jsonObject);
		}
		JSONObject jsonObject2 = new JSONObject();
		SimpleDateFormat sim = new SimpleDateFormat("YYYY-MM-dd");
		Date d = new Date();
		String today = sim.format(d);
		jsonObject2.put("id", "������"); // �����ȣ
		jsonObject2.put("title", "������"); // ����� �̸�
		jsonObject2.put("start", "2005-07-22"); // ��¥
		jsonObject2.put("end", today); // ��¥
		jsonArray.add(jsonObject2);
		System.out.println(jsonArray.toString());

		return jsonArray.toString();
	}

	@RequestMapping(value = "/json/getAshReservationTimeCount/{date}")
	public JSONObject getAshReservationTimeCount(@PathVariable String date,
			@RequestParam("healingDogNo") int healingDogNo) throws Exception {
		// int healingDogNo = Integer.parseInt(request.getParameter("healingDogNo"));
		System.out.println("�Ѿ�� ������ �ѹ� : " + healingDogNo);
		System.out.println("�Ѿ�� ��¥ : " + date);

		// HealingDog healingDog = ashService.getHealingDog(healingDogNo);
		Ash ash = ashService.getAshReservationTimeCount(healingDogNo, date);

		// System.out.println("��������? : " + healingDog);
		System.out.println("������? : " + ash);

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("ash", ash);

		return jsonObject;
	}

	// ������

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

	// end ������
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

		/// ������.jsp�� ī�� ������ callback �Ǵ���
		String forwardUri = "forward:/sns/kakaoPay.jsp";
		// snsKakaoPay�� ���� ����
		Point pointAsh = new Point();
		pointAsh.setUser(user);
		pointAsh.setAsh(ash);
		System.out.println(1);

		if (pointAsh.getAsh().getAshReservationPrice() == 0) { // ���� �� ���ݾ��� 0�̶��?
			System.out.println("����� �����ݾ��� ���ٸ�");
			price = pointAsh.getAsh().getAshReservationPrice(); // price�� 0�� �ִ´�.
		}

		if (Integer.parseInt(req.getParameter("usePoint")) != 0) { // ����� ����Ʈ�� 0�� �ƴ϶��
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
		JSONObject jobj = snsService.AshKakaoPay(pointAsh, uri); // īī������ �ٳ�ͼ� �����͸� �޴� ��ü
		System.out.println(jobj.get("tid"));
		String url = (String) jobj.get("next_redirect_app_url");
		// String url = (String)jobj.get("android_app_scheme");
		System.out.println(url);
		// System.out.println(url.replaceAll("kakaotalk", "intent"));
		JSONObject jsonUrl = new JSONObject();
		jsonUrl.put("url", url);

		System.out.println("����");

		return jsonUrl;

	}

}
