class AddSitePrefs < ActiveRecord::Migration
  def self.up
      create_table :site_preferences do |t|
        t.string   :blog_title
        t.string   :site_title
        t.string   :site_tagline
        t.string   :analytics_key
        
        t.timestamps
      end
  end

  def self.down
  end
end
