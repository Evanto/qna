module ApplicationCable
  class Connection < ActionCable::Connection::Base
    def connection
      if cookies[:secret] != '123'
        Rails.logger.info "Reject connection"
        reject_unauthorized_connection
      end
    end
  end
end
