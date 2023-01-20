json.extract! comment, :text, :id, :created_at, :post_id, :user_id
# json.user_name comment.user.name
# json.user_id comment.user.id

json.user do
    json.partial! 'users/user', user: comment.user, token: nil
end

json.likes_count comment.likes.size

if @user && comment.likes.find{| userliked | userliked.user_id == @user.id }
    
    json.liked true
else 
    json.liked false
end