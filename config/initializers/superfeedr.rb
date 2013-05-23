module Gread
  class Application < Rails::Application
    config.after_initialize do
      config.superfeedr.on_notification do |n|
        #NOTE: Helpers aren't available here. Models are, so we place notification
        #processing in a model and call that.
        Notification.parse_superfeedr(n)
      end
    end
  end
end
