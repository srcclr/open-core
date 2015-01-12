require 'spec_helper'

describe DiscourseReports::Topics::ArchetypesController, type: :controller do
  routes { DiscourseReports::Engine.routes }

  let(:topic) { create_topic(title: 'Poll: Chitoge vs Onodera') }
  let(:current_user) { Fabricate(:moderator) }

  before { log_in_user(current_user) }

  subject { topic.reload.archetype }

  describe 'update' do
    before do
      xhr :put, :update, topic_id: topic.id, id: archetype
    end

    context 'when archetype is book' do
      let(:archetype) { 'book' }

      it { is_expected.to eq('book') }
    end

    context 'when archetype is not exists' do
      let(:archetype) { 'any new' }

      it { is_expected.to eq('regular') }
    end
  end

  describe 'destroy' do
    let(:topic) { create_topic(title: 'Poll: Chitoge vs Onodera', archetype: :book) }

    before do
      xhr :delete, :destroy, topic_id: topic.id
    end

    it { is_expected.to eq('regular') }
  end
end
