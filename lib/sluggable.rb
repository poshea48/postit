module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug
    class_attribute :slug_column
  end

  # def self.included(base)
  #   base.send(:include, InstanceMethods)
  #   base.extend ClassMethods
  #   base.class_eval do
  #     my_class_method
  #   end
  # end

  def generate_slug
    the_slug = to_slug(self.send(self.class.slug_column.to_sym))
    obj = self.class.find_by(slug: the_slug)
    count = 2

    while obj && obj != self
      the_slug = append_suffix(the_slug, count)
      user = self.class.find_by(slug: the_slug)
      count += 1
    end
    self.slug = the_slug
  end

  def append_suffix(str, count)
    new_str = str
    if new_str.match(/\d+$/)
      new_str.gsub!(/\d+$/, count.to_s)
    else
      new_str += "-#{count}"
    end
    new_str
  end

  def to_slug(name)
    str = name.strip
    str.gsub!(/\s*[^a-zA-Z0-9]\s*/, '-')
    str.gsub!(/-+/, "-")
    str.downcase
  end

  def to_param
    self.slug
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end
