#!/usr/bin/env/ powershell

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Set-ExecutionPolicy Restricted -Scope CurrentUser  # back to some company policies