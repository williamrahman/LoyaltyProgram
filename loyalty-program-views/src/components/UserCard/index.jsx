import styles from "./UserCard.module.css";

function UserCard({ user, onSelectUser }) {
  return (
    <button onClick={() => onSelectUser(user.id)} className={styles.container}>
      <p
        style={{
          fontSize: "16px",
        }}
      >
        {user.name}
      </p>
      <div className={styles["tier-container"]}>
        <span>{user.tier}</span>
      </div>
    </button>
  );
}

export default UserCard;
