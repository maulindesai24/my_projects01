class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        @likeable = find_likeable
        @like = @likeable.likes.new(user: current_user)

        if @like.save
            redirect_back fallback_location: root_path, notice: "Liked!"
        else
            redirect_back fallback_location: root_path
        end
    end

    def destroy
        @like = Like.find_by(id: params[:id], user: current_user)
        @like.destroy if @like
            redirect_back fallback_location: root_path
    end

    private
    def find_likeable
        type = params[:likeable_type]
        id   = params[:likeable_id]

        type.constantize.find(id) if type.present? && id.present?
    end
end
