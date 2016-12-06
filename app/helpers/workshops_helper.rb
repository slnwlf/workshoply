module WorkshopsHelper
	def uri_encode(str)
		URI.escape(str, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
	end
end
