<!-- Account Edit Form tag -->
<%@ tag description="Account Form" pageEncoding="UTF-8"%>

<%@ attribute name="action" type="String" %>
<%@ attribute name="login" type="String" %>
<%@ attribute name="email" type="String" %>

<form method="post" <% if (request.getParameter("action") != null) { %>action="${action}"<% } %> >
    <input type="hidden" name="loginOld" value="${login}" />

    <label for="loginNew">Login</label>
    <input type="text" name="loginNew" value="${login}" />

    <label for="password">Password</label>
    <input type="password" name="password" />

    <label for="email">E-Mail</label>
    <input type="text" name="email" value="${email}" />

    <input type="submit" value="Submit" />
</form>