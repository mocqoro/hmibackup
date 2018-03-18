class NotificationsController < ApplicationController
	before_action :set_notification, only: [:read, :show, :delete]
	after_action :notification_flag_read, only: [:show]
	
	def create
		@user = User.find(params[:user_id])
		@user.create_notification(params[:notification_title], params[:notification_body])
		redirect_back fallback_location: root_path
	end
	
	def show
	end
	
	def read
		@user = @notification.user
		@notification.read_notification
		redirect_back fallback_location: notifications_user_path(@user)
	end
	
	def delete
		@user = @notification.user
		@notification.destroy
		flash[:success] = "Notification was successfully deleted"
		redirect_back fallback_location: notifications_user_path(@user)
	end
	
	private
		def set_notification
			@notification = Notification.find(params[:id])
		end
		
		def notification_flag_read
			@notification.read_notification
		end
end