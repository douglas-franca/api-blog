json.extract! post, :id, :title, :description
# json.user_name post.user.name
# json.user_id post.user.id
json.user do
    json.partial! 'users/user', user: post.user, token: nil
end

if with_childs
    json.likes do
        json.array! post.likes.includes(:user), partial: 'likes/like', as: :like
    end
    json.comments do
        json.array! post.comments.includes(:user), partial: 'comments/comment', as: :comment
    end
    json.tags do
        json.array! post.tags, partial: 'tags/tag', as: :tag
    end
end

if likes_index
    json.likes_count post.likes.size
    json.comment_count post.comments.size
    json.tags_count post.tags.size
end