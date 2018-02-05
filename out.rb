require_relative "./proxy_holder.rb"
    RECORDER = []

def fibonacci(n)
    record = {}
    method(__method__).parameters.each{|arg| record[arg.last.to_s] = (eval arg.last.to_s)}
    RECORDER.push(["fibonacci", record, "called"])
    x = MVWODJIXfibonacci(*(record.values))
    RECORDER.push(["fibonacci", x, "returned"])
    return x
end

def MVWODJIXfibonacci(n)
  proxies = Hash.new { |h,k| h[k] = ProxyHolder.new(["f0", "f1", "i", "f2", "left", "mid", "right"])}
  
  proxies[1].f0 = 0
  proxies[1].f1 = 1
  proxies[1].i = 0
  while proxies[1].i < n
    proxies[1].f2 = proxies[1].f0 + proxies[1].f1
    proxies[1].f0 = proxies[1].f1
    proxies[1].f1 = proxies[1].f2
    proxies[1].i += 1
  end
  return proxies[1].f0
end

def palindrome?(string)
    record = {}
    method(__method__).parameters.each{|arg| record[arg.last.to_s] = (eval arg.last.to_s)}
    RECORDER.push(["palindrome?", record, "called"])
    x = WGAHOXVCpalindrome?(*(record.values))
    RECORDER.push(["palindrome?", x, "returned"])
    return x
end

def WGAHOXVCpalindrome?(string)
  proxies = Hash.new { |h,k| h[k] = ProxyHolder.new(["f0", "f1", "i", "f2", "left", "mid", "right"])}
  
  string == string.reverse
end

def quicksort(arr)
    record = {}
    method(__method__).parameters.each{|arg| record[arg.last.to_s] = (eval arg.last.to_s)}
    RECORDER.push(["quicksort", record, "called"])
    x = TZNCBSPRquicksort(*(record.values))
    RECORDER.push(["quicksort", x, "returned"])
    return x
end

def TZNCBSPRquicksort(arr)
  proxies = Hash.new { |h,k| h[k] = ProxyHolder.new(["f0", "f1", "i", "f2", "left", "mid", "right"])}
  
  return arr if arr.length == 0
  proxies[3].left  = arr.select{|num| num < arr[0]}
  proxies[3].mid = arr.select{|num| num == arr[0]}
  proxies[3].right = arr.select{|num| num > arr[0]}
  return quicksort(proxies[3].left)+proxies[3].mid+quicksort(proxies[3].right)
end
