class Dir
  def self.home
    user = `whoami`.strip('\n')
    return "/Users/" + user
  end
end
