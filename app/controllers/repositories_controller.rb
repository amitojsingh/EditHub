class RepositoriesController < ApplicationController
  before_action :authenticate_user!
  def new
    @repository=Repository.new(repository_params)
  end

  def index
    @repository=Repository.all
    @gitrepo =  Gitrepo.all
  end
  def create
    @repository=Repository.create(repository_params)
    @repository.user=current_user
    if @repository.save
      Zip::File.open("#{@repository.upload.path}") do |file|
        file.each do |entry|
          entry_path=Rails.root.join("public/system/repositories/uploads/extract/#{@repository.id}", entry.name)
          FileUtils.mkdir_p(File.dirname(entry_path))
          entry.extract(entry_path) unless File.exist?(entry_path)
        end
      end
      flash[:success]="Successfully created"
      redirect_to repository_path(@repository.id)
    else
      flash[:danger]="Unable to extract"
      redirect_to repositories_new_path
    end
  end

  def show
    @repository=Repository.find(params[:id])
    if @repository.user==current_user
      @folder=File.basename("#{@repository.upload_file_name}",".zip")
      $path=Rails.root.join("public/system/repositories/uploads/extract/#{@repository.id}" ,@folder)
      Dir.chdir($path)
      @file=Dir.glob("**/*")
    else
      redirect_to repositories_path
      flash[:alert]= "Don't Try to be Smart"
    end
  end

  def generate
    request.GET.each do |key,value|
      @pathvalue=value
    end
    newpath=Rails.root.join($path,@pathvalue)
    @id=params[:id]
    @file=Hash.new

    if File.file?(newpath)
      @content=File.read(newpath)
      puts "#{@content}"
    end

    respond_to do |format|
      format.json { render json: @content }
    end
  end
  private
  def repository_params
    params.permit(:id,:upload)
  end
end
