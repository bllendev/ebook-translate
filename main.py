from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import tensorflow as tf
from transformers import TFAutoModelForSeq2SeqLM, AutoTokenizer

app = FastAPI()

# Load the tokenizer and model
tokenizer = AutoTokenizer.from_pretrained("Helsinki-NLP/opus-mt-en-es")
model = TFAutoModelForSeq2SeqLM.from_pretrained("Helsinki-NLP/opus-mt-en-es")

class TranslationInput(BaseModel):
    text: str

@app.post("/translate")
async def translate(input: TranslationInput):
    try:
        # Tokenize the input text
        # tokens = tokenizer.encode(input.text, return_tensors="tf")

        # # Perform the translation
        # translation_ids = model.generate(tokens)

        # # Decode the translated tokens
        # translated_text = tokenizer.decode(translation_ids[0])

        return {"translated_text": "this is ideally some translated text !!!!!"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
