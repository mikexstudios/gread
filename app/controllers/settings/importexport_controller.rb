require 'opml_saw'

class Settings::ImportexportController < ApplicationController
  def index
    @importexport = Importexport.new
  end

  def create
    @importexport = Importexport.new(params[:importexport])
    if @importexport.valid?
      opml = params[:importexport][:opml].read
      opml = OpmlSaw::Parser.new(opml)
      opml.parse
      opml.feeds.each do |feed|
        Feed.delay.subscribe(feed[:xml_url])
      end

      flash[:success] = 'Your subscriptions are being imported!'
      redirect_to :action => :index
    else
      render 'index'
    end
  end
end
