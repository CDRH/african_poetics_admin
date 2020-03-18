class Event < ApplicationRecord
  include Dates

  before_save :set_date_not_before

  has_and_belongs_to_many :news_items,
    dependent: :destroy
  has_and_belongs_to_many :people,
    dependent: :destroy

  belongs_to :location

  private

  def set_date_not_before
    self.date_not_before = derive_date_not_before(date)
  end

end
