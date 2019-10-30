class LiesController < ApplicationController
  before_action :set_lie, only: [:show, :edit, :update, :destroy]

  # GET /lies
  # GET /lies.json
  def index
    @lies = Lie.all
  end

  # GET /lies/1
  # GET /lies/1.json
  def show
  end

  # GET /lies/new
  def new
    order = params[:model_order]&.to_i || 2
    sentences = params[:sentences]&.to_i || 3
    puts "Generating new Lie with order: #{order} sentences: #{sentences}."
    text, ref_ids = Trump.get_sentences(sentences, order)
    @lie = Lie.new(text: text.join(' '), model_order: order, model_version: Trump.model_version)
    @reference_texts = Trump.sample_ref_texts(ref_ids.uniq)
  end

  # GET /lies/1/edit
  def edit
  end

  # POST /lies
  # POST /lies.json
  def create
    @lie = Lie.new(lie_params)

    respond_to do |format|
      if @lie.save
        format.html { redirect_to action: 'index', notice: 'Lie was successfully created.' }
        format.json { render :show, status: :created, location: @lie }
      else
        format.html { render :new }
        format.json { render json: @lie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lies/1
  # PATCH/PUT /lies/1.json
  def update
    respond_to do |format|
      if @lie.update(lie_params)
        format.html { redirect_to @lie, notice: 'Lie was successfully updated.' }
        format.json { render :show, status: :ok, location: @lie }
      else
        format.html { render :edit }
        format.json { render json: @lie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lies/1
  # DELETE /lies/1.json
  def destroy
    @lie.destroy
    respond_to do |format|
      format.html { redirect_to lies_url, notice: 'Lie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lie
      @lie = Lie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lie_params
      params.require(:lie).permit(:text, :model_version, :model_order, :state)
    end
end
