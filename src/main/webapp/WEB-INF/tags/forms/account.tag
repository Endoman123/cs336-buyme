<!-- Account Form tag -->
<%@ tag description="Account Form" pageEncoding="UTF-8"%>

<%@attribute name="action" type="String" %>
<%@attribute name="login" type="String" %>
<%@attribute name="password" type="String" %>
<%@attribute name="email" type="String" %>
<%@attribute name="type" type="String" %>

<form method="post" action="${action}">
    <label for="login">Login</label>
    <input type="text" name="login" value="${login}">

    <label for="password">Password</label>
    <input type="password" name="password" value="${password}">

    <label for="email">E-Mail</label>
    <input type="text" name="email" value="${email}">

    <input type="hidden" name="type" value="${type}">

    <input type="submit" value="Submit">
</form>