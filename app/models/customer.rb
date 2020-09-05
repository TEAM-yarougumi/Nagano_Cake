class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_furigana, presence: true
  validates :first_furigana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true, uniqueness: true

  enum status: { 退会: 0, 有効: 1}
  
end
