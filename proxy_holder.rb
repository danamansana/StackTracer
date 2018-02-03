class ProxyHolder
  def initialize
    @proxies = {}
  end

  def add(proxy)
    @proxies[proxy] = Proxy.new(proxy)
    define_method(proxy) {@proxies[proxy].ggggg}
    define_method("#{proxy}=") {|argument| @proxies[proxy].sssss(argument)}
  end
end

class Proxy
  def initialize(name)
    @name = name
    @inner = nil
  end

  def ggggg
    @inner
  end

  def sssss(value)
    @inner = value
    RECORDER.push("#{@name} set to #{@inner}")
    @inner.methods.each do |meth|
      add_method(meth)
    end
  end

  def add_method(meth)
    define_method(meth) do |*args|
      
    end
  end

end
