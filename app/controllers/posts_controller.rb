class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = current_user.posts
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            redirect_to posts_path, notice: "Post created successfully."
        else
            Rails.logger.debug "💥 Post save failed: #{@post.errors.full_messages}"
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @post = current_user.posts.find(params[:id])
    end

    def edit
        # Optional: Ensure only post owner can edit
        redirect_to posts_path, alert: "Not authorized" unless @post.user == current_user
    end

    def update
        if @post.user == current_user
        if @post.update(post_params)
            redirect_to posts_path, notice: "Post updated."
        else
            render :edit, status: :unprocessable_entity
        end
        else
            redirect_to posts_path, alert: "Not authorized"
        end
    end

    def destroy
        if @post.user == current_user
            @post.destroy
            redirect_to posts_path, notice: "Post deleted."
        else
            redirect_to posts_path, alert: "Not authorized"
        end
    end

    private
    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :body)
  end
end
