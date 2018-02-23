class NotificationsController < ApplicationController
	before_action :set_notification, only: [:read, :show, :delete]
	after_action :notification_flag_read, only: [:show]
	
	def create
		@user = User.find(params[:user_id])
		@user.create_notification(params[:notification_title], params[:notification_body])
		redirect_to :back
	end
	
	def show
	end
	
	def read
		@notification.read_notification
		redirect_to :back
	end
	
	def delete
		@notification.destroy
		flash[:success] = "Notification was successfully deleted"
		redirect_to :back
	end
	
	private
		def set_notification
			@notification = Notification.find(params[:id])
		end
		
		def notification_flag_read
			@notification.read_notification
		end
end