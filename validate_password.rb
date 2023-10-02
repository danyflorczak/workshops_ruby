class ValidatePassword
  def initialize(password)
    @password = password
  end

  def perform
    return validation_conditions.all?(&:call)
  end

  private

  # I was thinking a little longer how should I implement this and using procs here seemed for me like good fit
  # if at any point I would have to add new condition it is much more readable and scalable for me than just bunch of
  # return xyz unless statments maybe it was too fancy to use it here but I just went with it
  def validation_conditions
    [
      Proc.new { @password.length >= 6 && @password.length <= 24 },
      Proc.new { @password.match(/[A-Z]/) },
      Proc.new { @password.match(/[a-z]/) },
      Proc.new { @password.match(/\d/) },
      Proc.new { @password.match(/[!@#$%&*+=:;?<>.]/) },
      Proc.new { !@password.match(/(.)\1{2,}/) }
    ]
  end
end
