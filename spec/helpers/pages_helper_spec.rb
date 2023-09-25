require 'rails_helper'

RSpec.describe PagesHelper, type: :helper do
  let(:sample_page) { create(:page) }

  describe "when pass raw text" do

    specify "#normalizing_content" do
      normalizing_content = helper.normalizing_content(sample_page.content)
      expect(normalizing_content).to eq '<b>A</b> <i>B</i> <a href=A/a>B</a>'
    end
  end
end

