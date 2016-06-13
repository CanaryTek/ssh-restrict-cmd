#!/usr/bin/env bats

CMD="./ssh-restrict-cmd -l tests/ssh-restrict-cmd.log -f tests/cmd_list.txt"

# Check command env variable
@test "Failure if command not passed in variable" {
  run $CMD
  [ "$status" -eq 1 ]
}

# Check fails when command file not found
@test "Failure if command file not found" {
  SSH_ORIGINAL_COMMAND="echo test1" run $CMD
  [ "$status" -eq 1 ]
}

# Check fails when command file not found
@test "Failure if command not allowed" {
  SSH_ORIGINAL_COMMAND="echo test1" run $CMD
  [ "$status" -eq 1 ]
}

# Check command run when allowed
@test "Run exact command when allowed" {
  SSH_ORIGINAL_COMMAND="echo test" run $CMD
  [ "$status" -eq 0 ]
}
@test "Run extended command when allowed" {
  SSH_ORIGINAL_COMMAND="echo just_testing_longer " run $CMD
  [ "$status" -eq 0 ]
}
