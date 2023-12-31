require 'rails_helper'

RSpec.describe PagesHelper, type: :helper do
  let(:sample_page) { create(:page) }

  describe "when pass raw text" do

    specify "#normalizing_content" do
      normalizing_content = helper.normalizing_content(sample_page.content)
      expect(normalizing_content).to eq '<b>A</b> <i>B</i> <a href=A/a>B</a>'
    end
  end

  describe "when pass root page" do
    let(:sample_page) { create(:page, name: 'A') }

    specify "#render_tree" do
      complete_render = helper.render_tree([sample_page])
      expect(complete_render).to eq "<br><a href=\"A\">A</a>"
    end
  end
end

  