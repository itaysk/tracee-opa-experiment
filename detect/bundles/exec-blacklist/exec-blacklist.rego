package example
deny { 
    forbidden := data.blacklist[_]
    cmd := input.arguments["p0"]
    cmdparts := split(cmd, "/")
    cmdpart := cmdparts[_]

    input.api == "execve"
    cmdpart == forbidden
}