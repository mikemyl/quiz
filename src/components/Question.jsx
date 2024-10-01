import { useEffect, useRef } from 'react';
import Options from './Options';

function Question({ index, question, dispatch, answer }) {
	const imgRef = useRef(null);
	const h4Ref = useRef(null);

	useEffect(() => {
		if (imgRef.current && h4Ref.current) {
			imgRef.current.style.width = `${h4Ref.current.offsetWidth}px`;
		}
	}, [question]);

	return (
		<div>
			<div>
				<img ref={imgRef} src={`${index}.jpeg`} alt={`Image ${index}`} style={{ height: 'auto' }} />
			</div>
			<h4 ref={h4Ref}>{question.question}</h4>
			<Options question={question} dispatch={dispatch} answer={answer} />
		</div>
	);
}

export default Question;