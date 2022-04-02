require 'rails_helper'

RSpec.describe GithubController, type: :request do
  describe '#index' do
    before do
      get '/'
    end

    it 'responds with ok status' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#search' do
    context 'with successful Github response' do
      before do
        allow(GithubService::Repository).to(
          receive(:search).and_return(OpenStruct.new(success?: true, body: ''))
        )
        get '/search', xhr: true
      end

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'calls Github Service' do
        expect(GithubService::Repository).to have_received(:search)
      end
    end

    # TODO: Refactor it and use shared context example
    context 'with erroroneous Github response' do
      before do
        allow(GithubService::Repository).to(
          receive(:search).and_return(OpenStruct.new(success?: false, error: 'some error!'))
        )
        get '/search', xhr: true
      end

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'calls Github Service' do
        expect(GithubService::Repository).to have_received(:search)
      end
    end
  end
end