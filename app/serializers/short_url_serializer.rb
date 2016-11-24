class ShortUrlSerializer < ActiveModel::Serializer
  attributes :id, :original, :converted, :count
end
