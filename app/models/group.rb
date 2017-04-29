class Group < ApplicationRecord
  has_many :groups_members
  belongs_to :user
end