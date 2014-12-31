module Heroku::Git
  def self.check_git_version
    if git_is_insecure
      warn_about_insecure_git
    end
  end

  def self.git_is_insecure
    v = Version.parse(git_version)
    if    v < Version.parse('1.9') && v < Version.parse('1.8.5.6')
      return true
    elsif v < Version.parse('2.0') && v < Version.parse('1.9.5')
      return true
    elsif v < Version.parse('2.1') && v < Version.parse('2.0.5')
      return true
    elsif v < Version.parse('2.2') && v < Version.parse('2.2.1')
      return true
    end
    return false
  end

  def self.warn_about_insecure_git
    warn "Your version of git is #{git_version}. Which has serious security vulnerabilities."
    warn "More information here: https://blog.heroku.com/archives/2014/12/23/update_your_git_clients_on_windows_and_os_x"
  end

  private

  def self.git_version
    /git version ([\d\.]+)/.match(`git --version`)[1]
  end


  class Version
    include Comparable

    attr_accessor :major, :minor, :patch, :special

    def initialize(major, minor=0, patch=0, special=0)
      @major, @minor, @patch, @special = major, minor, patch, special
    end

    def self.parse(s)
      digits = s.split('.').map { |i| i.to_i }
      Version.new(*digits)
    end

    def <=>(other)
      return major <=> other.major unless (major <=> other.major) == 0
      return minor <=> other.minor unless (minor <=> other.minor) == 0
      return patch <=> other.patch unless (patch <=> other.patch) == 0
      return special <=> other.special
    end
  end
end
