class Link < ApplicationRecord
  belongs_to :user
  belongs_to :storage
end
