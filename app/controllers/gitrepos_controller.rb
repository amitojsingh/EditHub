# This controller is for Github
class GitreposController < ApplicationController
  before_action :create_github_repo, only: [:create]
  before_action :show_github_repo, only: [:show]
  def newrepo
    @gitrepo = Gitrepo.new
  end

  def create; end

  def show
    details = @repository.url.split('/').in_groups_of(3, false).second
    reponame = details.second
    path = "public/system/repositories/github/#{@repository.id}"
    @path = Rails.root.join(path, reponame)
    Dir.chdir(@path)
    @file = Dir.glob('**/*')
  end

  def moveto
    goto = {}
    request.path_parameters.each do |key, value|
      goto[key] = value
    end
    path = "/system/repositories/github/#{goto[:id]}/#{goto[:url]}#{goto[:all]}"
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

  def gitrepo_params
    params.require(:gitrepo).permit(:id, :url)
  end

  def create_github_repo
    @gitrepo = Gitrepo.new(gitrepo_params)
    return unless @gitrepo.save
    puts 'This is working'
    details = @gitrepo.url.split('/').in_groups_of(3, false).second
    user = details.first
    reponame = details.second
    repo = Github::Client::Repos.new
    @gitcontent = repo.find user: user, repo: reponame
    create_dir
  end

  def create_dir
    Dir.chdir(Rails.root)
    FileUtils.mkdir_p("public/system/repositories/github/#{@gitrepo.id}")
    Dir.chdir("public/system/repositories/github/#{@gitrepo.id}")
    puts %x(
      git clone #{@gitcontent.clone_url}
    )
    redirect_to gitrepo_path(@gitrepo.id)
  end

  def show_github_repo
    Dir.chdir(Rails.root)
    @repository = Gitrepo.find(params[:id])
  end
end
