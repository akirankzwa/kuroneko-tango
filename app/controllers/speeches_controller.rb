class SpeechesController < ApplicationController
  before_action :set_speech, only: [:show, :edit, :update, :destroy]

  def index
    @speeches = Speech.all
  end

  def show
  end

  def new
    @speech = Speech.new
  end

  def edit
  end

  def create
    @speech = Speech.new(speech_params)

    client = Google::Cloud::TextToSpeech.new(version: :v1beta1)
    synthesis_input = { text: @speech.definition }
    voice = {language_code: "en-US", name: "en-US-Wavenet-F", ssml_gender: 1}
    audio_config = {audio_encoding: "LINEAR16", pitch: 0, speaking_rate: 1 }
    response = client.synthesize_speech synthesis_input, voice, audio_config

    File.open "storage/output.mp3", "wb" do |file|
      file.write response.audio_content
    end

    @speech.speech.attach(io: File.open('storage/output.mp3'), filename: 'output.mp3')

    respond_to do |format|

      if @speech.save
        format.html { redirect_to @speech, notice: 'Speech was successfully created.' }
        format.json { render :show, status: :created, location: @speech }
      else
        format.html { render :new }
        format.json { render json: @speech.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @speech.update(speech_params)
        format.html { redirect_to @speech, notice: 'Speech was successfully updated.' }
        format.json { render :show, status: :ok, location: @speech }
      else
        format.html { render :edit }
        format.json { render json: @speech.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @speech.destroy
    respond_to do |format|
      format.html { redirect_to speeches_url, notice: 'Speech was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_speech
      @speech = Speech.find(params[:id])
    end

    def speech_params
      params.require(:speech).permit(:term, :definition, :status)
    end
end
