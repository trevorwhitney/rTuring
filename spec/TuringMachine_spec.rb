require 'spec_helper'
require 'TuringMachine'

describe 'TuringMachine' do
  # input [q, gamma, b, sigma, q0, f]
  # then define delta on machine

  it "can represent a machine that accepts L=L(aa*)" do
    q = ["q0", "q1"]
    gamma = ["a", :blank]
    b = :blank
    sigma = ["a"]
    q0 = "q0"
    f = ["q1"]

    delta = ->(input_tape) do
      init_tape(input_tape)

      while input_tape[@current_input] != @b
        if @q[@current_state] == "q0"
          if input_tape[@current_input] == "a"
            input_tape[@current_input] = "a"
            @current_input += 1
          else raise InvalidTransitionError.new
          end
        end
      end

      finalize_tape(input_tape)

      return @q[@current_state]
    end

    turing_machine = TuringMachine.new(q, gamma, b, sigma, delta, 
      q0, f)

    valid_input = [:blank, "a", "a", "a", :blank]
    invalid_input = [:blank, "a", "b", "a", :blank]

    turing_machine.accepts?(valid_input).should be_true
    turing_machine.accepts?(invalid_input).should be_false
  end

  it "can represent a machine that accepts the langauge L=L(aba*b)" do
    q = %w(q0 q1 q2 q3 q4)
    gamma = ["a", "b", :blank]
    b = :blank
    sigma = %w(a b)
    q0 = "q0"
    f = ["q4"]

    delta = ->(input_tape) do   
      init_tape(input_tape)

      while input_tape[@current_input] != @b
        if @q[@current_state] == "q0"
          if input_tape[@current_input] == "a"
            input_tape[@current_input] = "a"
            @current_input += 1
            @current_state += 1
          else raise InvalidTransitionError.new
          end
        elsif @q[@current_state] == "q1"
          if input_tape[@current_input] == "b"
            input_tape[@current_input] = "b"
            @current_input += 1
            @current_state += 1
          else raise InvalidTransitionError.new
          end
        elsif @q[@current_state] == "q2"
          if input_tape[@current_input] == "a"
            input_tape[@current_input] = "a"
            @current_input += 1
          elsif input_tape[@current_input] == "b"
            input_tape[@current_input] = "b"
            @current_input += 1
            @current_state += 1
          else raise InvalidTransitionError.new
          end
        # q3 should have a blank as input, or it's invalid
        # the blank will break the while loop, thus not
        # requiring a conditional here
        else raise InvalidTransitionError.new
        end
      end

      finalize_tape(input_tape)
      return @q[@current_state]
    end

    turing_machine = TuringMachine.new(q, gamma, b, sigma, delta,
      q0, f)

    valid_input = [:blank, "a", "b", "a", "a", "b", :blank]
    valid_input2 = [:blank, "a", "b", "b", :blank]
    invalid_input = [:blank, "a", "a", "a", :blank]

    turing_machine.accepts?(valid_input).should be_true
    turing_machine.accepts?(valid_input2).should be_true
    turing_machine.accepts?(invalid_input).should be_false
  end


  it "can represent a machine that accepts the language " +
      "L= {w : |w| is even" do
    q = %w(q0 q1 q2)
    gamma = ["w", :blank]
    b = :blank
    sigma = %w(w)

    delta = ->(input_tape) do
      init_tape(input_tape)

      while input_tape[@current_input] != :blank
        if q[@current_state] == "q0"
          if input_tape[@current_input] == "w"
            input_tape[@current_input] = "w"
            @current_input += 1
            @current_state += 2
          else raise InvalidTransitionError.new
          end
        elsif q[@current_state] == "q2"
          if input_tape[@current_input] == "w"
            input_tape[@current_input] = "w"
            @current_input += 1
            @current_state -= 2
          else raise InvalidTransitionError.new
          end
        else raise InvalidTransitionError.new
        end
      end

      finalize_tape(input_tape)
      return q[@current_state]
    end

    q0 = "q0"
    f = %w(q1)

    valid_input1 = [:blank, "w", "w", :blank]
    valid_input2 = [:blank, "w", "w", "w", "w", :blank]
    invalid_input1 = [:blank, "w", :blank]
    invalid_input2 = [:blank, "w", "w", "w", :blank]

    turing_machine = TuringMachine.new(q, gamma, b, sigma, delta, q0, f)
    turing_machine.accepts?(valid_input1).should be_true
    turing_machine.accepts?(valid_input2).should be_true
    turing_machine.accepts?(invalid_input1).should be_false
    turing_machine.accepts?(invalid_input2).should be_false
  end

  it "can represent a machine that accepts the language " +
      "L = {w : |w| is a multiple of 3}" do
      

    pending "not done yet"
  end
end