package example

blacklist := ["bash"]

detected {
    check == true
    data.state.nextstate == "C"
}

default check = false
check {
    forbidden := blacklist[_]
    cmd := input.arguments["p0"]
    cmdparts := split(cmd, "/")
    cmdpart := cmdparts[_]

    input.api == "execve"
    cmdpart == forbidden
}

nextstate = "?" {
    check == true
    detected == true
} else = "B" {
    check == true
    data.state.nextstate == "A"
} else = "C" {
    check == true
    data.state.nextstate == "B"
} else = "A" {
    check == true
} else = "A" {
    check == false
    data.state.nextstate == "A"
} else = "B" {
    check == false
    data.state.nextstate == "B"
} else = "C" {
    check == false
    data.state.nextstate == "C"
} else = "?" {
    check == false
}