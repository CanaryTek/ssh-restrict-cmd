
Description
===========

Sometimes you need to allow execution of programs between different hosts.
SSH's public key authentication allows you to do it. But if it must be done
unattended in a cron job, you need to setup a cleartext private key un the
source server. It is a big security problem, because if an attacker compromises
the source server, he will have full control on any hosts that can be accessed
with the private key.

OpenSSH has a feature that allows you to specify a given command to run when a
connection is made with a given key, discarding any command specified in the
client. This awesome feature is not widely used, because you need a different

ssh-restrict-cmd is a very simple shell wrapper that allow you to specify a
list of allowed commands for a given SSH public key. SSH stores the command
requested by the client in the **SSH_ORIGINAL_COMMAND** environment variable.
ssh-restrict-cmd uses this variable to check it agains a file of allowed
commands for that SSH key

Security
--------

We all know shell may not be the most secure way to do this type of wrapper,
but I needed something simple that I could run in any minimal system, even
embedded systems that may not have more secure (and big) interpreted languages
like perl, ruby or python. And C may be overkill for this simple task

ssh-restrict-cmd tries to avoid security problems aborting execution on any
error and also denies command execution if an illegal character is detected

Usage
-----

### Configure SSH authorized_keys

Configure the user's authorized_keys file to run ssh-restrict-cmd for the
given public key. You can specify the file with allowed commands as a
parameter

```sh
command="/usr/bin/ssh-restrict-cmd -f /home/myuser/mycommands.conf -l /home/myuser/commands.log",no-port-forwarding,no-X11-forwarding,no-agent-forwarding SSH_PUBLIC_KEY
```

### Command line options

Usage is very simple. This is the usage help:

```sh
  ssh-restrict-cmd [-h] | [-d] [-l logfile] -f [command_file]

  Usage:

    -h              : Show this help message
    -d              : Debug. Show debug messages
    -l logfile      : Log messages to logfile (Default: /var/log/ssh-restrict-cmd.log)
    -f command_file : Read allowed commands from command_file (Default: /etc/ssh-restrict-cmd/default.conf)

```

### Testing commands

TODO: Not yet, sorry
