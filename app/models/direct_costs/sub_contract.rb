module DirectCosts
  class SubContract < Cost
    belongs_to :contractor, foreign_key: 'costable_id'
    
  end
end
