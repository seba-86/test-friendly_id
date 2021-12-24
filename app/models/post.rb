class Post < ApplicationRecord
    validates :title, presence: true

    extend FriendlyId
    # friendly_id :title, use: [:slugged, :finders]
   
    #slugged = Model.friendly.find(params[:id]) 
    #finders = Default Model.find(params[:id])
    # you can use two ways (slugged and finders)

    #for update old records run command Model.find_each(&:save)

    #when a same name. Friendly_id replace column name for hash in url ..
    #used: candidate in replace of title column odds
    friendly_id :slug_candidate, use: [:slugged, :finders, :history]

    #method slug_candidate with odds
    def slug_candidate
        [
            :title,
            [:title, :comment]
        ]
    end

    #if edit title with other name that not exist , friendly_id will keep the same title previous.
    #method changed?

    def should_generate_new_friendly_id?
        title_changed?
    end
    #there is a problem, if other person have old url result=(404) for example,for that problem, make redirect old endpoint 
    #to new endpoint, add friendly_id option = history. need additional database table (add in first step this option for old 
    # records no work after)



end
