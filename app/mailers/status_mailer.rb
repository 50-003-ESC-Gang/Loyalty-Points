class StatusMailer < ApplicationMailer
    default from: 'ascenda.loyalty@gmail.com'

    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: "Welcome #{@user.name} to Ascenda Loyalty's Point Exchange Program!")
    end

    def status_email
        @user = params[:user]
        @transaction = Transaction.find(params[:transaction_id])
        mail(to: @user.email, subject: "Status Update on your Transaction - #{@transaction.id}")
    end
end
