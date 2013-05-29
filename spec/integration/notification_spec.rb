require 'spec_helper'
require 'json'

describe Notification do
  describe 'with superfeedr notification' do
    before do
      fixture_path = RSpec.configuration.fixture_path
      notification_path = File.join(fixture_path, 'basic-superfeedr-notification.json')
      @n = JSON.parse(File.read(notification_path))
    end

    describe 'should populate feed information' do
      before { Notification.parse_superfeedr(@n) }
      
      it 'should create a feed' do
        change(Feed, :count).by(1).should be_true
      end

      it 'should create two entries' do
        change(Entry, :count).by(2).should be_true
      end
    end
  end
end
