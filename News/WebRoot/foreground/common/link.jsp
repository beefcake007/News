<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<div class="container-fluid">
  <div class="row">
    <div class="link">
    	<div class="linkHeader">友情链接</div>
		    <div class="datas">
		    	<ul>
		    		<c:forEach var="link" items="${linkList }">
		    			<li><a href="${link.linkUrl }" target="_blank">${link.linkName }</a></li>
		    		</c:forEach>
		    	</ul>
		    </div>
    	</div>
    </div>	
  </div>
</div> 