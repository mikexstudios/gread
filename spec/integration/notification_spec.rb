require 'spec_helper'
require 'json'

describe Notification do
  describe 'with basic notification' do
    before do
      fixture_path = RSpec.configuration.fixture_path
      notification_path = File.join(fixture_path, 'superfeedr/basic.json')
      @n = JSON.parse(File.read(notification_path))
    end

    describe 'should populate information' do
      before { Notification.parse_superfeedr(@n) }
      
      it 'should create a feed' do
        change(Feed, :count).by(1).should be_true
      end

      describe 'feed information' do
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

      describe 'first entry information' do
        before do 
          @entry = Entry.first 
          @i = @n['items'].first
        end
        subject { @entry }

        its(:feed) { should == Feed.first }
        its(:title) { should == @i['title'] }
        its(:url) { should == @i['permalinkUrl'] }
        its(:author) { should == nil }
        its(:content) { should == @i['summary'] }
        its(:updated_at) { should_not == Time.at(@i['published']).to_datetime }
        its(:created_at) { should == Time.at(@i['published']).to_datetime }
      end

      describe 'second entry information with author' do
        before do 
          @entry = Entry.find_by_id(2)
          @i = @n['items'][1]
        end
        subject { @entry }

        its(:feed) { should == Feed.first }
        its(:title) { should == @i['title'] }
        its(:url) { should == @i['permalinkUrl'] }
        its(:author) { should == @i['actor']['displayName'] }
        its(:content) { should == @i['summary'] }
        its(:updated_at) { should_not == Time.at(@i['published']).to_datetime }
        its(:created_at) { should == Time.at(@i['published']).to_datetime }
      end

    end
  end

  describe 'successive basic notification of same feed' do
    before do
      fixture_path = RSpec.configuration.fixture_path
      #In basic, the example.com feed is new to the system and has published
      #two posts.
      notification_path = File.join(fixture_path, 'superfeedr/basic.json')
      @n1 = JSON.parse(File.read(notification_path))
      Notification.parse_superfeedr(@n1)

      #In basic2, the example.com feed has published its third post.
      notification_path = File.join(fixture_path, 'superfeedr/basic2.json')
      @n2 = JSON.parse(File.read(notification_path))
      Notification.parse_superfeedr(@n2)
    end

    it 'should only create one feed' do
      Feed.count.should == 1
    end

    describe 'third entry information' do
      before do 
        @entry = Entry.find_by_id(3) 
        @i = @n2['items'].first
      end
      subject { @entry }

      its(:feed) { should == Feed.first }
      its(:title) { should == @i['title'] }
      its(:url) { should == @i['permalinkUrl'] }
      its(:author) { should == nil }
      its(:content) { should == @i['summary'] }
      its(:updated_at) { should_not == Time.at(@i['published']).to_datetime }
      its(:created_at) { should == Time.at(@i['published']).to_datetime }
    end
  end

  describe 'with basic notification without datetimes' do
    before do
      fixture_path = RSpec.configuration.fixture_path
      notification_path = File.join(fixture_path, 'superfeedr/basic.json')
      @n = JSON.parse(File.read(notification_path))
      #Setting feed updated time to nil and first item's published time to nil
      @n['updated'] = nil
      @i = @n['items'].first
      @i['published'] = nil
      Notification.parse_superfeedr(@n)

      @feed = Feed.first
    end
    subject { @feed }

    #Because of possible time lag during testing, we allow a margin of error
    #of 30 min for the updated_at time. This is fine since the .json test
    #file has a nil timestamp.
    its(:updated_at) { should >= DateTime.now - 30.minutes }

    describe 'entry information without datetime' do
      before do 
        @entry = Entry.first 
        @i = @n['items'].first
      end
      subject { @entry }

      its(:created_at) { should >= DateTime.now - 30.minutes }
    end
  end
end
