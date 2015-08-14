require 'spec_helper'

describe DiscourseReports::HomepagesController, type: :controller do
  routes { DiscourseReports::Engine.routes }

  subject { JSON.parse(response.body)['id'] }

  describe 'show' do
    let!(:topic) { Fabricate(:topic) }

    before do
      topic.update(archetype: archetype)
      xhr :get, :show, format: :json
    end

    context 'when TOC topic is not exist' do
      let(:archetype) { 'regular' }
      it { is_expected.to be_nil }
    end

    context 'when TOC topic is exist' do
      let(:archetype) { 'toc' }
      it { is_expected.to eq(topic.id) }
    end
  end
end
