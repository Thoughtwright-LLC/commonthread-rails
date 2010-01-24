require 'helper'

class TestMonkeyPatches < Test::Unit::TestCase
	context "String patches" do
		should "convert a string with a regex and template" do
			assert_equal "?1234567890=abcdefg".convert('^.(.........)', '$1'), "123456789"
			assert_equal "?1234567890=abcdefg".convert('^.(\d{9})', '$1'), "123456789"
			assert_equal "?1234567890=abcdefg".convert('\?(\d+)=', '$1'), "1234567890"
		end

		should "escape/unescape strings for use in URLs" do
			assert_equal "foo/bar,boo:car".escape, "foo%2Fbar%2Cboo%3Acar"
			assert_equal "foo%2Fbar%2Cboo%3Acar".unescape, "foo/bar,boo:car"
		end

		should "hash strings with sha1 and md5" do
			assert_equal "commonthread".to_sha, "dc8e89d0a8d2364c4c3d2231f63df6a792667de2"
			assert_equal "commonthread".to_md5, "9a5c2ec77af09d5673a475566d4ccf14"
		end

		should "make possesive strings" do
			assert_equal "chris".to_possesive, "chris'"
			assert_equal "jason".to_possesive, "jason's"
		end

		should "strip xml" do
			assert_equal "<tag>inner</tag>".xml_strip, "inner"
			assert_equal "<tag>inner</tag> <other>text</inner>".xml_strip, "inner text"
		end

		should "wrap text" do
			assert_equal "pipe me".wrap('|'), "|pipe me|"
			assert_equal "bracket me".wrap('<','>'), "<bracket me>"
		end

		should "make pretty url fragments" do
			assert_equal "commonthread rails".to_pretty_url, "commonthread_rails"
			assert_equal "commonthread  rails".to_pretty_url, "commonthread_rails"
			assert_equal "commonthread_rails".to_pretty_url, "commonthread_rails"
			assert_equal "commonthread-rails".to_pretty_url, "commonthread-rails"
			assert_equal "commonthread-rails v0.1.1".to_pretty_url, "commonthread-rails_v011"
		end
	end

	context "Array patches" do
		setup do
			@numbers = (1..99).to_a
			@scores = [50, 75, 100]
			@letters = ('A'..'Z').to_a
		end

		should "find random item" do
			assert @numbers.rand.is_a?(Integer)
			assert @letters.rand.is_a?(String)
		end

		should "find maximum value of block" do
			assert_equal @numbers.maximum{|n| n}, 99
			assert_equal @letters.maximum{|l| l}, 'Z'
		end

		should "find minimum value of block" do
			assert_equal @numbers.minimum{|n| n}, 1
			assert_equal @letters.minimum{|l| l}, 'A'
		end

		should "find average value of block" do
			assert_equal @scores.average{|s| s}, 75
		end
	end
end
