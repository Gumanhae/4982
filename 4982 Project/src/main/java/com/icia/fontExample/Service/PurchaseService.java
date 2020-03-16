package com.icia.fontExample.Service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.stereotype.*;
import org.springframework.util.*;
import org.springframework.web.client.*;

import com.icia.fontExample.Dao.*;
import com.icia.fontExample.date.dto.*;
import com.icia.fontExample.entity.*;

@Service
public class PurchaseService {
	@Autowired
	private WaitingPointDao waitingPointDao;
	@Autowired
	private PurchaseDao purchaseDao;
	@Autowired
	private SummaryDao summaryDao;
	
	@Value("#{config['express.pay.default']}")
	private long expressPay;
	@Value("#{config['express.pay.mountain']}")
	private long expressPayMountain;
	@Value("#{config['express.pay.jeju']}")
	private long expressPayJeju;
	
	public int insertPurchase(String username, long no,int quantity) {
		RestTemplate restTemplete = new RestTemplate();
		long price = restTemplete.getForObject("http://localhost:8081/fontExample/api/product/find/price?no="+no,Long.class);
		long userPrice = restTemplete.getForObject("http://localhost:8081/fontExample/api/point?username="+username, Long.class);
		String seller = restTemplete.getForObject("http://localhost:8081/fontExample/findsellerbyno?no="+no, String.class);
		long proQuantity = restTemplete.getForObject("http://localhost:8081/fontExample/api/product/quantity?no="+no,Long.class);
		Purchase purchase = new Purchase().builder().product_no(no).username(username).seller(seller).
				quantity(quantity).method(1).state(1).address_no(1).build();
		long point = price * quantity + expressPay;
		if((userPrice>=point)&&(quantity<=proQuantity)) {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("username",username);
			map.add("point", point);
			restTemplete.postForObject("http://localhost:8081/fontExample/api/point/down",map,String.class);
			purchaseDao.insert(purchase);
			WaitingPoint waitingPoint = new WaitingPoint().builder().no(purchase.getNo()).buyUsername(username)
				.sellUsername(seller).point(point).build();
			waitingPointDao.insert(waitingPoint);
			MultiValueMap<String, Object> map2 = new LinkedMultiValueMap<String, Object>();
			map2.add("no", no);
			map2.add("quantity", quantity*-1);
			restTemplete.postForObject("http://localhost:8081/fontExample/api/product/quantity", map2, String.class);
			return 1;
		} else {
			return 0;
		}
	}
	public long findPurchaseNo(String username, long no) {
		Purchase purchase = new Purchase();
		purchase.setProduct_no(no);
		purchase.setUsername(username);
		return purchaseDao.findPurchaseNo(purchase);
	}
	public PurchasePage findPurchaseBuyer(String username,int pageno,int pagesize){
		int count = purchaseDao.conutByState(username);
		int startRowNum = (pageno-1) * pagesize + 1;
		int endRowNum = pageno * pagesize;
		if(endRowNum==count) {
			endRowNum=count;
		}
		List<Purchase> Purchases = purchaseDao.findPurchaseBuyer(username,startRowNum,endRowNum);
		return new PurchasePage().builder().pageno(pageno).pagesize(pagesize).totalcount(count).Purchases(Purchases).build();
	}
	public PurchasePage findPurchaseSeller(String username,int pageno,int pagesize){
		int count = purchaseDao.conutByState(username);
		int startRowNum = (pageno-1) * pagesize + 1;
		int endRowNum = pageno * pagesize;
		if(endRowNum==count) {
			endRowNum=count;
		}
		List<Purchase> Purchases = purchaseDao.findPurchaseSeller(username,startRowNum,endRowNum);
		return new PurchasePage().builder().pageno(pageno).pagesize(pagesize).totalcount(count).Purchases(Purchases).build();
	}
	public int updateState(long no) {
		return purchaseDao.updateState(no);
	}
	public String purchaseComplete(long no) {
		Purchase rePurchase = purchaseDao.findPurchaseByNo(no);
		WaitingPoint reCharge = waitingPointDao.findByNo(no);
		Summary summary = new Summary().builder().productNo(rePurchase.getProduct_no()).buyerUsername(reCharge.getBuyUsername()).
				sellerUsername(reCharge.getSellUsername()).amount(rePurchase.getAmount()).quantity(rePurchase.getQuantity()).
				method(rePurchase.getMethod()).build();
		summaryDao.insert(summary);
		RestTemplate tpl = new RestTemplate();
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("username",reCharge.getSellUsername());
		map.add("point", reCharge.getPoint());
		tpl.postForObject("http://localhost:8081/fontExample/api/point/up",map,String.class);
		MultiValueMap<String, Long> map2 = new LinkedMultiValueMap<String, Long>();
		map2.add("amount", reCharge.getPoint());
		tpl.postForObject("http://localhost:8081/fontExample/api/statistics/dealcount", null,Integer.class);
		tpl.postForObject("http://localhost:8081/fontExample/api/statistics/dealamount",map2,Integer.class);
		waitingPointDao.delete(no);
		purchaseDao.delete(no);
		return "success";
	}
}
