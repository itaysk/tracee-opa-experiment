package example

blacklist := ["bash"]

detected { 
    forbidden := blacklist[_]
    cmd := input.arguments["p0"]
    cmdparts := split(cmd, "/")
    cmdpart := cmdparts[_]

    input.api == "execve"
    cmdpart == forbidden
}