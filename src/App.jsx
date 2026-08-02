import Greeting from './components/Greeting'
import Counter from './components/Counter'

const App = () => {
  return (
    <>
      <h1>Mi primer componente de react</h1>
      <h2>Mi sitio web con reactjs</h2>
      <Greeting name="Fernando" lastname="Aguilar" />
      <Greeting name="Amilcar" />
      <Greeting name="Alan" />
      <Greeting name="Audelia" />
      <Greeting />
      <Counter />
      <Counter initCounter={10} />
      <Counter initCounter={20} />
    </>
  )
}

export default App