class SubsController < ApplicationController
  before_action :is_moderator?, only: [:edit, :update, :destroy]
  before_action :must_be_logged_in, only: [:new, :create]

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    @subs = Sub.all
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user

    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def destroy
    @sub_to_destroy = Sub.find(params[:id])
    @sub_to_destroy.destroy
    redirect_to subs_url
  end

  private
  def is_moderator?
    @sub = Sub.find(params[:id])
    current_user == @sub.moderator
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
