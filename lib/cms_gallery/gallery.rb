module CmsGallery::Gallery
  
  include CmsTag
  
  def self.regex_tag_signature(label = nil)
    label ||= /[\w\/\-]+/
    /\{\{\s*cms:gallery:(#{label}):?(.*?)\s*\}\}/
  end
  
  def regex_tag_signature
    self.class.regex_tag_signature(label)
  end
  
  def content
    @gallery = Gallery.find_by_slug(label)
    ps = params.split(':').collect_with_index{|p, i| ":param_#{i+1} => '#{p}'"}.join(', ')
    if (@gallery)
      "<%= render :partial => 'content/gallery'#{ps.blank?? nil : ", :locals => {#{ps}}"} %>"
    else
      "Gallery not found."
    end    
  end
end