json.extract! post, :id, :title, :description, :user_id
if with_childs
    json.tags do
        json.array! post.tags, partial: 'tags/tag', as: :tag
    end
end