############## syntax ##############

# conditional ternary operator
state = "nice" if is_nice else "not nice"

# exception
try:
    file = open('test.txt', 'rb')
except (IOError, EOFError) as e:
    print("An error occurred. {}".format(e.args[-1])) 

############## Python Library ##############
# a list comprehension
cubes = [i**3 for i in range(5) if i %%2 == 2]

# dict comprehension
d = {v: k for k, v in some_dict.items()}

# tuples
tuple = (1,'pouet',3)
print(tuple[1::-1])

# string formatting
nums = [4, 5, 6]
msg = "Numbers: {0} {1} {2}".format(nums[0], nums[1], nums[2])
print(msg)

#string methods
print(", ".join(["spam", "eggs", "ham"]))
#prints "spam, eggs, ham"

print("Hello ME".replace("ME", "world"))
#prints "Hello world"

print("This is a sentence.".startswith("This"))
# prints "True"

print("This is a sentence.".endswith("sentence."))
# prints "True"

print("This is a sentence.".upper())
# prints "THIS IS A SENTENCE."

print("AN ALL CAPS SENTENCE".lower())
#prints "an all caps sentence"

print("spam, eggs, ham".split(", "))
#prints "['spam', 'eggs', 'ham']"

# map
nums = [11, 22, 33, 44, 55]
map = map(lambda x: x+5, nums)
print(type(map))
# class map
print(map)
# object map @...
result=list(map)
print(result)
# [16...]

# generator
def countdown():
    i=5
    while i > 0:
        yield i
        i -= 1
for i in countdown():
    print(i)

# decorator
def decor(func):
    def wrap():
        print("============")
        func()
        print("============")
    return wrap

@decor
def print_text():
    print("Hello world!")
   
print_text()


############## itertools ##############
## count
from itertools import count 

for i in count(3):
  print(i)
  if i >=11:
    break
# 3
# ..
# 11

## accumulate, takewhile
from itertools import accumulate, takewhile

nums = list(accumulate(range(8)))
print(nums)
# [0, 1, 3, 6, 10, 15, 21, 28]
print(list(takewhile(lambda x: x<= 6, nums)))
# [0, 1, 3, 6]

## product, permutations
from itertools import product, permutations

letters = ("A", "B")
print(list(product(letters, range(2))))
# [('A', 0), ('A', 1), ('B', 0), ('B', 1)]
print(list(permutations(letters)))
# [('A', 'B'), ('B', 'A')]

############## magic method's / dunders ##############
class Vector2D:
  def __init__(self, x, y):
    self.x = x
    self.y = y
  def __add__(self, other):
    return Vector2D(self.x + other.x, self.y + other.y)

first = Vector2D(5, 7)
second = Vector2D(3, 9)
result = first + second
print(result.x) # 8
print(result.y) # 16

# magic method example
class SpecialString:
  def __init__(self, cont):
    self.cont = cont

  def __truediv__(self, other):
    line = "=" * len(other.cont)
    return "\n".join([self.cont, line, other.cont])

spam = SpecialString("spam")
hello = SpecialString("Hello world!")
print(spam / hello)
# spam
# ============
# Hello world!

############## numpy ################
import numpy as np

# Create an array of rank 2
my_arr = np.array([[1,2,3,4], [5,6,7,8]])

print(my_arr)
# [[1 2 3 4]
# [5 6 7 8]]

print(my_arr[1, 2]) # access a single element
# 7

print(my_arr.ndim) # the rank
# 2

print(my_arr.shape) # n rows, m columns
# (2, 4)

print(my_arr.size) # number of elements
# 8

print(type(my_arr)) # element type
# <type 'numpy.ndarray'>

################# other 

### one liners
# Read File Python One-Liner
[line.strip() for line in open(filename)]

# Performance Profiling Python One-Liner
# python -m cProfile foo.py

# Web server on port 8000
# python -m http.server
# python -m http.server 9000 # (other port)

# open browser
python -m webbrowser -t "https://www.usesql.com"

############## regex ##############
### re
# re.search()
>>> re.search('\d', 'abc4def')
<_sre.SRE_Match object; span=(3, 4), match='4'>

