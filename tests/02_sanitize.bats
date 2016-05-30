#!/usr/bin/env bats

@test "Sanitize ;" {
  SSH_ORIGINAL_COMMAND="echo just_test ; echo BANG" run ./ssh-restrict-cmd cmd_list.txt
  [ "$status" -eq 1 ]
}

@test "Sanitize &" {
  SSH_ORIGINAL_COMMAND="echo just_test && echo BANG" run ./ssh-restrict-cmd cmd_list.txt
  [ "$status" -eq 1 ]
}
@test "Sanitize |" {
  SSH_ORIGINAL_COMMAND="echo just_test || echo BANG" run ./ssh-restrict-cmd cmd_list.txt
  [ "$status" -eq 1 ]
}
