class GitreposController < ApplicationController
  def newrepo
      @gitrepo=Gitrepo.new
    end

    def create
      @gitrepo=Gitrepo.new(gitrepo_params)
      if @gitrepo.save
        details=@gitrepo.url.split('/').in_groups_of(3,false).second
        user=details.first
        reponame=details.second
        repo = Github::Client::Repos.new
        @gitcontent=repo.find user: user,repo: reponame

        Dir.chdir("#{Rails.root}")
        FileUtils.mkdir_p("public/system/repositories/github/#{@gitrepo.id}")
        Dir.chdir("public/system/repositories/github/#{@gitrepo.id}")
        puts %x{git clone #{@gitcontent.clone_url}}
        redirect_to gitrepo_path(@gitrepo.id)
      end
    end

    def show
      Dir.chdir("#{Rails.root}")
      @repository=Gitrepo.find(params[:id])
      details=@repository.url.split('/').in_groups_of(3,false).second
      user=details.first
      reponame=details.second
      $path=Rails.root.join("public/system/repositories/github/#{@repository.id}" ,reponame)
      Dir.chdir($path)
      @file=Dir.glob("**/*")

    end
    private
    def gitrepo_params
      params.require(:gitrepo).permit(:id,:url)
    end

  end
