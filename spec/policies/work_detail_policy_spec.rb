require 'rails_helper'

describe WorkDetailPolicy do
  subject { WorkDetailPolicy.new(user, work_detail) }

  let(:work_detail) { create(:work_detail) }



  context "for a project engineer" do
    let(:user) { create(:user, role: :project_engineer) }
     it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should permit(:destroy) }
  end

    context "for an owner of the business " do
    let(:user) { create(:user, role: :owner) }
     it { should permit(:show)    }
    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not  permit(:update)  }
    it { should_not permit(:edit)    }
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
    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end

  context "for a monitoring officer " do
    let(:user) { create(:user, role: :monitoring_officer) }
     it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should  permit(:update)  }
    it { should permit(:edit)    }
    it { should_not permit(:destroy) }
  end


end
