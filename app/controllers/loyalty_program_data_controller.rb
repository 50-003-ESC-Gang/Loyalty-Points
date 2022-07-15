class LoyaltyProgramDataController < ApplicationController
  before_action :set_loyalty_program_datum, only: %i[ show edit update destroy ]

  # GET /loyalty_program_data or /loyalty_program_data.json
  def index
    @loyalty_program_data = LoyaltyProgramDatum.where(account_id: current_user)
    
      
  end



  # GET /loyalty_program_data/1 or /loyalty_program_data/1.json
  def show
    

  end

  # GET /loyalty_program_data/new
  def new
    @loyalty_program_datum = LoyaltyProgramDatum.new
  end

  # GET /loyalty_program_data/1/edit
  def edit
    form_complete = true

    required = [:points]
    required.each do |f|
      if params.has_key? f and not params[f].blank?
        
      else
        form_complete = false
      end
      
      
      if form_complete
        Transaction.create(amount: params[:points], loyalty_program_data_id: 100, status: 0)
      end
    end





  end

  # POST /loyalty_program_data or /loyalty_program_data.json
  def create
    @loyalty_program_datum = LoyaltyProgramDatum.new(loyalty_program_datum_params)

    respond_to do |format|
      if @loyalty_program_datum.save
        format.html { redirect_to loyalty_program_datum_url(@loyalty_program_datum), notice: "Loyalty program datum was successfully created." }
        format.json { render :show, status: :created, location: @loyalty_program_datum }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loyalty_program_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loyalty_program_data/1 or /loyalty_program_data/1.json
  def update
    respond_to do |format|
      if @loyalty_program_datum.update(loyalty_program_datum_params)
        format.html { redirect_to loyalty_program_datum_url(@loyalty_program_datum), notice: "Loyalty program datum was successfully updated." }
        format.json { render :show, status: :ok, location: @loyalty_program_datum }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loyalty_program_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loyalty_program_data/1 or /loyalty_program_data/1.json
  def destroy
    @loyalty_program_datum.destroy

    respond_to do |format|
      format.html { redirect_to loyalty_program_data_url, notice: "Loyalty program datum was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loyalty_program_datum
      @loyalty_program_datum = LoyaltyProgramDatum.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loyalty_program_datum_params
      params.require(:loyalty_program_datum).permit(:loyalty_program_id, :points, :transaction_history)
    end
  end

