class GithubController < ApplicationController

  def index; end

  def search
    query = params[:query]
    @page = params[:page].to_i

    if query
      # Octokit gem: Octokit::Client.new.search_repositories(query, options)
      response = RestClient.get('https://api.github.com/search/repositories', {
        params: {
          q: "#{query} in:name",
          sort: 'stars',
          order: 'desc',
          page: @page
        }
      })

      @repos = JSON.parse(response.body)
    else
      @repos = []
    end

  rescue RestClient::ExceptionWithResponse => er
    Rails.logger.error er.to_s
    head :bad_request
  rescue => er
    Rails.logger.error er.to_s
    head :internal_server_error
  end
end
