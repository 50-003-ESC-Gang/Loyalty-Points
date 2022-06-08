class LoyaltyProgramsController < ApplicationController
  before_action :set_loyalty_program, only: %i[ show edit update destroy ]

  # GET /loyalty_programs or /loyalty_programs.json
  def index
    @loyalty_programs = LoyaltyProgram.all
  end

  # def GET
  #   respond_to do |format|
  #     if @loyalty_program.save
  #       format.html { redirect_to loyalty_program_url(@loyalty_program), notice: "Loyalty program was successfully created." }
  #       format.json { render :show, status: :created, location: @loyalty_program }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @loyalty_program.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # GET /loyalty_programs/1 or /loyalty_programs/1.json
  def show
  end

  # GET /loyalty_programs/new
  def new
    @loyalty_program = LoyaltyProgram.new
  end

  # GET /loyalty_programs/1/edit
  def edit
  end

  # POST /loyalty_programs or /loyalty_programs.json
  def create
    @loyalty_program = LoyaltyProgram.new(loyalty_program_params)

    respond_to do |format|
      if @loyalty_program.save
        format.html { redirect_to loyalty_program_url(@loyalty_program), notice: "Loyalty program was successfully created." }
        format.json { render :show, status: :created, location: @loyalty_program }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loyalty_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loyalty_programs/1 or /loyalty_programs/1.json
  def update
    respond_to do |format|
      if @loyalty_program.update(loyalty_program_params)
        format.html { redirect_to loyalty_program_url(@loyalty_program), notice: "Loyalty program was successfully updated." }
        format.json { render :show, status: :ok, location: @loyalty_program }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loyalty_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loyalty_programs/1 or /loyalty_programs/1.json
  def destroy
    @loyalty_program.destroy

    respond_to do |format|
      format.html { redirect_to loyalty_programs_url, notice: "Loyalty program was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loyalty_program
      @loyalty_program = LoyaltyProgram.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loyalty_program_params
      params.require(:loyalty_program).permit(:loyalty_program_id, :program_name, :currency_name, :processing_time, :description, :enrollment_link, :terms_and_conditions_link)
    end
end
