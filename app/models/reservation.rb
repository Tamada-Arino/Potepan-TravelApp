class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  with_options presence: true do
    validates :check_in
    validates :check_out
    validates :people, numericality: { only_integer: true, greater_than: 0 }
  end
  validate :in_out_check
  
  def in_out_check
    unless check_in == nil || check_out ==nil
    errors.add(:check_out, "はチェックインより後の日付を選択してください") unless
    self.check_in < self.check_out
    end
  end
end
