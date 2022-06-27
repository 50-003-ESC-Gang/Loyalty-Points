class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :account
  after_save :create_account

  private

  def create_account
    byebug
    build_account.save # when `has_one`
    # Account.create!(user_id : id)
  end
end
