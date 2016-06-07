class GoalsController < ApplicationController
  before_action :require_login

  def index
    @goals = current_user.goals
  end

  def show
    @goal = Goal.find_by_id(params[:id])
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find_by_id(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    user = @goal.user
    @goal.destroy
    redirect_to user_url(user)
  end

  def goal_params
    params.require(:goal).permit(:title, :body, :confidential, :status)
  end
end
