require 'rails_helper'

describe ProjectPolicy do
  subject { ProjectPolicy.new(user, project) }

  let(:project) { create(:project) }



  context "for a project engineer" do
    let(:user) { create(:user, role: :project_engineer) }
    it { should permit(:create)  }
    it { should permit(:new)     }
  end
end
