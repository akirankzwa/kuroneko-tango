class HomeController < ApplicationController
  def index
    client = Google::Cloud::TextToSpeech.new(version: :v1beta1)

    synthesis_input = { text: "Google Cloud Text-to-Speech enables developers to synthesize natural-sounding speech with 100+ voices, available in multiple languages and variants." }

    voice = {
      language_code: "en-US",
      name: "en-US-Wavenet-F",
      ssml_gender: 1
    }

    audio_config = {
      "audio_encoding": "LINEAR16",
      "pitch": 0,
      "speaking_rate": 1
    }

    response = client.synthesize_speech synthesis_input, voice, audio_config

    File.open "output.mp3", "wb" do |file|
      file.write response.audio_content
    end
  end
end
