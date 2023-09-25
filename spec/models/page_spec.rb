require 'rails_helper'

RSpec.describe Page, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_uniqueness_of(:name) }
  it { should allow_value('Eng').for(:name) }
  it { should allow_value('Русс').for(:name) }
end
