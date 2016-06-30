class WikisController < ApplicationController

  before_action :require_sign_in, except: [:index, :show]
  before_action :set_wiki, except: [:index, :new, :create]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash[:alert] = "Error saving wiki. Please try again."
      render :edit
    end
   end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    authorize @wiki
    @wiki.collaborators = params[:wiki][:user_id]
    if @wiki.update(wiki_params)
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash[:alert] = "Error updating the wiki. Please try again."
      render :edit
    end
  end

  def destroy
     authorize @wiki
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
   end

   private

    def wiki_params
      params.require(:wiki).permit(:title, :description, :public)
    end

    def set_wiki
      @wiki = Wiki.find(params[:id])
    end

end