>>> re.search('\D', '234Q678')
<_sre.SRE_Match object;

>>> re.search('\w', '#(.a$@&')
<_sre.SRE_Match object; span=(3, 4), match='a'>

>>> re.search('\W', 'a_1*3Qb')
<_sre.SRE_Match object; span=(3, 4), match='*'>

>>> re.search('\S', '  \n foo  \n  ')
<_sre.SRE_Match object; span=(4, 5), match='f'>

# word boundary
>>> re.search(r'\bbar', 'foo bar')
<_sre.SRE_Match object; span=(4, 7), match='bar'>

>>> re.search(r'\bbar', 'foo.bar')
<_sre.SRE_Match object; span=(4, 7), match='bar'>

# greedy vs non greedy (lazy)
>>> re.search('<.*>', '%<foo> <bar> <baz>%')
<_sre.SRE_Match object; span=(1, 18), match='<foo> <bar> <baz>'>

>>> re.search('<.*?>', '%<foo> <bar> <baz>%')
<_sre.SRE_Match object; span=(1, 6), match='<foo>'>

# groups
>>> m = re.search('(\w+),(\w+),(\w+)', 'foo,quux,baz')
>>> m
<_sre.SRE_Match object; span=(0, 12), match='foo:quux:baz'>
>>> m.groups()
('foo', 'quux', 'baz')

# back reference
>>> m.group(1)
'foo'
>>> m = re.search(regex, 'qux,qux')
>>> m
<_sre.SRE_Match object; span=(0, 7), match='qux,qux'>
>>> m.group(1)
'qux'
>>> m = re.search(regex, 'foo,qux')
>>> print(m)
None

# match()
>>> re.match(r'\d+', '123foobar')
<_sre.SRE_Match object; span=(0, 3), match='123'>
>>> print(re.match(r'\d+', 'foo123bar'))
None

# fullmatch()
>>> print(re.fullmatch(r'\d+', '123foo'))
None
>>> print(re.fullmatch(r'\d+', 'foo123'))
None

# find all()
>>> re.findall(r'\w+', '...foo,,,,bar:%$baz//|')
['foo', 'bar', 'baz']

>>> re.findall(r'(\w+),(\w+)', 'foo,bar,baz,qux,quux,corge')
[('foo', 'bar'), ('baz', 'qux'), ('quux', 'corge')]

# finditer()
for i in re.finditer(r'\w+', '...foo,,,,bar:%$baz//|'):
     print(i)
# <_sre.SRE_Match object; span=(3, 6), match='foo'>
# <_sre.SRE_Match object; span=(10, 13), match='bar'>
# <_sre.SRE_Match object; span=(16, 19), match='baz'>

# sub()
# simple
>>> s = 'foo.123.bar.789.baz'
>>> re.sub(r'\d+', '#', s)
'foo.#.bar.#.baz'
# with groups
>>> re.sub(r'(\w+),bar,baz,(\w+)',
...        r'\2,bar,baz,\1',
...        'foo,bar,baz,qux')
'qux,bar,baz,foo'

# split()
>>> re.split('\s*[,;/]\s*', 'foo,bar  ;  baz / qux')
['foo', 'bar', 'baz', 'qux']
# With groups: contains delimiters
>>> re.split('(\s*[,;/]\s*)', 'foo,bar  ;  baz / qux')
['foo', ',', 'bar', '  ;  ', 'baz', ' / ', 'qux']

### match object
#expand(): like sub for match
>>> m = re.search(r'(\w+),(\w+),(\w+)', 'foo,bar,baz')
>>> m
<_sre.SRE_Match object; span=(0, 11), match='foo,bar,baz'>
>>> m.groups()
('foo', 'bar', 'baz')
>>> m.expand(r'\2')
'bar'
>>> m.expand(r'[\3] -> [\1]')
'[baz] -> [foo]'

#m.lastindex()
>>> m = re.search(r'(\w+),(\w+),(\w+)?', 'foo,bar,')
>>> m.groups()
('foo', 'bar', None)
>>> m.lastindex, m[m.lastindex]
(2, 'bar')
