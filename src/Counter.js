import React, { useState } from "react";

export default function Counter({ label }) {
  const [count, setCount] = useState(0);
  return (
    <button onClick={() => setCount(c => c + 1)}>
      {label}: {count}
    </button>
  );
}
