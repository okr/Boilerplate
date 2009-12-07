class AddSitePrefs < ActiveRecord::Migration
  def self.up
      create_table :preferences do |t|
        t.string   :title
        t.string   :tagline
        t.string   :blog_title
        t.string   :analytics_key
        t.references :user
        
        t.timestamps
      end
  end

  def self.down
  end
end
