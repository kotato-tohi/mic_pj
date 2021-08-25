class Storage < ApplicationRecord
    has_many :links, dependent: :destroy
    validates :name, uniqueness: { scope: :owner_id }
end
