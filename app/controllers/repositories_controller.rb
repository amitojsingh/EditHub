class RepositoriesController < ApplicationController
  def new
    @repository=Repository.new
  end

  def index
  end
  def create
    @repository=Repository.new(repository_params)
  end

  private
  def repository_params
  params.permit(:zip_upload)
end
end
