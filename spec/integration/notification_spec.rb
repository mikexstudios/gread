require 'spec_helper'
require 'json'

describe Notification do
  describe 'with superfeedr notification' do
    before do
      fixture_path = RSpec.configuration.fixture_path
      notification_path = File.join(fixture_path, 'basic-superfeedr-notification.json')
      @n = JSON.parse(File.read(notification_path))
    end

    it 'should create a feed' do
      expect { Notification.parse_superfeedr(@n) }.to change(Feed, :count).by(1)
    end
    it 'should create two entries' do
      expect { Notification.parse_superfeedr(@n) }.to change(Entry, :count).by(2)
    end
  end
end
