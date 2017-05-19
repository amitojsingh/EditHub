# This is main repositories controller
class RepositoriesController < ApplicationController
  before_action :authenticate_user!
  def new
    @repository = Repository.new(repository_params)
  end

  def index
    Dir.chdir(Rails.root)
    puts "present directory=#{Dir.pwd}"
    @repository = Repository.all
    @gitrepo =  Gitrepo.all
  end

  def create
    @repository = Repository.create(repository_params)
    @repository.user = current_user
    if @repository.save
      Dir.chdir(Rails.root)
      create_repo
      flash[:success] = 'Successfully created'
      redirect_to repository_path(@repository.id)
    else
      flash[:danger] = 'Unable to extract'
      redirect_to repositories_new_path
    end
  end

  def show
    @repository = Repository.find(params[:id])
    if @repository.user == current_user
      show_repo
    else
      redirect_to repositories_path
      flash[:alert] = "Don't Try to be Smart"
    end
  end

  def generate
    request.GET.each do |_key, value|
      @pathvalue = value
    end
    generate_repo
  end

  def moveto
    goto = {}
    request.path_parameters.each do |key, value|
      goto[key] = value
    end
    path = "/system/repositories/uploads/extract/#{goto[:id]}/#{goto[:upload_file_name]}#{goto[:all]}"
    redirect_to(path)
  end

  def filedata
    name = {}
    request.POST.each do |key, value|
      name[key] = value
    end
    puts name['file']
    f = File.open(name['file'], 'w')
    f.write(name['content'])
    f.close

  end

  private

  def repository_params
    params.permit(:id, :upload)
  end

  def create_repo
    Zip::File.open(@repository.upload.path) do |file|
      file.each do |entry|
        path = "public/system/repositories/uploads/extract/#{@repository.id}"
        entry_path = Rails.root.join(path, entry.name)
        FileUtils.mkdir_p(File.dirname(entry_path))
        entry.extract(entry_path) unless File.exist?(entry_path)
      end
    end
  end

  def show_repo
    @folder = File.basename(@repository.upload_file_name, '.zip')
    path = "public/system/repositories/uploads/extract/#{@repository.id}"
    @path = Rails.root.join(path, @folder)
    Dir.chdir(@path)
    puts "after click= #{Dir.pwd}"
    @file = Dir.glob('**/*')
  end

  def generate_repo
    @path = Dir.pwd
    newpath = Rails.root.join(@path, @pathvalue)
    @id = params[:id]
    @file = {}
    if File.file?(newpath)
      @content = File.read(newpath)
    end
    respond_to do |format|
      format.json { render json: @content }
    end
  end
end
