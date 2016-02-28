class Accounting::Assets::PettyCash
  has_many :disbursements, class_name: "Plutus::Entry", foreign_key: "commercial_document_id"
end
