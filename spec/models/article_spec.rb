require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "Associations" do
    it{ should belong_to(:user) }
    it{ should have_many(:article_categories) }
    it{ should have_many(:categories) }
  end

  describe "Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(3) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(10) }
  end
end
