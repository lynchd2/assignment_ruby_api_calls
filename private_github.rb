require 'github_api'
require 'pp'
require 'pry'

class GithubAPI

  GITHUB_API_KEY = ENV["GITHUB_API_KEY"]

  def initialize
    @github = Github.new(oauth_token: GITHUB_API_KEY)
  end


  def user_repos(name)
    @github.repos.list user: name
  end

  def commits(name, repo)
    array = []
    response = @github.repos.commits.list name, repo, sha: ''
    response.each_page do |page|
      page.each do |repo|
         array << "#{repo.commit.author.date} : #{repo.commit.message} : #{repo.commit.author.name}"
      end
    end
    array.sort.reverse[0..9]
  end
end



g = GithubAPI.new
g.user_repos("lynchd2")
p g.commits("lynchd2", "vikingcodeschool_github_api_optional")