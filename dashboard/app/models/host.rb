class Host < ApplicationRecord
  has_many :file_delta
  belongs_to :user
end
