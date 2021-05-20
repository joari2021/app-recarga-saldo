class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one :profile, dependent: :destroy
  has_one :balance, dependent: :destroy
  has_many :recharges, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :deposits, dependent: :destroy
  include PermissionsConcern

  before_create :set_profile
  before_create :set_balance
  after_create :set_user_id_referidor
  after_create :verify_referidor 
  
  def set_profile
    self.profile = Profile.create()
  end

  def set_balance
    self.balance = Balance.create()
  end

  def set_user_id_referidor
    def create_id_referidor
      @new_id_referidor = 16.times.map { [*'0'..'9', *'A'..'Z'].sample }.join
      if User.find_by(referidor_id: @new_id_referidor).present?
        create_id_referidor()
      end
    end
    create_id_referidor()

    self.update(referidor_id: @new_id_referidor)
  end

  def verify_referidor
    unless User.find_by(referidor_id: self.user_referidor_id).present?
      self.update(user_referidor_id: nil)
    end
  end
end
