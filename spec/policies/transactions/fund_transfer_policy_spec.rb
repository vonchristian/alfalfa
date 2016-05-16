require 'rails_helper'

describe Transactions::FundTransferPolicy do
  subject { Transactions::FundTransferPolicy.new(user, fund_transfer) }

  let(:fund_transfer) { create(:entry_with_credit_and_debit) }



  context "for a project engineer" do
    let(:user) { create(:user, role: :project_engineer) }
     it { should permit(:show)    }
    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end

    context "for an owner of the business " do
    let(:user) { create(:user, role: :owner) }
     it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should_not permit(:destroy) }
  end

  context "for a system administrator " do
    let(:user) { create(:user, role: :system_administrator) }
     it { should permit(:show)    }
    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not  permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end

  context "for a supply officer " do
    let(:user) { create(:user, role: :supply_officer) }
     it { should permit(:show)    }
    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not  permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end

  context "for an accounting officer " do
    let(:user) { create(:user, role: :accounting_officer) }
     it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should_not permit(:destroy) }
  end

  context "for a monitoring officer " do
    let(:user) { create(:user, role: :monitoring_officer) }
     it { should permit(:show)    }
    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not  permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end


end
