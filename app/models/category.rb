require 'fileutils'
class Category < ActiveRecord::Base
  #attr_accessible :title, :menu_label, :position
  #attr_accessible :parent_id, :is_koopje, :alle_koopjes, :alle_veilingen

  acts_as_tree :parent_column_name => :parent_id, :order => :position
 
  has_many :products
  #still broken for now...
 # translates :title, :menu_label

  def self.flush_cashed_pages
    remove_language("en")
    remove_language("es")
    remove_language("nl")
    remove_language("fr")
    remove_language("de")
    FileUtils.rm_rf page_path+"veilings"
    FileUtils.rm_f page_path+"index.html"
  end

  def self.list_cashed_pages
    list=[]
    list<<show_dir("en")
    list<<show_dir("es")
    list<<show_dir("nl")
    list<<show_dir("fr")
    list<<show_dir("de")
    list<<show_dir("veilings")
    list<<"index.html, en.html, es.html, nl.html, fr.html and de.html removed"
    list
  end

  private
    def self.remove_language(lang)
      FileUtils.rm_rf page_path+"#{lang}"
      FileUtils.rm_f  page_path+"#{lang}.html"
    end

    def self.page_path
      Rails.root.to_s+"/public/"
    end

    def self.show_dir(lang)
      page_path+"#{lang} => "+`tree #{Rails.root}/public/#{lang} | grep html | wc -l`+ " html files removed"
    end

end


