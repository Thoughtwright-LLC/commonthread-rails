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

		should "make random strings" do
			assert String.rand =~ /^[a-z0-9]{8}$/
			assert String.rand(5) =~ /^[a-z0-9]{5}$/
		end

		should "check if string is an email" do
			assert "ben@commonthread.com".email?
			assert "ben.o'neil@commonthread.com".email?
			assert ! "ben.commonthread.com".email?
		end

		should "check if string is a phone number" do
			assert "800.555.1212".phone?
			assert "800-555-1212".phone?
			assert "(800) 555-1212".phone?
			assert ! "800.555.121".phone?
		end

		should "check if string is a date" do
			assert "08/02/1980".date?
			assert "08-02-1980".date?
			assert "Aug 2, 1980".date?
			assert ! "08021980".date?
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

			random_number = @numbers.rand
			assert @numbers.find{|n| n == random_number}

			random_letter = @letters.rand
			assert @letters.find{|l| l == random_letter}
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

	context "NilClass patches" do
		should "not fail on each" do
			assert_equal nil.each, nil
		end

		should "not fail on to_s" do
			assert_equal nil.to_s, ""
			assert_equal nil.to_s(:standard), ""
		end

		should "not fail on to_xs" do
			assert_equal nil.to_xs, ""
		end

		should "not fail on empty?" do
			assert nil.empty?
		end

		should "not fail on blank?" do
			assert nil.blank?
		end
	end

	context "Object Patches" do
		setup do
			class Foo
				def self.class_bar
					"bar"
				end

				def instance_bar
					"bar"
				end
			end

			@foo = Foo.new
		end

		should "have my_method properties" do
			assert_equal Foo.class_bar, "bar"
			assert_equal @foo.instance_bar, "bar"

			assert_equal Foo.my_methods, ["class_bar"]
			assert_not_equal Foo.methods, ["class_bar"]
			assert_equal @foo.my_methods, ["instance_bar"]
			assert_not_equal @foo.methods, ["instance_bar"]
		end
	end
end
