class HomeController < ApplicationController
  def index
    photo_count = Photo.count
    @photo = Photo.offset(rand(photo_count)).first
  end
end
