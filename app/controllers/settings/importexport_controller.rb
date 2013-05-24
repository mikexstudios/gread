class Settings::ImportexportController < ApplicationController
  def index
    @importexport = Importexport.new
  end

  def create
    @importexport = Importexport.new(params[:importexport])
    if @importexport.valid?
    else
      render 'index'
    end
  end
end
