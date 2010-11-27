class String
  def convert(pattern, template)
    output = String.new(template)
    self.match(pattern).to_a.each_with_index{|group, index| output.gsub!("$#{index}", group.to_s)}
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
    self[-1].chr.downcase == 's' ? "#{self}'" : "#{self}'s"
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

	def self.rand(length = 8)
    alphabet = ('a' .. 'z').to_a + ('0' .. '9').to_a
    rand_string = ''
    length.times do
      rand_string << alphabet.rand
    end
    rand_string
  end
 
	def self.rand_hex(length = 12)
    alphabet = ('a' .. 'f').to_a + ('0' .. '9').to_a
    rand_string = ''
    length.times do
      rand_string << alphabet.rand
    end
    rand_string
  end
 
  def email?
    if self =~ /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
      return true
    else
      return false
    end
  end
 
  def phone?
    return false if self.nil?
    self.gsub(/[^0123456789]/, '').length > 9
  end
 
  def date?
    Date.parse(self)
    true
  rescue
    false
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


class Time
  def beginning_of_week_sunday
    beginning_of_week - wday.days
  end
end


class Date
  def beginning_of_week_sunday
    beginning_of_week - wday.days
  end
end


class NilClass
  def each
    nil
  end

  def to_s(format = nil)
    ""
  end

	def to_xs
		""
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


if defined?(ActiveRecord)
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
end
