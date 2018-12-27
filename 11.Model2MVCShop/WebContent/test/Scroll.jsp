<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script language="javascript">
/*$(document).ready(function () {
	  $(document).scroll(function() {
	    var maxHeight = $(document).height();
	    var currentScroll = $(window).scrollTop() + $(window).height();
		
	    if (maxHeight <= currentScroll + 1000) {
	    	alert(maxHeight);
	    	alert(currentScroll);
	    	$("#enters").append("<h1>Page " + page + "</h1><BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~");
	    }
	  })
	}); */
/* var page = 1;	
$(window).scroll(function() {
	  if ($(window).scrollTop() == $(document).height() - $(window).height()) {
      alert($(window).height());
    	console.log(++page);
      $("#enters").append("<h1>Page " + page + "</h1><BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~");
      
    }
}); */
var page = 1;	
$(window).scroll(function() {
	
	var scrollHeight = $(window).scrollTop() + $(window).height();
	var documentHeight = $(document).height();
	if (scrollHeight >= documentHeight){
	   console.log($(window).scrollTop());
	   console.log($(document).height());
	   console.log($(window).height());
	   
     /*  $("#enters").append("<h1>Page " + page + "</h1><BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~"); */
      
    }
});

[{"reference":"CmRSAAAAKSixIxQggYYBl3jmbDpv2zL1SiU6pshAbkHdo1VnIZ37neqZ-Dzm7LoWl--fqzoDrZ8GIlW_5lVrcbpxJ8Rid1QGoMyhRcfpyLDob7umLaxdWRQH8Hr7C_uJeANMYfsdEhCsZ6QCWmsWOO2XYNKj3UKTGhSf3eEUIHl6a-iwiSeEftthlOj8RA",
	"types":["hospital","point_of_interest","establishment"],
	"scope":"GOOGLE","icon":"https:\/\/maps.gstatic.com\/mapfiles\/place_api\/icons\/doctor-71.png",
	"name":"메디스캔종합검진센터",
	"opening_hours":{"open_now":true,"weekday_text":[]},
	"rating":4,
	"geometry":{"viewport":{"southwest":{"lng":127.0268542197085,"lat":37.4942664197085},
		"northeast":{"lng":127.0295521802915,"lat":37.4969643802915}},
		"location":{"lng":127.0282032,"lat":37.4956154}},
		"vicinity":"20층, 대한민국 서울특별시 서초구 서초동 강남대로 369 1328-3 에이플러스에셋타워, 369 Gangnam-daero, Seocho-gu",
		"id":"5794a3e7d1d2012ed9a1a162f8d47fe10c3f69ce",
		"place_id":"ChIJFfk0oU-hfDURzpSBX06wXvQ"},
		{"reference":"CmRSAAAAcPhgUJ8tY7nY6-XDJLWX-1cgSFtpoVmRT1qa3ViXxzbsSFlPbTHW-xegsc8-GTijl36osMuI5vGA9NV1bhpltU0fQOa8ljNlAoDwjoQrMB-rlRY_lTyxVpNJFrcFWqObEhBefvVNl35VesH5SXDxrs8tGhTJzMR9RZnEOt0B2pt_H56fXf-vuQ",
	"types":["hospital","health","point_of_interest","establishment"],"scope":"GOOGLE","icon":"https:\/\/maps.gstatic.com\/mapfiles\/place_api\/icons\/doctor-71.png","name":"최수호신경정신과의원","geometry":{"viewport":{"southwest":{"lng":127.0280343197085,"lat":37.49189011970849},"northeast":{"lng":127.0307322802915,"lat":37.49458808029149}},"location":{"lng":127.0293833,"lat":37.49323909999999}},"vicinity":"1329-8 Seocho 2(i)-dong, Seocho-gu","id":"4597054e0480a966d6845c98cc2cadcb6413b795","place_id":"ChIJVXHiCVChfDURqiwzOZYOiME"},{"reference":"CmRSAAAA3N46_W5Ya_7TPhc4Zc0KMwvL4fHKJpkDh_WiFXzoDosVbmwGgRSeWi_Mqfi5RieSOs9M_bFGuoCOhrV2CiDmSLDuPqob5piJPf0yVB89il1m2WpdtQ7LepdFdoqY9qegEhBta7Oo-mAFdbAsN3lIqyyGGhT32i5K1NIKbiNnHZq9A0Fe2J7Jqg","types":["hospital","doctor","health","point_of_interest","establishment"],"scope":"GOOGLE","icon":"https:\/\/maps.gstatic.com\/mapfiles\/place_api\/icons\/generic_business-71.png","name":"마음편한유외과","opening_hours":{"open_now":true,"weekday_text":[]},"geometry":{"viewport":{"southwest":{"lng":127.0275980197085,"lat":37.4925130197085},"northeast":{"lng":127.0302959802915,"lat":37.4952109802915}},"location":{"lng":127.028947,"lat":37.49386199999999}},"vicinity":"349, Gangnam-daero, Seocho-gu","id":"49368f0eb4a1140e7ea2e23656003b31cf24dbb7","place_id":"ChIJFes1mVqhfDUR0CwkRdpQMJY"},{"reference":"CmRRAAAAjZnI7CvgE5t7xoIzsPT_GwedKwZPQPRIDkw-nnF6qmBDFDzw4BLlNveUbvGU8dhePsp8ru_UD_pho1-M52ZwpVr14LDl5amMikLwILlDDSthw3jsNlIbycbs_EQ46VtJEhCV-Ctv1SUYLSifXhttHpqnGhQnSAnXYk8QHHG9emHsWSnv0WAbYQ","types":["hospital","doctor","health","point_of_interest","establishment"],"scope":"GOOGLE","icon":"https:\/\/maps.gstatic.com\/mapfiles\/place_api\/icons\/generic_business-71.png","name":"노들담한의원","opening_hours":{"open_now":true,"weekday_text":[]},"geometry":{"viewport":{"southwest":{"lng":127.0290148197085,"lat":37.4934869197085},"northeast":{"lng":127.0317127802915,"lat":37.49618488029149}},"location":{"lng":127.0303638,"lat":37.4948359}},"vicinity":"강남대로 78길 12, 예미프레스티지 빌딩 11층, Gangnam-gu","id":"293bd6b54813b989522167d075cbc06e9d9bbe06","photos":[{"photo_reference":"CmRaAAAArAZL8ktwmqePsNroDTny_aVcl8R50KrgYK2K5BqfhZJgIFmgKX6mXqWRpeDklxiTe-kMrfneRuLzPi3RxD0xJfZ_X2rHwqFzWRUKAjakPAQPirxGov3x-qFBX9MIJOBTEhB0CUi75PjYQMVPHH4sFAmLGhQvE5jwI7yvukdh2OQR3DrWJfJ07Q","width":2988,"html_attributions":["<a href=\"https:\/\/maps.google.com\/maps\/contrib\/113240006585155782056\/photos\">노들담한의원<\/a>"],"height":5312}],"place_id":"ChIJ5crpjVChfDURVLrTCuJpMF8"},{"reference":"CmRRAAAA40askvADr4FO4hfih8qRTiM1wjOYLG3IPfDyYfrYzci71Z7LyzHlTMqOOT-hXCx_oGNy0tpqDLOs0HfB_OBVQQ4yn8Td8cXkzvoxDIMRg38Y4jXQj3Z0oOxhnC5eYwfQEhDMAd4236F5UA5bi1O1ltozGhQyMEybDL3BVh9dTUkdhBglT23FZA","types":["hospital","doctor","health","point_of_interest","establishment"],"scope":"GOOGLE","icon":"https:\/\/maps.gstatic.com\/mapfiles\/place_api\/icons\/doctor-71.png","name":"기쁨병원","opening_hours":{"open_now":true,"weekday_text":[]},"rating":4,"geometry":{"viewport":{"southwest":{"lng":127.0323700197085,"lat":37.48854301970849},"northeast":{"lng":127.0350679802915,"lat":37.49124098029149}},"location":{"lng":127.033719,"lat":37.48989199999999}},"vicinity":"942-3, Gangnam-gu","id":"fdd8dfa8d224b03d2a3042f2fbafedf9f6343b6d","photos":[{"photo_reference":"CmRaAAAAguDm4pSal44jHtjpRjyGpXAvn4JHFOIoLzeowg4-uRRo328YvxMcMeGi40U5lwsYPZsboMlKSJld_XiS1lSzQ4_ladjh79AROVWiMt8czNn1OKhg3iRJziZ2EteTdnKXEhBR0PLRs9zl3t-OM93MX5ygGhTcCFrnb30QKIDC3CmKSP-XYTvTzA","width":720,"html_attributions":["<a href=\"https:\/\/maps.google.com\/maps\/contrib\/108592222201990681807\/photos\">Gipum Hospital기쁨병원<\/a>"],"height":437}],"place_id":"ChIJtUlfEU6hfDURt9dkuiGhNjY"},{"reference":"CmRSAAAAZnzMrd8T4qaU_4NaqjWRsmYC5OS7tbudJA2peBTQ0IP5n5k0eTLfdDEv_GhI9EPdEfiQ7yycgcTTKcbwe9pQRSTV4q0-NY61I7opaKQn7jChGcD8azSE1VktAfycFvvwEhBsPrgZHtZiZbp_yC7LZe8BGhQGH_reSwQJxOosdsM8rrfnbSOvoQ","types":["hospital","health","point_of_interest","establishment"],"scope":"GOOGLE","icon":"https:\/\/maps.gstatic.com\/mapfiles\/place_api\/icons\/doctor-71.png","name":"성모힐정신건강의학과의원","opening_hours":{"open_now":true,"weekday_text":[]},"rating":5,"geometry":{"viewport":{"southwest":{"lng":127.0294936197085,"lat":37.4910324197085},"northeast":{"lng":127.0321915802915,"lat":37.4937303802915}},"location":{"lng":127.0308426,"lat":37.4923814}},"vicinity":"328 강남역 쉐르빌 2F, Gangnam-daero, Gangnam-gu","id":"36951c1cffe7ed854083ba86c027149ccfee9490","photos":[{"photo_reference":"CmRaAAAAZHgHYlLz7Ev5ImWjdk9s9c5ZxPiW7sG6Am3_BqkcALcAZp6nt2vHNUggxzME5xRnrtvZ-qbkw9lWkG1HZlHxYBtqdFng8AxcfLNaURXqoIPjmmO_18QfsNOZPWYSGCS-EhBhyqMMIA1DnxrOs4EIIqniGhTZRc2hYc3l31Yclcbm9A4KLK2Aug","width":2835,"html_attributions":["<a href=\"https:\/\/maps.google.com\/maps\/contrib\/107854179628520509946\/photos\">성모힐정신건강의학과<\/a>"],"height":2846}],"place_id":"ChIJszItI1ChfDUR_FTyJvpFTew"},{"reference":"CmRSAAAA6F_BQ20kVKYCQTkISjAp67bPXn-TRLE0YZT3-2rmrnB7khGjtpm7I6MSoI4tSBCm0ZiI7Utw5gKDvGLXRUdeWLEYUmolEkyFMRDrUoDJXpvucm7gvDxCsC0jy9KOM3EYEhCgVWg-U3s-PvoK2Oe4cQhoGhRny2TxirYkAdaTX1VazCCkqJg5-A","types":["hospital","point_of_interest","establishment"],"scope":"GOOGLE","icon":"https:\/\/maps.gstatic.com\/mapfiles\/place_api\/icons\/doctor-71.png","name":"약손사랑 혈경락 마사지","geometry":{"viewport":{"southwest":{"lng":127.0291496197085,"lat":37.4892194197085},"northeast":{"lng":127.0318475802915,"lat":37.4919173802915}},"location":{"lng":127.0304986,"lat":37.4905684}},"vicinity":"-dong, 1338-21 서초2동, 서초구","id":"d6ea6c09084eb0c6a69cfb2e8059702acc9ab8e3","place_id":"ChIJG4u2lU-hfDURXi1sYP75xus"},{"reference":"CmRRAAAA1YrryMhknJQdkvmN14ig4XePiQFtLio-NbMKPglD6kcxCYmMw5ajBEeAEpIuDaS9lyuo0fJCky4TVdSTDpiS93gufbYIJI7nj1xJy6hfRCaBin6HTdBi0CkGY1jDxPCcEhAWFs-ZcWJXb4RVGzKCbL96GhS7MO01QeF6LV7VrnDY1ZhIhVyFQw","types":["hospital","point_of_interest","establishment"],"scope":"GOOGLE","icon":"https:\/\/maps.gstatic.com\/mapfiles\/place_api\/icons\/doctor-71.png","name":"강남서울외과의원","opening_hours":{"open_now":true,"weekday_text":[]},"rating":3,"geometry":{"viewport":{"southwest":{"lng":127.0278170197085,"lat":37.49434701970849},"northeast":{"lng":127.0305149802915,"lat":37.49704498029149}},"location":{"lng":127.029166,"lat":37.495696}},"vicinity":"826-23, Gangnam-gu","id":"8d7952cba6e6b45a825c44c1a4fb8e54434a02f5","photos":[{"photo_reference":"CmRaAAAApWMM_GcMy8JIA0RJrSR-V946jqtUxcVNs0G8Y7tEoOkrl1r98kPtpTisWPi7IHdjcPWvujQF0DZvVKPVfe9kifHExBdHwu4J0Wa7MO2lqIVoFb1ZOxdONWqOpRsaudGDEhD2Hg_-UAGTX89pHuE-EPPmGhR7lqLySKioh4PHStE-jgtF3VT4mg","width":2048,"html_attributions":["<a href=\"https:\/\/maps.google.com\/maps\/contrib\/112393011841117958728\/photos\">강남서울외과의원<\/a>"],"height":1152}],"place_id":"ChIJjySwdVqhfDUR8rnjke6uQVA"},{"reference":"CmRSAAAAiJAYNaZtE8KIP92BwVDESxDGy_SZfzjU01ZfMWG50ZcBhfOpzlg74l1ufm8sLWRAL8nUHXf-Om0aJW94TFHwbAhe3-kg2Xkoi71y-SMBgPBOQc1dQYFtqHgpdG6dA1HhEhD6ttv8cW0ijwlRngqvw5aOGhSEPdaF83Z9zOqerkRv8kiBm9ydiQ","types":["hospital","point_of_interest","establishment"],"scope":"GOOGLE","icon":"https:\/\/maps.gstatic.com\/mapfiles\/place_api\/icons\/doctor-71.png","name":"Shiminan clinic","rating":5,"geometry":{"viewport":{"southwest":{"lng":127.0274550197085,"lat":37.49486761970849},"northeast":{"lng":127.0301529802915,"lat":37.49756558029149}},"location":{"lng":127.028804,"lat":37.49621659999999}},"vicinity":"826 Yeoksam-dong, Gangnam-gu","id":"58d2cca537edfb3e153a6e26880d2d29de4d7c7c","place_id":"ChIJvQNLDFqhfDURfKqT3_9bhJw"},{"reference":"CmRRAAAA7bv4wqaxOdQXUfbGsU5pSt7DjLLLTBjepoicBcmU9kZkaAU09wkjybMverYi_wgfnL8YKDPNvqZjKFXnBq8vXjHlcNf2SD_yRz39Lfo9NcHUEsQk8mvq_gQNg-j8NW_zEhBOSEkwZ0b9J3LpqF6vrJVmGhSEritIXVh8ppdr6jDc_3Cik0vR0g","types":["hospital","point_of_interest","establishment"],"scope":"GOOGLE","icon":"https:\/\/maps.gstatic.com\/mapfiles\/place_api\/icons\/doctor-71.png","name":"Gipum hospital","opening_hours":{"open_now":true,"weekday_text":[]},"geometry":{"viewport":{"southwest":{"lng":127.0323698197085,"lat":37.4885431197085},"northeast":{"lng":127.0350677802915,"lat":37.4912410802915}},"location":{"lng":127.0337188,"lat":37.4898921}},"vicinity":"122 Dogok-ro, Gangnam-gu","id":"f4ab920c40bd4fa07561adc10e6ce684e2fd5437","photos":[{"photo_reference":"CmRaAAAADq5iGYIh4mPhWldmWSqODGhGserPpUAJll_SOIhUzR8gzLGt0ydqonhLBBcW7WWXREEZUvkYCKMMp46qQr6Lv9fif5-odJNBp3b0MbglwCr-qDM0T2KPSStohkxfy80TEhCbRqJ47NcW9dU0M7V_XHMdGhR_hWDkIGQ2qg65XgbMb5nDO0BP2w","width":900,"html_attributions":["<a href=\"https:\/\/maps.google.com\/maps\/contrib\/113613283899848953107\/photos\">이용연<\/a>"],"height":600}],"place_id":"ChIJFVSRLI-hfDURjHP4MhIywCo"},{"reference":"CmRRAAAAi0foc6-mEDSPavhmrciLzXjrLeGpt7kW3bE_FlfZh4pw5URURxz2LbgahCoayqeRDpLhIkLLr53odv96mVbM2NkH-ZkrCXbB09R_mzjdhHdLBf60AbtSFd9FXN3wV94LEhDFVykzqnecBDj2BhFgt64rGhTmCTOr_kOpQnjaFys_9mitNvMDCQ","types":["hospital","point_of_interest","establishment"],"scope":"GOOGLE","icon":"https:\/\/maps.gstatic.com\/mapfiles\/place_api\/icons\/doctor-71.png","name":"Клиника Seoul Slim Surgery","opening_hours":{"open_now":true,"weekday_text":[]},"rating":5,"geometry":{"viewport":{"southwest":{"lng":127.0270919197085,"lat":37.49537331970851},"northeast":{"lng":127.0297898802915,"lat":37.49807128029151}},"location":{"lng":127.0284409,"lat":37.4967223}},"vicinity":"Gangnam-daero, Seocho-gu","id":"efffe8f558e6aafa52a3d5403facfadd7b300655","photos":[{"photo_reference":"CmRaAAAA7FLx6SZVMLVILqNtPFEqlubXdBVlCI52GxrsCjEBSWHCkcwJBf8KWeeoKax3qjLHwIQkhevcNKBo3xAg-oV2SSAVLKCAVfrf6K3vlluvu7McGpbU89A0oEEtLDbBVPsyEhBhRrLq-A7FB6UgL_HY2u50GhS-cEwweo2rV99OD_aOKAXCUgC1OQ","width":3024,"html_attributions":["<a href=\"https:\/\/maps.google.com\/maps\/contrib\/107256956629219221820\/photos\">Виктор Ли<\/a>"],"height":4032}],"place_id":"ChIJj9RBjaihfDURjRUS1dXf020"}]

/* var page = 1;
$(document).ready(function () {
$(document).scroll(function() {
	 var maxHeight = $(document).height();
	 var currentScroll = $(window).scrollTop() + $(window).height();
    if (maxHeight >= currentScroll + 100) {
       alert($(document).height());
      alert($(window).height());
      alert($(window).scrollTop());
    	console.log(++page);
      $("#enters").append("<h1>Page " + page + "</h1><BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~");
      
    }
})
}); */
</script>
</head>
<body>

<div class="aritcleView" id="enters">
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
       <div>1</div>
       <div>2</div>
       <div>3</div>
        
</div>


</body>
</html>