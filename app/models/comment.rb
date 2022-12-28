class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :text, length: { minimum: 10}

  default_scope { order(updated_at: :desc) }

end
