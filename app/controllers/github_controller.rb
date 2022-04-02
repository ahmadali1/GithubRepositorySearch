class GithubController < ApplicationController
  def index; end

  def search
    @page = params[:page].to_i

    response = GithubService::Repository.search(
      search_params[:query],
      @page
    )

    if response.success?
      @repos = response.body
    else
      @error = response.error
    end
  end

  private

  def search_params
    params.permit(:query, :page)
  end
end
