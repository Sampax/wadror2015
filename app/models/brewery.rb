class Brewery < ActiveRecord::Base
  include AverageRating

  validates :name, presence:true
  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                    less_than_or_equal_to: Proc.new { Time.now.year },
                                    only_integer: true }
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2015
    puts "changed year to #{year}"
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
    sorted_by_rating_in_desc_order.take n
  end
end
