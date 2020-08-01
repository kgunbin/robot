module Robot
  # And exception occured when the state of the robob could not ne changed
  class StateException < StandardError; end

  # And excetrion occured what the command processor is unable to unterpref the user input
  class CommandException < StandardError; end
end
