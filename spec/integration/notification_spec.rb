require 'spec_helper'
require 'json'

describe Notification do
  describe 'with superfeedr notification' do
    before do
      fixture_path = RSpec.configuration.fixture_path
      notification_path = File.join(fixture_path, 'basic-superfeedr-notification.json')
      @n = JSON.parse(File.read(notification_path))
    end

    describe 'should populate information' do
      before { Notification.parse_superfeedr(@n) }
      
      it 'should create a feed' do
        change(Feed, :count).by(1).should be_true
      end

      describe 'should have feed information' do
        before { @feed = Feed.first }
        subject { @feed }

        its(:title) { should == @n['title'] }
        its(:url) { should == @n['status']['feed'] }
        its(:updated_at) { should == Time.at(@n['updated']).to_datetime }
        its(:created_at) { should_not == Time.at(@n['updated']).to_datetime }
      end


      it 'should create two entries' do
        change(Entry, :count).by(2).should be_true
      end

      describe 'should have first entry information' do
        before do 
          @entry = Entry.first 
          @i = @n['items'].first
        end
        subject { @entry }

        its(:feed) { should == Feed.first }
        its(:title) { should == @i['title'] }
        its(:permalink) { should == @i['permalinkUrl'] }
        its(:content) { should == @i['summary'] }
        its(:updated_at) { should_not == Time.at(@i['published']).to_datetime }
        its(:created_at) { should == Time.at(@i['published']).to_datetime }
      end
    end
  end
end
