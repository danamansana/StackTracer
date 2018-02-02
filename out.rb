RECORDER = []

def fibonacci(n)

    args  = method(__method__).parameters.map{|arg| arg[1].to_s}
    vals = args.map{|arg| eval arg}
    RECORDER.push(["fibonacci", args, vals])
    x = DAZCPOTXfibonacci(*vals)
    RECORDER.push(x)
    return x
end

def DAZCPOTXfibonacci(n)
    f0 = 0
  f1 = 1
  i = 0
  while i < n
    f2 = f0 + f1
    f0 = f1
    f1 = f2
    i += 1
  end
  return f0
end

def palindrome?(string)

    args  = method(__method__).parameters.map{|arg| arg[1].to_s}
    vals = args.map{|arg| eval arg}
    RECORDER.push(["palindrome?", args, vals])
    x = HMFPWERJpalindrome?(*vals)
    RECORDER.push(x)
    return x
end

def HMFPWERJpalindrome?(string)
    string == string.reverse
end

def quicksort(arr)

    args  = method(__method__).parameters.map{|arg| arg[1].to_s}
    vals = args.map{|arg| eval arg}
    RECORDER.push(["quicksort", args, vals])
    x = AIPJRCLVquicksort(*vals)
    RECORDER.push(x)
    return x
end

def AIPJRCLVquicksort(arr)
    return arr if arr.length == 0
  left  = arr.select{|num| num < arr[0]}
  mid = arr.select{|num| num == arr[0]}
  right = arr.select{|num| num > arr[0]}
  return quicksort(left)+mid+quicksort(right)
end
