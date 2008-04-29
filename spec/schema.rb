ActiveRecord::Schema.define(:version => 1) do
  create_table :companies, :force => true do |t|
    t.column :name, :string
    t.column :city, :string
    t.column :street, :string
    t.column :zip, :string
  end
  
  create_table :people, :force => true do |t|
    t.column :name, :string
    t.column :city, :string
    t.column :street, :string
    t.column :zip, :string
  end
end