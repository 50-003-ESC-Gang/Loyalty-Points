class LoyaltyProgramDataController < ApplicationController
  before_action :set_loyalty_program_datum, only: %i[show edit update destroy]

  # GET /loyalty_program_data or /loyalty_program_data.json
  def index
    # @loyalty_program_data = LoyaltyProgramDatum.all
    @loyalty_program_data = LoyaltyProgramDatum.where(account_id: current_user)
    @loyalty_program = []

    @loyalty_program_data.each do |loyalty_program_datum|

      @temp = LoyaltyProgram.where(loyalty_program_id: loyalty_program_datum.loyalty_program_id)
      # There is not suppose to be loyalty_program_data with loaylty program id = 10 [BUGGG]
      @loyalty_program.append(@temp)
    end

    @loyalty_programs = @loyalty_program_data.zip(@loyalty_program)
  
  end

  # GET /loyalty_program_data/1 or /loyalty_program_data/1.json
  def show; end

  # GET /loyalty_program_data/new
  def new
    # @loyalty_program_datum = LoyaltyProgramDatum.new
  end


  def confirm
   
  
    current_loyalty_program_data = LoyaltyProgramDatum.where(id: params[:loyalty_program_datum_id])[0]
    current_loyalty_program = LoyaltyProgram.where(loyalty_program_id: current_loyalty_program_data.loyalty_program_id)[0]


    respond_to do |format|
      if params[:in_points] != ""
        if params[:in_points].to_d.is_a? Numeric
          val = current_loyalty_program.conversion_rate * params[:in_points].to_d
          msg = format("The amount transfered after conversion -> %f. \n Point Transfer is now being processed", val)
          @loyalty_program_datum.points += val
          @loyalty_program_datum.save

          @transaction = Transaction.create(amount: loyalty_program_datum_params[:in_points].to_d, loyalty_program_datum_id: current_loyalty_program.loyalty_program_id, status: 0, account_id: current_user.id)
          # if (@transaction)
          #   AccrualProcessor.convert_to_accrual(@transaction)
          # end 
        format.html { redirect_to loyalty_program_datum_url(@loyalty_program_datum), notice: msg }
        format.json { render :show, status: :ok, location: @loyalty_program_datum }
          format.html { redirect_to edit_loyalty_program_datum_url(params[:loyalty_program_datum_id]), notice: msg  }
        else
          format.html { redirect_to edit_loyalty_program_datum_url(params[:loyalty_program_datum_id]), notice: "Input must be numerical" }
        end
      else
        format.html { redirect_to edit_loyalty_program_datum_url(params[:loyalty_program_datum_id]), notice: "Input cannot be empty" }
      end
    end

    

    @converted = params[:in_points] * current_loyalty_program.conversion_rate


   

  end

  # GET /loyalty_program_data/1/edit
  def edit; end

  # POST /loyalty_program_data or /loyalty_program_data.json
  def create
    @loyalty_program_datum = LoyaltyProgramDatum.new(loyalty_program_datum_params)

    respond_to do |format|
      if @loyalty_program_datum.save
        format.html do
          redirect_to loyalty_program_datum_url(@loyalty_program_datum),
                      notice: 'Loyalty program datum was successfully created.'
        end
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
        current_loyalty_program_data = LoyaltyProgramDatum.where(id: params[:id])[0]
        current_loyalty_program = LoyaltyProgram.where(loyalty_program_id: current_loyalty_program_data.loyalty_program_id)[0]


        val = if current_loyalty_program.conversion_rate.nil?
          loyalty_program_datum_params[:in_points].to_d

        else
          current_loyalty_program.conversion_rate * loyalty_program_datum_params[:in_points].to_d

        end
        msg = "The amount transfered after conversion -> %f. \n Point Transfer is now being processed" % [val]

        @loyalty_program_datum.points += val
        @loyalty_program_datum.save!

        @transaction = Transaction.create(
          amount: val,
          loyalty_program_id: current_loyalty_program.loyalty_program_id, 
          status: 0, 
          account_id: current_user.id,
          loyalty_program_datum_id: 11,
        )
        if (@transaction)
          AccrualProcessor.convert_to_accrual(@transaction)
        end 
        format.html { redirect_to loyalty_program_datum_url(@loyalty_program_datum), notice: msg }
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
      format.html { redirect_to loyalty_program_data_url, notice: 'Loyalty program datum was successfully destroyed.' }
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
