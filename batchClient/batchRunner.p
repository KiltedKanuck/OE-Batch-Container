// def your variables
def var iWait as int64 no-undo.
def var iLooper as int64 no-undo.
def var iLoop as int64 no-undo.
def var kMyID as CHARACTER format "x(36)" no-undo.
def var kJobID as char no-undo.

// init your variables
assign 
    iWait = 2
    iLoop = 5
    iLooper = 0
    kMyID = guid(GENERATE-UUID)

    .
message "Starting batch client".

// register agent with pool
message substitute("Registering batch agent &1", kMyID).
create batchAgent.
assign
    batchAgent.AgentID = kMyID
    batchAgent.AgentActive = false.
// start processing

do iLooper = 1 to iLoop:
    message "Looking for new job".
    find first batchQueue exclusive-lock 
        where batchQueue.queueID <> ""
          and NOT batchQueue.queueActive
          and NOT batchQueue.queueProcessed
          no-error.
    if available batchQueue then do:
        assign kJobID = guid(generate-uuid).
        message substitute("Processing...[queue = &1, job = &2]", batchQueue.queueID, kJobID).
        create batchJob.
        assign
            batchJob.agentID = kMyID
            batchJob.queueID = batchQueue.queueID
            batchJob.jobID = kJobID
            batchJob.JobDateTime = now
            batchJob.jobAction = "Processing"
            .
    end.
        pause iWait.
end.

// remove agent from pool
message substitute("Deregistering batch agent &1", kMyID).
find first batchAgent exclusive-lock 
    where batchAgent.AgentID = kMyID.
if available batchAgent then delete batchAgent.

message "Shutdown batch client".
