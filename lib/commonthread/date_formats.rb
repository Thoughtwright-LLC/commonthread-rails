# ================
# = Date Formats =
# ================

common_formats = {
  :filename => '%m_%d_%Y', # 08_02_1982
  :standard => '%m/%d/%Y', # 12/14/2002
  :full => '%m/%d/%Y %H:%M:%S', # 08/02/1980 09:30:00
  :full_12 => '%m/%d/%Y %I:%M %p', # 08/02/1980 09:30 AM
  :full_24 => '%m/%d/%Y %H:%M:%S', # 08/02/1980 09:30:00
  :medium => '%b %d %Y', # Jan 11 2008
  :day => '%A', # Sunday
  :time_12 => '%I:%M %p', # 04:30 PM
  :time_24 => '%H:%M' # 16:30
}

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(common_formats)
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(common_formats)
