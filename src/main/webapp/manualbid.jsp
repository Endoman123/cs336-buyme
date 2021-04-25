<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>

<t:base context="${pageContext.request.contextPath}" title="Manual Bidding">

    <h2>Bid Details</h2>
	<form action="manualbid" method="post">
		<label>Enter Auction ID:</label> <input type="number" name="auction_ID" required min=1> <br> 
        <br/><label>Enter Bid Amount:</label> <input type="number" name="bid_amount" required> <br>
        <br/><input type="submit" value="Submit">
	<br>
	<p></p>

</t:base>