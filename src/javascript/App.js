import React from "react";
import { jsCounter as Counter } from "../output/Counter.Interop";

function App() {
  return (
    <div>
      <h1>My JavaScript App</h1>
      <Counter onClick={n => console.log("Clicked", n)} />
      <Counter counterType="Decrement" label="Clicks" />
      <Counter label="Interactions" />
    </div>
  );
}

export default App;
