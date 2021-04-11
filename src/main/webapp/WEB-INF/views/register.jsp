<!-- Register View -->
<%@ include file="/WEB-INF/includes/page_directives.jsp" %>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:base>
    <h2>Register</h2>
    <form method="post" action="./register">
        <label for="login">Login</label>
        <input type="text" name="login" >
        <label for="pass">Password</label>
        <input type="password" name="password">
        <label for="email">E-Mail</label>
        <input type="text" name="email">
        <input type="submit" value="Submit">
    </form>
</t:base>