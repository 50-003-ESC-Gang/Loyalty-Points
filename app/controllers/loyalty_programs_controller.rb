class LoyaltyProgramsController < ApplicationController
  include Authenticable

  before_action :set_loyalty_program, only: %i[show edit update destroy]

  before_action :authenticate_admin!, only: [:update_conversion_rate] # `only` part if applicable

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
  def show; end

  # GET /loyalty_programs/new
  def new
    @loyalty_program = LoyaltyProgram.new
  end

  # GET /loyalty_programs/1/edit
  def edit; end

  # POST /loyalty_programs or /loyalty_programs.json
  def create
    @loyalty_program = LoyaltyProgram.new(loyalty_program_params)

    respond_to do |format|
      if @loyalty_program.save
        format.html do
          redirect_to loyalty_program_url(@loyalty_program), notice: 'Loyalty program was successfully created.'
        end
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
        format.html do
          redirect_to loyalty_program_url(@loyalty_program), notice: 'Loyalty program was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @loyalty_program }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loyalty_program.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_conversion_rate; end

  # DELETE /loyalty_programs/1 or /loyalty_programs/1.json
  def destroy
    @loyalty_program.destroy

    respond_to do |format|
      format.html { redirect_to loyalty_programs_url, notice: 'Loyalty program was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def link
    @loyalty_program = LoyaltyProgram.find(params[:loyalty_program_id])
    # byebug

    validity = @loyalty_program.valid_membership(params[:membership_id])

    respond_to do |format|
      if validity
        format.html do
          redirect_to loyalty_program_url(@loyalty_program),
                      notice: 'Loyalty Program Membership was successfully linked.'
        end
        # format.json { head :no_content }
      else
        # format.html { redirect_to loyalty_program_url(@loyalty_program), notice: "Loyalty Program Membership was not found!" }
        # format.json { head :no_content }
        format.html do
          redirect_to loyalty_program_url(@loyalty_program), notice: 'Loyalty Program Membership could not be linked!',
                                                             status: :unprocessable_entity
        end
        # @loyalty_program.new :error
        @loyalty_program.errors[:validity] << ['Loyalty Program Membership could not be linked!']
        format.json { render json: @loyalty_program.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_loyalty_program
    @loyalty_program = LoyaltyProgram.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def loyalty_program_params
    params.require(:loyalty_program).permit(:loyalty_program_id, :program_name, :currency_name, :processing_time,
                                            :description, :enrollment_link, :terms_and_conditions_link, :membership_regex)
  end
  def loyalty_program_admin_params
    params.require(:loyalty_program).permit(:loyalty_program_id, :program_name, :currency_name, :processing_time,
                                            :description, :enrollment_link, :terms_and_conditions_link, :membership_regex. :conversion_rate)

  end
end
