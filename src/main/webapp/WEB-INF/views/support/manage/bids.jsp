<!-- Manage Bids Form -->
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="u" uri="/WEB-INF/taglibs/util.tld" %>

<t:base title="Manage bids">
    <h2>Manage Bids</h2>

    <u:get-bids>
        <div class="bid">
            <p class="bid__info">${bid.login} (${bid.bidDate} ${bid.bidTime.time}): ${bid.amount} for auction ${bid.auctionID}</p>
            <button onclick="tryDelete(${bid.bidNumber})">Delete Bid</button>
        </div>
    </u:get-bids>

    <script>
        function tryDelete(id) {
            if (confirm("Are you sure you want to delete bid " + id + "?")) {
                var url = new URL(window.location.href);
                url.searchParams.append("bidNumber", id);

                alert("Deleting " + id + "!");

                fetch(url, {
                  method: "DELETE",
                  redirect: "follow"
                }).then(res => {
                    self.location = res.url;
                });
            }
        }    
    </script>
</t:base>