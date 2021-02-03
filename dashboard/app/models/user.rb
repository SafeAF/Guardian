class User < ApplicationRecord
	has_many :hosts, autosave: true, dependent: :destroy
end
