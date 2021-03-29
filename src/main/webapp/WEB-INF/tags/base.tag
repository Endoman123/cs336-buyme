<!-- Base Website tag -->
<%@ tag description="Base template" pageEncoding="UTF-8"%>

<%@attribute name="title" type="String" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title><% if (title != null) { %>${title} | <% } %>BuyMe</title>
    </head>
    <header>
        <h1>BuyMe</h1>
    </header>
    <body>
        <jsp:doBody/>
    </body>
    <footer>
    </footer>
</html>