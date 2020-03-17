# ElixirInAction

**Work from the book "Elixir In Action"**

## Project Description

This project serves as a repository for samples and exercises noted while 
reading [Elixir in Action](https://www.manning.com/books/elixir-in-action). 

Much of the code is recreated from examples in the book, written out for 
additional practice. Some chapters have groups of practice exercises, which 
are also here.

## Layout & Approach

The bulk of the code is in `lib` and is structured by chapter. Generally, 
examples from the book are directly under the chapter directory, and practice 
exercises are in a subdirectory `exercises`.

`@moduledoc` and `@doc` metadata is intentionally verbose - much more so than 
a typical project. This repo is intended for learning, with my intent being to 
revisit for reference/refreshers often. The oversharing is intentional so 
context can be easily reloaded. Since `@doc` should not be used on private 
functions, plain comments have been used to achieve the same result while 
avoiding compiler warnings.

I will likely revisit at some point to include typespecs and may endeavor to 
include them moving forward (chapter 3 complete as of this writing).

## Credit

Other than the exercise problems this is not my original work, and the intent 
of even the exercise problems is academic in nature with a focus on future 
study/reference. Examples have been used with little to no modification from 
what is provided in the book by Saša Jurić.
