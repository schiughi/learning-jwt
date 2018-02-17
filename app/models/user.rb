class User < ApplicationRecord
  has_secure_password
  validates :username,
    uniqueness: { case_sensitive: false },
    length:     { minimum: 4, maximum: 20 },
    format:     { with: /\A[ -~｡-ﾟ]*\z/, message: "は半角で入力してください" }
end
