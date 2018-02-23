class Notification < ActiveRecord::Base
    belongs_to :user
    
    # marks this notification as read
    def read_notification
		self.read = true
		self.save
    end
end