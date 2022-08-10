class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]
  # after_action :status_email, only: %i[create edit update new destroy]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.where(account_id: current_user)
  end

  # GET /transactions/1 or /transactions/1.json
  def show; end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit; end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    # StatusMailer.with(user: current_user, transaction_id: @transaction.id).status_email.deliver_now

    respond_to do |format|
      if @transaction.save
        # StatusMailer.with(user: current_user, transaction_id: @transaction.id).status_email.deliver_now
        format.html { redirect_to transaction_url(@transaction), notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
        # generate accrual file
        # Thread.new(AccrualProcessor.convert_to_accrual(@transaction))
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def status_email
    puts "EMAIL DELIVERY"
    StatusMailer.with(user: current_user, transaction_id: @transaction.id).status_email.deliver_now
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:loyalty_program, :user, :date, :amount, :status, :loyalty_program_datum_id)
  end
end
