#!/bin/bash

API_KEY="${OPENAPI_KEY}"  # <-- Set this via env var or paste your key directly here
MODEL="dall-e-3"
IMAGE_SIZE="1024x1024"
INPUT_JSON='src/data/questions.json'  # Path to your questions JSON

# Ensure dependencies
if ! command -v jq &> /dev/null; then
    echo "jq not found (install with: sudo apt install jq or brew install jq)"
    exit 1
fi


LEN=$(jq length "$INPUT_JSON")

for (( i=0; i<2; i++ )); do
    QUESTION=$(jq -r ".[$i].question" "$INPUT_JSON")
    OPT1=$(jq -r ".[$i].options[0]" "$INPUT_JSON")
    OPT2=$(jq -r ".[$i].options[1]" "$INPUT_JSON")
    OPT3=$(jq -r ".[$i].options[2]" "$INPUT_JSON")
    OPT4=$(jq -r ".[$i].options[3]" "$INPUT_JSON")

    # Build a clear, literal, layout-constrained prompt
    PROMPT="Create a high-resolution quiz-style image with a clean, professional look.
The title at the top should be: \"$QUESTION\" in bold black font.
Below the title, divide the image into a perfect 2x2 grid, each quadrant showing one realistic food photo:
- Top left: photo of $OPT1, with the label \"$OPT1\" below it
- Top right: photo of $OPT2, with the label \"$OPT2\" below it
- Bottom left: photo of $OPT3, with the label \"$OPT3\" below it
- Bottom right: photo of $OPT4, with the label \"$OPT4\" below it
Use realistic, studio-lit food photography. Avoid cartoon style, hand-drawn or AI art artifacts. No extra elements outside the grid."

    PROMPT_JSON=$(jq -Rs . <<< "$PROMPT")

    echo "Generating image for: $QUESTION"

    RESPONSE=$(curl -s https://api.openai.com/v1/images/generations \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $API_KEY" \
        -d "{
            \"model\": \"$MODEL\",
            \"prompt\": $PROMPT_JSON,
            \"n\": 1,
            \"size\": \"$IMAGE_SIZE\"
        }")

    IMAGE_URL=$(echo "$RESPONSE" | jq -r '.data[0].url')

    if [[ "$IMAGE_URL" != "null" ]]; then
        PNG_FILENAME="quiz_${i}.png"
        curl -s "$IMAGE_URL" -o "$PNG_FILENAME"
        echo "✅ Saved $PNG_FILENAME"
    else
        echo "❌ Image generation failed for question $i"
        echo "$RESPONSE"
    fi
done

