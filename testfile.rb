def fibonacci(n)
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
  string == string.reverse
end

def quicksort(arr)
  return arr if arr.length == 0
  left  = arr.select{|num| num < arr[0]}
  mid = arr.select{|num| num == arr[0]}
  right = arr.select{|num| num > arr[0]}
  return quicksort(left)+mid+quicksort(right)
end
