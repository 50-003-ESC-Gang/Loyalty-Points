class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :account, :dependent => :destroy
  after_save :create_account

  private

  def create_account
    @account = build_account.save # when `has_one`
  end

  def get_points
    # get points from loyalty program data
    # loyalty_program_data.points
    User.find(@user_id).account.loyalty_program_data.where(loyalty_program_id: 1).first.points
  end
end
