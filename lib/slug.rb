
module Slug

    def slug
        self.name.gsub(/[^0-9A-Za-z ]/, '').downcase.split(' ').join('-')
    end

    def find_by_slug(slug)
        found = nil
        self.all.each do |i|
            if i.slug == slug
                found = i
            end
        end
        found
    end

end

