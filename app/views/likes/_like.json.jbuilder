json.extract! like, :id, :likeable_type, :likeable_id, :user_id
json.user do
    json.partial! 'users/user', user: like.user, token: nil
end


if @user && like.user_id == @user.id
    json.liked true
else 
end