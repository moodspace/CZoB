class AlbumsController < ApplicationController
  layout 'main'
  def show
    @habitat = params[:habitat] ? params[:habitat] : 'undefined'
    @food = params[:food] ? params[:food] : 'undefined'
    @id = params[:id].to_i == 0 ? 'undefined' : params[:id].to_i
    render 'albums/index'
  end
end
