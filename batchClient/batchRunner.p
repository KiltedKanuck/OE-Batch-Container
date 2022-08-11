// def your variables
def var iWait as int64 no-undo.
def var iLooper as int64 no-undo.
def var iLoop as int64 no-undo.

// init your variables
assign 
    iWait = 5
    iLoop = 10
    iLooper = 0
    .

// start processing
message "Starting batch client".

do iLooper = 1 to iLoop:
    message "Processing...".
    pause iWait.
end.

message "Shutdown batch client".
