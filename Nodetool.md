# Nodetool generic options
- All options are supported:
```
usage: nodetool [(-pw <password> | --password <password>)]
        [(-u <username> | --username <username>)] [(-p <port> | --port <port>)]
        [(-h <host> | --host <host>)]
        [(-pwf <passwordFilePath> | --password-file <passwordFilePath>)] <command>
        [<args>]
```

Ex:
```
( -h | --host ) <host name> | <ip address>
( -p | --port ) <port number>
( -pw | --password ) <password >
( -u | --username ) <user name>
( -pwf <passwordFilePath | --password-file <passwordFilePath> )
nodetool (-h 192.168.1.8) (-p 10000) (-pw huuthang201) (-u huuthang201) (-pwf huuthang201)
```
