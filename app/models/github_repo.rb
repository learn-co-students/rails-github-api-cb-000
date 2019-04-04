class GithubRepo

  attr_reader :name, :url

  def initialize(package)
    @name = package["name"]
    @url = package["html_url"]
  end

end
