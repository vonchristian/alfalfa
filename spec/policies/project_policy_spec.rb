require 'rails_helper'

describe ProjectPolicy do
  subject { ProjectPolicy.new(user, project) }

  let(:project) { create(:project) }



   context "for a project engineer" do
    let(:user) { create(:user, role: :project_engineer) }
     it { is_expected.to permit(:show)    }
    it { is_expected.to permit(:create)  }
    it { is_expected.to permit(:new)     }
    it { is_expected.to permit(:update)  }
    it { is_expected.to permit(:edit)    }
    it { is_expected.to_not permit(:destroy) }
  end

    context "for an owner of the business " do
    let(:user) { create(:user, role: :owner) }
     it { is_expected.to_not permit(:show)    }
    it { is_expected.to_not permit(:create)  }
    it { is_expected.to_not permit(:new)     }
    it { is_expected.to_not  permit(:update)  }
    it { is_expected.to_not permit(:edit)    }
    it { is_expected.to_not permit(:destroy) }
  end

  context "for a system administrator " do
    let(:user) { create(:user, role: :system_administrator) }
     it { is_expected.to_not permit(:show)    }
    it { is_expected.to_not permit(:create)  }
    it { is_expected.to_not permit(:new)     }
    it { is_expected.to_not  permit(:update)  }
    it { is_expected.to_not permit(:edit)    }
    it { is_expected.to_not permit(:destroy) }
  end

  context "for a supply officer " do
    let(:user) { create(:user, role: :supply_officer) }
     it { is_expected.to_not permit(:show)    }
    it { is_expected.to_not permit(:create)  }
    it { is_expected.to_not permit(:new)     }
    it { is_expected.to_not  permit(:update)  }
    it { is_expected.to_not permit(:edit)    }
    it { is_expected.to_not permit(:destroy) }
  end

  context "for an accounting officer " do
    let(:user) { create(:user, role: :accounting_officer) }
    it { is_expected.to_not permit(:show)    }
    it { is_expected.to_not permit(:create)  }
    it { is_expected.to_not permit(:new)     }
    it { is_expected.to_not permit(:update)  }
    it { is_expected.to_not permit(:edit)    }
    it { is_expected.to_not permit(:destroy) }
  end

  context "for a monitoring officer " do
    let(:user) { create(:user, role: :monitoring_officer) }
    it { is_expected.to permit(:show)    }
    it { is_expected.to permit(:create)  }
    it { is_expected.to permit(:new)     }
    it { is_expected.to  permit(:update)  }
    it { is_expected.to permit(:edit)    }
    it { is_expected.to_not permit(:destroy) }
  end


end
