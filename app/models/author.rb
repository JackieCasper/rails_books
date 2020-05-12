class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :email,
            confirmation: true,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/,
              message: 'Invalid email address'
            },
            length: {
              minimum: 5,
              message: 'How can an email be less than 5 characters?'
            }
  validates :email_confirmation, presence: true
  validates :name, presence: true
end
