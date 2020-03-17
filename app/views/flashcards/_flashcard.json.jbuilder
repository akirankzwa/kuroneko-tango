json.extract! flashcard, :id, :term, :definition, :status, :created_at, :updated_at
json.url flashcard_url(flashcard, format: :json)
json.speech rails_blob_path(@flashcard.speech)
