# == Schema Information
#
# Table name: areas
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Area < ActiveRecord::Base
  attr_accessible :name

  has_many :area_users
  has_many :questions

  validates :name, presence: true

  default_scope order: 'areas.name'
end
