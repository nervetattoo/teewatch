class Tee < Sequel::Model
  set_schema do
    primary_key :id

    varchar :title, :empty => false
    varchar :url, :unique => true,:empty => false
    varchar :img, :unique => true
    varchar :artist
    belongs_to :source
  end

  create_table unless table_exists?

  if empty?
    create :title => 'Rescue', 
        :url => 'http://www.designbyhumans.com/shop/detail/3941'
    create :title => 'Bull\'s Eye',
        :url => 'http://www.designbyhumans.com/shop/detail/4475'
  end
end
