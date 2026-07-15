# INTER-PROCESS COMMUNICATION - Mailboxes, Semaphores, and Events

Covers SystemVerilog's built-in inter-process communication and
synchronization primitives - essential for coordinating concurrent
processes in a testbench (e.g. driver, monitor, scoreboard all running
in parallel).

## Files


1 .	MAILBOX	

	 	01_mailbox_basics.sv                        | Bounded mailbox, `put()`/`get()`, blocking behavior                           |
	 	02_mailbox_methods.sv                        | `put()`/`get()`, `try_put()`,`try_get()`, blocking and non blocking behaviour |
	 	03_mailbox_try_methods.sv                    | Non-blocking `try_put()`, `try_get()`, `try_peek()`                           |

2 .	SEMAPHORE	

	 	01_semaphore_basics.sv                       | Semaphore with a single key - mutual exclusion                                |
	 	02_semaphore_methods.sv                      | Semaphore methods blocking and non blocking                  		           |
	 	03_semaphore_multiple_keys.sv                | Semaphore with multiple keys - limited concurrent access                      |

3 .	EVENTS	

		01_event_basics.sv                           | Basic event trigger (`->`) and wait (`@(event)`)                              |
	 	02_event_methods.sv         			     | `triggered()` method, `->>` persistent/scheduled trigger                      |
 	 	03_event_trigger_wait_combinations.sv        | All 4 combinations: `@`/`wait` waiting with `->`/`->>` triggering             |
	 	04_event_trigger_before_wait.sv              | What happens when the trigger fires BEFORE the wait - deadlock risk analysis  |

## Key takeaways
- **Mailboxes** pass data between concurrent processes safely - `put()`
  blocks if the mailbox is full (bounded), `get()` blocks if it's empty.
  This is the standard mechanism connecting a sequencer to a driver.
- **try_put/try_get/try_peek** are non-blocking versions that return a
  status immediately instead of waiting - useful when a process can't
  afford to block.
- **Semaphores** control access to a shared resource using a pool of
  keys. With 1 key, only one process can proceed at a time (mutual
  exclusion); with multiple keys, a limited number of processes can
  proceed concurrently (resource pooling).
- **Events** synchronize processes without passing data - one process
  triggers (`->`/`->>`), another waits (`@(event)`/`wait(ev.triggered())`).
- **`->` vs `->>`** only affects timing *within the same simulation time
  step* - `->` triggers immediately at that statement, `->>` schedules
  the trigger to happen later in the same time step, after other
  pending blocking statements execute. Neither makes a trigger persist
  beyond the current time step.
- **`@(event)` vs `wait(ev.triggered())`**: `@` blocks directly on the
  event and can only catch a trigger that happens *after* it starts
  waiting. `wait(ev.triggered())` polls a boolean that stays true for
  the rest of the *current* time step, so it can catch a trigger that
  already happened earlier in that same time step - but not one from an
  earlier time step.
- **Trigger-before-wait pitfall**: if a process triggers an event before
  another process starts waiting on it, `@(event)` and `->>` combined
  with `@(event)` deadlock permanently, since the trigger is gone by the
  time the wait begins. `wait(ev.triggered())` only survives this if the
  check happens within the *same* time step as the trigger - it does not
  protect against triggers from earlier time steps. Real testbenches
  avoid this fragility by using semaphores, mailboxes, or persistent
  flags instead of relying on event trigger/wait ordering.
