require 'rails_helper'

describe Accounting::BalanceSheetPolicy do
  subject { Accounting::BalanceSheetPolicy.new(user, nil) }

  context "for an accounting officer " do
    let(:user) { create(:user, role: :accounting_officer) }
    it { should permit(:index)  }
  end
  context "for a project officer " do
    let(:user) { create(:user, role: :project_engineer) }
    it { should_not permit(:index)  }
  end


end
