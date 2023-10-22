import { Outlet } from "react-router-dom";
import MainHeader from "../../MainHeader";

function MainContainer() {
  return (
    <div>
      {/* Header */}
      <MainHeader />
      {/* Content */}
      <Outlet />
    </div>
  );
}

export default MainContainer;
