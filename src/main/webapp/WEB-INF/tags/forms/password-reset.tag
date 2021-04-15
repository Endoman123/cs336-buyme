<!-- Password Reset Form tag -->
<%@ tag description="Password Reset" pageEncoding="UTF-8"%>

<%@ attribute name="action" type="String" %>
<%@ attribute name="login" type="String" %>
<%@ attribute name="password" type="String" %>

<form method="post" action="${action}">
    <input type="hidden" name="login" value="${login}" />

    <label for="password">Password</label>
    <input type="password" name="password" />

    <label for="password-confirm">Confirm Password</label>
    <input type="password" name="password-confirm" />

    <input type="submit" value="Submit">
</form>