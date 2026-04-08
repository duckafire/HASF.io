[log-m]: https://codeigniter.com/user_guide/general/common_functions.html#log_message "`\log_message` documentation"
[log-m-tags]: https://codeigniter.com/user_guide/general/logging.html "`\log_message` tags"

## Logs

Patterns to write application logs; based in function [`\log_message`][log-m], from CodeIgniter4.
Below there is a list with the avaiable classification of the messages:

| Level       | Description                                               | HTTP 500 |
| :-:         | :--                                                       | :-:      |
| "debug"     | Debugging information (only in development environment).  | Maybe    |
| "info"      | Monitoring of specific events (like user login).          | No       |
| "notice"    | Monitoring of high importance events (like admin access). | No       |
| "warning"   | Undesirable events (like use of a deprecated feature).    | No       |
| "error"     | Relating with errors that can be turn around in runtime.  | No       |
| "critical"  | Problem turn aroundable with parte of the application.    | No       |
| "alert"     | Part of the application is unavailable/unusable.          | Yes      |
| "emergency" | Application is unavailable/unusable.                      | Yes      |

> [!NOTE]
> These constantes are based in the [`\log_message` *tags*][log-m-tags].

It is recommended to use `HTTPCode500Exception` to call `"alert"` and `"emergency"`; and
`"debug"` when applicable. Please do not use this exception with other types of log messages
(there are not validation to it).

