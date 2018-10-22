package com.withdog.web.purchase;

import java.net.URI;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.withdog.service.domain.Product;
import com.withdog.service.domain.Purchase;
import com.withdog.service.product.ProductService;
import com.withdog.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	
	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	//�����ڰ� ����ϱ��ư Ŭ���� ����� ����
	@RequestMapping( value="json/updatePurchaseConditionAdmin/{purchaseCondition}/{purchaseNo}")
	public String updatePurchaseConditionAdmin(@PathVariable String purchaseNo, @PathVariable String purchaseCondition) throws Exception{
		
		System.out.println("json/updatePurchaseConditionAdmin : ����ϱ�");
		
		Purchase purchase = new Purchase();
		purchase.setPurchaseNo(Integer.parseInt(purchaseNo));
		purchase.setPurchaseCondition(purchaseCondition);
		
		purchaseService.updatePurchaseCondition(purchase);
		
		return "1";
	}
	
	//ȸ���� ������� �� ����Ǻ���� �Բ� ���� ������Ʈ
	@RequestMapping( value="json/updateCancelPurchaseCondition/{purchaseCondition}/{purchaseNo}")
	public String updateCancelPurchaseCondition(@PathVariable String purchaseNo, @PathVariable String purchaseCondition) throws Exception{
		
		System.out.println("json/updateCancelPurchaseCondition : �������");
		
		System.out.println("���Ź�ȣ" + purchaseNo+ "�����ڵ�" + purchaseCondition);
		Purchase purchase = new Purchase();
		purchase.setPurchaseNo(Integer.parseInt(purchaseNo));
		purchase.setPurchaseCondition(purchaseCondition);
		purchaseService.updatePurchaseCondition(purchase);
		
		//���Ź�ȣ�������� ����Ʈ ��Ƽ�
		List<Purchase> purchaseList = purchaseService.getPurchase(Integer.parseInt(purchaseNo));
		
		for(int i=0; i<purchaseList.size(); i++) {
			int purchaseQuantity = purchaseList.get(i).getPurchaseQuantity();
			int prodNo = purchaseList.get(i).getProduct().getProdNo();
			System.out.println("���ż���" + purchaseQuantity);
			System.out.println("��ǰ��ȣ" + prodNo);
			
			Product product = productService.getProduct(prodNo);		// �ٽ� ������ ��ǰ�� ���� ���� �˾ƾ���, ������ ���� ��ǰ��ȣ �������� ��ǰ ã�ƿ�
			int prodQuantity = product.getProdQuantity();						//��ǰ��ȣ�� ������ ��ǰ��  �������
			System.out.println("��ǰ�������" + prodQuantity);
			prodQuantity = prodQuantity + purchaseQuantity;				//��ǰ ��������� + ���ż���(�������) 
			product.setProdQuantity(prodQuantity); 									//���� ��ǰ���� ��ǰ�����ο� ���
			productService.updateProductAdmin(product);						//�������� ������
		}
		
		return "1";
	}
	
	
	//ȸ���� ����Ȯ����ư Ŭ���� ����� ����
	@RequestMapping( value="json/updateMyPurchaseCondition/{purchaseCondition}/{purchaseNo}")
	public String updateMyPurchaseCondition(@PathVariable String purchaseNo, @PathVariable String purchaseCondition) throws Exception{
		
		System.out.println("json/updateMyPurchaseCondition : ����Ȯ��");
		
		Purchase purchase = new Purchase();
		purchase.setPurchaseNo(Integer.parseInt(purchaseNo));
		purchase.setPurchaseCondition(purchaseCondition);
		
		purchaseService.updatePurchaseCondition(purchase);
		
		return "1";
	}

	//�����ı⾲�� Ŭ���� �ۼ����� ��ǰ����Ʈ ��� ���� ���� 
	@RequestMapping(value = "json/getPurchaseProduct/{purchaseNo}")
	public JSONObject  getPurchaseProduct(@PathVariable("purchaseNo") int purchaseNo, HttpServletRequest request, Model model) throws Exception{ 
		
		System.out.println("/json/getPurchaseProduct : �����ı⾲��");

		List<Purchase> purchaseReviewProduct = purchaseService.getPurchaseCondition(purchaseNo)	;
		
		System.out.println(purchaseReviewProduct.size());
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("purchaseReviewProduct", purchaseReviewProduct);
		
		return jsonObject;
	}
	
	
}
