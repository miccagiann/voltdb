    #
    # Sample script to create database.
    #
    MGTHOST="http://voltdbmgr:9000"
    RestAdd () {
      ID=$( curl -sw "%{redirect_url}" -d "$2" \
              "$MGTHOST/man/api/1.0$1" \
              | grep -oP "(?<=$1/)[0-9]+" )
      echo "$ID"
    }

    # Define Three servers
    JSON='{"Server":{"host":"goneril","name":"goneril"}}'
    S1=$( RestAdd "/mgmt/servers" "$JSON" )
    JSON='{"Server":{"host":"regan","name":"regan"}}'
    S2=$( RestAdd "/mgmt/servers" "$JSON" )
    JSON='{"Server":{"host":"cordelia","name":"cordelia"}}'
    S3=$( RestAdd "/mgmt/servers" "$JSON" )

    # Define a deployment
    JSON='{"Deployment":{"name":"Flight deployment"}}'
    D1=$( RestAdd "/mgmt/deployments" "$JSON" )
    # Load a catalog (use base64-encoding)
    CATALOG=$( base64 flight.jar )
    JSON="{\"Catalog\":{\"name\":\"flight\",\
           \"catalogbytes\":\"$CATALOG\"}}"
    C1=$( RestAdd "/mgmt/catalogs" "$JSON" )

    # Define and start database
    JSON="{\"Database\":{\"name\":\"Flight DB\",\
          \"catalog\":\"$C1\",\"deployment\":\"$D1\",\
          \"remotedir\":\"flightdb\",\
          \"Servers\":[{\"server\":\"$S1\"},\
          {\"server\":\"$S2\"},{\"server\":\"$S3\"}]}}"
    DB=$( RestAdd "/mgmt/databases" "$JSON" )
    curl -X PUT "$MGTHOST/man/api/1.0/mgmt/databases/$DB/start"
