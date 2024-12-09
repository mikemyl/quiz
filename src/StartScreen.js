function StartScreen({numQuestions, dispatch}) {
    return (
        <div className="start">
            <h2>Welcome to The Christmas Around the world quiz!</h2>
            <h3>{numQuestions} questions to test your Christmas traditions knowledge</h3>
            <button className="btn btn-ui" onClick={() => dispatch({type: 'start'})}>Start Quiz</button>
        </div>
    )
}

export default StartScreen
