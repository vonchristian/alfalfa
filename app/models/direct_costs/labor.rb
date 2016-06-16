module DirectCosts
  class Labor < Cost
    belongs_to :employee, foreign_key: 'costable_id'
    validates :costable_id, :costable_type, presence: true
  end
end
