# frozen_string_literal: true

module GithubService
  class Repository < ApplicationService
    BASE_ENDPOINT = 'https://api.github.com'.freeze
    SEARCH_ENDPOINT = '/search/repositories'.freeze

    def self.search(query, page = 1)
      return [] if query.blank?

      response = RestClient.get(search_url, { # TODO: Use Octokit gem: Octokit::Client.new.search_repositories(query, options)
        params: {
          q: "#{query} in:name",
          sort: 'stars',
          order: 'desc',
          page: page
        }
      })

      OpenStruct.new(success?: true, body: JSON.parse(response.body))
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.error e.response.to_s
      OpenStruct.new(success?: false, error: e.response.to_s)
    end

    def self.search_url
      [BASE_ENDPOINT, SEARCH_ENDPOINT].join
    end
  end
end
