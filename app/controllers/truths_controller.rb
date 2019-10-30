class TruthsController < ApplicationController
  before_action :set_truth, only: [:show, :edit, :update, :destroy, :accept]

  PAGE_SIZE = 20

  # GET /truths
  # GET /truths.json
  def index
    @page = params[:page]&.to_i || 1
    offset = (@page - 1) * PAGE_SIZE
    @truths = Truth.where(state: 'ACCEPTED').limit(PAGE_SIZE).offset(offset)
  end

  # GET /truths/review
  def review
    @page = params[:page]&.to_i || 1
    offset = (@page - 1) * PAGE_SIZE
    @truths = Truth.where(state: 'REVIEW').limit(PAGE_SIZE).offset(offset)
  end

  # GET /truths/1
  # GET /truths/1.json
  def show
  end

  # GET /truths/new
  def new
    @truth = Truth.new
  end

  # GET /truths/1/edit
  def edit
  end

  # POST /truths
  # POST /truths.json
  def create
    @truth = Truth.new(truth_params)

    respond_to do |format|
      if @truth.save
        format.html { redirect_to @truth, notice: 'Truth was successfully created.' }
        format.json { render :show, status: :created, location: @truth }
      else
        format.html { render :new }
        format.json { render json: @truth.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /truths/1
  # PATCH/PUT /truths/1.json
  def update
    respond_to do |format|
      if @truth.update(truth_params)
        format.html { redirect_to @truth, notice: 'Truth was successfully updated.' }
        format.json { render :show, status: :ok, location: @truth }
      else
        format.html { render :edit }
        format.json { render json: @truth.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    @truth.update(state: 'ACCEPTED')
    redirect_to review_truths_url, notice: 'Truth was accepted.'
  end

  # DELETE /truths/1
  # DELETE /truths/1.json
  def destroy
    @truth.destroy
    respond_to do |format|
      format.html { redirect_to review_truths_url, notice: 'Truth was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_truth
      @truth = Truth.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def truth_params
      params.require(:truth).permit(:text, :sent, :tweet_id, :retweet_count, :state)
    end
end
