<!-- Login View -->
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:base context="${pageContext.request.contextPath}" title="Login">
    <h2>Login</h2>
    <form method="post" action="login">
        <label for="login">Login</label>
        <input type="text" name="login" >
        <label for="pass">Password</label>
        <input type="password" name="password">
        <input type="submit" value="Submit">
    </form>
</t:base>