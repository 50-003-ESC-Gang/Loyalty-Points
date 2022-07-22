module AccountsHelper
  def get_account(user_id)
    @account = Account.find(user_id)
    return @account
  end
end
