import React from "react";
import { mkJsCounter as Counter } from "../output/Counter.Interop";
import { mkJsForm as Form } from "../output/Form.Interop";

function App() {
  return (
    <div>
      <h1>My JavaScript App</h1>
      <Counter
        counterType="Decrement"
        onClick={n => console.log("Clicked", n)}
      />
      <Counter label="Clicks" />
      <Counter label="Interactions" />
      <Form />
    </div>
  );
}

export default App;
