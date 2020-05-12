class Book < ApplicationRecord
  belongs_to :author
  has_many :comments,
           dependent: :destroy,
           as: :commentable

  validates :title, presence: true
  validates :author_id, presence: true
  validates :genre, presence: true
  validates :pages,
            numericality: { only_integer: true },
            presence: true
end
