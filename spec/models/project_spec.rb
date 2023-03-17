# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      user = create(:user)
      project = create(:project, user: user)
      expect(project.user).to eq(user)
    end

    it 'has many comments' do
      project = create(:project)
      comment1 = create(:comment, project: project)
      comment2 = create(:comment, project: project)
      expect(project.comments).to include(comment1, comment2)
    end

    it 'has many status_changes' do
      project = create(:project)
      status_change1 = create(:status_change, project: project)
      status_change2 = create(:status_change, project: project)
      expect(project.status_changes).to include(status_change1, status_change2)
    end
  end

  describe 'validations' do
    let(:user) { create(:user) }
    let(:project) { build(:project, user: user) }

    it 'is valid with a title and a user' do
      expect(project).to be_valid
    end

    it 'is invalid without a title' do
      project.title = nil
      expect(project).not_to be_valid
    end

    it 'has the correct enum values for status' do
      expect(Project.statuses).to eq({ 'pending' => 0, 'active' => 1, 'done' => 2, 'inactive' => 3 })
    end
  end

  describe 'dependent destroy' do
    let(:user) { create(:user) }
    let!(:project) { create(:project, user: user) }
    let!(:comment) { create(:comment, project: project, user: user) }

    it 'deletes associated comments when project is deleted' do
      expect { project.destroy }.to change { Comment.count }.by(-1)
    end
  end
end
