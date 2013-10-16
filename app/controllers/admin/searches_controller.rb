class Admin::SearchesController < AdminController
  def new
    @search = Search.new
  end

  def create
    @search = Search.create!(params[:search])
    redirect_to [:admin,@search]
  end

  def show
    @search = Search.find(params[:id])
  end
end
