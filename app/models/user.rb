class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  before_create :generate_api_key

  def generate_api_key
    self.api_key = SecureRandom.hex(32)
  end

  def regenerate_api_key!
    update!(api_key: SecureRandom.hex(32))
  end
end
