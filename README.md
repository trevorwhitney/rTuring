# rTuring

This is a simple implementation of a Turing Machine in Ruby.
It takes 7 arguments to it's constructor, which resembles the
formal definition of a Turing Machine.

    TuringMachine.new(q, gamma, b, sigma, delta, q0, f)

Where `q` is the set of non-empty state, `gamma` is the set of alphabet characters, `b` is the blank symbol/character, `sigma` is the set of input characters, `delta` is the transition funtion (this should be a proc or lambda), `q0` is the initial state, and `f` is the set of final/accepting states.

See the tests for examples.

