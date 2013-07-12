class EntriesController < ApplicationController
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      #format.html
      format.html 
      format.json { render :json => @entry }
    end
  end
end
