class Collection < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :project
  
end
