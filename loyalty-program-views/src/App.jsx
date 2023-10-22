import { BrowserRouter, Route, Routes } from "react-router-dom";
import Home from "./pages/Home";
import MainContainer from "./components/containers/MainContainer";
import CreateCustomer from "./pages/CreateCustomer";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<MainContainer />}>
          <Route index element={<Home />} />
          <Route path="create-customer" element={<CreateCustomer />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
