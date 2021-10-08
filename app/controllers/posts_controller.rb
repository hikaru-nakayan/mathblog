class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: [:destroy, :edit, :update]

  def new
    @post = Post.new
  end

  def index
  end

  def preview_new
    @post = current_user.posts.new(post_params)
    render :new unless @post.valid? 
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do

        # PDF文書を作成
        pdf = Prawn::Document.new

        pdf.font "app/assets/fonts/ipaexm.ttf" 

        # PDFに "Hello, world!!" と表示する
        pdf.text "#{@post.content}"

        send_data pdf.render,
          filename:    "#{@post.id}.pdf",
          type:        "application/pdf",
          disposition: "inline"
      end
    end
  end

  def create
    @post = current_user.posts.new(post_params)

    if params[:preview].present?
      render :preview_new
      return
    end

    if params[:back].present?
      render :new
      return
    end

    if @post.save
      flash[:success] = "記事を作成しました。"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "記事を削除しました。"
    redirect_to request.referrer || root_url
  end

  def update
    if @post.update(post_params)
      flash[:success] = "記事を編集しました。"
      redirect_to root_url
    else
      render :edit
    end
  end

  def edit  
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
