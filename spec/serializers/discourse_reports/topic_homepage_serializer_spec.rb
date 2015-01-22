require 'spec_helper'

describe DiscourseReports::TopicHomepageSerializer, type: :serializer do
  let(:topic) { Fabricate(:topic) }
  let(:serializer) { DiscourseReports::TopicHomepageSerializer.new(topic, scope: Guardian.new, root: false) }
  let(:json) { serializer.as_json }

  it 'have id, title attributes' do
    [:id, :title].each do |attr|
      expect(json[attr]).to be_present
    end
  end

  context 'when topic have not a post' do
    it 'have not post_stream attribute' do
      expect(json[:post_stream]).to_not be_present
    end
  end

  context 'when topic have a post' do
    let!(:post) { Fabricate(:post, topic: topic) }

    it 'have post_stream attribute' do
      expect(json[:post_stream]).to be_present
    end
  end
end
