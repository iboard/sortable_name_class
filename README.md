Ruby-class 'SortableName'
=========================

This example is inspired by a CleanCoder-video by Robert C. Martin (Uncle Bob)

  * Clean Coders, Episode 19, Part 1

and a talk by Sandi Metz at the RailsConf2013 in Portland.

  * The Magic Tricks of Testing

First let me say, I'm very thankful for all the stuff I learned from 
Uncle Bob's talks and video-courses. Thank you!

In episode 19 he did a _NameInverter_ Java-program, the TDD way.
At the end of the episode he asked the audience to figure out which 
mistakes are hidden in the program. 

When I checked the discussion-group about this, in order to find out
if I have a chance to get one of the green CleanCoder-bands, Uncle Bob 
promised to give away for the first 20 people who will mention one of
the mistakes...  Ok, it was obvious that I was late. But then I remembered 
Sandi's gorges talk about testing and I tried if Sandi's point of view
will collide with Uncle Bob's rules. If not (and I think it will not)
then Sandi's suggestion of 'not test private methods' will be more
efficient (at least for me) 

Let me know what you think about.
And once again, thank you all my teachers for feeding me with wisdom.

Here is my entry to the CleanCoders discussion group
----------------------------------------------------

### Episode 19, Part 1 - Mistakes

_Dear Uncle Bob,_

First I want to send you a big hug for all the stuff you've been
teaching me since I first met you at the RailsConf2010 in Baltimore.  

I guess all the mistakes are mentioned yet and I fear there is no green
band left for me anyway. So I took an hour off from my regular work to
draft my version of a SortableName class. I will wonder what you and
your audience thinks about this approach.

1) Of course I did follow the GRY-cycle in very small steps, just as you
told me. I guess this is the essence of Episode 19/1. 

But then, I left the way and I'm willing to take your admonishment if
I'm completely wrong. 

2)  I did it in Ruby (because my last Java-experience was long ago
and I had no time to refresh my memories this afternoon. This shall make
no difference because it's about the way rather than the tool. 

3.) start by setting up my environment in order to see green for
`expect(true).to be_true`

4.) I made the decision that I will definitely do it in a class. (I took
the time for a cigarette and my conclusion was, that this is not too
early. Not for the decision, neither for some nicotine and coffee)

4a) green for the initializer

4b) red for no parameter

4c) red/green for expecting an exception-error if the param is nil 
(I like to fail early and I thought it was time for a kinda joke ,)

5) here I began to leave your way by thinking, ok, the initializer 
will not do the work, neither can I expect it to do anything but 
remember the input string. 

5a) I wrote a test to make sure a (private) message, responsible to
format the output, gets called before I output any instance of my class
as a string.

6) I took your advise that it's ok to do more than one physical assert
in one test as long as it is all about the same logical assertion. So,
I named my test 'It should format all defined input-variations to match
the expected output'. 

I started with an empty array of Test-pairs and made sure the test
compiles. It was even green because the array was empty and the inner
assertion was never called.  The test reads as 

    for pair in pairs do
      expect(SortableName.new(pair.first).to eq(pair.last)
    end

7.) I filled in the first pair `['','']`
The test failed with a nice message telling me: `'' is not nil`. 
Of course, my format-function (tested just to be called in 5a) 
still returns nil. 

8) I remembered a gorgeous talk by Sandi Matz from this years RailsConf
in Portland, mentioning that one should not test private methods if they
are tested through the public interface. So I wrote no more tests for 
my class, since all the stuff I will do from now on will be done in the 
private block.  

I just return the `@name` instance-var of my class and the test passed.

9) I found nothing worth a re factor and my RGY-cycle for `['','']`
was done. 

10.) I added the pair `[' ','']` to my definitions. 

10a) test failed

10b) added a `.strip` to the output of my formatting method. -> passes

10c) moved the strip to the initializer thus the format method will have not
to care about it. 

11.) added `['Name','Name']` to my definition. Passes,  
The same way `[' Name ','Name']` does. 

Notice that I'm using SimpleCov to make sure all LOC are covered 
whenever I run the tests. 

12.) `['First Last','Last, First']` failed.

12.a) added the split and reverse until green. 

12b) cleaned up the mess

And so on....

 * a) add the pair to be tested to the definition array
 * b) see it fail with the output of what's wrong
 * c) make it green. 
 * d) clean up and make sure every LOC is covered (remove the lines which are not.)
 * Continue at a)

You can do so with any case of input one may come up with.
Without writing a new test. Just add the test-pair and get back to 
your work. I love writing tests tho. Writing clean production code is 
even more fun. 

At the end I implemented two more _Integration-test_ just to see
if it's possible to get the name formatted for sorting and unformatted
as passed when initializing an instance.

Finally I cleaned up everything I was not happy with.

_IMHO I do not violate any of your rules, master, by following this
strategy. But please, proof me wrong or even an idiot if I just didn't
see the truth._

Rspec-output
------------

    SortableName
      Without intput
        Computer says, no.
      With any data
        make sure parser runs on initialize
        make sure format_sortable is called before :to_s
      Pairs of possible input and expected outputs
                                  "" => ""                            
                              "Name" => "Name"                        
                        "First Last" => "Last, First"                 
                          "Mr. Last" => "Last"                        
                    "Mr. First Last" => "Last, First"                 
                   "Mrs. First Last" => "Last, First"                 
                    "Ms. First Last" => "Last, First"                 
                         "Last PhD." => "Last PhD."                   
                   "First Last PhD." => "Last, First PhD."            
           "Mr. First van Last PhD." => "Last, First van PhD."        
                          "  Name  " => "Name"                        
                 "  First    Last  " => "Last, First"                 
                "  Mr.   First Last" => "Last, First"                 
               "Mr. First Last jun." => "Last, First jun."            
                     "Mr. Last sen." => "Last sen."                   
          "Mr. Robert C. Martin Esq" => "Martin, Robert C. Esq"       
        passes all examples
      Integration
        outputs formatted
        outputs unformatted

    Finished in 0.0056 seconds
    6 examples, 0 failures
    Coverage report generated for RSpec to ./coverage. 26 / 26 LOC (100.0%) covered.
    
    
Links
=====

  * [Clean Code Episode 19 Part 1 - Advanced TDD](http://www.cleancoders.com/codecast/clean-code-episode-19-p1/show)
  * [Rails Conf 2013 The Magic Tricks of Testing by Sandi Metz](http://www.youtube.com/watch?v=URSWYvyc42M)
 
 
Special Thanks
--------------

  * [Christoph's SimpleCov gem](https://github.com/colszowka/simplecov)
 
License
=======

This is free software. Use it in any way you want, without any warranty.

(c) 2013 by Andreas Altendorfer, <andreas@altendorfer.at>

