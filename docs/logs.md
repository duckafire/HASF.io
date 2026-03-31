[log-m]: https://codeigniter.com/user_guide/general/common_functions.html#log_message "`\log_message` documentation"
[log-m-tags]: https://codeigniter.com/user_guide/general/logging.html "`\log_message` tags"

## Logs

Patterns to write application logs; based in function [`\log_message`][log-m], from CodeIgniter4.

Below there is a list with the avaiable classification of the messages:

| Level | Constants      | Description                                               | HTTP 500 |
| :-:   | :--            | :--                                                       | :-:      |
| 1     | LOG\_DEBUG     | Debugging information (only in development environment).  | Maybe    |
| 2     | LOG\_INFO      | Monitoring of specific events (like user login).          | No       |
| 3     | LOG\_NOTICE    | Monitoring of high importance events (like admin access). | No       |
| 4     | LOG\_WARNING   | Undesirable events (like use of a deprecated feature).    | No       |
| 5     | LOG\_ERROR     | Relating with errors that can be turn around in runtime.  | No       |
| 6     | LOG\_CRITICAL  | Problem turn aroundable with parte of the application.    | No       |
| 7     | LOG\_ALERT     | Part of the application is unavailable/unusable.          | Yes      |
| 8     | LOG\_EMERGENCY | Application is unavailable/unusable.                      | Yes      |

> [!NOTE]
> These constantes are based in the [`\log_message` *tags*][log-m-tags].

It is recommended to use `HTTPCode500Exception` to call `LOG_ALERT` and `LOG_EMERGENCY`; and
`LOG_DEBUG` when applicable. Please do not use this exception with other types of log messages
(there are not validation the it).

