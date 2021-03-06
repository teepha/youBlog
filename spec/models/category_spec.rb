require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Associations" do
    it{ should have_many(:article_categories) }
    it{ should have_many(:articles) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3) }
    it { should validate_length_of(:name).is_at_most(24) }
    it { should validate_uniqueness_of(:name) }
  end
end
