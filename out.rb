RECORDER = []

def fibonacci(n)

    record = {}
    method(__method__).parameters.each{|arg| record[arg[1].to_s] = (eval arg[1].to_s)}
    RECORDER.push(["fibonacci", record, "called"])
    x = OWLJPRQHfibonacci(*(record.values))
    RECORDER.push(["fibonacci", x, "returned"])
    return x
end

def OWLJPRQHfibonacci(n)
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

    record = {}
    method(__method__).parameters.each{|arg| record[arg[1].to_s] = (eval arg[1].to_s)}
    RECORDER.push(["palindrome?", record, "called"])
    x = BAYSXNWDpalindrome?(*(record.values))
    RECORDER.push(["palindrome?", x, "returned"])
    return x
end

def BAYSXNWDpalindrome?(string)
    string == string.reverse
end

def quicksort(arr)

    record = {}
    method(__method__).parameters.each{|arg| record[arg[1].to_s] = (eval arg[1].to_s)}
    RECORDER.push(["quicksort", record, "called"])
    x = HUWLFAMVquicksort(*(record.values))
    RECORDER.push(["quicksort", x, "returned"])
    return x
end

def HUWLFAMVquicksort(arr)
    return arr if arr.length == 0
  left  = arr.select{|num| num < arr[0]}
  mid = arr.select{|num| num == arr[0]}
  right = arr.select{|num| num > arr[0]}
  return quicksort(left)+mid+quicksort(right)
end
