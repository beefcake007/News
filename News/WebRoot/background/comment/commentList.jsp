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

	$(document).ready(function(){
		$("#checkedAll").click(function(){
			if($(this).prop("checked")==true){
				$("input[name='commentIds']").prop("checked",true);
			}else{
				$("input[name='commentIds']").prop("checked",false);
			}
		});
	});

	function commentDelete(commentId){
		if(confirm("确认要删除这条评论吗？")){
			$.post("comment?action=delete",{commentIds:commentId},
				function(result){
					var result=eval('('+result+')');
					if(result.success){
						alert("删除成功！");
						window.location.href="${pageContext.request.contextPath}/comment?action=backList";
					}else{
						alert(result.errorMsg);
					}
				}
			);
		}
	}
	
	function commentsDelete(){
		var chk_value=[];
		$('input[name="commentIds"]:checked').each(function(){
			chk_value.push($(this).val());
		});
		if(chk_value.length==0){
			alert("请选择要删除的评论！");
			return ;
		}
		var commentIds=chk_value.join(",");
		if(confirm("确认要删除这些评论吗？")){
			$.post("comment?action=delete",{commentIds:commentIds},
				function(result){
					var result=eval('('+result+')');
					if(result.success){
						alert("成功删除"+result.delNums+"条评论！");
						window.location.href="${pageContext.request.contextPath}/comment?action=backList";
					}else{
						alert(result.errorMsg);
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
	<div class="search_content" style="vertical-align: middle; padding-right: 20px; padding-top: 10px; padding-bottom: 10px;">
		<div style="float:left;padding-left: 20px;">
			<button type="button" class="btn btn-danger btn-primary btn-xs" onclick="commentsDelete()">批量删除</button>
		</div>
		<div style="float:right;padding-bottom: 10px;">
			<form action="${pageContext.request.contextPath }/comment?action=backList" method="post">
				评论日期：<input type="text" id="s_bCommentDate" name="s_bCommentDate" class="Wdate" style="width:100px;border-radius:5px;" value="${s_bCommentDate }" onclick="WdatePicker()"/>
				&nbsp;到&nbsp;<input type="text" id="s_aCommentDate" class="Wdate" name="s_aCommentDate" style="width:100px;border-radius:5px;" value="${s_aCommentDate }" onclick="WdatePicker()"/>
				&nbsp;&nbsp;<button type="submit" class="btn btn-primary btn-xs" onclick="">查询</button>
			</form>
		</div>
	</div>
	<div class="data_content">
		<table class="table table-hover table-bordered">
			<tr>
				<th><input type="checkbox" id="checkedAll" /></th>
				<th>序号</th>
				<th>评论内容</th>
				<th>评论主题</th>
				<th>评论时间</th>
				<th>操作</th>
			</tr>
			
			<c:forEach var="commentBack" items="${commentBackList }" varStatus="status">
				<tr>
					<td><input type="checkbox" name="commentIds" value="${commentBack.commentId}" /></td>
					<td>${status.index+1 }</td>
					<td><a title="${commentBack.content }">${fn:substring(commentBack.content,0,15) }</a></td>
					<td><a title="${commentBack.newsTitle }" target="_blank" href="news?action=show&newsId=${commentBack.newsId }">${fn:substring(commentBack.newsTitle,0,15) }</a></td>
					<td><fmt:formatDate value="${commentBack.commentDate }" type="date" pattern="yyyy-MM-dd"/></td>
					<td><button type="button" class="btn btn-danger btn-primary btn-xs" onclick="commentDelete(${commentBack.commentId})">删除</button></td>
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