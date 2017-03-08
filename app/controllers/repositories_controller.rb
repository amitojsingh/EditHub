  class RepositoriesController < ApplicationController
    def new
      @repository=Repository.new(repository_params)
    end

    def index
      @repository=Repository.all
    end
    def create
      @repository=Repository.create(repository_params)

        if @repository.save
          puts "successfully saved"
          Zip::File.open("#{@repository.upload.path}") do |file|

              file.each do |entry|
                entry_path=Rails.root.join("public/system/repositories/uploads/extract/#{@repository.id}", entry.name)
                        FileUtils.mkdir_p(File.dirname(entry_path))
                        entry.extract(entry_path) unless File.exist?(entry_path)
                      end
                    end
            flash[:success]="Successfully created"
          redirect_to repositories_path
        else
          flash[:danger]="Unable to extract"
          redirect_to repositories_new_path
        end
    end
      def show
        @repository=Repository.find(params[:id])
        @folder=File.basename("#{@repository.upload_file_name}",".zip")
        path=Rails.root.join("public/system/repositories/uploads/extract/#{@repository.id}" ,@folder)
        Dir.chdir("#{path}")
        Dir.open(Dir.pwd).each do |filename|
        next  if File.directory? filename
    # otherwise, process file
              #@files[entries]=path/entries
          end
      end
      def generate
        request.POST.each do |key,value|
          @filename=key
          @path= value
        end
        @id=params[:id]
        @file=Hash.new
        if File.directory?(@path)
           Dir.chdir("#{@path}")
           Dir.glob("*").each do |entries|
             @file[entries]="#{@path}/#{entries}"
            puts "#{entries}"
          end
            #ActionCable.server.broadcast "operations",
          #render(partial: 'operations/dir',object: @operations  )
          else
            @content=File.read(@path)
          #  ActionCable.server.broadcast "editions",
          #  render(partial: 'editions/listen',object:@editions)
          end
      end

    private
    def repository_params
    params.permit(:id,:upload)
  end
  end
