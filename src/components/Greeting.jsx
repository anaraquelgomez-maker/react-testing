const Greeting = ({ name = "Invitado", lastname }) => {
    return (
        <h1>Buenas noches {name} {lastname}</h1>
    )
}

export default Greeting