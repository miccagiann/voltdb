#!/usr/bin/env bash

CURLBASE='curl -H "Content-Type: application/json"'
URIBASE="http://localhost:8000/api/1.0"

# By default, the deployment service starts up with one database, called
# "Database", and the local host in the server list.
#
# Let's check that:
$CURLBASE $URIBASE/databases/

# and one server. The "get" specifies "databases", then the id number
# of the database, and the asks for its servers:
$CURLBASE $URIBASE/databases/1/servers/

# Let's remove then so we can go through the whole process, albeit for
# a one node cluster.

# Remove the server:
$CURLBASE -X DELETE -d '{"dbId":1}' $URIBASE/databases/1/servers/1/

# Add a new database:
$CURLBASE -X POST -d '{"name":"myNewDatabase"}' $URIBASE/databases/ 

# And the local server:
$CURLBASE -X POST -d '{"name":"volt12q"}' $URIBASE/databases/1/servers/

# Now we can start the "cluster":
$CURLBASE $URIBASE/databases/1/start
