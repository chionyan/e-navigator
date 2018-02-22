class InterviewsController < ApplicationController
  before_action :set_user, only: [:index, :new, :create, :order]
  before_action :set_interview, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.where.not(id: current_user.id)
    if @user == current_user
      @interviews = @user.interviews.order('interview_date DESC')
    else
      @interviews = @user.interviews.where.not(interview_status:"承認").order('interview_date DESC')
    end
  end

  def show
  end

  def new
    @interview = @user.interviews.build
  end

  def create
    @interview = @user.interviews.build(interview_params)
    if @interview.save
      flash[:success] = '面接が作成されました'
      redirect_to user_interview_path(@user, @interview)
    else
      flash.now[:danger] = '面接が作成されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @user != current_user
      @interviews.update_all("interview_status='却下'")
    end

    if @interview.update(interview_params)
      flash[:success] = '面接が更新されました'
      redirect_to user_interview_path(@user, @interview)
    else
      flash.now[:danger] = '面接が更新されませんでした'
      render :edit
    end

    if @user != current_user
      @src_user = @user
      @dst_user = current_user
      InterviewMailer.apply(@src_user, @dst_user).deliver
    end
  end

  def destroy
    @interview.destroy
    flash[:success] = '面接が削除されました'
    redirect_to user_interviews_path(@user)
  end

  def order
    @src_user = @user
    @dst_user = User.find(params[:interviewer_id])
    if InterviewMailer.order(@src_user, @dst_user).deliver
      flash[:success] = '申請が完了しました'
      redirect_to user_interviews_path(@src_user)
    else
      flash.now[:danger] = '申請に失敗しました'
      render :index
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_interview  
    @interview = Interview.find(params[:id])
    @user = @interview.user
    @interviews =  @user.interviews
  end

  def interview_params
    params.fetch(:interview, {}).permit(:interview_date, :interview_status)
  end

end
