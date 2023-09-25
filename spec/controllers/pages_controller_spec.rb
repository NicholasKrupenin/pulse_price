require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:page) { create(:page) }

  describe "GET #index" do
    let(:root_pages) { create_list(:page, 3) }

    before { get :index }

    it "populates an array of all root pages" do
      expect(assigns(:root)).to match_array(root_pages)
    end

    it "renders index view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    before { get :new, params: { page: attributes_for(:page) } }

    it "creates a new page" do
      expect(assigns(:page)).to be_new_record
    end

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe "GET #show" do
    before { get :show, params: { page_path: "#{page.name}", page: attributes_for(:page) } }

    it "renders show view" do
      expect(response).to render_template :show
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves a new page in the database" do
        expect { post :create, params: { page: attributes_for(:page) } }.to change(Page, :count).by(1)
      end

      it "redirects to root view" do
        post :create, params: { page: attributes_for(:page) }
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid attributes" do
      it "does not save the page" do
        expect { post :create, params: { page: attributes_for(:page, :invalid) } }.to_not change(Page, :count)
      end

      it "re-renders new view" do
        post :create, params: { page: attributes_for(:page, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "assigns the @page" do
        patch :update, params: { page_path: "#{page.name}", page: attributes_for(:page) }
        expect(assigns(:page)).to eq page
      end

      it "changes page attributes" do
        patch :update, params: { page_path: "#{page.name}", page: { title: "new title", content: 'new body' } }
        page.reload

        expect(page.title).to eq "new title"
        expect(page.content).to eq "new body"
      end

      it "redirects to updated page" do
        patch :update, params: { page_path: "#{page.name}", page: attributes_for(:page) }
        expect(response).to redirect_to page_path
      end
    end

    context "with invalid attributes" do
      before { patch :update, params: { page_path: "#{page.name}", page: attributes_for(:page, :invalid) } }

      it "does not change page" do
        page.reload

        expect(page.title).to eq "a_title"
        expect(page.content).to eq "*[A]* \\[B]\\ ((A/a [B]))"
      end

      it "re-renders edit view" do
        expect(response).to render_template :edit
      end
    end
  end
end
