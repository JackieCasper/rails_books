class User < ApplicationRecord
  has_secure_password
  has_many :comments, dependent: :destroy

  before_validation :downcase_email
  before_validation :set_user_avatar

  validates :email,
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
  validates :password_confirmation, presence: true
  validates :password, confirmation: true
  validates :name, presence: true
  validates :avatar,
            presence: true,
            format: {
              with:  URI.regexp(%w[http https]),
              message: 'please insert a image url'
            }

  scope :like_lower_email, ->(email) { where('LOWER(name) LIKE ?', "%#{email.downcase}%") }

private

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def set_user_avatar
    self.avatar ||= "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?d=identicon&f=y"
  end
end
