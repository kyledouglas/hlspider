# Internal: A set of methods for examining individual lines of m3u8 playlists.
module HLSpider
  module PlaylistLine
    # Internal: Checks if String str contains a .ts file extension
    #
    # str - String to be checked
    #
    # Examples
    #
    #   has_segment?("video_01.ts")
    #   #=> true
    #
    #   has_segment?("arandomstring")
    #   #=> false
    #
    # Returns Boolean.
    def has_segment?(str)
      !!/.*.ts(\z|\?)/.match(str)
    end

    # Internal: Checks if String str contains links to .m3u8 file extensions.
    #
    # str - String to be checked
    #
    # Examples
    #
    #   has_playlist?("playlist.m3u8")
    #   #=> true
    #
    #   has_playlist?("arandomstring")
    #   #=> false
    #
    # Returns Boolean.
    def has_playlist?(str)
      !!/.m3u8/.match(str)
    end  
  
    # Internal: Checks if String str contains 'EXT-X-TARGETDURATION'.
    #
    # str - String to be checked
    #
    # Examples
    #
    #   duration_line?("EXT-X-TARGETDURATION:10")
    #   #=> true
    #
    #   duration_line?("arandomstring")
    #   #=> false
    #
    # Returns Boolean.
    def duration_line?(str)
      !!/EXT-X-TARGETDURATION/.match(str)
    end 
  
    # Internal: Parses Integer target duration out of String str
    #
    # str - String to be parsed
    #
    # Examples
    #
    #   parse_duration("EXT-X-TARGETDURATION:10")
    #   #=> 10
    #
    #   parse_duration("arandomstring")
    #   #=> nil
    #
    # Returns Integer or nil.
    def parse_duration(str)
      /EXT-X-TARGETDURATION:(\d*)\z/.match(str)

      if dur = Regexp.last_match(1)
        dur.to_i
      else  
        nil
      end  
    end
    
    # Internal: Parses String video segment filename out of String str.
    #
    # str - String to be parsed
    #    
    # Examples
    #
    #   filename("/media/video_01.ts?query_string=22")
    #   #=> 'video_01.ts'
    #
    #   filename("arandomsring")
    #   #=> nil
    #
    # Returns String or nil.
    def filename(str)
     str.slice(/\w{1,}(.ts)/)
    end
  end
end