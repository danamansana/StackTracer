require 'byebug'

class ProxyHolder
  def initialize(variables = [])
    @proxies = {}
    variables.each do |var|
      add(var)
    end
  end

  def add(proxy)
    @proxies[proxy] = Proxy.new(proxy)
    getter = Proc.new {@proxies[proxy].ggggg}
    self.class.send(:define_method, proxy, &getter)
    setter = Proc.new {|argument| @proxies[proxy].sssss(argument)}
    self.class.send(:define_method,"#{proxy}=", &setter)
  end
end

class Proxy
  def initialize(name)
    @name = name
    @inner = nil
  end

  def method_missing(method_name, *args)
    record = {}
    ggggg.method(method_name).parameters.each_with_index{|par, idx| record[par.last.to_s] = args[idx]}
    RECORDER.push([name, record, "method_called"])
    x = ggggg.send(method_name, *args)
    RECORDER.push([name, x, "returned"])
    return x
  end

  def name
    @name
  end

  def ggggg
    @inner
  end

  def sssss(value)
    @inner = value
    RECORDER.push(["#{name} set to #{ggggg}", nil, "set"])
  end


  # def sssss(value)
  #   @inner = value
  #   RECORDER.push(["#{@name} set to #{@inner}", nil, "set"])
  #   @inner.methods.each do |meth|
  #     add_method(meth) unless meth == :debugger
  #   end
  # end
  #
  # def add_method(meth)
  #   meth_proc = Proc.new do |*args|
  #     record = {nil => name}
  #     ggggg.method(meth).parameters.each_with_index {|parameter, idx| record[parameter.last.to_s] = args[idx] }
  #     RECORDER.push([name, record, "method_called"])
  #     x = ggggg.send(meth, *args)
  #     RECORDER.push([name, x, "returned"])
  #     return
  #   end
  #   debugger
  #   self.class.send(:define_method, meth, &meth_proc)
  # end

end
