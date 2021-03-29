<!-- Login View -->
<%@ include file="/WEB-INF/includes/page_directives.jsp" %>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:base>
    <h2>Login</h2>
    <form method="post" action="./login">
        <label for="log">Login</label>
        <input type="text" name="log" >
        <label for="pass">Password</label>
        <input type="password" name="pass">
        <input type="submit" value="Submit">
    </form>
</t:base>