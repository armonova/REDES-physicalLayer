import os

messageReceived = 'SERVER1-SERVER3-quadro.txt'
segmentSent = 'SERVER3-SERVER4-segmento.txt'
segmentReceived = 'CLIENT3-CLIENT1-segmento.txt'

def getMessageLength(filename):
    return os.stat(filename).st_size

def getMessageSequence():
    
    return 1

def getSegmentSentHeader(length, sequence):
    header = "SEQUENCE: " + str(sequence) + "\nLENGTH: " + str(length)
    return header

def getMessageReceivedBody(filename): #thats wrong
    file = open(filename, 'r')
    for line in file:
        if(line == "DATA"):
            return line
    return line

def sendSegment(header, body):
    file = open(segmentSent, 'w')
    file.write(header)
    file.write(body)
    file.close()
    return True

length = getMessageLength(messageReceived)
sequence = getMessageSequence()
header = getSegmentSentHeader(length, sequence)

print header