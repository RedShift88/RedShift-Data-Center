<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.redshift.redshiftdatacenter.HelloAppEngine" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
  <link href='//fonts.googleapis.com/css?family=Marmelad' rel='stylesheet' type='text/css'>
  <title>Hello App Engine Standard Java 8</title>
</head>
<body>
    <h1>Hello App Engine -- Java 8!</h1>

  <p>This is <%= HelloAppEngine.getInfo() %>.</p>
<%
	pageContext.setAttribute("request_URI", request.getRequestURI());
	pageContext.setAttribute("request_Query", request.getQueryString());
	pageContext.setAttribute("request_URL", request.getRequestURL());
%>
<h2>URI: ${fn:escapeXml(request_URI)}</h2>
<h2>Query String: ${fn:escapeXml(request_Query)}</h2>
<h2>URL: ${fn:escapeXml(request_URL)}</h2>
  <table>
    <tr>
      <td colspan="2" style="font-weight:bold;">Available Servlets:</td>
    </tr>
    <tr>
      <td><a href='/hello'>Hello App Engine</a></td>
    </tr>
  </table>

</body>
</html>
