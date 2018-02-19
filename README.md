# StackTracer
StackTracer is a project currently under development to create a tool for generating usefully structured, visually appealing
records of program activity. StackTracer is based on the idea that there should be no mystery about what a program is doing during debugging,
and that all information about a program's activity should be available in a useful format for efficient debugging.

To this end StackTracer generates a tree visualisization recording all method calls, method arguments, method return values, and
variable assignments, correctly nested by scope, when a program is run. Users can focus in on the section of a program call which
is of interest to them, and efficiently zero in on places where a program is not running as expected.

StackTrace thus improves on several commonly used debugging tools. For example, a traditional terminal stack trace records only which
methods are called from which leading up to an error, but not which iteration of those methods generated the error, or what arguments
the methods were called with. Standard debuggers like byebug do allow users to view variable assignments and method calls, but have several
major drawbacks. The most important of these is that they do not record the nesting of method calls, so that a programmer who wants to focus
on something occurring in a nested method call has to step through a large amount of irrelevant information to get to the step
that is causing a problem. Furthermore they have to be re-run if the programmer decides to switch to focusing on a different step
of the program run, and lastly they do not generate a visual record of program calls.
## Demo
To see examples of the kinds of files StackTrace generates, open up the index.html file
To demo StackTracer for yourself, go through the following steps:
* Clone the StackTracer repository
* Navigate to StackTracer in your terminal
* Enter pry and load 'file_manager.rb'
* enter "filecreator('testfile.rb')" (you can replace testfile with another file if you wish)
* load "out.rb"
* Try calling some of the methods in the testfile. Currently there are "math_eval", "quicksort", "fibonacci", and "palindrome?"
* enter html_creator(generate_html(RECORDER)) into pry
* load the index.html file into your browser
I am currently in the process of developing a much friendlier user interface for StackTracer.
