<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <link href="${pageContext.request.contextPath }/style/news.css" rel="stylesheet">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>狗崽子新闻</title>
<script type="text/javascript">
function newsDelete(newsId){
	if(confirm("确认要删除这条新闻吗？")){
		$.post("news?action=delete",{newsId:newsId},
			function(delFlag){
				var flag=eval('('+delFlag+')');
				if(flag){
					alert("删除成功!");
					window.location.href="${pageContext.request.contextPath}/news?action=backList";
				}else{
					alert("删除失败");
				}
			}
		);
	}
}
</script>
</head>
<body>
<div class="data_list backMain">
	<div class="dataHeader navi">
		${navCode }
	</div>
	<div class="search_content" style="vertical-align: middle; ">
		<form action="${pageContext.request.contextPath }/news?action=backList" method="post">
			新闻标题：<input type="text" id="s_title" name="s_title" value="${s_title }" style="border-radius:5px;">&nbsp;&nbsp;
			发布日期：<input type="text" id="s_bPublishDate" name="s_bPublishDate" class="Wdate" style="width:100px;border-radius:5px;" value="${s_bPublishDate }" onclick="WdatePicker()"/>
			&nbsp;到&nbsp;<input type="text" id="s_aPublishDate" class="Wdate" name="s_aPublishDate" style="width:100px;border-radius:5px;" value="${s_aPublishDate }" onclick="WdatePicker()"/>
			&nbsp;&nbsp;<button type="submit" class="btn btn-primary btn-xs" onclick="">查询</button>
		</form>
	</div>
	<div class="data_content">
		<table class="table table-hover table-bordered">
			<tr>
				<th><input type="checkbox" id="checkedAll" /></th>
				<th>序号</th>
				<th>新闻标题</th>
				<th>新闻类别</th>
				<th>发布时间</th>
				<th>操作</th>
			</tr>
			
			<c:forEach var="newsBack" items="${newsBackList }" varStatus="status">
				<tr>
					<td><input type="checkbox" name="newsIds" value="${newsBack.newsId}" /></td>
					<td>${status.index+1 }</td>
					<td>${newsBack.title }</td>
					<td>${newsBack.typeName }</td>
					<td><fmt:formatDate value="${newsBack.publishDate }" type="date" pattern="yyyy-MM-dd"/></td>
					<td><button type="button" class="btn btn-info btn-primary btn-xs" onclick="javascript:window.location.href='news?action=preSave&newsId=${newsBack.newsId}'">修改</button><button type="button" class="btn btn-danger btn-primary btn-xs" onclick="newsDelete(${newsBack.newsId})">删除</button></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<nav aria-label="Page navigation">
  		${pageCode }
  	</nav>
</div>
</body>
</html>