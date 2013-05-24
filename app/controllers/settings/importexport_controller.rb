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
      pp opml.feeds

      #ompl.feeds.each do |feed|
      #  
      #end
      flash[:success] = 'Your subscriptions have been imported!'
      redirect_to :action => :index
    else
      render 'index'
    end
  end
end
