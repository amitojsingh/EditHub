class RepositoriesController < ApplicationController
  require 'zip'
  def new
    @repository=Repository.new(repository_params)
  end

  def index
    @repository=Repository.all
  end
  def create
    @repository=Repository.create(repository_params)
    if @repository.save
    end
    end

  private
  def repository_params
  params.permit(:upload)
end
end
