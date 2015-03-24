class Tagging < ActiveRecord::Base
  belongs_to :link
  belongs_to :tag
end
