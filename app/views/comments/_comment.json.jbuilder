json.extract! comment, :text, :id
# json.user_name comment.user.name
# json.user_id comment.user.id

json.user do
    json.partial! 'users/user', user: comment.user, token: nil
end

json.likes_count comment.likes.size