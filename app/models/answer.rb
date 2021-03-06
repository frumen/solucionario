# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :integer          default(0)
#  user_id     :integer
#  question_id :integer
#  points      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  available   :integer          default(0)
#

class Answer < ActiveRecord::Base
  attr_accessible :content, :points, :user_id, :available, :rejected, :comments_attributes
  has_many :comments, dependent: :destroy
  belongs_to :question
  belongs_to :writer, class_name: "User", foreign_key: "user_id"
  accepts_nested_attributes_for :comments

  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :content, presence: true, length: { maximum: 2000 }

  default_scope order: 'answers.created_at'
end
