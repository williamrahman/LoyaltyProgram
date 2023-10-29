import dayjs from "dayjs";
import TierProgress from "../TierProgress";
import styles from "./LoyaltyDetails.module.css";

function LoyaltyDetails({ orderDetail }) {
  return (
    <div
      style={{
        display: "flex",
        margin: "20px",
        marginRight: 0,
        flex: 1,
        backgroundColor: "#f0f9ff",
        borderRadius: 8,
        border: "1px solid #172554",
        padding: 16,
      }}
    >
      <div
        style={{
          width: "100%",
          display: "flex",
          flexDirection: "column",
        }}
      >
        {/* user */}
        <div
          style={{
            display: "flex",
            flexDirection: "row",
            alignItems: "center",
            justifyContent: "flex-end",
            border: "1px solid #172554",
            borderWidth: "0px 0px 1px 0px",
            width: "100%",
          }}
        >
          <p
            style={{
              fontWeight: "bold",
              fontSize: 24,
            }}
          >
            {orderDetail.customer_name}
          </p>
          <div className={styles["tier-container"]}>
            <span>{orderDetail.tier}</span>
          </div>
        </div>

        {/* loyalty */}
        <div
          style={{
            marginTop: 16,
          }}
        >
          {/* tier list */}
          <div
            style={{
              display: "grid",
              gridTemplateColumns: "repeat(3, 1fr)",
              gridGap: 16,
            }}
          >
            {["Bronze", "Silver", "Gold"].map((tier, index) => (
              <div
                key={tier + index}
                style={{
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  borderRadius: 8,
                  color: "#FFF",
                  height: 80,
                  background: `linear-gradient(135deg, ${
                    {
                      Bronze: "#CD7F32",
                      Silver: "#4b5563",
                      Gold: "#facc15",
                    }[tier]
                  }, #111)`,
                  boxShadow: "0px 4px 4px rgba(0, 0, 0, 0.25)",
                }}
              >
                <span
                  style={{
                    fontWeight: "bold",
                    fontSize: 18,
                  }}
                >
                  {tier}
                </span>
              </div>
            ))}
          </div>
          {/* Progress */}
          <TierProgress orderDetail={orderDetail} />
          {/* order list */}
          <div
            style={{
              fontSize: 16,
              display: "grid",
              gridTemplateColumns: "repeat(2, 1fr)",
              gridGap: 16,
            }}
          >
            {orderDetail.orders.map((order) => (
              <div
                key={"order" + order.id}
                style={{
                  backgroundColor: "#e0f2fe",
                  padding: 16,
                  borderRadius: 8,
                  border: "1px solid #172554",
                }}
              >
                <div
                  style={{
                    display: "flex",
                    flexDirection: "row",
                    justifyContent: "space-between",
                  }}
                >
                  <div
                    style={{
                      display: "flex",
                      flexDirection: "row",
                      fontSize: 14,
                      fontWeight: "bold",
                    }}
                  >
                    <p>Transaction ID: </p>
                    <p style={{ marginLeft: 8 }}>{order.id}</p>
                  </div>
                  <div
                    style={{
                      display: "flex",
                      flexDirection: "row",
                      fontSize: 14,
                      fontWeight: "bold",
                    }}
                  >
                    <p>{dayjs(order.created_at).format("DD MMMM YYYY")}</p>
                  </div>
                </div>
                <div
                  style={{
                    display: "flex",
                    flexDirection: "row",
                    justifyContent: "space-between",
                  }}
                >
                  <p>Total Order</p>
                  <p
                    style={{
                      fontWeight: "bold",
                    }}
                  >
                    US$ {order.total_order}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}

export default LoyaltyDetails;
