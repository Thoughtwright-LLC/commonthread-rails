require 'helper'

class TestMonkeyPatches < Test::Unit::TestCase
	context "String patches" do
		should "convert a string with a regex and template" do
			assert_equal "?1234567890=abcdefg".convert('^.(.........)', '$1'), "123456789"
			assert_equal "?1234567890=abcdefg".convert('^.(\d{9})', '$1'), "123456789"
			assert_equal "?1234567890=abcdefg".convert('\?(\d+)=', '$1'), "1234567890"
		end

		should "escape strings for use in URLs" do
			assert_equal "foo/bar,boo:car".escape, "foo%2Fbar%2Cboo%3Acar"
		end

		should "unescape strings for use in URLs" do
			assert_equal "foo%2Fbar%2Cboo%3Acar".unescape, "foo/bar,boo:car"
		end
	end
end
