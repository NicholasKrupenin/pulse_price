class PagesController < ApplicationController
  before_action :find_page, only: %i[show edit update]
  before_action :session_ancestor, only: %i[new edit]

  def index
    @root = Page.all.roots
  end

  def show; end

  def new
    @page = Page.new
  end

  def create
    @page = session[:ancestor].nil? ? Page.new(page_param) : ancestor.children.create(page_param)
    if @page.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    @page.update(page_param)
    if @page.save
      redirect_to page_path
    else
      render :edit
    end
  end

  private

  def page_param
    params.require(:page).permit(:name, :title, :content)
  end

  def find_page
    @page = Page.find_by(name: explore_page)
  end

  def session_ancestor
    session[:ancestor] = explore_page
  end

  def ancestor
    Page.find_by(name: session[:ancestor])
  end

  def explore_page
    PathAnalysis.new.explore_path(request)
  end
end
