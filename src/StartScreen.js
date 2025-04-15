function StartScreen({numQuestions, dispatch}) {
    return (
        <div className="start">
            <h2>Welcome to The Greek Food quiz!</h2>
            <h3>{numQuestions} questions to test your Greek Food knowledge</h3>
            <button className="btn btn-ui" onClick={() => dispatch({type: 'start'})}>Start Quiz</button>
        </div>
    )
}

export default StartScreen
