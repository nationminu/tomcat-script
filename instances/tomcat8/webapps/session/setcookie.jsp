<%@ page import="java.util.Date" %>


<%
String cookieName = "myCookie";
//String cookieValue = new Date().toString();
String cookieValue = "a=!@#$%^&*()d'";

Cookie cookie = new Cookie(cookieName, cookieValue);
cookie.setMaxAge(1*60*60);
response.addCookie(cookie);
%>
<a href="getcookie.jsp">cookie list</a>
