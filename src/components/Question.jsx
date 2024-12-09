import Options from './Options';

function Question({ index, question, dispatch, answer }) {
	return (
		<div>
			<div style={{ width: '100%', maxHeight: '50vh', display: 'flex', justifyContent: 'center', marginBottom: '2rem' }}>
				<img
					src={`${index}.jpeg`}
					alt={`Image ${index}`}
					style={{
						width: '100%',
						height: '100%',
						maxHeight: '50vh',
						objectFit: 'contain'
					}}
				/>
			</div>
			<h4>{question.question}</h4>
			<Options question={question} dispatch={dispatch} answer={answer} />
		</div>
	);
}
export default Question;