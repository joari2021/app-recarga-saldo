class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_one :balance, dependent: :destroy
  has_many :recharges, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :deposits, dependent: :destroy
  include PermissionsConcern

  after_create :set_profile
  after_create :set_balance

  def set_profile
    self.profile = Profile.create()
  end

  def set_balance
    self.balance = Balance.create()
  end
end
