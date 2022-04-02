require 'rails_helper'

RSpec.describe GithubService::Repository do
  describe '#search' do
    it 'responds to search' do
      expect(described_class).to respond_to(:search)
    end

    context 'with valid repository call' do
      around do |example|
        VCR.use_cassette('hello_repository') do
          example.run
        end
      end

      let(:response) { described_class.search('hello') }

      it 'returns response' do
        expect(response.success?).to be_truthy
      end
    end

    context 'when repository is not found' do
      before do
        stub_request(:get, 'https://api.github.com/search/repositories?order=desc&page=1&q=hello%20in:name&sort=stars').
          to_return(status: 200,
                    body: '{"total_count":0,"incomplete_results":false,"items":[]}')
      end

      let(:response) { described_class.search('hello') }

      it 'returns response' do
        expect(response.success?).to be_truthy
      end
    end

    context 'with error' do
      before do
        stub_request(:get, 'https://api.github.com/search/repositories?order=desc&page=1&q=hello%20in:name&sort=stars').
          to_return(status: 500,
                    body: 'Some error!')
      end

      let(:response) { described_class.search('hello') }

      it 'handles httpClient crash' do
        expect(response.success?).to be_falsy
        expect(response.error).to eq('Some error!')
      end
    end
  end
end
