class FlashcardsController < ApplicationController
  before_action :set_flashcard, only: [:show, :edit, :update, :destroy]

  def index
    @flashcards = Flashcard.all.page(params[:page])
  end

  def show
  end

  def new
    @groups = Group.all
    @flashcard = Flashcard.new
  end

  def edit
    @groups = Group.all
  end

  def create
    @flashcard = Flashcard.new(flashcard_params)
    @flashcard.group_id = params[:group]

    client = Google::Cloud::TextToSpeech.new(version: :v1beta1)
    synthesis_input = { text: @flashcard.definition }
    voice = {language_code: "en-US", name: "en-US-Wavenet-F", ssml_gender: 1}
    audio_config = {audio_encoding: "LINEAR16", pitch: 0, speaking_rate: 1 }
    response = client.synthesize_speech synthesis_input, voice, audio_config

    File.open "storage/output.mp3", "wb" do |file|
      file.write response.audio_content
    end

    @flashcard.speech.attach(io: File.open('storage/output.mp3'), filename: 'output.mp3')


    respond_to do |format|
      if @flashcard.save
        format.html { redirect_to @flashcard, notice: 'Flashcard was successfully created.' }
        format.json { render :show, status: :created, location: @flashcard }
      else
        format.html { render :new }
        format.json { render json: @flashcard.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @flashcard.update(flashcard_params)
        format.html { redirect_to @flashcard, notice: 'Flashcard was successfully updated.' }
        format.json { render :show, status: :ok, location: @flashcard }
      else
        format.html { render :edit }
        format.json { render json: @flashcard.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @flashcard.destroy
    respond_to do |format|
      format.html { redirect_to flashcards_url, notice: 'Flashcard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_flashcard
      @flashcard = Flashcard.find(params[:id])
    end

    def flashcard_params
      params.require(:flashcard).permit(:term, :definition, :status)
    end
end
