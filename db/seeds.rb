# frozen_string_literal: true

# Create users
user1 = User.create!(name: 'John Doe', email: 'john3@example.com', password: 'password', password_confirmation: 'password')
user2 = User.create!(name: 'Jane Smith', email: 'jane4@example.com', password: 'password', password_confirmation: 'password')

# Create projects
project1 = Project.create!(title: 'Project 1', title: 'Project 1 Title', user: user1, status: :pending)
project2 = Project.create!(title: 'Project 2', title: 'Project 2 Title', user: user2, status: :active)

# Create comments
comment1 = Comment.create!(content: 'Comment 1 for Project 1', project: project1, user: user1)
Comment.create!(content: 'Comment 2 for Project 1', project: project1, user: user2)
comment3 = Comment.create!(content: 'Comment 1 for Project 2', project: project2, user: user1)

# Create replies
Comment.create!(content: 'Reply to Comment 1 for Project 1', project: project1, user: user2, parent_comment_id: comment1.id)
Comment.create!(content: 'Reply to Comment 1 for Project 2', project: project2, user: user2, parent_comment_id: comment3.id)

# Create status changes
StatusChange.create!(user: user1, project: project1, status: 'pending')
StatusChange.create!(user: user1, project: project1, status: 'active')
StatusChange.create!(user: user2, project: project2, status: 'active')
