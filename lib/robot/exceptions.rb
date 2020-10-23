module Robot
  # And exception occured when the state of the robot could not ne changed
  class StateException < StandardError; end
  class OutOfBoundsException < StateException; end
  class ObstacleException < StateException; end

  # And excetrion occured what the command processor is unable to unterpref the user input
  class CommandException < StandardError; end
end
