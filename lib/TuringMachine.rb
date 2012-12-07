class TuringMachine

  def initialize(q, gamma, b, sigma, delta, q0, f)
    @q = q
    @gamma = gamma
    @b = b
    @sigma = sigma
    @q0 = q0
    @f = f
    self.class.send(:define_method, :delta, delta)
  end

  def accepts?(tape)
    begin
      final_state = delta(tape)
      @f.include?(final_state)
    rescue InvalidTransitionError
      false
    end
  end

  def init_tape(input_tape)
    @current_input = 0
    @current_state = @q.index(@q0)

    while input_tape[@current_input] == @b
        @current_input += 1
    end
  end

  def finalize_tape(input_tape)
    input_tape[@current_input] = @b
    @current_input -= 1
    @current_state += 1
  end

end

class InvalidTransitionError < StandardError
end