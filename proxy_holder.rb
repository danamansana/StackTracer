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
    RECORDER.push(["#{@name} set to #{@inner}", nil, "set"])
    @inner.methods.each do |meth|
      add_method(meth.last)
    end
  end


  def add_method(meth)
    define_method(meth) do |*args|
      record = {nil => @name}
      @inner.method(meth).parameters.each_with_index {|parameter, idx| record[parameter] = args[idx] }
      RECORDER.push([@name, record, "method_called"])
      x = @inner.send(meth, *args)
      RECORDER.push([@name, x, "returned"])
      return
    end
  end

end
