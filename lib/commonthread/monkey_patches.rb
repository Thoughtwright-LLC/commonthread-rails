class String
  def convert(pattern, template)
    output = String.new(template)
    self.match(pattern).to_a.each_with_index{|group, index| output.gsub!("$#{index}", group)}
    output
  end

  def escape
    CGI::escape(self)
  end

  def unescape
    CGI::unescape(self)
  end

  def to_sha
    Digest::SHA1.hexdigest(self)
  end

  def to_md5
    Digest::MD5.hexdigest(self)
  end

  def to_possesive
    self.last.downcase == 's' ? "#{self}'" : "#{self}'s"
  end

  def xml_strip
    self.gsub(/<.*?>/, '')
  end

  def wrap(before, after = nil)
    before + self + (after || before)
  end

  def to_pretty_url
    self.strip.downcase.gsub(/\s+/, '_').gsub(/[^\w_-]/, '')
  end

  def to_html
    BlueCloth.new(self).to_html rescue ''
  end
end


class Array
  def rand
    self[Object.send(:rand, size)]
  end

  def maximum(&block)
    self.collect{|n| yield(n)}.max
  end

  def minimum(&block)
    self.collect{|n| yield(n)}.min
  end

  def average(&block)
    sum = 0
    items = 0

    self.each do |n|
      current_value = yield(n)
      sum += current_value and items += 1 if current_value
    end

    if items > 0
      sum.to_f / items.to_f
    else
      nil
    end
  end
end


class NilClass
  def each
    nil
  end

  def to_s(format = nil)
    ''
  end
  
  def empty?
    true
  end
  
  def blank?
    true
  end
end


class Object
  def self.my_methods
    methods - (superclass ? superclass.methods : [])
  end

  def my_methods
    methods - (self.class.superclass ? self.class.superclass.new.methods : [])
  end
end


class ActiveRecord::Base
  def self.[](id)
    self.find(id)
  end

  def to_param
    if self.respond_to?(:name) and !self.name.blank?
      "#{self.id}-#{self.name.to_pretty_url}"
    else
      self.id.to_s
    end
  end

  def dom_id(prefix = nil) 
    prefix ||= 'new' if self.new_record? 
    [ prefix, self.class.name, self.id ].compact.join('_').downcase
  end
end
