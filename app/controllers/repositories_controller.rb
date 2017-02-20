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
                entry_path=Rails.root.join("public/system/repositories/uploads/extract", entry.name)
                        FileUtils.mkdir_p(File.dirname(entry_path))
                        entry.extract(entry_path) unless File.exist?(entry_path)
                      end
                    end
            #  puts "Extracting #{entry.name}"
            #if entry.directory?
            #  puts "#{entry.name}is folder"
            #elsif entry.symlink?
            #  puts "#{entry.name} is symlink"
            #elsif entry.file?
            #  puts "#{entry.name} is file
            flash[:success]="Successfully created"
          redirect_to repositories_path
        else
          flash[:danger]="Unable to extract"
          redirect_to repositories_new_path
        end
    end
      def show
        @repository=Repository.find(params[:id])
        path=Rails.root.join("public/system/repositories/uploads/extract" , @repository.upload_file_name)
        Dir.chdir("public/system/repositories/uploads/extract/#{@repository.upload_file_name}")
        puts" #{Dir.pwd}"
      end

    private
    def repository_params
    params.permit(:id,:upload)
  end
  end
