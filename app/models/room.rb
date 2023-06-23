class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :image
    
  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
    validates :address
  end
end
