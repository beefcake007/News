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
  
  <body>
   <div class="container">
   		<jsp:include page="/foreground/common/head.jsp"></jsp:include>
   		 <div class="container-fluid">
   			 	<div class="row">
   			 		<div class="col-md-8">
   			 			<jsp:include page="${mainPage }"></jsp:include>
   			 		</div>
  					<div class="col-md-4">
  						<div class="data_list right_news_list">
					  		<div class="dataHeader">最新新闻</div>
					  		<div class="datas">
					  			<ul>
									<c:forEach var="newestNews" items="${newestNewsList }">
										<li><a href="news?action=show&newsId=${newestNews.newsId }" title="${newestNews.title }">${fn:substring(newestNews.title,0,15) }</a></li>
									</c:forEach>
					  			</ul>
					  		</div>
					  	</div>
					  	
					  	<div class="data_list right_news_list">
					  		<div class="dataHeader">热门新闻</div>
					  		<div class="datas">
					  			<ul>
									<c:forEach var="hotNews" items="${hotNewsList }">
										<li><a href="news?action=show&newsId=${hotNews.newsId }" title="${hotNews.title }">${fn:substring(hotNews.title,0,15) }</a></li>
									</c:forEach>
					  			</ul>
					  		</div>
					  	</div>
				
					  </div>
  					</div>
   			 	
   			 	</div>
	 	<jsp:include page="/foreground/common/foot.jsp"></jsp:include>
   </div>
  </body>
</html>
