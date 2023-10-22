import axios from "axios";
import { useEffect, useState } from "react";
import UserCard from "../components/UserCard";
import styles from "./home.module.css";
import LoyaltyDetails from "../components/LoyaltyDetails";

function Home() {
  const [users, setUsers] = useState([]);
  const [selectedUser, setSelectedUser] = useState(1);
  const [orderDetail, setOrderDetail] = useState(null);

  const fetchOrderDetail = async () => {
    return axios.get(
      `https://5b9d-118-99-107-131.ngrok-free.app/customers/${selectedUser}`
    );
  };

  useEffect(() => {
    const fetchUsers = async () => {
      return axios.get("https://5b9d-118-99-107-131.ngrok-free.app/customers");
    };

    fetchUsers().then((res) => {
      setUsers(res.data);
      fetchOrderDetail().then((res) => {
        setOrderDetail(res.data);
      });
    });
  }, []);

  useEffect(() => {
    if (users.length !== 0) {
      fetchOrderDetail().then((res) => {
        setOrderDetail(res.data);
      });
    }
  }, [selectedUser]);

  return users.length > 0 ? (
    <div className={styles.container}>
      {/* user list */}
      <div className={styles["users-container"]}>
        {users?.map((user) => (
          <UserCard user={user} key={user.id} onSelectUser={setSelectedUser} />
        ))}
      </div>

      {/* loyalty detail */}
      {orderDetail && <LoyaltyDetails orderDetail={orderDetail} />}
    </div>
  ) : (
    <div />
  );
}

export default Home;
