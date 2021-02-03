class Host < ApplicationRecord
  has_many :file_delta, autosave: true, dependent: :destroy
  belongs_to :user
end
