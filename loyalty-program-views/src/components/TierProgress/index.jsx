import dayjs from "dayjs";

function TierProgress({ orderDetail }) {
  const tierStatus = () => {
    if (orderDetail.total_spent_to_maintain_current_tier === 0) {
      return `Your tier is maintained in ${orderDetail.tier}`;
    } else {
      return `Your tier will be returned to ${orderDetail.before_tier} on ${dayjs(orderDetail.reset_tier_date).format("D MMMM YYYY")}`
    }
  };

  return (
    <div>
      <p
        style={{
          fontWeight: "bold",
          fontSize: 24,
          marginBottom: 0,
        }}
      >
        Your Tier: {orderDetail.tier}
      </p>
      <div
        style={{
          marginTop: 16,
          display: "flex",
          flexDirection: "row",
          alignItems: "center",
        }}
      >
        <div
          style={{
            width: "100%",
            height: 8,
            borderRadius: 8,
            backgroundColor: "#E5E5E5",
          }}
        >
          <div
            style={{
              width: `${orderDetail.progress_to_reach_next_tier * 100}%`,
              height: 8,
              borderRadius: 8,
              backgroundColor: "#fbbf24",
            }}
          ></div>
        </div>
        <p
          style={{
            fontWeight: "bold",
            fontSize: 18,
            marginLeft: 8,
            flexShrink: 0,
          }}
        >
          US$ {orderDetail.current_tier_total_spent} /{" "}
          US$ {orderDetail.tier === "Bronze" ? 100 : 500}
        </p>
      </div>
      <p
        style={{
          fontWeight: "bold",
          fontSize: 16,
          marginTop: 8,
        }}
      >
        {orderDetail.total_spent_need_to_upgrade === 0
          ? "Congratulations! You have reach GOLD tier."
          : `US$ ${orderDetail.total_spent_need_to_upgrade} orders left to ${orderDetail.next_tier}`}
      </p>
      <div
        style={{
          fontSize: 14,
          marginTop: 8,
        }}
      >
        <p>
          {orderDetail.total_spent_to_maintain_current_tier === 0 ? "" : `Maintain your tier by spending another US$ ${orderDetail.total_spent_to_maintain_current_tier}`}
        </p>
        <p>
          <span
            style={{
              fontWeight: "bold",
            }}
          >
            {tierStatus()}
          </span>
        </p>
      </div>
    </div>
  );
}

export default TierProgress;
