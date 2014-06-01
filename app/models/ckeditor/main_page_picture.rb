class Ckeditor::MainPagePicture < Ckeditor::Asset
  has_attached_file :data,
                    :url  => "/ckeditor_assets/main_page_pictures/:id/:style_:basename.jpg",
                    :path => ":rails_root/public/ckeditor_assets/main_page_pictures/:id/:style_:basename.jpg",
                    :styles => { :content => ['960x460>', :jpg], :thumb => ['80x38>', :jpg] }

  attr_accessible :width, :height

  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_presence :data

  def url_content
    url(:content)
  end
end
