class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  respond_to :html

  def index
    @links = Link.all
    respond_with(@links)
  end

  def show
    respond_with(@link)
  end

  def new
    @link = current_user.links.build
    respond_with(@link)
  end

  def edit
  end

  def create
    @link = current_user.links.build(link_params)
    @link.save
    respond_with(@link)
  end

  def update
    @link.update(link_params)
    respond_with(@link)
  end

  def destroy
    @link.destroy
    flash[:notice] = "You deleted a link!"
    respond_with(@link)
  end
  def upvote
    @link = Link.find(params[:id])
    @link.upvote_by current_user
    redirect_to :back
  end
  def downvote
    @link = Link.find(params[:id])
    @link.downvote_by current_user
    redirect_to :back
  end
  private
    def set_link
      @link = Link.find(params[:id])
    end

    def link_params
      params.require(:link).permit(:title, :url)
    end
end
