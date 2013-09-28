require 'spec_helper'

describe User do
  subject(:user) { build(:user) }

  it { should respond_to(:topics) }
  it { should respond_to(:replies) }
  it { should respond_to(:stars) }
  it { should respond_to(:role) }

  it { should respond_to(:replies_count) }
  it { should respond_to(:topics_count) }

  it { should respond_to(:username) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should ensure_length_of(:username).is_at_most(17) }

  it { should validate_presence_of(:role) }
  it { should ensure_inclusion_of(:role).in_array(%w[admin moderator user]) }
  its(:role) { should == "user" }

  describe "when username's format is invalid" do
    before { user.username = "@#123" }

    it { should_not be_valid }
  end

  describe "#star_topic" do
    let(:user) {create(:confirmed_user)}
    let(:topic) {create(:topic)}

    it "star a new topic" do
      expect do
        user.star_topic(topic.id)
      end.to change{user.stars.length}.from(0).to(1)
    end

    it "star a stared topic" do
      user.star_topic(topic.id)

      expect do
        user.star_topic(topic.id)
      end.not_to change{user.stars.length}
    end
  end

  describe "#unstar_topic" do
    let(:user){create(:confirmed_user)}
    let(:topic){create(:topic)}
    let(:topic_two){create(:topic)}

    it "unstar a stared topic" do
      user.star_topic(topic.id)

      expect do
        user.unstar_topic(topic.id)
      end.to change{user.stars.length}.from(1).to(0)
    end

    it "unstar a unstared topic" do
      user.star_topic(topic.id)

      expect do
        user.unstar_topic(topic_two.id)
      end.not_to change{user.stars.length}
    end
  end
end
