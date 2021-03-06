<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>FUNDIGO 펀딩고</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="/static/img/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/static/css/styles.css" rel="stylesheet" />
<!-- Core theme JS-->
<script src="/static/js/scripts.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>


<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<!-- ////////////////iamport.payment.js/////////////////-->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!--//////////////// Daum address api ///////////////-->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
a:link {
	text-decoration: none;
	color: #646464;
}

a:visited {
	text-decoration: none;
	color: #646464;
}

a:active {
	text-decoration: none;
	color: #646464;
}

a:hover {
	text-decoration: none;
	color: #646464;
}

@font-face {
	font-family: 'BMDOHYEON';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMDOHYEON.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

body {
	font-family: 'BMDOHYEON'
}
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//============= "계속해서 펀딩하기"  Event 연결 =============
	$(function() {
		//$("td.ct_btn01:contains('계속해서 펀딩하기')").on("click", function() {
		$("button.btn.btn-danger").on("click", function() {
			//$("form").attr("method" , "POST").attr("action" , "/funding/addFund/"+${pjtNo}).submit();
	console.log(${project.pjtNo})
		});
		$("#result").click(function(){
			 invalidItem();	
		 });
		
		//입력 유효성 검사
		function invalidItem() {
			var count = $("input[name='number']:checkbox:checked").length;
			//몇개가 체크되었는지 개발자모드에서 확인해보셈
			console.log(count);
			if(count<1){
				alert("한 개 이상을 선택하셔야 합니다.");
				console.log(count);
				return false;
			}else{
				//alert("체크박스 "+count+"개가 선택되었습니다.");
				console.log(count);	
			}
			console.log(${project.pjtNo});
			$("form").attr("method" , "POST").attr("action" , "/funding/selectProd/"+${project.pjtNo}).submit();
			
		}

		
	});

	//============= "이전"  Event 연결 =============
	$(function() {
		//$("td.ct_btn01:contains('이전')").on("click", function() {
		$("a[href='#' ]").on("click", function() {
			window.history.back();
		});
	
		
		$("input[name='number']").on('click',function(){			
			calculateAmount();		
		});
		
		$("input[name='plus']").on('click',function(){
			var plusValue = parseInt($(this).prev().val(),10)+1;
			$(this).prev().val(plusValue);
			calculateAmount();
		});
		
		$("input[name='minus']").on('click',function(){
			if(parseInt($(this).prev().prev().val(),10) > 1 ){				
				var minusValue = parseInt($(this).prev().prev().val(),10)-1;
				$(this).prev().prev().val(minusValue);
				calculateAmount();
			}
		});
		 
		
	});
	
	
	
	
	
	

</script>
	


<script type="text/javascript">

var price;
var prodQuantity;



function calculateAmount(){
	
	var prodAmount = 0;
	
	$('input[type="checkbox"]:checked').each(function(index){
		prodQuantity = parseInt($(this).parent().parent().find('#prodQuantity').val());
		price = parseInt($(this).parent().parent().find('#price').val());
		
		console.log(prodQuantity);
		console.log(price);
		
		prodAmount += price*prodQuantity;	
		console.log(prodAmount);
	});
	prodAmount += 3000;
	
	$('#prodAmount').val(prodAmount);
	
}



</script>


</head>



<body>

	<!-- Navigation-->
	<c:import url="../toolbar.jsp" />
	<!-- Header-->


	<!--  화면구성 div Start /////////////////////////////////////-->

	<div class="page-header"><br>
		<h4 style="margin-left: 45%;" class=" text-info">리워드 선택</h4>
		<h6 style="margin-left: 35%;" class="text-muted">
			펀딩해주시는 금액에 따라 감사의 의미로<strong class="text-warning"> 리워드를 </strong>제공해 드립니다.
		</h6>
	</div>
	<hr>
	
	<form>
	<div class="container" >
	
		<div class="row">	
			<div class="col-1 col-md-4"></div>	
			<div class="col-5 col-md-2">프로젝트명</div> 
			<div class="col-5 col-md-3">
				<input type="text" class="form-control-plaintext" id="pjtName" name="pjtName"
					value="${project.pjtName}" readonly />
			</div>	
			<div class="col-1 col-md-3"></div>	
										
		</div>
		
		<hr>
			
		<c:forEach var="productList" items="${productList}">
			
			<div class="row">
				<div class="col-1 col-md-4" style="text-align: right"><input type="checkbox" name="number" ></div>	
				<div class="col-5 col-md-2">리워드 번호</div> 
				<div class="col-5 col-md-3">
					<input type="text" class="form-control-plaintext" id="prodNo" name="prodNo" 
						value="${productList.prodNo}" readonly>
				</div>	
				<div class="col-1 col-md-3"></div>
				
				<div class="col-1 col-md-4"></div>	
				<div class="col-5 col-md-2">리워드명</div> 
				<div class="col-5 col-md-3">
					<input type="text" class="form-control-plaintext" id="prodName" name="prodName" 
						value="${productList.prodName}" readonly>
				</div>	
				<div class="col-1 col-md-3"></div>
				
				<div class="col-1 col-md-4"></div>	
				<div class="col-5 col-md-2">리워드 수량</div> 
				<div class="col-5 col-md-3">
					<input type="text"  
					size="3" onchange="change();" maxlength="4" id="prodQuantity" name="prodQuantity" value="1" readonly> 개
					<input name="plus" type="button" value=" + " >&nbsp;
					<input name="minus" type="button" value=" - " >
				</div>	
				<div class="col-1 col-md-3"></div>
				
				<div class="col-1 col-md-4"></div>	
				<div class="col-5 col-md-2">리워드 금액</div> 
				<div class="col-5 col-md-3">
					<input type="text" class="form-control-plaintext" id="price" name="price" 
						value="${productList.price} 원" readonly>
				</div>	
				<div class="col-1 col-md-3"></div>
				
		</div>
		
		<hr>
		
		</c:forEach>
		
		
				
		<div class="row">		
			<div class="col-1 col-md-4"></div>	
			<div class="col-5 col-md-2">배송비</div> 
			<div class="col-5 col-md-3">
				<input type="text"
					class="form-control-plaintext" id="deliveryAmount" value="3000원" readonly>
			</div>	
			<div class="col-1 col-md-3"></div>
				
			<div class="col-1 col-md-4"></div>	
			<div class="col-5 col-md-2">리워드 총액</div> 
			<div class="col-5 col-md-3">
				<input size="8" type="text" id="prodAmount" name="sum" value="0" readonly> 원을 펀딩합니다.
			</div>	
			<div class="col-1 col-md-3"></div>
	
		</div>
	
	</div>
	</form>

	<br>
	<hr>


<div class="row">
	<div class="col-md-11 text-center ">
		<a class="btn btn-info" href="#" role="button" style="margin-left:8%; height: 40px; color: white;">이전</a>
		<button type="submit" id="result" name="result" class="btn btn-danger"
			style="width: 200px; height: 40px;"> 계속해서 펀딩하기</button>
			
	</div>
</div>
<br>



</body>
</html>