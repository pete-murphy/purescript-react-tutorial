import React from "react";
import Counter from "./Counter";

function App() {
  return (
    <div>
      <h1>My App</h1>
      <Counter label="Count" />
      <Counter label="Clicks" />
      <Counter label="Interactions" />
    </div>
  );
}

export default App;
