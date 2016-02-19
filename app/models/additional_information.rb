class AdditionalInformation < ActiveRecord::Base
  belongs_to :informeable, polymorphic: true



  def self.sexes
    %w(Male Female)
  end

  def self.civil_statuses
    %w(Single Married Widowed)
  end
end
