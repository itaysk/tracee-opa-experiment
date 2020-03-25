Tracee - OPA integration

Demonstration of using Open Policy Agent as a rule engine over Tracee log stream. This is merely a POC of why OPA can be useful in such use case. This is not a usable project in real world, and definitely not a product.

## Concepts
The demo is built on a classical model of collect->detect->act.

- Collect step is gathering the events from the source. In practice this is just Tracee CLI tool, but in the demo I use a mock that just generates events from a fixed file.
- Detect step is where the user build rules to look for specific patterns in the incoming events. This is where OPA steps in as the language and engine to describe and evaluate those rules.
- Act step is reacting to detected signals by invoking a pluggable action. For example, notify someone, perform automatic remediation, etc.

In this demo we are processing a continuous stream of events. 
- Collect steps are generating streams of events.
- Detect steps are processing the stream of events by filtering it down and emitting another stream of filtered events. Detect steps can be chained together (like pipes).
- Act steps are processing the stream of events and have some side affect.

## Implementation
- The demo is implemented using simple bash scripts. 
- Every step is a standalone script. 
- Steps are connected using bash pipes. 
- Events are represented as JSON documents.

## Demo
see Demo.txt


