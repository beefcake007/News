<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<div class="container-fluid">
  <div class="row">
    <img src="${pageContext.request.contextPath }/images/logo.png"/>
  </div>
</div>

<div class="container-fluid">
  <div class="row">
    <nav class="navbar navbar-default">
	  <div class="container">
	    <ul class="nav nav-pills">
	    	<li><a class="active" href="goIndex">首页</a></li>
		  <c:forEach var="newsType" items="${newsTypeList }">
		  	<li><a href="news?action=list&typeId=${newsType.newsTypeId }">${newsType.typeName }</a></li>
		  </c:forEach>
		</ul>
	  </div>
	</nav>
  </div>
</div>