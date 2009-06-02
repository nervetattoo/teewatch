class Source < Sequel::Model
  set_schema do
    primary_key :id

    varchar :title, :unique => true, :empty => false # Threadless
    varchar :url, :empty => false, :unique => true #http://
    varchar :logo
    varchar :safe_title, :unique => true

    has_many :tees
  end

  create_table unless table_exists?

  if empty?
    create :title => 'Design By Humans', 
        :url => 'http://www.designbyhumans.com/',
        :logo => 'dbh_mini.png',
        :safe_title => 'designbyhumans'
    create :title => 'Threadless',
        :url => 'http://www.threadless.com/',
        :logo => 'threadless.gif',
        :safe_title => 'threadless'
  end
end
