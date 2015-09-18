### Coding with style 

> Code unto others as you would have them code unto you.

Why style? ask Hadley Wickham, developer of many wonderful R packages:

> Good style is important because while your code only has one
author, it’ll usually have multiple readers. This is especially true when you’re
writing code with others. In that case, it’s a good idea to agree on a common
style up-front. Since no style is strictly better than another, working with
others may mean that you’ll need to sacrifice some preferred aspects of your style.

The Ocean Health Index is founded upon principles of open-source science, so our code should be not just available, but legible to others.  For OHI+, we expect people to modify code to implement new goal models, and we may need to provide support in developing and debugging their code.

Certain coding techniques are more efficient than others (e.g. in R, looping across elements in a vector is much slower than operating on the entire vector at once), but the speed and efficiency of our final code is not as important to us as it is to an iPhone app developer or a video game developer.  Much more of our time is spent writing code, translating old code into new models, and debugging.  Transparent, readable code will save more time in the future than a perfectly-optimized but opaque algorithm.  

The less time you spend poring over opaque code line-by-line and character-by-character, the more time you can spend actually analyzing data! Whee!

Readable code is:

* collaborative
* easier for others to understand and debug
* easier for others to update and modify (beg, borrow, steal)
* easier for 'future you' to interpret what 'past you' meant when you wrote that chunk of code.

Technical debt - you can do it quickly or you can do it right.  Time saved now may cost you or someone else more time later.  Don't expect to come back and prettify your code at a later date - get in the habit of doing it as you code!

#### Suggested best practices for coding in OHI assessments:
How many of these are second-nature?  How many of these can you implement with little to no effort?  Do you have strong preferences that go against these suggestions?  What alternative methods or styles do you prefer, and why?

**Write easy-to-read code**
Check out Hadley Wickham's [style guide](http://r-pkgs.had.co.nz/style.html) - most of these are taken directly from him.

* use a consistent format for variable names, filenames, function names, etc.
    * `lower_case_with_underscores` (preferred - Hadley style guide) 
        * not `camelCase` - capitalization is less consistent to predict
        * not `periods.in.between`
    * use names that are brief but intuitive
* use `<-` to assign values to variables (not necessary for functionality)
    * use `=` for passing arguments within a function call
* use `%>%` to create intuitive chains of related functions
    * one function per line
    * break long function calls into separate lines (e.g. multiple mutated variables)
    * reduces the need for intermittent objects
* use proper spacing and formatting for legibility
    * don't crowd the code - use spaces between math operators and after commas
    * use indents to indicate nested or sequential/chained code
    * break sequences or long function calls into separate lines logically - e.g. one function call per line

**Divide code into logical chunks with helpful names or labels**

* Comment clearly for your own purposes, and for others.
    * Comment on the purpose of each important block of code.
    * Comment on the reasoning behind any unusual lines of code, for example an odd function call that gets around a problem.
* Take advantage of R Studio section labels functionality:
    * If a comment line ends with four or more -, =, or # signs, R Studio recognizes it as a new section.
    * Text within the comment becomes the section name, accessible in the drop-down menu in the bottom left of the RStudio script window.
* use functions to add intuitive names to chunks of code

**Keep the data tidy**

* Use 'tidy data' practices - take advantage of `tidyr`, `dplyr`
    * the chain operator `%>%` eliminates the need to create intermittent objects
* clean up after yourself: remove temporary columns using `select(-colname)`
* functions can help here: variables used locally within a function don't clutter up the global environment
* Don't clutter up the environment by filling it with libraries you only call for a single simple function
    * e.g. `library(psych)` only for the geometric mean function? arrrrrggghhhh!
    * maddening conflicts when one package masks same-name functions within another package - e.g. `extract()`
      in both `raster` and `tidyr`; `rename()` in both `plyr` and `dplyr`
    * frustration when a long process fails mid-way because you haven't installed some arcane package

**Stick with it: it is an ongoing, iterative process**

* If you are working on an older script, spend a few extra minutes to update it according to these best practices
    * ditch the `plyr` calls! arrrrgghhh - translate it to `dplyr` and `tidyr`

#### Writing functions

http://nicercode.github.io/guides/functions/

Why write functions?

* name a chunk of code for easier reading
* easily reuse a chunk of code
* leverage the full power of sapply and lapply

What makes a good function?

* It’s short
* It performs a single operation well
* It uses intuitive names for the function, arguments, and variables
* It is flexible where possible

