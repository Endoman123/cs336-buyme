<!-- Reset Password Form -->
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="u" uri="/WEB-INF/taglibs/util.tld" %>

<t:base title="Manage Auctions">
    <h2>Manage Auctions</h2>

    <u:get-auctions>
        <div class="auction">
            <p class="auction__item">Item: ${auction.itemID}</p>
            <p class="auction__host">Run By: ${auction.login}</p>
            <p class="auction__init">Initial Amount: ${auction.initPrice}</p>
            <button onclick="tryDelete(${auction.auctionID})">Delete Auction</button>
        </div>
    </u:get-auctions>

    <script>
        function tryDelete(id) {
            if (confirm("Are you sure you want to delete auction " + id + "?")) {
                var url = new URL(window.location.href);
                url.searchParams.append("auctionID", id);

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