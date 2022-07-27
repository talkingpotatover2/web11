<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	int listcount = (Integer)request.getAttribute("listcount");
	int nowpage = (Integer)request.getAttribute("page");
	int maxpage = (Integer)request.getAttribute("maxpage");
	int startpage = (Integer)request.getAttribute("startpage");
	int endpage = (Integer)request.getAttribute("endpage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/shopping.css">
</head>
<body>
<div id="wrap" align="center">
	<h1>게시글 리스트</h1>
	<table class="list">
		<tr>
			<td colspan="5" style="border: white; text-align: right">
				<a href="BoardServlet?command=board_write_form">게시글 등록</a>
			</td>
		</tr>
		<tr><th>번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회</th></tr>
		<c:forEach var="board" items="${boardList}">
			<tr class="record">
				<td>${board.num}</td>
				<td>
					<a href="BoardServlet?command=board_view&num=${board.num}">
						${board.title}
					</a>
				</td>
				<td>${board.name}</td>
				<td><fmt:formatDate value="${board.writedate}"/></td>
				<td>${board.readcount}</td>
			</tr>
		</c:forEach>
		<!-- 페이지 번호 시작 -->
			<tr align="center" height="20">
				<td colspan="5">
					<%if(nowpage <= 1){ %>
					[이전]&nbsp;
					<%}else{ %>
					<a href="BoardServlet?command=board_list&page=<%=nowpage-1 %>">[이전]</a>&nbsp;
					<%} %>
					
					<%
						for(int a=startpage; a<=endpage; a++){
							if(a == nowpage){ 
					%>
								[<%=a%>]&nbsp;
					<%		}else{ %>
							<a href="BoardServlet?command=board_list&page=<%=a %>">[<%=a%>]</a>&nbsp;
						  <%} %>
					<%	}%>
					
					<%if(nowpage >= maxpage) { %>
					[다음]&nbsp;
					<%}else{ %>
					<a href="BoardServlet?command=board_list&page=<%=nowpage+1 %>">[다음]</a>&nbsp;
					<%} %>
				</td>
			</tr>
		<!-- 페이지 번호 끝 -->
	</table>
</div>
</body>
</html>