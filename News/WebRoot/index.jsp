<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
		<title>狗崽子新闻</title>
  </head>
  <link href="${pageContext.request.contextPath }/style/news.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath }/bootstrap3/css/bootstrap.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath }/bootstrap3/css/bootstrap-theme.min.css" rel="stylesheet">
  <script src="${pageContext.request.contextPath }/bootstrap3/js/jquery-3.1.1.min.js"></script>
  <script src="${pageContext.request.contextPath }/bootstrap3/js/bootstrap.min.js"></script>
  
  <script type="text/javascript">
	var auto;
	var index=0;
	$('.tuhuo ul li').hover(function(){
		clearTimeout(auto);
		index=$(this).index();
		move(index);
		},function(){
			auto=setTimeout('autogo('+index+')',3000);
	});
	
	function autogo(){
		if(index<5){
			move(index);
			index++;
		}
		else{
			index=0;	
			move(index);
			index++;
		}
	}
	function move(l){
		var src=$('.tu_img').eq(index).attr('src');
		$("#fou_img").css({  "opacity": "0"  });
		$('#fou_img').attr('src',src);
		$('#fou_img').stop(true).animate({ opacity: '1'},1000);
		$('.tuhuo ul li').removeClass('fouce');
		$('.tuhuo ul li').eq(index).addClass('fouce');
		$('.tuhuo p').hide();
		$('.tuhuo p').eq(index).show();
		var ao=$('.tuhuo p').eq(index).children('a').attr('href');
		$('#fou_img').parent('a').attr("href",ao);
	}
	autogo();
	setInterval('autogo()',3000);
</script>
  <body>
   <div class="container">
   		 <jsp:include page="/foreground/common/head.jsp"></jsp:include>
   		 
   		 <div class="container-fluid">
	 　		<div class="row">
			  <div class="col-xs-12 col-md-8">
			  	<!-- 轮播图 -->
			  	<div>
				  	<DIV style="width: 330px; height: 228px;" class="tuhuo">
					<A href="" target="_blank"><IMG style="width: 330px; height: 208px;" id="fou_img" src=""></A>

						<c:forEach var="imageNews" items="${imageNewsList }">
							<A href="news?action=show&newsId={imageNews.newsId}"> 
								<IMG style="display: none;" class="tu_img" src="${imageNews.imageName }" width="330" height="208" />
							</A>
						</c:forEach>
						
						<c:forEach var="imageNews" items="${imageNewsList }">
							<A href="news?action=show&newsId={imageNews.newsId}"> 
								 <P style="height: 20px;" class="tc"><A href="news?action=show&newsId=${imageNews.newsId }" target="_blank" title="${imageNews.title }">${fn:substring(imageNews.title,0,18) }</A></P>
							</A>
						</c:forEach>

						<UL>
						  <LI class="fouce">1</LI>
						  <LI>2</LI>
						  <LI>3</LI>
						  <LI>4</LI>
						  <LI>5</LI>
						</UL>
					</DIV>
			  	</div>
			  	<div class="newsHeader_list">
			  		<div class="newsHeader">
			  			<h3><a href="news?action=show&newsId=${headNews.newsId }" title="${headNews.title }">${fn:substring(headNews.title,0,10) }</a></h3>
						<p>${fn:substring(headNews.content,0,40) }<a href="news?action=show&newsId=${headNews.newsId }" >[查看全文]</a></p>
			  			
			  		</div>
			  		
			  		<div class="currentUpdate">
			  			<div class="currentUpdateHeader">最近更新</div>
			  			<div class="currentUpdateDatas">
			  			<table width="100%">
							
							<c:forEach var="newestNews" items="${newestNewsList }"  varStatus="status">
								<c:if test="${status.index%2==0 }">
									<tr>
								</c:if>
								<td width="50%">
									<a href="news?action=show&newsId=${newestNews.newsId }" title="${newestNews.title }">${fn:substring(newestNews.title,0,12) }</a>
								</td>
								<c:if test="${status.index%2==1 }">
									</tr>
								</c:if>
							</c:forEach>
			  			</table>
			  			</div>
			  		</div>
			  	</div>
			  </div>
			  <div class="col-xs-6 col-md-4">
			  	<div class="data_list hotspot_news_list">
			  		<div class="dataHeader">热点新闻</div>
			  		<div class="datas">
			  			<ul>
							<c:forEach var="hotSpotNews" items="${hotSpotNewsList }">
								<li><a href="news?action=show&newsId=${hotSpotNews.newsId }" title="${hotSpotNews.title }">${fn:substring(hotSpotNews.title,0,15) }</a></li>
							</c:forEach>
			  			</ul>
			  		</div>
			  	</div>
			  </div>
			</div>
		 </div>
   	<c:forEach var="allIndexNews" items="${allIndexNewsList }" varStatus="allStatus">
   		<c:if test="${allStatus.index%3==0 }">
   			 <div class="container-fluid">
   			 	<div class="row">
   		</c:if>
   		<c:forEach var="indexNews" items="${allIndexNews }" varStatus="oneStatus">
			<c:if test="${oneStatus.first }">
   				<div class="col-xs-6 col-md-4">
			  	<div class="data_list news_list" >
					<div class="dataHeader">${newsTypeList.get(allStatus.index).typeName }<span class="more"><a href="news?action=list&typeId=${newsTypeList.get(allStatus.index).newsTypeId }">更多...</a></span></div>
					<div class="datas">
						<ul>
   			</c:if>
   			<li><fmt:formatDate value="${indexNews.publishDate }" type="date" pattern="MM-dd"/>&nbsp;<a href="news?action=show&newsId=${indexNews.newsId }" title="${indexNews.title }">${fn:substring(indexNews.title,0,18) }</a></li>
   			<c:if test="${oneStatus.last }">
   						</ul>
					</div>
				</div>
			  </div>
   			</c:if>
   		</c:forEach>
   		<c:if test="${allStatus.index%3==2 || allStatus.last }">
   			 </div>
   			 </div>
   		</c:if>
   	</c:forEach>	 
   		 
   		 
	 <jsp:include page="/foreground/common/link.jsp"></jsp:include>
	 <jsp:include page="/foreground/common/foot.jsp"></jsp:include>
   </div>
  </body>
</html>
