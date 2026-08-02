import { useState } from "react"

const Counter = ({ initCounter = 0 }) => {
    const [counter, setCounter] = useState(initCounter)

    const increment = () => {
        setCounter(counter + 1)
    }

    const decrement = () => {
        setCounter(counter - 1)
    }

    const reset = () => {
        setCounter(0)
    }

    return (
        <section>
            <h1>Contador: {counter}</h1>
            <button onClick={increment}>+</button>
            <button onClick={decrement} disabled={counter === 0} >-</button>
            <button onClick={reset}>0</button>
        </section>
    )
}

export default Counter