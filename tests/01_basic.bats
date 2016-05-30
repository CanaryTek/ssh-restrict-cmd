#!/usr/bin/env bats

# Check command env variable
@test "Failure if command not passed in variable" {
  run ./ssh-restrict-cmd cmd_list.txt
  [ "$status" -eq 1 ]
}

# Check fails when command file not found
@test "Failure if command file not found" {
  SSH_ORIGINAL_COMMAND="echo test1" run ./ssh-restrict-cmd doesnotexist.txt
  [ "$status" -eq 1 ]
}

# Check command denied

# Check fails when command file not found
@test "Failure if command not allowed" {
  SSH_ORIGINAL_COMMAND="echo test1" run ./ssh-restrict-cmd cmd_list.txt
  [ "$status" -eq 1 ]
}
# Check sanitizing (;)

# Check command run when allowed
@test "Run exact command when allowed" {
  SSH_ORIGINAL_COMMAND="echo test" run ./ssh-restrict-cmd cmd_list.txt
  [ "$status" -eq 0 ]
}
@test "Run extended command when allowed" {
  SSH_ORIGINAL_COMMAND="echo just_testing_longer " run ./ssh-restrict-cmd cmd_list.txt
  [ "$status" -eq 0 ]
}
