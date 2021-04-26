<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>

<t:base context="${pageContext.request.contextPath}" title="Manual Bidding">

    <h2>Bid Details</h2>
	<form action="manualbid" method="post">
		<label>Enter Auction ID:</label> <input type="number" name="auction_ID" required min=1> <br> 
        <br/><label>Enter Bid Amount:</label> <input type="number" name="bid_amount" required> <br>
        <br/><input type="submit" value="Submit">
	<br>
	<p></p>

	<div
	style="border: 1px solid black; width: 400px; height: 150px; overflow: scroll;">
	<h2>Bid Alerts</h2>

	<p>Higher bids placed on this item by: <p>

	</p>
</div>

</t:base>