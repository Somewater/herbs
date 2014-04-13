if defined?(ActsAsFerret)
  ActsAsFerret.define_index(SearchController::INDEX_NAME,
      :models => {
          TextPage => {:fields => [:title_ru, :title_en, :body_ru, :body_en]},
          Product => {:fields => [:title_ru, :title_en, :description_ru, :description_en]}
  })
end