import { Link } from "react-router-dom";
import styles from "./MainHeader.module.css";

function MainHeader() {
  return (
    <div className={styles.header}>
      <Link
        to="/"
        style={{
          textDecoration: "none",
        }}
      >
        <h1
          style={{
            fontSize: "24px",
            color: "#FFF",
          }}
        >
          Loyalty Program
        </h1>
      </Link>
      <div
        style={{
          paddingRight: 40,
        }}
      >
        <Link
          to="/create-customer"
          style={{
            backgroundColor: "#FFF",
            padding: "8px 16px",
            textDecoration: "none",
            borderRadius: 8,
            color: "#111",
          }}
        >
          Create Customer
        </Link>
      </div>
    </div>
  );
}

export default MainHeader;
