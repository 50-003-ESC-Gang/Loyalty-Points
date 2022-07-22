class LoyaltyProgramDataController < ApplicationController
  before_action :set_loyalty_program_datum, only: %i[ show edit update destroy ]

  # GET /loyalty_program_data or /loyalty_program_data.json
  def index
    # @loyalty_program_data = LoyaltyProgramDatum.all
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
      # if @loyalty_program_datum.update(loyalty_program_datum_params)
        # debugger


        # I want to add points to a particular loyalty program data with loyalty program id = params[:id], but dont know how to do
        # @loyalty_program_datum.where(loyalty_program_id: params[:id]).points += loyalty_program_datum_params[:points].to_d
        # puts @loyalty_program_datum.points
        # puts @loyalty_program_datum.account_id
        # puts @loyalty_program_datum.loyalty_program_id
        # puts @loyalty_program_datum.id
        # puts "Above is the object info"
        @loyalty_program_datum.points += loyalty_program_datum_params[:in_points].to_d
        @loyalty_program_datum.save

 
        @transaction = Transaction.create(amount: loyalty_program_datum_params[:in_points].to_d, loyalty_program_datum_id: params[:id], status: 0, account_id: current_user.id)
        if (@transaction)
          AccrualProcessor.convert_to_accrual(@transaction)
        end 
        format.html { redirect_to loyalty_program_datum_url(@loyalty_program_datum), notice: "Loyalty program datum was successfully updated." }
        format.json { render :show, status: :ok, location: @loyalty_program_datum }
      # else
      #   format.html { render :edit, status: :unprocessable_entity }
      #   format.json { render json: @loyalty_program_datum.errors, status: :unprocessable_entity }
      # end
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
      params.require(:loyalty_program_datum).permit(:loyalty_program_id, :points, :in_points)
    end
  end

