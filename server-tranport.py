import os
import sys

segmentReceived = 'SERVER1-SERVER3-segmento.txt'
messageSent = 'SERVER3-SERVER4-mensgem.txt'

messageReceived = 'SERVER4-SERVER3-mensagem.txt'
segmentSent = 'SERVER3-SERVER1-segmento.txt'


def getFileLength(filename):
    return os.stat(filename).st_size


def getAllFileContent(filename):
    file = open(filename, 'r')
    return "DATA:\n" + file.read()

def getSequenceNumber():
    return 1

def getOnlyFileData(filename):

    file = open(filename, 'r')
    reachedBody = False
    body = ""

    for line in file:
        if reachedBody:
            body += line
        if line == "DATA:\n":
            reachedBody = True

    print(body)
    return body


def getMessageSequence():
    return 1


def TCPHeader(srcPort, dstPort, length, checksum, sequenceNumber, ackNumber, windowSize, urgentPointer, options, padding):
    header = "SRCPORT: " + str(srcPort) + ", DSTPORT: " + str(dstPort) + \
        ", SEQUENCENUMBER: " + str(sequenceNumber) + \
        "\nACKNUMBER: " + str(ackNumber) + \
        "\nLENGTH: " + str(length) + \
        "\nWINDOWSIZE: " + str(windowSize) + \
        "\nCHKSUM: " + str(checksum) + \
        "\nURGENTPOINTER: " + str(urgentPointer) + \
        "\nOPTIONS: " + str(options) + \
        "\nPADDING: " + str(padding) + '\n'
    return header


def UPDHeader(srcPort, dstPort, length, checksum):
    header = "SRCPORT: " + str(srcPort) + ", DSTPORT: " + str(dstPort) + \
        "\nLENGTH: " + str(length) + \
        ", CHKSUM: " + str(checksum) + '\n'

    return header


def writeOutput(outputFile, header, body):
    print(header)
    print(body)
    file = open(outputFile, 'w')
    file.write(header)
    file.write(body)
    file.close()


# sys.argv[1] => opcao que diz se esta enviando ou recebendo mensagem
sending = sys.argv[1] == "send"
receiving = sys.argv[1] == "receive"
# sys.argv[2] => opcao que diz se esta usando UDP ou TCP
udp = sys.argv[2] == "udp"
tcp = sys.argv[2] == "tcp"

if sending:
    print("Server reading from APP layer, sending to PHY layer")
    inputFile = messageReceived
    outputFile = segmentSent

    if udp:
        print("Using UDP\n")
        srcPort = 25
        dstPort = 3000

        body = getAllFileContent(inputFile)
        length = getFileLength(inputFile)
        checksum = 0

        header = UPDHeader(srcPort, dstPort, length, checksum)

        writeOutput(outputFile, header, body)
    if tcp:
        print("Using TCP\n")
        
        #three way handshake

        body = getAllFileContent(inputFile)
        length = getFileLength(inputFile)
        checksum = 0

        header = TCPHeader(srcPort, dstPort, length, checksum, getSequenceNumber(), 1, 1024, 3, 7, 1)
        writeOutput(outputFile, header, body)
    else:
        print("Undefined protocol used\n\n")

if receiving:
    print("Server reading from PHY layer, sending to APP layer")
    inputFile = segmentReceived
    outputFile = messageSent

    if udp:
        print("Using UDP\n")
        writeOutput(outputFile, '', getOnlyFileData(inputFile))
    if tcp:
        print("Using TCP\n")
        writeOutput(outputFile, '', getOnlyFileData(inputFile))
    else:
        print("Undefined protocol used\n\n")
